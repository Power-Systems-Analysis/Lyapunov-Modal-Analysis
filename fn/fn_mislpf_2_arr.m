% Calculating mislpf from the sequence.
function [mislpf_eki_arr] = fn_mislpf_2_arr(u_arr, e_arr, v_arr)
    a_size = size(u_arr, 1);
    k_size = size(u_arr, 3);
    mislpf_eki_arr = zeros(a_size, a_size, k_size);
    progress = cls_progress;
    progress.beg('MISLPF calculation...', k_size);
    for k = 1:k_size
        [mislpf_eki_arr(:,:,k)] = fn_mislpf_2(u_arr(:,:,k), e_arr(:,k), v_arr(:,:,k));
        progress.print();
    end
    progress.end();
end