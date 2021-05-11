% Liapunov energy mode i at node k from the sequence.
function [eo_ki_arr, eo_arr] = fn_elyap_o_ki_arr(u_arr, e_arr, v_arr, a_arr, c_arr)
    a_size = size(a_arr, 1);
    c_size = size(c_arr, 1);
    k_size = size(a_arr, 3);
    eo_ki_arr = zeros(c_size, a_size, k_size);
    eo_arr = zeros(c_size, k_size);
    progress = cls_progress;
    progress.beg('Observation energy calculation...', k_size);
    for k = 1:k_size
        [eo_ki_arr(:,:,k), eo_arr(:,k)] = fn_elyap_o_ki(u_arr(:,:,k), e_arr(:,k), v_arr(:,:,k), a_arr(:,:,k), c_arr(:,:,k));
        progress.print();
    end
    progress.end();
end