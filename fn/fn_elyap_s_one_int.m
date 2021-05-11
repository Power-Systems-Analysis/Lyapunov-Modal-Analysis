% Calculation of the Lyapunov energy of the k state through numerical integration (for verification).
% doc.pdf eq. 24.
% One external perturbation.
% a - dynamic matrix.
function e = fn_elyap_s_one_int(a)
    n = size(a, 1);
    t_max = 100.0;
    dt = 0.0001;
    a = a * dt;
    e = zeros(n, 1);
    x = ones(n, 1);
    for t = 0.0:dt:t_max
        e = e + x.^2;
        x = x + a * x;
    end
    e = e * dt;
end