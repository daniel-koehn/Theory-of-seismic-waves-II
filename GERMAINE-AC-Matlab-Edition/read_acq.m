function [ acq ] = read_acq( model )
% READ_ACQ
% Read acquisition geometry

    % read receiver coordinates from receiver.dat
    rec_data = load(model.file_rec);

    % x,z-coordinates of the receiver
    acq.xrec = rec_data(:,1);
    acq.yrec = rec_data(:,2);

    acq.ntr = length(acq.xrec);     % number of traces per shot

    % clean up memory
    clear rec_data;

    % read source coordinates from source.dat
    shot_data = importdata(model.file_src, ' ', 1);

    % x,z-coordinates of the source positions
    acq.xshot = shot_data.data(:,1);
    acq.yshot = shot_data.data(:,3);
    
%     acq.xshot = model.dh.*round(model.nx./2).*(acq.xshot./acq.xshot);
%     acq.yshot = model.dh.*round(model.ny./2).*(acq.yshot./acq.yshot);
    
    acq.nsrc = length(acq.xshot);     % number of shots
    
    % clean up memory
    clear shot_data;

    % calculate discrete shot and receiver positions on FD grid
    acq.nxshot = round(acq.xshot./model.dh);
    acq.nyshot = round(acq.yshot./model.dh);
    
    acq.nxrec = round(acq.xrec./model.dh);
    acq.nyrec = round(acq.yrec./model.dh);
    
    % define center frequency of Ricker wavelet
    acq.fc = 10.0;
    
end
