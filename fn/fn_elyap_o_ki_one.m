% Lyapunov energy of mode i at node k.
% One external perturbation.
% a - dynamic matrix.
% с - observation matrix.
% eo_ki:
%    k - row, node
%    i - column, mode
function eo_ki = fn_elyap_o_ki_one(u, e, v, a, c)
    n_c = size(c, 1);
    n_a = size(c, 2);
    ek = zeros(n_c, n_c);
    eo_ki = zeros(n_c, n_a);
    r_i = fn_r(u, v);
    a_i = zeros(n_a, n_a, n_a);
    x = ones(n_c, 1);
    for i = 1:n_a
        a_i(:,:,i) = inv(conj(e(i)) * eye(n_a) + a);
    end
    for k = 1:n_c
        ek(k,k) = 1.0;
        qk = c' * ek * c;
        for i = 1:n_a
            p = r_i(:,:,i)' * qk * a_i(:,:,i);
            p = -0.5 * (p + p');
            eo_ki(k, i) = x' * p * x;
        end
        ek(k,k) = 0.0;
    end
end