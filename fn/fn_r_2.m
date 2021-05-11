% Calculating residue through a derivative.
% doc.pdf eq. 4.
function r = fn_r_2(a)
    % Matrix element increment.
    eps_d = 1e-9;
    % How close are the eigenvalues to look for.
    eps_e = 0.1;
    %
    n = size(a, 1);
    r = zeros(n, n, n);
    e0 = eig(a);
    eps = zeros(n,n);
    % Loop through rows.
    for ri = 1:n
        % Loop through columns.
        for ci = 1:n
            eps(ri,ci) = eps_d;
            e1 = eig(a - eps);
            e2 = eig(a + eps);
            eps(ri,ci) = 0;
            % Loop over eigenvalues.
            for ei = 1:n
                % We are looking for nearby eigenvalues.
                de1 = abs(e1 - e0(ei));
                de2 = abs(e2 - e0(ei));
                idx1 = find(de1 < eps_e);
                idx2 = find(de2 < eps_e);
                % We are looking for a triple with minimal curvature.
                k_min = realmax;
                i1_min = 0;
                i2_min = 0;
                for i1 = 1:length(idx1)
                    for i2 = 1:length(idx2)
                        k = abs(0.5 * e1(idx1(i1)) + 0.5 * e2(idx2(i2)) - e0(ei));
                        if k < k_min
                            k_min = k;
                            i1_min = idx1(i1);
                            i2_min = idx2(i2);
                        end
                    end
                end
                % Derivative value.
                r(ci,ri,ei) = e2(i2_min) - e1(i1_min);
            end
        end
    end
    r = 0.5 * r / eps_d;
end