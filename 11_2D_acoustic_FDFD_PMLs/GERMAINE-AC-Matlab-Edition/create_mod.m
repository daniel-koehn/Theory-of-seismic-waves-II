function [ vp ] = create_mod( model )
% CREATE_MOD 
% Create Vp-model on-the-fly

     % Example of a simple on-the-fly Vp model
     % - be more creative
     for j=1:model.ny
         for i=1:model.nx
             
             vp(j,i) = 4000.0; 
             
         end
     end

end
