% Calculation of the Lyapunov energy for observations.
% a - dynamic matrix.
% с - observation matrix.
function eo = fn_elyap_o(a, c)
    n = size(c, 1);
    e = zeros(n, n);
    eo = zeros(n, 1);
    % In matlab lyap use A*X + X*A' + Q = 0.
    % We use A'*X + X*A + Q = 0.
    a = a';
    for k = 1:n
        e(k,k) = 1.0;
        p = lyap(a, c' * e * c);
        eo(k) = trace(p);
        e(k,k) = 0.0;
    end
end