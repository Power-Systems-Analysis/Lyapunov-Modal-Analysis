% Getting eigenvalues and vectors.
% a - dynamic matrix.
% u - right eigenvector columns.
% v - left eigenvector rows.
function [u, e, v] = fn_eig(a)
    [u, e] = eig(a);
    v = inv(u);
    e = diag(e);
end