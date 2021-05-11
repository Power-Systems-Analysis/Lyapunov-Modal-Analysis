% Lyapunov energy of the i-th mode.
% doc.pdf eq. between 37 and 38.
% One external perturbation.
% u * diag(e) * v = a
% ezi = x0' * v' * pzi * v * x0
% pzi = - (ei * ei') / (2 * real(eigi))
function ez = fn_elyap_m_one(u, e, v)
    s = size(e, 1);
    p = zeros(s, s);
    ez = zeros(s, 1);
    x = ones(s, 1);
    % We calculate in advance the products of states by the eigenvector.
    x1 = x' * v';
    x2 = v * x;
    for k = 1:s
        un = norm(u(:,k));
        p(k,k) = -0.5 * un * un / real(e(k));
        ez(k) = real(x1 * p * x2);
        % We return the value to 0 in order to set a new value at the next iteration.
        p(k,k) = 0;
    end
end