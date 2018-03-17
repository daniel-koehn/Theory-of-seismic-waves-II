function [ srm ] = SRM( model )
% SRM
% Define damping profiles of in absorbing boundary frame of 
% stiffness reduction method (SRM) 

% apply damping of image in the PML layers
DAMPING=99;
amp=1.0-DAMPING./100.0;   % amplitude at the edge of the numerical grid 
ifw=10;  % frame width in gridpoints 
a=sqrt(-log(amp)./((ifw-1).^2));
        
for i=1:ifw
    coeff(i)=exp(-(a.^2.*(ifw-i).^2));
    %coeff(i) = 0.0;
end

% initialize array of coefficients with one 
for j=1:model.ny
    for i=1:model.nx 
      absorb_coeff(j,i)=1.0;
    end
end

% coefficients for left and right boundary
for j=1:model.ny
    for i=1:ifw
      absorb_coeff(j,i) = absorb_coeff(j,i) * coeff(i);
    end           
end

for j=1:model.ny
    for i=1:ifw
      ii = model.nx - i + 1;
      absorb_coeff(j,ii) = absorb_coeff(j,ii) * coeff(i);
    end           
end
  
% coefficients for top and bottom boundary
for j=1:ifw
    for i=1:model.nx
      absorb_coeff(j,i) = absorb_coeff(j,i) * coeff(j);
    end           
end
  
for j=1:ifw
    jj = model.ny - j + 1;
    for i=1:model.nx
      absorb_coeff(jj,i) = absorb_coeff(jj,i) * coeff(j);
    end           
end

  srm.absorb = absorb_coeff;
  
end
