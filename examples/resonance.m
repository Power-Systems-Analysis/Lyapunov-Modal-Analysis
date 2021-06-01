addpath('../fn');


%%
% Variant 1.
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


%%
% Variant 2.
par_name = 'k';
k_arr = 80:0.1:120;
k_size = size(k_arr, 2);
a_size = 4;
a_arr = zeros(a_size, a_size, k_size);
for k = 1:k_size
    a = [
          -1  100         10         0;
        -100   -1          0         0;
           0    0         -2  k_arr(k);
           0    0  -k_arr(k)        -2;
    ];
    a_arr(:,:,k) = a;
end


%%
% Variant 3 (LC).
R0 = 3;
R1 = 2;
R2 = 1;
L1 = 2 * 1e-3;
C1 = 0.5 * 1e-6;
L2 = 1e-3;
C2 = 1e-6;
par_name = 'C_2 uF';
k_arr = (0.5:0.001:1.5);
k_size = size(k_arr, 2);
a_size = 4;
a_arr = zeros(a_size, a_size, k_size);
for k = 1:k_size
    C2 = k_arr(k) * 1e-6;
    a_arr(:,:,k) = [
           -(R0 + R1)/L1, -1/sqrt(L1 * C1), R0/sqrt(L1 * L2),                0;
         1/sqrt(L1 * C1),                0,                0,                0;
        R0/sqrt(L1 * L2),                0,    -(R0 + R2)/L2, -1/sqrt(L2 * C2);
                       0,                0,  1/sqrt(L2 * C2),                0;
    ];
end

k = 500;
a = a_arr(:,:,k);
b = eye(a_size);
c = eye(a_size);
sys = ss(a, b, c, []);
t = 0:1e-8:0.005;
t_size = size(t, 2);
u = zeros(a_size, t_size);
x0 = ones(a_size, 1);
x0(1) = 1;
x0(2) = 0;
x0(3) = 0;
x0(4) = 0;
y = lsim(sys, u, t, x0);
figure;
plot(t, y);
legend('S1', 'S2', 'S3', 'S4');
grid on;
title(sprintf('Transient response C_2 = %0.2f uF', k_arr(k)));


%%
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
    for j = i:a_size
        l_arr(1, k) = i;
        l_arr(2, k) = j;
        k = k + 1;
    end
end
fn_plot('LMIE', k_arr, lmie_arr, l_arr, 'M%d/M%d', 0);
xlabel(par_name);


% Mode in state.
[l2_es_arr, l2_eijk_norm_arr] = fn_l2_arr(u_arr, e_arr, v_arr, eye(a_size));
[l2_eik_norm_arr] = fn_l2_mc_arr(u_arr, e_arr, v_arr, eye(a_size));

l_arr = zeros(2, a_size);
k = 1;
for s = 1:1
    for m = 1:4
        l_arr(1, k) = m;
        l_arr(2, k) = s;
        k = k + 1;
    end
end
fn_plot('L2 MC', k_arr, l2_eik_norm_arr, l_arr, 'M%d/S%d', 0);

% Mode in state.
l_arr = [
    1 1 3;
    1 3 3;
];
fn_plot('L2 MC and MI for state 1', k_arr, reshape(l2_eijk_norm_arr(:,:,1,:), [a_size, a_size, k_size]), l_arr, 'M%d/M%d', 0);
fn_plot('L2 MC and MI for state 3', k_arr, reshape(l2_eijk_norm_arr(:,:,3,:), [a_size, a_size, k_size]), l_arr, 'M%d/M%d', 0);


% Special initial conditions. 
x = zeros(a_size, 1);
x(1) = 1;
l2_es_arr_1 = zeros(a_size, k_size);
l2_eijk_norm_arr_1 = zeros(a_size, a_size, a_size, k_size);
for k = 1:k_size
    [l2_es_arr_1(:,k), l2_eijk_norm_arr_1(:,:,:,k)] = fn_l2_test(u_arr(:,:,k), e_arr(:,k), v_arr(:,:,k), eye(a_size), x);
end
% Mode in state.
l_arr = [
    1 1 3;
    1 3 3;
];
fn_plot('L2 MC and MI for state 1', k_arr, reshape(l2_eijk_norm_arr_1(:,:,1,:), [a_size, a_size, k_size]), l_arr, 'M%d/M%d', 0);

% Special initial conditions. 
x = zeros(a_size, 1);
x(3) = 1;
l2_es_arr_2 = zeros(a_size, k_size);
l2_eijk_norm_arr_2 = zeros(a_size, a_size, a_size, k_size);
for k = 1:k_size
    [l2_es_arr_2(:,k), l2_eijk_norm_arr_2(:,:,:,k)] = fn_l2_test(u_arr(:,:,k), e_arr(:,k), v_arr(:,:,k), eye(a_size), x);
end
% Mode in state.
l_arr = [
    1 1 3;
    1 3 3;
];
fn_plot('L2 MC and MI for state 3', k_arr, reshape(l2_eijk_norm_arr_2(:,:,3,:), [a_size, a_size, k_size]), l_arr, 'M%d/M%d', 0);

