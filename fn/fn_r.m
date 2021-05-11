% Coefficients of the corresponding residue matrix.
% doc.pdf eq. 6.
% u - right eigenvector columns.
% v - left eigenvector rows.
function r = fn_r(u, v)
    n = size(u, 1);
    r = zeros(n, n, n);
    for i = 1:n
        r(:,:,i) = u(:,i) * v(i,:);
    end
end