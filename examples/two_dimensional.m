addpath('../fn');


par_name = 'k';
k_arr = -1.5:0.01:1.5;
% k_arr = k_arr(k_arr~=0.0);
k_size = size(k_arr, 2);
a_size = 2;
a_arr = zeros(a_size, a_size, k_size);
for k = 1:k_size
    a = [
         -2 + k_arr(k)             1;
         0             -2 - k_arr(k);
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
[l2_es_arr, l2_eijk_norm_arr] = fn_l2_arr(u_arr, e_arr, v_arr, eye(a_size));
[l2_eik_norm_arr] = fn_l2_mc_arr(u_arr, e_arr, v_arr, eye(a_size));

l_arr = 1:a_size;
fn_plot('Energy of states', k_arr, l2_es_arr, l_arr, 'S%d', 0);
xlabel(par_name);

% Mode in state.
l_arr = zeros(2, a_size);
k = 1;
for s = 1:1
    for m = 1:a_size
        l_arr(1, k) = m;
        l_arr(2, k) = s;
        k = k + 1;
    end
end
fn_plot('L2 MC', k_arr, l2_eik_norm_arr, l_arr, 'M%d/S%d', 0);

% Mode in state.
l_arr = zeros(2, a_size);
k = 1;
for m1 = 1:a_size
    for m2 = 1:a_size
        l_arr(1, k) = m1;
        l_arr(2, k) = m2;
        k = k + 1;
    end
end
fn_plot('L2 MC and MI for state 1', k_arr, reshape(l2_eijk_norm_arr(:,:,1,:), [a_size, a_size, k_size]), l_arr, 'M%d/M%d', 0);

