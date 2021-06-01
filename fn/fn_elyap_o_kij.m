% Energy of modal interaction of modes i and j at node k. 
% a - dynamic matrix.
% c - observation matrix.
% eo_kij - energy of modal interaction at node
%    k - row, node
function [eo_kij] = fn_elyap_o_kij(u, e, v, c, i, j)
    n_c = size(c, 1);
    eo_kij = zeros(n_c, 1);
    r_i = (c * u(:,i) * v(i,:))';
    r_j = c * u(:,j) * v(j,:);
    for k = 1:n_c
        eo_kij(k) = r_j(k,:) * r_i(:,k);
    end
    eij = -1 / (e(i)' + e(j));
    eo_kij = eo_kij * eij;
end