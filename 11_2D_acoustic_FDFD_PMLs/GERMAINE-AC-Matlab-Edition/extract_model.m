function [ ps ] = extract_model( model, ps )
% Extract model 
% Extract vp model

     nx_old = model.nx - 2 * model.npml;
     ny_old = model.ny - 2 * model.npml;

     ps_new = ps(1+model.npml:ny_old+model.npml,1+model.npml:nx_old+model.npml);

     clear ps;
     ps = ps_new;
     clear vp_new;

     model.nx = nx_old;
     model.ny = ny_old;
     
end
