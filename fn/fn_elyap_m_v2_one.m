% Lyapunov energy of the i-th mode (v2).
% doc.pdf eq. 27.
% One external perturbation.
% u * diag(e) * v = a
function ez = fn_elyap_m_v2_one(u, e, v)
    n = size(e, 1);
    % In matlab lyap use A*X + X*A' + Q = 0.
    % We use A'*X + X*A + Q = 0.
    d = diag(e)';
    c = zeros(n, n);
    ez = zeros(n, 1);
    x = ones(n, 1);
    % We calculate in advance the products of states by the eigenvector.
    z2 = v * x;
    z1 = z2';
    for k = 1:n
        c(k,k) = 1.0;
        p = lyap(d, c);
        ez(k) = z1 * p * z2;
        un = norm(u(:,k));
        ez(k) = real(un * un * ez(k));
        % We return the value to 0 in order to set a new value at the next iteration.
        c(k,k) = 0.0;
    end
end