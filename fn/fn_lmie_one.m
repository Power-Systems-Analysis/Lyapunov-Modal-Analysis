% The Lyapunov modal interaction energy (LMIE) (one external perturbation).
% doc.pdf eq. 51.
% a = u * diag(e) * v
% eij - LMIE of the i-th and j-th modes in the system.
function [ezij] = fn_lmie_one(u, e, v)
    n = size(e, 1);
    x = ones(n, 1);
    ezij = zeros(n, n);
    r = fn_r(u, v);
    for i = 1:n
        % Since the matrix is symmetric, we count only half of.
        for j = 1:i
            pij = -0.5 * real(r(:,:,i)' * r(:,:,j) / (conj(e(i)) + e(j)) + r(:,:,i).' * r(:,:,j) / (e(i) + e(j)));
            ezij(i,j) = x' * pij * x;
            if j < i
                ezij(j,i) = ezij(i,j);
            end
        end
    end
end