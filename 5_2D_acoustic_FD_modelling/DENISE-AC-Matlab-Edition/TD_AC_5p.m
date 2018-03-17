function [Pp] = TD_AC_5p( model, vp, acq)
% TD_AC_5p
% Solve acoustic wave equation using the 
% 2D 5-point stencil FD scheme

    % define parameters
    vp2 = vp.^2;    
    idh2 = 1.0/model.dh.^2;
    dt2 = model.dt.^2;
    
    % initialize wavefields
    Pm = zeros(model.ny,model.nx);
    P = zeros(model.ny,model.nx);
    Pp = zeros(model.ny,model.nx);
    
    % loop over time steps
    for k=1:model.nt
    
        % calculate time
        t = k .* model.dt;
        
        % calculate Laplacian and update pressure wavefield Pp
        for j=2:model.ny-1
            for i=2:model.nx-1 
            
                Pp(j,i) = 2.0 .* P(j,i) - Pm(j,i) + (vp2(j,i) .* idh2 .* dt2 .* (P(j,i+1)+P(j,i-1)+P(j+1,i)+P(j-1,i)-4.0.*P(j,i)));
            
            end
        end
        
        % apply source wavelet
        ts = 1.0./model.f;
        tau = pi .* (t-1.5.*ts)/(1.5.*ts); % Ricker
        amp = (1.0-4.0.*tau.^2).*exp(-2.0*tau.^2);
        Pp(acq.nyshot,acq.nxshot) = Pp(acq.nyshot,acq.nxshot) + amp;
        
        % shift temporal arrays
        Pm = P;
        P = Pp;        
        
    end    
    
end
