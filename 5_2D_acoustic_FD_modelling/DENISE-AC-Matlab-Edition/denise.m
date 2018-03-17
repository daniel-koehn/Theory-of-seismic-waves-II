% DENISE Matlab-Edition - 2D acoustic TDFD seismic modelling code
% 
% Daniel Koehn
% Kiel, the 21st of March 2017
 
clear all;
close all;

% define solver
% SOLVER = 1 - TD stencil with FOR-loop 
% SOLVER = 2 - TD stencil using sparse-matrix multiplication
SOLVER = 2;

% define FD-scheme
% FD_SCHEME = 1 - 5-point stencil
FD_SCHEME = 1;

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

% % 5-point stencil 
% if(FD_SCHEME==1)
%     A = init_A_AC_5p(model,vp);
% end

% loop over shots
tic;
for ishot = 1:1        
    
    % calculate forward wavefield using 5-point stencil 
    % and time-stepping using FOR-loops    
    if(SOLVER==1)                
        [P] = TD_AC_5p( model, vp, acq);        
    end
    
    % calculate forward wavefield using 5-point stencil 
    % and time-stepping using sparse-matrix multiplication    
    if(SOLVER==2)                
        [P] = TD_AC_5p_sparse( model, vp, acq, ishot);        
    end
    
end

disp('Total time for shot modelling');
toc;

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

imagesc(model.x./1000.0,model.y./1000.0,P);
caxis([-model.caxis1 model.caxis1]);
load 'util/seismic.map'
colormap(seismic);
cbar_handle=colorbar('EastOutside');
set(get(cbar_handle,'ylabel'),'string','Pressure [Pa]','fontsize',model.FSize,'FontWeight',model.Fweight);

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
title('Pressure wavefield');

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [5 7]);

imfile=['TDFD_wavefield.png'];
eval([['print -dpng '] imfile]);

% imfile=['TDFD_wavefield.eps'];
% eval([['print -dpsc2 '] imfile]);

% write wavefield to file
if(WRITE_SNAP==1)
  
  file=['wavefield_hom_p.bin'];
  fid=fopen(file,'w','ieee-le');
  fwrite(fid,real(full(ps)),'float')
  fclose(fid);
   
end
