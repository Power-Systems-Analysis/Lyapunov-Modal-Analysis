% Calculation of the Lyapunov energy for observations from the sequence.
function [eo_arr] = fn_elyap_o_arr(a_arr, c_arr)
    c_size = size(c_arr, 1);
    k_size = size(a_arr, 3);
    eo_arr = zeros(c_size, k_size);
    progress = cls_progress;
    progress.beg('Observation energy calculation...', k_size);
    for k = 1:k_size
        a = a_arr(:,:,k);
        c = c_arr(:,:,k);
        eo_arr(:,k) = fn_elyap_o(a, c);
        progress.print();
    end
    progress.end();
end