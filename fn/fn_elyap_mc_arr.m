% Modal contribution (MC) from the serial.
function [mc_arr] = fn_elyap_mc_arr(u_arr, e_arr, v_arr)
    a_size = size(u_arr, 1);
    k_size = size(u_arr, 3);
    mc_arr = zeros(a_size, k_size);
    progress = cls_progress;
    progress.beg('Energy modes calculation...', k_size);
    for k = 1:k_size;
        u = u_arr(:,:,k);
        e = e_arr(:,k);
        v = v_arr(:,:,k);
        mc_arr(:,k) = fn_elyap_mc(u, e, v);
        progress.print();
    end
    progress.end();
end