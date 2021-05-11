% Calculation of the Lyapunov energy of the k state (integral of the state squared).
% doc.pdf eq. 24.
% One external perturbation in different states. 
% a - dynamic matrix.
% es:
%    row - state energy.
%    column - perturbation number.
function es = fn_elyap_s_var(a)
    n = size(a, 1);
    c = zeros(n, n);
    es = zeros(n, n);
    % In matlab lyap use A*X + X*A' + Q = 0.
    % We use A'*X + X*A + Q = 0.
    a = a';
    for k = 1:n
        c(k,k) = 1.0;
        p = lyap(a, c);
        for i = 1:n
            es(k,i) = p(i,i);
        end
        c(k,k) = 0.0;
    end
end