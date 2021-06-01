% Lyapunov energy of mode i at node k. 
% a - dynamic matrix.
% c - observation matrix.
% eo_ki:
%    k - row, node
%    i - column, mode
% eo - total node energy
function [eo_ki, eo] = fn_elyap_o_ki(u, e, v, a, c)
    n_c = size(c, 1);
    n_a = size(c, 2);
    eo_ki = zeros(n_c, n_a);
    %
    r_i = zeros(n_a, n_c, n_a);
    for i = 1:n_a
        r_i(:,:,i) = (c * u(:,i) * v(i,:))';
    end
    %
    a_i = zeros(n_c, n_a, n_a);
    for i = 1:n_a
        a_i(:,:,i) = c / (conj(e(i)) * eye(n_a) + a);
    end
    %
    for k = 1:n_c
        for i = 1:n_a
            eo_ki(k, i) = -a_i(k,:,i) * r_i(:,k,i);
        end
    end
    eo = real(sum(eo_ki, 2));
end