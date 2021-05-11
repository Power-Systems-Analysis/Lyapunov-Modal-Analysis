% The Lyapunov modal interaction energy (LMIE).
% doc.pdf eq. 51.
% a = u * diag(e) * v
% eij - LMIE of the i-th and j-th modes in the system.
function [ezij] = fn_lmie_2(u, e, v)
    n = size(e, 1);
    ezij = zeros(n, n);
    for i = 1:n
        for j = 1:i
           ezij(j,i) = -real((u(:,i)' * u(:,j)) * (v(j,:) * v(i,:)') / (e(i)' + e(j)));
           ezij(j,i) = 0.5 * (ezij(j,i) - real((u(:,i).' * u(:,j)) * (v(j,:) * v(i,:).') / (e(i) + e(j))));
           % The matrix is symmetrical.
           if j < i
                ezij(i,j) = ezij(j,i);
            end
        end
    end
end