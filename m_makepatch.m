clc; clear; close all;
tic;

% test
dir_folder = '/Users/franciscolt/Library/Mobile Documents/com~apple~CloudDocs/Tasks/ks-dataset/fold-1/SUR/test/';
isfolder(dir_folder);
addpath(dir_folder);
list_class =  { ...
                'Subtype_Ia', ...
                'Subtype_IVa', ...
                'Subtype_IVa2', ...
                'Subtype_IVc', ...
                'Subtype_IVd', ...
                'Subtype_Va' ...
              };

for i = 1:1:length(list_class)
    name_folder = list_class{i}; 
    f_main(dir_folder, name_folder, 0); % 0 -- Test dataset
end 




%% train
dir_folder = '/Users/franciscolt/Library/Mobile Documents/com~apple~CloudDocs/Tasks/ks-dataset/fold-1/SUR/train/';
isfolder(dir_folder);
addpath(dir_folder);
list_class =  { ...
                'Subtype_Ia', ...
                'Subtype_IVa', ...
                'Subtype_IVa2', ...
                'Subtype_IVc', ...
                'Subtype_IVd', ...
                'Subtype_Va' ...
              };

for i = 1:1:length(list_class)
    name_folder = list_class{i}; 
    f_main(dir_folder, name_folder, 1); % 1 -- Train dataset
end 
toc;







%% main

function f_main(dir_folder, name_folder, train)
% Parametros
window_size = 256;
step = 1; % min:20px  % default;

dir_folder = [dir_folder,name_folder,'/'];
dir_label = [dir_folder,'mask/'];
addpath(dir_folder, dir_label);
dir_patch = [dir_folder,'patch/'];
mkdir(dir_patch); addpath(dir_patch);
dir_file = dir(fullfile(dir_folder,['*.', 'png']));
dir_numberimages = numel(dir_file);

if train==1
    num_patch_req = 800; % 800 for training;
elseif(train==0)
    num_patch_req = 200; % 200 for testing;
else
    disp('error train/test');
end

num_img = num_patch_req/dir_numberimages;
num_img = int32(num_img);
cont_patch = 0;
for j = 1:1:dir_numberimages
    disp(dir_folder)
    dir_name = dir_file(j).name; % Name of image

    vctr_overlap = [];
    vctr_numpatch = [];
    for overlap = 5:step:window_size
        num_patch = f_makepatch(dir_folder, dir_name, overlap, 0); % Estimate patches 0
        display = [ ' | image: ', dir_name,...
                    ' | overlap: ', num2str(overlap), ...
                    ' | img_required: ', num2str(num_img),...
                    ' | num_patch: ', num2str(num_patch), ' |'];
        disp(display);
        vctr_overlap = horzcat(vctr_overlap,overlap);
        vctr_numpatch = horzcat(vctr_numpatch,num_patch);
    end
    num_patchoverlap = [vctr_overlap; vctr_numpatch];
    optimal_step = f_lookingstep(num_patchoverlap, num_img);
    num_patch = f_makepatch(dir_folder, dir_name, optimal_step, 1); % Write patches 1
    %disp(num_patch)
    cont_patch = cont_patch+ num_patch;
    disp(cont_patch);
end
end








