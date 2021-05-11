% Calculation of the Lyapunov energy of the state from the sequence.
function [es_arr] = fn_elyap_s_var_arr(a_arr)
    a_size = size(a_arr, 1);
    k_size = size(a_arr, 3);
    es_arr = zeros(a_size, a_size, k_size);
    progress = cls_progress;
    progress.beg('Energy states calculation...', k_size);
    for k = 1:k_size
        a = a_arr(:,:,k);
        es_arr(:,:,k) = fn_elyap_s_var(a);
        progress.print();
    end
    progress.end();
end