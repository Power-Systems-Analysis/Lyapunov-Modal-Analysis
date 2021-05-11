% Lyapunov energy of the i-th mode (integration, for verification).
% doc.pdf eq. 27.
% One external perturbation.
% a - dynamic matrix.
function ez = fn_elyap_m_one_int(u, e, v)
    n = size(e, 1);
    t_max = 100.0;
    dt = 0.0001;
    a = u * diag(e) * v * dt;
    ez = zeros(n, 1);
    x = ones(n, 1);
    for t = 0.0:dt:t_max
        ez = ez + abs(v * x).^2;
        x = x + a * x;
    end
    ez = ez * dt;
    for k = 1:n
        un = norm(u(:,k));
        ez(k) = un * un * ez(k);
    end
end