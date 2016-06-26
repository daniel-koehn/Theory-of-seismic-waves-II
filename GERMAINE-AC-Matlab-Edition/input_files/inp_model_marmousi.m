function [ model ] = inp_model( )
% INP_MODEL 
% Define model parameters for 2D acoustic FDFD modelling
% Model:
% Marmousi-II model from 


    % number of gridpoint in x- and y-direction
    model.nx = 500;
    model.ny = 174;

    model.n = model.nx * model.ny;

    % spatial sampling interval [m]
    model.dh = 20.0;
    
    % define x- and y-axis [m]
    model.x = model.dh.*(1:model.nx);
    model.y = model.dh.*(1:model.ny);
    
    % define modeling frequency [Hz]
    model.f = 10.0;
    model.omega = 2.0*pi*model.f; 
    
    % define thickness of PML boundary frame [gridpoints]
    model.npml = 10;
    model.a0_pml = 1.79;
    
    % define free surface
    model.free = 1;
    
    % basename of input model
    model.file_true = 'start/marmousi_II_marine';
    
    % file names for source and receiver file
    model.file_rec = 'receiver/receiver_OBC.dat';
    model.file_src = 'source/source_OBC_VSP.dat';
    
    % define Caxis clip
    model.caxis1 = 6e-2;
    
    % define fonts
    model.FSize = 20;
    model.Fweight = 'bold'; 
    
end

