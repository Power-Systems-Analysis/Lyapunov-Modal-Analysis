% Lyapunov energy of the i-th mode.
% doc.pdf eq. between 37 and 38.
% u * diag(e) * v = a
% ezi = x0' * v' * pzi * v * x0
% pzi = - (ei * ei') / (2 * real(eigi))
function ez = fn_elyap_m(u, e, v)
    s = size(e, 1);
    p = zeros(s, s);
    ez = zeros(s, 1);
    v_tmp = v';
    for k = 1:s
        un = norm(u(:,k));
        p(k,k) = -0.5 * un * un / real(e(k));
        ez(k) = real(trace(v_tmp * p * v));
        % We return the value to 0 in order to set a new value at the next iteration.
        p(k,k) = 0;
    end
end