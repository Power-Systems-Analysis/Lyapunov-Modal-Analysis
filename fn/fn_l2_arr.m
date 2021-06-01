% Calculating l2 coefficient from the sequence.
function [l2_es_arr, l2_eijk_norm_arr] = fn_l2_arr(u_arr, e_arr, v_arr, c)
    a_size = size(u_arr, 1);
    c_size = size(c, 1);
    k_size = size(u_arr, 3);
    l2_es_arr = zeros(a_size, k_size);
    l2_eijk_norm_arr = zeros(a_size, a_size, c_size, k_size);
    progress = cls_progress;
    progress.beg('L2 calculation...', k_size);
    for k = 1:k_size
        [l2_es_arr(:,k), l2_eijk_norm_arr(:,:,:,k)] = fn_l2(u_arr(:,:,k), e_arr(:,k), v_arr(:,:,k), c);
        progress.print();
    end
    progress.end();
end