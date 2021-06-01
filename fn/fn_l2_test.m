% New variant L2 coefficients (test version).
% a = u * diag(e) * v - dynamic matrix.
% c - observation matrix.
% x - initial value.
% es - energy of states.
% eijk - energy of i j mods in state k.
% eijk_norm - energy of i j mods in state k normed by diagonal sum.
function [es, eijk_norm, eijk] = fn_l2_test(u, e, v, c, x)
    a_n = size(u, 1);
    c_n = size(c, 1);
    cu = c * u;
    cr = zeros(c_n, a_n, a_n);
    for i = 1:a_n
        cr(:,:,i) = cu(:,i) * v(i,:);
    end
    q = zeros(c_n, c_n, c_n);
    for k = 1:c_n
        ek = zeros(c_n, 1);
        ek(k) = 1;
        q(:,:,k) = c' * ek * ek.' * c;
    end
    eijk = zeros(a_n, a_n, c_n);
    for i = 1:a_n
        for j = 1:a_n
            for k = 1:c_n
                pijk = cr(:,:,i)' * q(:,:,k) * cr(:,:,j) / (e(i)' + e(j));
                pijk = - (pijk + pijk') / 2;
                eijk(i,j,k) = x' * pijk * x;
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