% The Lyapunov modal interaction energy (LMIE) old version.
% doc.pdf eq. 54.
% a = u * diag(e) * v
% eij - LMIE of the i-th and j-th modes in the system.
function [ezij] = fn_lmie_old(u, e, v)
    n = size(e, 1);
    ezij = zeros(n, n);
    r = fn_r(u, v);
    for i = 1:n
        % Since the matrix is symmetric, we count only half of.
        for j = 1:i
            ezij(i,j) = -0.5 * real(trace(r(:,:,i)' * r(:,:,j)) / (conj(e(i)) + e(j)) + trace(r(:,:,i).' * r(:,:,j)) / (e(i) + e(j)));
            if j < i
                ezij(j,i) = ezij(i,j);
            end
        end
    end
end