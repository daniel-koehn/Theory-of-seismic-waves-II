function [ vp, rho, model ] = extend_model( model, vp, rho )
% Extend model 
% Extend vp model with PML boundary 

     nx_new = model.nx + 2 * model.npml;
     ny_new = model.ny + 2 * model.npml;

     vp_new = zeros(ny_new,nx_new);
     rho_new = zeros(ny_new,nx_new);

     % central model
     vp_new(1+model.npml:model.ny+model.npml,1+model.npml:model.nx+model.npml) = vp; 
     rho_new(1+model.npml:model.ny+model.npml,1+model.npml:model.nx+model.npml) = rho; 

     % left boundary
     for i=1:model.npml
         vp_new(:,i) = vp_new(:,1+model.npml);
         rho_new(:,i) = rho_new(:,1+model.npml);
     end

     % right boundary
     for i=(model.nx + model.npml + 1):nx_new
         vp_new(:,i) = vp_new(:,model.nx + model.npml);
         rho_new(:,i) = rho_new(:,model.nx + model.npml);
     end

     % top boundary
     for j=1:model.npml
         vp_new(j,:) = vp_new(model.npml + 1,:);
         rho_new(j,:) = rho_new(model.npml + 1,:);
     end

     % bottom boundary
     for j=(model.ny + model.npml + 1):ny_new
         vp_new(j,:) = vp_new(model.ny + model.npml,:);
         rho_new(j,:) = rho_new(model.ny + model.npml,:);
     end

     clear vp rho;
     vp = vp_new;
     rho = rho_new;
     clear vp_new rho_new;

     model.nx = nx_new;
     model.ny = ny_new;
      model.n = nx_new * ny_new;
     
end
