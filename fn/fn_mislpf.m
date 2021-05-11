% Mode-in-state Lyapunov PF.
% doc.pdf eq. 37.
% a = u * diag(e) * v
% eki - i mode (column) in k state (row).
% ek - energy of states.
function [eki, ek] = fn_mislpf(u, e, v)
    n = size(e, 1);
    % Pre-calculated multiplications transpose(vij(i,j)) = transpose(v_i' * v_j).
    vij = v * v';
    for i = 1:n
        for j = 1:n
            vij(i,j) = vij(i,j) / (e(j)' + e(i));
        end
    end
    %
    eki = u * vij;
    eki = real(eki .* conj(u));
    %
    ek = sum(eki, 2);
    for k = 1:n
        norm = 1 / ek(k);
        eki(k,:) = eki(k,:) * norm;
    end
    ek = -ek;
end