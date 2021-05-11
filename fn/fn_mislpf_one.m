% Mode-in-state Lyapunov PF.
% doc.pdf eq. 33.
% One external perturbation.
% eki - i mode (column) in k state (row).
% ek - energy of states.
function [eki, ek] = fn_mislpf_one(u, e, v)
    n = size(e, 1);
    eki = zeros(n, n);
    x = ones(n, 1);
    % eq. 31
    for k = 1:n
        for i = 1:n
            pki = zeros(n, n);
            for j = 1:n
                pki = pki + v(i,:)' * u(k,i)' * u(k,j) * v(j,:) / (e(i)' + e(j));
            end
            pki = -0.5 * (pki + pki');
            eki(k,i) = x' * pki * x;
        end
    end
    ek = sum(eki, 2);
    for k = 1:n
        norm = 1 / ek(k);
        for i = 1:n
            eki(k,i) = eki(k,i) * norm;
        end
    end
end