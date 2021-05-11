% Modal contribution (MC) of the i-th mode to the Lyapunov energy of states.
% doc.pdf eq. 45.
% u * diag(e) * v = a
function ez = fn_elyap_mc(u, e, v)
    n = size(e, 1);
    ez = zeros(n, 1);
    v_tmp = v';
    for i = 1:n
        p = zeros(n, n);
        for j = 1:n
            p(i,j) = -u(:,i)' * u(:,j) / (e(i)' + e(j));
        end
        p = 0.5 * (p + p');
        ez(i) = real(trace(v_tmp * p * v));
    end
end