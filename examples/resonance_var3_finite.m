addpath('../fn');

% Variant 3 (LC).
R0 = 3;
R1 = 2;
R2 = 1;
L1 = 2 * 1e-3;
C1 = 0.5 * 1e-6;
L2 = 1e-3;
C2 = 1e-6;
par_name = 'C_2 uF';
k_arr = (0.5:0.005:1.5);
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

% Finite energy calculation
c = [1 0 0 0];
x0 = [1 0 0 0]';
t = 0:1e-5:0.002;
fle1_surf = zeros(k_size, length(t));
fle3_surf = zeros(k_size, length(t));
for k = 1:k_size
    expt = fn_expt_curves(e_arr(:,k), t);
    exc_ij = fn_elyap_x0c(u_arr(:,:,k), e_arr(:,k), v_arr(:,:,k).', c, x0);
    fle_ij = zeros(size(expt));
    for tau=1:length(t)
        fle_ij(:,:,tau) = real(expt(:,:,tau)).*real(exc_ij)+...
            imag(expt(:,:,tau)).*imag(exc_ij); 
    end;
    fle_i = squeeze(sum(fle_ij));
    fle1_surf(k, :) = fle_i(1,:)*2;
    fle3_surf(k, :) = fle_i(3,:)*2;
end;
subplot(1,2,1);
surf(t, k_arr, fle1_surf);
xlabel('t, sec');
ylabel('k');
zlabel('C1+C2 (C1 output) finite Lyapunov Energy');
subplot(1,2,2);
surf(t, k_arr, fle3_surf);
xlabel('t, sec');
ylabel('k');
zlabel('C3+C4 (C1 output) finite Lyapunov Energy');