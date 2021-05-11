% The Lyapunov modal interaction energy (LMIE).
% doc.pdf eq. 54.
% a = u * diag(e) * v
% eij - LMIE of the i-th and j-th modes in the system.
function [ezij] = fn_lmie(u, e, v)
    n = size(e, 1);
    ezij = zeros(n, n);
    r = fn_r(u, v);
    for i = 1:n
        v_i = reshape(r(:,:,i), 1, []);
        v_i_conj = conj(v_i);
        % Since the matrix is symmetric, we count only half of.
        for j = 1:i
            % A more efficient version of the trace from the product of matrices.
            % trace(A * B) = reshape(A.',1,[]) * reshape(B, [], 1);
            v_j = reshape(r(:,:,j), [], 1);
            trace_1 = v_i_conj * v_j;
            trace_2 = v_i * v_j;
            ezij(i,j) = -0.5 * real(trace_1 / (conj(e(i)) + e(j)) + trace_2 / (e(i) + e(j)));
            if j < i
                ezij(j,i) = ezij(i,j);
            end
        end
    end
end