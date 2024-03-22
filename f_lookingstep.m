function optimal_step = f_lookingstep(num_patchoverlap, patch_req)
patch_req = int32(patch_req);

[~,n] = size(num_patchoverlap);

last_index = num_patchoverlap(end,end);
last_overlap = num_patchoverlap(1,end);


%if(num_patch_ximage>)
if(patch_req>last_index)
    for i = 1:1:n
        gen_patch = num_patchoverlap(end,i);

        if(patch_req>=gen_patch) % num patches por imagen mayor al numero de patches generados
            optimal_step = num_patchoverlap(end-1,i-1);
            break;
        elseif(gen_patch==0)
            break;
        end
    end
else
    optimal_step = last_overlap;
end
end