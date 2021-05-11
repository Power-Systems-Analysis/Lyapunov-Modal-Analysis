% Lyapunov energy of the i-th mode (v2).
% doc.pdf eq. 27.
% u * diag(e) * v = a
function ez = fn_elyap_m_v2(u, e, v)
    n = size(e, 1);
    % In matlab lyap use A*X + X*A' + Q = 0.
    % We use A'*X + X*A + Q = 0.
    d = diag(e)';
    c = zeros(n, n);
    ez = zeros(n, 1);
    v_tmp = v';
    for k = 1:n
        c(k,k) = 1.0;
        p = lyap(d, c);
        ez(k) = trace(v_tmp * p * v);
        un = norm(u(:,k));
        ez(k) = real(un * un * ez(k));
        % We return the value to 0 in order to set a new value at the next iteration.
        c(k,k) = 0.0;
    end
end