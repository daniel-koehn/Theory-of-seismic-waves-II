function [ PMLs ] = PML( model )
% PML
% Define damping profiles within PML boundary condition 
% according to Chen et al. (2013)

% define thickness of PML [m]
lPML = model.npml * model.dh;

% calculate PML damping profiles sigma_x and sigma_y in x- and y-direction
for i=1:model.nx  
    
    sigma_x(i) = 0.0;
    
    % define damping profile at left PML boundary 
    if(i < model.npml)
      sigma_x(i) = model.omega .* model.a0_pml .* ((model.npml-i).*model.dh./lPML).^2;
    end
    
    % define damping profile at right PML boundary 
    if(i >= model.nx - model.npml)
      sigma_x(i) = model.omega .* model.a0_pml .* ((model.dh.*((model.nx-model.npml+1)-i))./lPML).^2;
    end 
    
end

for j=1:model.ny
    
    sigma_y(j) = 0.0;
    
    % define damping profile at top PML boundary 
    if((j < model.npml)&&(model.free~=1))
      sigma_y(j) = model.omega .* model.a0_pml .* ((model.npml-j).*model.dh./lPML).^2;
    end
    
    % define damping profile at bottom PML boundary 
    if(j >= model.ny - model.npml)
      sigma_y(j) = model.omega .* model.a0_pml .* ((model.dh.*((model.ny-model.npml+1)-j))./lPML).^2;
    end 
    
end

% calculate sx and sy
for j=1:model.ny
    for i=1:model.nx
        
        % activate damping in PMLs
        sx(j,i) = 1-(sigma_x(i)*1i/model.omega);
        sy(j,i) = 1-(sigma_y(j)*1i/model.omega);
        
        % deactivate damping in PMLs
%         sx(j,i) = 1.0;
%         sy(j,i) = 1.0;

        
    end
end

PMLs.sy1 = sy; 
PMLs.sx1 = sx; 

% calculate factors A, B and C
PMLs.A = sy./sx;
PMLs.B = sx./sy;
PMLs.C = sx.*sy;

% calculate arithmetic average values
PMLs.Ax = PMLs.A;
PMLs.Bx = PMLs.B;

PMLs.Ay = PMLs.A;
PMLs.By = PMLs.B;

for j=2:model.ny-1
    for i=2:model.nx-1
        
        PMLs.Ax(j,i) = (PMLs.A(j,i) + PMLs.A(j,i+1))./2.0;
        PMLs.Bx(j,i) = (PMLs.B(j,i) + PMLs.B(j,i+1))./2.0;
        
        PMLs.Ay(j,i) = (PMLs.A(j,i) + PMLs.A(j+1,i))./2.0;
        PMLs.By(j,i) = (PMLs.B(j,i) + PMLs.B(j+1,i))./2.0;
        
    end
end
