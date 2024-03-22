function num_patch = f_makepatch(dir_folder, dir_name, overlap, mode)

I = imread(dir_name); % Kidney stone image
dir_name_png = strrep(dir_name,'jpg','png');
dir_label = [dir_folder,'mask/'];
dir_gt = [dir_label, dir_name_png];
GT = imread(dir_gt); % Ground truth image
[yGT,xGT,~] = size(GT);
% overlap = 100; % Default value
window_size = 256;
percent_stone = 90; %%
cont_patch = 0;
for y = 1:overlap:xGT-window_size
    for x = 1:overlap:yGT-window_size
        if(x+window_size<xGT && y+window_size<yGT)
            GTpatch = GT(x:x+window_size-1, y:y+window_size-1); % Ground truth patch
            GTpatch_logic = logical(GTpatch);
            [xGTpatch, yGTpatch] = size(GTpatch_logic);
            p_patch = ((sum(sum(GTpatch_logic)))*(100))/(xGTpatch*yGTpatch);
            if(p_patch>percent_stone)
                Ipatch = I(x:x+window_size, y:y+window_size, :); % Kidney stone patch
                cont_patch = cont_patch+1;
                    if(mode==1) %write mode (generate patch files)
                        name_patch_save = [dir_name_png(1:end-4), '-', num2str(cont_patch), '.png']; % Name of patch                    
                        dir_save = [dir_folder, 'patch/', name_patch_save];
                        imwrite(Ipatch, dir_save); % Coment this line for test! 
                        display =  [' | image: ', dir_name,...
                                    ' | overlap: ', num2str(overlap), ...
                                    ' | num_patch: ', num2str(cont_patch),...
                                    ' | patch: ', name_patch_save, ' |']; 
                        disp(display);
                    end 
            end
        end
    end    
end
num_patch = cont_patch; 
end
