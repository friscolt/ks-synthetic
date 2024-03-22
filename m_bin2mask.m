
% Convierte mascaras de segmentación de [0,1] a 255;

clc; clear; close all; 

dir_root = '/Users/franciscolt/Library/Mobile Documents/com~apple~CloudDocs/Tasks/Model 2 (Dataset)/SUR/';
addpath(dir_root);

dir_class = 'Subtype_Ia/';
% dir_class = 'Subtype_IVa/';
% dir_class = 'Subtype_IVa2/';
% dir_class = 'Subtype_IVc/';
% dir_class = 'Subtype_IVd/';
% dir_class = 'Subtype_Va/';



dir_folder = [dir_root, dir_class];
dir_gt = [dir_root,dir_class,'mask/'];
addpath(dir_folder, dir_gt);
ext_img = 'png';


f_main(dir_folder,dir_gt, ext_img);

function f_main(dir_folder, dir_gt, ext)
addpath(dir_folder);
addpath(dir_gt);

dir_file = dir(fullfile(dir_folder,['*.', ext]));
dir_numberimages = numel(dir_file);


for j = 1:1:dir_numberimages
    dir_name = dir_file(j).name; % Name of image
    I = imread(dir_name);
    dir_label = strrep(dir_name,'jpg','png');
    dir_gt_label = [dir_gt,dir_label];
    exist_gt = isfile(dir_gt_label);
    
    if(exist_gt == 1)
        GT = imread(dir_gt_label);
        GT = 255*GT;
        dir_save = [dir_folder,'mask/',dir_label];
        imwrite(GT, dir_save);
    else

        mytext = ['NonExist ', num2str(exist_gt), ' ' ,dir_name];
        disp(mytext);
        %disp(dir_name);
    end 
    

    %k = strfind(dir_name,'Copia de ');
    %if(k==1)
        
    %    aux_dir_name = dir_name(10:end);
    %    dir_rename = [dir_folder, aux_dir_name];
    %    %imwrite(I,dir_rename);

    %end 
end
end