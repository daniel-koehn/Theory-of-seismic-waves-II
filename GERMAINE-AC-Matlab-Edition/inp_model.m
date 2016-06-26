function [ model ] = inp_model( )
% INP_MODEL 
% Define model parameters for 2D acoustic FDFD modelling
% Model:
% Two inclusions in a homogeneous full-space from
% Operto S, Virieux J, Sourbier F, 2007
% Documentation of FWT2D.V4.6 program:
% Frequency-domain full-waveform modeling/inversion
% of wide-aperture seismic data for imaging 2D acoustic media
% Technical report No 6 - SEISCOPE project

    % number of gridpoint in x- and y-direction
    model.nx = 250;
    model.ny = 125;

    model.n = model.nx * model.ny;

    % spatial sampling interval [m]
    model.dh = 40.0;
    
    % define x- and y-axis [m]
    model.x = model.dh.*(1:model.nx);
    model.y = model.dh.*(1:model.ny);
    
    % define modeling frequency [Hz]
    model.f = 10.0;
    model.omega = 2.0*pi*model.f; 
    
    % define thickness of PML boundary frame [gridpoints]
    model.npml = 20;
    model.a0_pml = 1.79;
    
    % define free surface
    model.free = 0;
    
    % basename of input model
    model.file_true = 'start/inclusions_true';
    
    % file names for source and receiver file
    model.file_rec = 'receiver/receiver_inc.dat';
    model.file_src = 'source/source_inc.dat';
    
    % define Caxis clip
    model.caxis1 = 6e-2;
    
    % define fonts
    model.FSize = 20;
    model.Fweight = 'bold'; 
    
end

