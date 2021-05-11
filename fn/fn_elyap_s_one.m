% Calculation of the Lyapunov energy of the k state (integral of the state squared).
% doc.pdf eq. 24.
% One external perturbation.
% a - dynamic matrix.
function e = fn_elyap_s_one(a)
    n = size(a, 1);
    c = zeros(n, n);
    e = zeros(n, 1);
    x = ones(n, 1);
    % In matlab lyap use A*X + X*A' + Q = 0.
    % We use A'*X + X*A + Q = 0.
    a = a';
    for k = 1:n
        c(k,k) = 1.0;
        p = lyap(a, c);
        e(k) = x' * p * x;
        c(k,k) = 0.0;
    end
end