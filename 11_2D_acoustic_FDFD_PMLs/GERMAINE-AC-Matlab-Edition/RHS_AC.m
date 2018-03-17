function [ RHS ] = RHS_AC( acq, ishot, model)
% RHS_AC
% Assemble source vector 

    % allocate sparse RHS source vector 
    RHS = spalloc(model.n,1,1);
    
    % calculate f vector index for shot no. ishot
    k_src = acq.nxshot(ishot) + (acq.nyshot(ishot)-1)*model.nx;
    
    % Ricker wavelet
    % amp = (2.0./sqrt(pi)).*(model.f^2/acq.fc.^3).*exp(-(model.f/acq.fc).^2);
    
    % Spike wavelet
    amp = 1.0;
    
    % Define spike source
    RHS(k_src) = amp./model.dh^2;
     
end
