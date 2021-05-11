% Modal contribution (MC) of the i-th mode to the Lyapunov energy of states.
% One external perturbation.
% doc.pdf eq. 46.
% u * diag(e) * v = a
function ez = fn_elyap_mc_one(u, e, v)
    s = size(e, 1);
    d = diag(e)';
    c = zeros(s, s);
    ez = zeros(s, 1);
    % We calculate in advance that we can.
    ut = 0.5 * u' * u;
    z1 = v * ones(s, 1);
    z2 = z1';
    for k = 1:s
        c(k,k) = 1;
        % A*X + X*A' + C = 0
        % e'*p + p*e + 0.5*(u'*u*c + c*u'*u) = 0
        p = lyap(d, ut * c + c * ut);
        ez(k) = real(z2 * p * z1);
        % We return the value to 0 in order to set a new value at the next iteration.
        c(k,k) = 0;
    end
end