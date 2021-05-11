% Mode-in-state Lyapunov PF.
% doc.pdf eq. 31.
% a = u * diag(e) * v
% eki - i mode (column) in k state (row).
function [eki] = fn_mislpf_2(u, e, v)
    n = size(e, 1);
    eki = zeros(n, n);
    for k = 1:n
        for i = 1:n
            for j = 1:n
               eki(k,i) = eki(k,i) -  real(u(k,i)' * u(k,j) * (v(j,:) * v(i,:)' / (e(i)' + e(j))));
            end
        end
    end
end