% GERMAINE Matlab-Edition - 2D acoustic FDFD seismic modelling code
% 
% Daniel Koehn
% Kiel, the 24th of June 2016
 
clear all;
close all;

% define solver
% SOLVER = 1 - LU factorization + forward/backward substitution 
% SOLVER = 2 - BICGSTAB solver
% SOLVER = 3 - Direct solver with Matlab backslash operator \
SOLVER = 3;

% define FD-scheme
% FD_SCHEME = 1 - 5-point stencil
% FD_SCHEME = 2 - 9-point mixed grid stencil with PMLs
FD_SCHEME = 2;

% write real part of pressure wavefield to IEEE binar file
WRITE_SNAP = 0;

% define input model parameters
model = inp_model;

if(model.MODEL==1)
    % read Vp-model from file
    vp = readmod(model);
else
    % define Vp-model on the fly
    vp = create_mod(model);
end

if(model.npml>0)
    [vp,model] = extend_model(model,vp);
end

% define source and receiver positions in def_acq.m
if(model.ACQ==1)
   acq = def_acq(model);
end

% read source and receiver positions from file
if(model.ACQ==2)
   acq = read_acq(model);

   % shift acquisition geometry if model.npml > 0
   if(model.npml>0)
       acq = shift_acq(model,acq);
   end

end

% ----------------------------------
% assemble acoustic impedance matrix
% ----------------------------------

% 5-point stencil 
if(FD_SCHEME==1)
    A = init_A_AC_5p(model,vp);
end

% 9-point mixed grid stencil with PMLs
if(FD_SCHEME==2)
    % define PML boundary damping profiles
    PMLs = PML(model);
    A = init_A_AC_9p_mixed_pml(model,vp,PMLs);
end

% LU factorization
if(SOLVER==1)
    tic;
    [L,U] = lu(A);
    disp('LU factorization');
    toc;
end

% loop over shots
tic;
for ishot = 1:1
    
    % calculate RHS for shot no. ishot
    RHS = RHS_AC(acq,ishot,model);
    
    if(SOLVER==1)
        % calculate forward wavefield by forward and back substitution
        y = L\RHS;
        p = U\y;
    end

    if(SOLVER==2)
        % calculate forward wavefield by BICGSTAB solver
        p = bicgstab(A,RHS,1e-6,10000);
    end
    
    if(SOLVER==3)
        % calculate forward wavefield by direct solution
        spparms('spumoni',1)
        p = A\RHS;
    end
    
end

disp('Total time for shot modelling');
toc;

% reshape solution vector 
ps = reshape(p,model.nx,model.ny);
ps = ps';
if(model.npml>0)
    ps = extract_model(model,ps);
    vp = extract_model(model,vp);
end
%ps = fliplr(ps);

% plot model and modelling results
set(gcf,'position',[0 0, model.screenx model.screeny]);
set(gcf,'PaperPositionMode','Auto');

subplot(2,1,1)

imagesc(model.x./1000.0,model.y./1000.0,vp);
load 'util/seismic.map'
colormap(seismic);
cbar_handle=colorbar('EastOutside');
set(get(cbar_handle,'ylabel'),'string','Vp [m/s]','fontsize',model.FSize,'FontWeight',model.Fweight);

set(get(gca,'title'),'FontSize',model.FSize);
set(get(gca,'title'),'FontWeight',model.Fweight);
set(get(gca,'Ylabel'),'FontSize',model.FSize);
set(get(gca,'Ylabel'),'FontWeight',model.Fweight);
set(get(gca,'Xlabel'),'FontSize',model.FSize);
set(get(gca,'Xlabel'),'FontWeight',model.Fweight);
set(gca,'FontSize',model.FSize);
set(gca,'FontWeight',model.Fweight);
set(gca,'Box','on');
set(gca,'Linewidth',1.0);
axis ij;
axis equal;
axis tight;

%xlabel('Distance [km]');
ylabel('Depth [km]');
title('P-wave velocity model');

% plot model and modelling results
subplot(2,1,2)

imagesc(model.x./1000.0,model.y./1000.0,real(ps));
caxis([-model.caxis1 model.caxis1]);
load 'util/seismic.map'
colormap(seismic);
cbar_handle=colorbar('EastOutside');
set(get(cbar_handle,'ylabel'),'string','Re(p)','fontsize',model.FSize,'FontWeight',model.Fweight);

set(get(gca,'title'),'FontSize',model.FSize);
set(get(gca,'title'),'FontWeight',model.Fweight);
set(get(gca,'Ylabel'),'FontSize',model.FSize);
set(get(gca,'Ylabel'),'FontWeight',model.Fweight);
set(get(gca,'Xlabel'),'FontSize',model.FSize);
set(get(gca,'Xlabel'),'FontWeight',model.Fweight);
set(gca,'FontSize',model.FSize);
set(gca,'FontWeight',model.Fweight);
set(gca,'Box','on');
set(gca,'Linewidth',1.0);
axis ij;
axis equal;
axis tight;

xlabel('Distance [km]');
ylabel('Depth [km]');
title('Real part of pressure wavefield');

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [5 7]);

imfile=['FDFD_wavefield.eps'];
eval([['print -dpsc2 '] imfile]);

% write wavefield to file
if(WRITE_SNAP==1)
  
  file=['wavefield_hom_p.bin'];
  fid=fopen(file,'w','ieee-le');
  fwrite(fid,real(full(ps)),'float')
  fclose(fid);
   
end
