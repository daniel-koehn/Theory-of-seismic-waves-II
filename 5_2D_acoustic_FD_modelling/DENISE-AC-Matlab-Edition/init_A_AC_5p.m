function [ A ] = init_A_AC_5p( model, vp)
% ass_A_AC_5p
% Assemble impedance matrix for an acoustic medium using the 
% 2D 5-point stencil FD scheme

    % define parameters
    vp2 = vp.^2;    
    idh2 = 1.0/model.dh.^2;
    dt2 = model.dt.^2;
    
    % Assemble impedance matrix
    % -------------------------
    
    % loop over Cartesian grid
    k = 1;
    count = 1;
    for j=1:model.ny
        for i=1:model.nx 
            
            % implement discrete FDFD operator ...
            
            % N gridpoint
            if(j > 1)
               Tx(count) = idh2 .* vp2(j,i) .* dt2;
               Ti(count) = k;
               Tj(count) = k-model.nx;
               count = count + 1;
            end
            
            % W gridpoint
            if(i > 1)
               Tx(count) = idh2 .* vp2(j,i) .* dt2;
               Ti(count) = k;
               Tj(count) = k-1;
               count = count + 1;
            end
            
            % central gridpoint
            Tx(count) = 2.0 - 4.0 .* idh2 .* vp2(j,i) .* dt2;
            Ti(count) = k;
            Tj(count) = k;
            count = count + 1;
            
            % E gridpoint
            if(i < model.nx)
               Tx(count) = idh2 .* vp2(j,i) .* dt2;
               Ti(count) = k;
               Tj(count) = k+1;
               count = count + 1;
            end
            
            % S gridpoint
            if(j < model.ny)
               Tx(count) = idh2 .* vp2(j,i) .* dt2;
               Ti(count) = k;
               Tj(count) = k+model.nx;
               count = count + 1;
            end            
            
            k = k + 1;
            
        end
    end

    % assemble sparse matrix A
    A = sparse(Ti,Tj,Tx);
     
end
