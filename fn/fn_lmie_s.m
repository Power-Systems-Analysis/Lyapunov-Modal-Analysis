% Lyapunov pair PFs.
% doc.pdf eq. 56.
% a = u * diag(e) * v
% eijk(i,j,k) - Lyapunov energy of the k-th state variable associated with a pair of i-th and j-th modes.
function [eijk] = fn_lmie_s(u, e, v)
    n = size(e, 1);
    eijk = zeros(n, n, n);
    for i = 1:n
        for j = 1:n
           for k = 1:n
               eijk(j,i,k) = -real(u(k,i)' * u(k,j) * (v(j,:) * v(i,:)') / (e(i)' + e(j)));
               eijk(j,i,k) = 0.5 * (eijk(j,i,k) - real(u(k,i) * u(k,j) * (v(j,:) * v(i,:).') / (e(i) + e(j))));
           end
        end
    end
end