addpath('../fn');

par_name = 'k';
k_arr = 0.0:0.1:10;
k_size = size(k_arr, 2);
a_size = 4;
a_arr = zeros(a_size, a_size, k_size);
for k = 1:k_size
    a = [
          -1  100     k_arr(k)  0;
        -100   -1     0         0;
           0    0    -2       100;
           0    0  -100        -2;
    ];
    a_arr(:,:,k) = a;
end

% Calculating eigenvectors
fprintf('Sorting eigenvalues...\n');
[u_arr, e_arr, v_arr] = fn_eigenshuffle(a_arr);
fprintf('Done.\n');


% Charts
l_arr = 1:a_size;
fn_plot('Real part of eigenvalues', k_arr, real(e_arr), l_arr, 'M%d', 0);
xlabel(par_name);
fn_plot('Imaginary part of eigenvalues', k_arr, imag(e_arr), l_arr, 'M%d', 0);
xlabel(par_name);


% Energy calculation
[s_arr] = fn_elyap_s_arr(a_arr);
[m_arr] = fn_elyap_m_arr(u_arr, e_arr, v_arr);
[mc_arr] = fn_elyap_mc_arr(u_arr, e_arr, v_arr);
[mislpf_eki_arr, mislpf_ek_arr] = fn_mislpf_arr(u_arr, e_arr, v_arr);
[lmie_arr] = fn_lmie_arr(u_arr, e_arr, v_arr);


l_arr = 1:a_size;
fn_plot('States energy', k_arr, mislpf_ek_arr, l_arr, 'S%d', 0);
xlabel(par_name);
fn_plot('States energy', k_arr, s_arr, l_arr, 'S%d', 0);
xlabel(par_name);

l_arr = 1:a_size;
fn_plot('Mode energy', k_arr, m_arr, l_arr, 'M%d', 0);
fn_plot('Modal contribution', k_arr, mc_arr, l_arr, 'M%d', 0);


% Mode in state.
l_arr = zeros(2, a_size);
k = 1;
for s = 4:4
    for m = 1:a_size
        l_arr(1, k) = s;
        l_arr(2, k) = m;
        k = k + 1;
    end
end
fn_plot('MISLPF', k_arr, mislpf_eki_arr, l_arr, 'S%d/M%d', 0);

l_arr = zeros(2, (a_size + 1) * a_size / 2);
k = 1;
for i = 1:a_size
    for j = 1:i
        l_arr(1, k) = i;
        l_arr(2, k) = j;
        k = k + 1;
    end
end
fn_plot('LMIE', k_arr, lmie_arr, l_arr, 'M%d/M%d', 0);
xlabel(par_name);
