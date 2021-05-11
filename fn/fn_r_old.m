% Coefficients of the corresponding residue matrix.
% doc.pdf eq. 6.
% Old version.
% u - right eigenvector columns.
% v - left eigenvector rows.
function r = fn_r_old(u, v)
    n = size(u, 1);
    r = zeros(n, n, n);
    for i = 1:n
        for k = 1:n
            for l = 1:n
                r(k,l,i) = u(k,i) * v(i,l);
            end
        end
    end
end