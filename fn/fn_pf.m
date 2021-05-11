% Participation factors (PF).
% doc.pdf eq. 3.
% u - right eigenvector columns.
% v - left eigenvector rows.
% p_ki = u_ik * v_ik.
% k - states, row.
% i - modes, column.
function pki = fn_pf(u, v)
    n = size(u, 1);
    pki = zeros(n, n);
    for k = 1:n
        for i = 1:n
            pki(k,i) = u(k,i) * v(i,k);
        end
    end
end