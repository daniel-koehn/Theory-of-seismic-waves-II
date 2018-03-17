function [ acq ] = shift_acq( model, acq )
% SHIFT_ACQ
% Shift acquisition geometry if model.npml > 0

    % shift  discrete shot and receiver positions on FD grid
    acq.nxshot = acq.nxshot + model.npml;
    acq.nyshot = acq.nyshot + model.npml;
    
    acq.nxrec = acq.nxrec + model.npml;
    acq.nyrec = acq.nyrec + model.npml;
    
end
