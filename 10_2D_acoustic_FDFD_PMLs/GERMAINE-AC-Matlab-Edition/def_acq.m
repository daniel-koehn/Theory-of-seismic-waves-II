function [ acq ] = def_acq( model )
% DEF_ACQ
% Define acquisition geometry

    % x,z-coordinates of the receiver
    acq.xrec = model.dh*round(model.nx./2.0);
    acq.yrec = model.dh*round(model.ny./2.0);

    % x,z-coordinates of the source positions
    acq.xshot = model.dh*round(model.nx./2.0);
    acq.yshot = model.dh*round(model.ny./2.0);
    
    % calculate discrete shot and receiver positions on FD grid
    acq.nxshot = round(acq.xshot./model.dh);
    acq.nyshot = round(acq.yshot./model.dh);
    
    acq.nxrec = round(acq.xrec./model.dh);
    acq.nyrec = round(acq.yrec./model.dh);
    
    % define center frequency of Ricker wavelet
    acq.fc = 20.0;
    
end
