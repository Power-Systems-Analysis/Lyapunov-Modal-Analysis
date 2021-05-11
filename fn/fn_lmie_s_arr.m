% Calculating lmie from the sequence.
function [lmie_s_arr] = fn_lmie_s_arr(u_arr, e_arr, v_arr)
    a_size = size(u_arr, 1);
    k_size = size(u_arr, 3);
    lmie_s_arr = zeros(a_size, a_size, a_size, k_size);
    progress = cls_progress;
    progress.beg('LMIE state calculation...', k_size);
    for k = 1:k_size
        lmie_s_arr(:,:,:,k) = fn_lmie_s(u_arr(:,:,k), e_arr(:,k), v_arr(:,:,k));
        progress.print();
    end
    progress.end();
end