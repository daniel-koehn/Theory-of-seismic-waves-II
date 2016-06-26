function [ vp ] = readmod( model )
% READMOD 
% Read IEEE model binary files

     file=[model.file_true '.vp'];
     disp([' loading file ' file]);
     fid=fopen(file,'r','ieee-le');
     vp=fread(fid,[model.ny,model.nx],'float');
     fclose(fid);

end
