% Calculation of the Lyapunov energy of the k state (integral of the state squared).
% doc.pdf eq. 24.
% a - dynamic matrix.
function e = fn_elyap_s(a)
    n = size(a, 1);
    c = zeros(n, n);
    e = zeros(n, 1);
    % In matlab lyap use A*X + X*A' + Q = 0.
    % We use A'*X + X*A + Q = 0.
    a = a';
    for k = 1:n
        c(k,k) = 1.0;
        p = lyap(a, c);
        e(k) = trace(p);
        c(k,k) = 0.0;
    end
end