% New variant L2 coefficients.
% Light version of fn_l2 (only i i mode).
% Spherically symmetric initial conditions.
% a = u * diag(e) * v - dynamic matrix.
% c - observation matrix.
% eik - energy of i mods in state k.
% eik_norm - energy of i mods in state k normed by diagonal sum.
function [eik_norm, eik] = fn_l2_mc(u, e, v, c)
    a_n = size(u, 1);
    c_n = size(c, 1);
    cu = c * u;
    eik = zeros(a_n, c_n);
    for i = 1:a_n
        cri = cu(:,i) * v(i,:);
        for k = 1:c_n
            eik(i,k) = cri(k,:) * cri(k,:)';
        end
        eii = -1 / (e(i)' + e(i));
        eik(i,:) = real(eik(i,:) * eii);
    end
    %
    eik_norm = zeros(a_n, c_n);
    for k = 1:c_n
        norm = 1.0 / sum(eik(:,k));
        eik_norm(:,k) = eik(:,k) * norm;
    end
end