% Calculation of the modes energy from the serial.
function [m_arr] = fn_elyap_m_arr(u_arr, e_arr, v_arr)
    a_size = size(u_arr, 1);
    k_size = size(u_arr, 3);
    m_arr = zeros(a_size, k_size);
    progress = cls_progress;
    progress.beg('Energy modes calculation...', k_size);
    for k = 1:k_size;
        u = u_arr(:,:,k);
        e = e_arr(:,k);
        v = v_arr(:,:,k);
        m_arr(:,k) = fn_elyap_m(u, e, v);
        progress.print();
    end
    progress.end();
end