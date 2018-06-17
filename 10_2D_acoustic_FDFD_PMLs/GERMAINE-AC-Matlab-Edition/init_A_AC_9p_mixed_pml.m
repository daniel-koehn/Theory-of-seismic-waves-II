function [ A ] = init_A_AC_9p_mixed_pml( model, vp, PMLs )
% ass_A_AC_9p_mixed_pml
% Assemble impedance matrix for an acoustic medium using the 
% 2D 9-point mixed grid FD scheme including PML according to 
% 
% Z. Chen, D. Cheng, W. Feng, H. Yang, 2013, An optimal 9-point finite 
% difference scheme for the Helmholtz equation with PML, Int. J. Numer. 
% Anal. Model., 10, 389-410.

    % define parameters
    b = 0.7926;
    d = 0.3768;
    e = -0.0064;
    
    ivp2 = 1.0./vp.^2;
    omega2 = model.omega^2;
    k2 = omega2.*ivp2; 
    
    idh2 = 1.0/model.dh^2;
    
    % Assemble impedance matrix
    % -------------------------
    
    % loop over Cartesian grid
    k=1;
    count = 1;
    for j=1:model.ny
        for i=1:model.nx 
            
            % implement discrete FDFD operator ...
            
            % NW gridpoint
            if((i > 1) && (j > 1))
                
               Tx(count) = ((1-b).*idh2./2.0) .* (PMLs.Ax(j-1,i-1) + PMLs.By(j-1,i-1)) ...
                                   + (e./4.0) .* PMLs.C(j-1,i-1) .* k2(j-1,i-1);
               Ti(count) = k;
               Tj(count) = k-1-model.nx;
               count = count + 1;
               
            end
            
            % N gridpoint
            if(j > 1)
                
               Tx(count) = -((1-b).*idh2) .* PMLs.A(j-1,i) ... 
                                  + (b.*idh2) .* PMLs.By(j-1,i) ... 
                                  + (d./4.0) .* PMLs.C(j-1,i) .* k2(j-1,i);

               Ti(count) = k;
               Tj(count) = k-model.nx;               
               count = count + 1;
               
            end
            
            % NE gridpoint
            if((i < model.nx) && (j > 1))
                
               Tx(count) = ((1-b).*idh2./2.0) .* (PMLs.Ax(j-1,i) + PMLs.By(j-1,i+1)) ... 
                                   + (e./4.0) .* PMLs.C(j-1,i+1) .* k2(j-1,i+1);
                               
               Ti(count) = k;
               Tj(count) = k+1-model.nx;               
               count = count + 1;
      
            end
            
            % W gridpoint
            if(i > 1)
                
               Tx(count) = (b.*idh2) .* PMLs.Ax(j,i-1) - ((1-b).*idh2) .* PMLs.B(j,i-1) ...
                                   + (d./4.0) .* PMLs.C(j,i-1) .* k2(j,i-1);
               
               Ti(count) = k;
               Tj(count) = k-1;               
               count = count + 1;
                               
            end
            
            % central gridpoint
            Tx(count) = (1-d-e) .* PMLs.C(j,i) .* k2(j,i) ... 
                      - (2.0.*b.*idh2) .* (PMLs.A(j,i)+PMLs.B(j,i));
            
            Ti(count) = k;
            Tj(count) = k;               
            count = count + 1;
     
            
            % E gridpoint
            if(i < model.nx)
                
               Tx(count) = (b.*idh2) .* PMLs.Ax(j,i) - ((1-b).*idh2) .* PMLs.B(j,i+1) ... 
                           + (d./4.0) .* PMLs.C(j,i+1) .* k2(j,i+1);
                       
               Ti(count) = k;
               Tj(count) = k+1;               
               count = count + 1;
        
            end
            
            % SW gridpoint
            if( (j < model.ny) && (i > 1) )
                
               Tx(count) = ((1-b).*idh2./2.0) .* (PMLs.Ax(j+1,i-1) + PMLs.By(j,i-1)) ... 
                                   + (e./4.0) .* PMLs.C(j+1,i-1) .* k2(j+1,i-1);
               Ti(count) = k;
               Tj(count) = k-1+model.nx;               
               count = count + 1;
                             
            end
            
            % S gridpoint
            if(j < model.ny)
                
               Tx(count) = -((1-b).*idh2) .* PMLs.A(j+1,i) + (b.*idh2) .* PMLs.By(j,i) ...
                                  + (d./4.0) .* PMLs.C(j+1,i) .* k2(j+1,i);
               Ti(count) = k;
               Tj(count) = k+model.nx;               
               count = count + 1;
                       
            end
            
            % SE gridpoint
            if((i < model.nx) && (j < model.ny))
                
               Tx(count) = ((1-b).*idh2./2.0) .* (PMLs.Ax(j+1,i) + PMLs.By(j,i+1)) ... 
                                   + (e./4.0) .* PMLs.C(j+1,i+1) .* k2(j+1,i+1);
               Ti(count) = k;
               Tj(count) = k+1+model.nx;               
               count = count + 1;
                              
            end
            
            k = k + 1;
            
        end
    end
    
    % assemble sparse matrix A
    A = sparse(Ti,Tj,Tx);
     
end
