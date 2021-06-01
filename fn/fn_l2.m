% New variant L2 coefficients.
% Spherically symmetric initial conditions.
% a = u * diag(e) * v - dynamic matrix.
% c - observation matrix.
% es - energy of states.
% eijk - energy of i j mods in state k.
% eijk_norm - energy of i j mods in state k normed by diagonal sum.
function [es, eijk_norm, eijk] = fn_l2(u, e, v, c)
    a_n = size(u, 1);
    c_n = size(c, 1);
    cu = c * u;
    cr = zeros(c_n, a_n, a_n);
    for i = 1:a_n
        cr(:,:,i) = cu(:,i) * v(i,:);
    end
    % trace(AB) = sum(aji * bij)
    % trace(hermitian(A)) = trace(real(À)) = real(trace(À))
    % eijk = trace(pijk)
    % pijk = -hermitian(ri' * q * rj / (ei' + ej))
    % pijk = -real(trace(ri' * q * rj / (ei' + ej)))
    % pijk = -real(trace(ri' * q * rj) / (ei' + ej))
    % q = c' * ek * ek.' * c
    % ri' * q * rj = crj' * ek * ek.' * crj
    % ri = c * ri
    % trace(cri' * ek * ek.' * crj) = crj(k,:) * cri(k,:)'
    eijk = zeros(a_n, a_n, c_n);
    for i = 1:a_n
        for j = i:a_n
            for k = 1:c_n
                eijk(i,j,k) = cr(k,:,j) * cr(k,:,i)';
            end
            eij = -1 / (e(i)' + e(j));
            eijk(i,j,:) = real(eijk(i,j,:) * eij);
            % Symmetric matrix.
            if i ~= j
                eijk(j,i,:) = eijk(i,j,:);
            end
        end
    end
    % Energy of states. 
    es = reshape(sum(eijk, [1, 2]), [c_n, 1]);
    %
    eijk_norm = zeros(a_n, a_n, c_n);
    for k = 1:c_n
        norm = 1.0 / trace(eijk(:,:,k));
        eijk_norm(:,:,k) = eijk(:,:,k) * norm;
    end
end