% Mode-in-state Lyapunov PF (not optimized version).
% doc.pdf eq. 37.
% a = u * diag(e) * v
% eki - i mode (column) in k state (row).
% ek - energy of states.
function [eki, ek] = fn_mislpf_old(u, e, v)
    n = size(e, 1);
    eki = zeros(n, n);
    % Pre-calculated multiplications vij(i,j) = v_i' * v_j.
    vij = conj(v) * transpose(v);
    for i = 1:n
        for j = 1:n
            vij(i,j) = vij(i,j) / (e(i)' + e(j));
        end
    end
    for k = 1:n
        for i = 1:n
            for j = 1:n
                eki(k,i) = eki(k,i) + vij(i,j) * u(k,j);
            end
            eki(k,i) = real(eki(k,i) * u(k,i)');
        end
    end
    ek = sum(eki, 2);
    for k = 1:n
        norm = 1 / ek(k);
        for i = 1:n
            eki(k,i) = eki(k,i) * norm;
        end
    end
    ek = -ek;
end