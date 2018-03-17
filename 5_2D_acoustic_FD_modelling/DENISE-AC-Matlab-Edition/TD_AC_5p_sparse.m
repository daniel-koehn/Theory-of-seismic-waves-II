function [Pp] = TD_AC_5p_sparse( model, vp, acq, ishot)
% TD_AC_5p
% Solve acoustic wave equation using the 
% 2D 5-point stencil FD scheme with sparse-matrix multiplication    
    
    % initialize wavefields
    Pm = zeros(model.n,1);
    P = zeros(model.n,1);
    Pp = zeros(model.n,1);
    
    % calculate P vector index for shot no. ishot
    k_src = acq.nxshot(ishot) + (acq.nyshot(ishot)-1)*model.nx;
    
    % assemble impedance matrix
    A  = init_A_AC_5p( model, vp);    
    
    % loop over time steps
    for k=1:model.nt
    
        % calculate time
        t = k .* model.dt;
        
        % calculate Laplacian and update pressure wavefield Pp        
        Pp = A*P - Pm;        
                
        % apply source wavelet
        ts = 1.0./model.f;
        tau = pi .* (t-1.5.*ts)/(1.5.*ts); % Ricker
        amp = (1.0-4.0.*tau.^2).*exp(-2.0*tau.^2);                
        Pp(k_src,1) = Pp(k_src,1) + amp;
        
        % shift temporal arrays
        Pm = P;
        P = Pp;        
        
    end
    
    % reshape P vector
    Pp = reshape(Pp,model.nx,model.ny);
    Pp = Pp';
    
end
