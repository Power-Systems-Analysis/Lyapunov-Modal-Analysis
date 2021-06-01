% Checking the correctness of work.
function test(a_n, c_n)

    % Test matrix.
    a = randn(a_n);
    c = randn(c_n, a_n) + 1i * randn(c_n, a_n);
    % a = [-2, 1, 1; 1, -4, 2; 1, 1, -6];

    x = ones(a_n, 1);
    ck = zeros(a_n, a_n);
    err_all = 0.0;


    % Check fn_eig
    [u, e, v] = fn_eig(a);
    err_fn_eig = sum(sum(abs(u * diag(e) * v - a)));
    display(err_fn_eig);
    err_all = err_all + err_fn_eig;


    % Check fn_r
    r = fn_r(u, v);
    err_fn_r = 0.0;
    for s = 1:10
        tmp = zeros(a_n, a_n);
        for i = 1:a_n
            tmp = tmp + r(:,:,i) / (s - e(i));
        end
        tmp = tmp - inv(s * eye(a_n) - a);
        err_fn_r = err_fn_r + sum(sum(abs(tmp)));
    end
    display(err_fn_r);
    err_all = err_all + err_fn_r;


    % Check fn_elyap_s_one
    % ek = fn_elyap_s_one(a);
    % ek_test = fn_elyap_s_one_int(a);
    % err_fn_elyap_s_one = sum(abs(ek - ek_test));
    % display(err_fn_elyap_s_one);
    % err_all = err_all + err_fn_elyap_s_one;


    % Check fn_elyap_m_one
    % ek = fn_elyap_m_one(u, e, v);
    % ek_test = fn_elyap_m_one_int(u, e, v);
    % err_fn_elyap_one_m = sum(abs(ek - ek_test));
    % display(err_fn_elyap_one_m);
    % err_all = err_all + err_fn_elyap_one_m;


    % Check fn_elyap_m_2 (alternative calculation).
    ek = fn_elyap_m_v2(u, e, v);
    ek_test = fn_elyap_m(u, e, v);
    err_fn_elyap_m_v2 = sum(abs(ek - ek_test));
    display(err_fn_elyap_m_v2);
    err_all = err_all + err_fn_elyap_m_v2;


    % Check fn_elyap_m_2_one (alternative calculation).
    ek = fn_elyap_m_v2_one(u, e, v);
    ek_test = fn_elyap_m_one(u, e, v);
    err_fn_elyap_m_v2_one = sum(abs(ek - ek_test));
    display(err_fn_elyap_m_v2_one);
    err_all = err_all + err_fn_elyap_m_v2_one;


    % Check fn_mislpf (through the solution of the Lyapunov equation)
    [eki, ek] = fn_mislpf(u, e, v);
    eki_test = zeros(a_n, a_n);
    ek_test = zeros(a_n, 1);
    for k = 1:a_n
        ck(k,k) = 1.0;
        pk = lyap(a', ck);
        ek_test(k) = trace(pk);
        for i = 1:a_n
            pki = lyap(a', 0.5 * (r(:,:,i)' * ck + ck * r(:,:,i)));
            eki_test(k,i) = trace(pki);
        end
        eki_test(k,:) = eki_test(k,:) / ek_test(k);
        ck(k,k) = 0.0;
    end
    err_fn_mislpf = sum(sum(abs(eki - eki_test))) + sum(abs(ek - ek_test));
    display(err_fn_mislpf);
    err_all = err_all + err_fn_mislpf;


    % Check fn_mislpf_2
    % The sum of the energies of the modes over states is equal to the energy of the state
    eki = fn_mislpf_2(u, e, v);
    es_test = fn_elyap_s(a);
    for k = 1:a_n
        for i = 1:a_n
            es_test(k) = es_test(k) - eki(k,i);
        end
    end
    err_fn_mislpf_2 = sum(abs(es_test));
    display(err_fn_mislpf_2);
    err_all = err_all + err_fn_mislpf_2;


    % Check fn_mislpf_one (through the solution of the Lyapunov equation)
    [eki, ek] = fn_mislpf_one(u, e, v);
    eki_test = zeros(a_n, a_n);
    ek_test = zeros(a_n, 1);
    for k = 1:a_n
        ck(k,k) = 1.0;
        pk = lyap(a', ck);
        ek_test(k) = x' * pk * x;
        for i = 1:a_n
            pki = lyap(a', 0.5 * (r(:,:,i)' * ck + ck * r(:,:,i)));
            eki_test(k,i) = x' * pki * x;
        end
        eki_test(k,:) = eki_test(k,:) / ek_test(k);
        ck(k,k) = 0.0;
    end
    err_fn_mislpf_one = sum(sum(abs(eki - eki_test))) + sum(abs(ek - ek_test));
    display(err_fn_mislpf_one);
    err_all = err_all + err_fn_mislpf_one;


    % Check fn_elyap_mc
    % The sum of the energies mc is equal to the sum of the energies of the states
    ez = fn_elyap_mc(u, e, v);
    ek_test = fn_elyap_s(a);
    err_fn_elyap_mc = abs(sum(ez) - sum(ek_test));
    display(err_fn_elyap_mc);
    err_all = err_all + err_fn_elyap_mc;


    % Check fn_elyap_mc and fn_elyap_mc_old
    ez = fn_elyap_mc(u, e, v);
    ez_test = fn_elyap_mc_old(u, e, v);
    err_fn_elyap_mc_old = sum(abs(ez - ez_test));
    display(err_fn_elyap_mc_old);
    err_all = err_all + err_fn_elyap_mc_old;


    % Check fn_elyap_mck_one
    ez = fn_elyap_mc_one(u, e, v);
    ek_test = fn_elyap_s_one(a);
    err_fn_elyap_mc_one = abs(sum(ez) - sum(ek_test));
    display(err_fn_elyap_mc_one);
    err_all = err_all + err_fn_elyap_mc_one;


    % Check fn_lmie
    ezij = fn_lmie(u, e, v);
    ez_test = fn_elyap_mc(u, e, v);
    for i = 1:a_n
        for j = 1:a_n
            ez_test(i) = ez_test(i) - ezij(i,j);
        end
    end
    err_fn_lmie = sum(abs(ez_test));
    display(err_fn_lmie);
    err_all = err_all + err_fn_lmie;


    % Check fn_lmie_2
    % The sum of paired energies in a given mode is equal mc
    ezij = fn_lmie_2(u, e, v);
    ez_test = fn_elyap_mc(u, e, v);
    for i = 1:a_n
        for j = 1:a_n
            ez_test(i) = ez_test(i) - ezij(i,j);
        end
    end
    err_fn_lmie_2 = sum(abs(ez_test));
    display(err_fn_lmie_2);
    err_all = err_all + err_fn_lmie_2;


    % Check fn_lmie_s
    % The sum of the paired energies over all states is equal lmie
    eijk = fn_lmie_s(u, e, v);
    eij_test = fn_lmie_2(u, e, v);
    for i = 1:a_n
        for j = 1:a_n
            for k = 1:a_n
                eij_test(i,j) = eij_test(i,j) - eijk(i,j,k);
            end
        end
    end
    err_fn_lmie_s = sum(abs(eij_test), 'all');
    display(err_fn_lmie_s);
    err_all = err_all + err_fn_lmie_s;


    % Check fn_lmie_one
    ezij = fn_lmie_one(u, e, v);
    ez_test = fn_elyap_mc_one(u, e, v);
    for i = 1:a_n
        for j = 1:a_n
            ez_test(i) = ez_test(i) - ezij(i,j);
        end
    end
    err_fn_lmie_one = sum(abs(ez_test));
    display(err_fn_lmie_one);
    err_all = err_all + err_fn_lmie_one;


    % Check fn_elyap_o
    eo = fn_elyap_o(a, eye(a_n));
    es_test = fn_elyap_s(a);
    err_fn_elyap_o = sum(abs(es_test - eo));
    display(err_fn_elyap_o);
    err_all = err_all + err_fn_elyap_o;


    % Check fn_elyap_o_ik and fn_elyap_o_ki_old
    eo_ki = fn_elyap_o_ki(u, e, v, a, c);
    eo_ki_old = fn_elyap_o_ki_old(u, e, v, a, c);
    err_fn_elyap_o_ik_old = sum(sum(abs(eo_ki - eo_ki_old)));
    display(err_fn_elyap_o_ik_old);
    err_all = err_all + err_fn_elyap_o_ik_old;


    % Check fn_elyap_o_ki
    % The sum over all i must match fn_elyap_o
    eo_ki = fn_elyap_o_ki(u, e, v, a, c);
    es_test = fn_elyap_o(a, c);
    for k = 1:c_n
        for i = 1:a_n
            es_test(k) = es_test(k) - eo_ki(k, i);
        end
    end
    err_fn_elyap_o_ki = sum(abs(es_test));
    display(err_fn_elyap_o_ki);
    err_all = err_all + err_fn_elyap_o_ki;


    % Check fn_elyap_o_kij
    % The sum over all j must match fn_elyap_o_ki
    eo_ki_test = fn_elyap_o_ki(u, e, v, a, c);
    for i = 1:a_n
        for j = 1:a_n
            eo_kij = fn_elyap_o_kij(u, e, v, c, i, j);
            eo_ki_test(:,i) = eo_ki_test(:,i) - eo_kij;
        end
    end
    err_fn_elyap_o_kij = sum(sum(abs(eo_ki_test)));
    display(err_fn_elyap_o_kij);
    err_all = err_all + err_fn_elyap_o_kij;


    % Check fn_elyap_s_var
    es_var = fn_elyap_s_var(a);
    % es_var_test = fn_elyap_s(a);
    [~, es_var_test] = fn_mislpf(u, e, v);
    err_fn_elyap_s_var = sum(abs(sum(es_var, 2) - es_var_test));
    display(err_fn_elyap_s_var);
    err_all = err_all + err_fn_elyap_s_var;

    % fn_l2
    [es, eijk_norm, eijk] = fn_l2(u, e, v, c);
    % fn_l2 es
    es_test = fn_elyap_o(a, c);
    err_fn_l2_es = sum(abs(es_test - es));
    display(err_fn_l2_es);
    err_all = err_all + err_fn_l2_es;
    % fn_l2 eijk
    eijk_test = zeros(a_n, a_n, c_n);
    r = fn_r(u, v);
    for i = 1:a_n
        for j = 1:a_n
            for k = 1:c_n
                ek = zeros(c_n, 1);
                ek(k) = 1;
                q = c' * ek * ek.' * c;
                pijk = r(:,:,i)' * q * r(:,:,j) / (e(i)' + e(j));
                pijk = - (pijk + pijk') / 2;
                eijk_test(i,j,k) = trace(pijk);
            end
        end
    end
    err_fn_l2_eijk = sum(abs(eijk_test - eijk), 'all');
    display(err_fn_l2_eijk);
    err_all = err_all + err_fn_l2_eijk;
    
    
    % fn_l2
    [eik_norm, eik] = fn_l2_mc(u, e, v, c);
    err_fn_l2_mc = 0;
    for i = 1:a_n
        err_fn_l2_mc = err_fn_l2_mc + sum(abs(eik_norm(i,:) - reshape(eijk_norm(i,i,:), [1, c_n])), 'all');
    end
    display(err_fn_l2_mc);
    err_all = err_all + err_fn_l2_mc;
    
    % Total error
    display(err_all);

end
