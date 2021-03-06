addpath('../fn');

% Testing procedure using curve fitting
% and randomized quarter-car model
% !!! REQUIRES MATLAB Curve Fitting Tool !!!

% Model initialization
% state vector: (zu vu zb zv)
% spectrum: 2 x complex pairs
x0 = [rand*0.01; rand*10; rand*0.1; rand]; % initial condition
%t_arr = 0:0.01:2; % time interval, s
kb = 20000+rand*20000; % 'body' spring stiffness, N/m
ku = 200000+rand*200000; % 'tyre' spring stiffness, N/m
cb = 2000+rand*1000; % 'body' damping, (N*s)/m
cu = 200+rand*400; % 'tyre' damping, (N*s)/m
Mu = 10+rand*40; % unsprung mass, kg
Mb = 200+rand*600; % 'body' mass, kg
a = [ 0 1 0 0;...
    -(kb+ku)/Mu -(cb+cu)/Mu -kb/Mu -cb/Mu;...
    0 0 0 1;...
    -kb/Mb -cb/Mb -kb/Mb -cb/Mb];
c = sqrt(cb)*[0 -1 0 1]; % output matrix
% calculating output
sys = ss(a, x0, c, []);
[y, t_arr, ~] = impulse(sys);
y2 = y.*y;
y2int = cumtrapz(t_arr, y2);
% calculating LMC
[u, e, v] = fn_eig(a);
expt = fn_expt_curves(e, t_arr);
exc_ij = fn_elyap_x0c( u, e, v.', c, x0 ); % !!!v - column-eigenvectors!!!
y2int_lyap = zeros(size(expt));
for tau=1:length(t_arr)
    y2int_lyap(:,:,tau) = real(expt(:,:,tau)).*real(exc_ij)+...
        imag(expt(:,:,tau)).*imag(exc_ij); 
end;
y2int_lyap_sum = squeeze(sum(squeeze(sum(y2int_lyap))));
plot(t_arr, y2int, t_arr, y2int_lyap_sum); % visual reconstruction

% curve fitting test
% assuming |spectrum = 2 pairs|

basis = ...
    {...
        sprintf('exp(%.5f*x)',2*real(e(1))),...
        sprintf('real(exp((%.5f+%.5f*1i)*x))',...
            2*real(e(1)),2*imag(e(1))),...
        sprintf('imag(exp((%.5f+%.5f*1i)*x))',...
            2*real(e(1)),2*imag(e(1))),...
        sprintf('exp(%.5f*x)',2*real(e(3))),...
        sprintf('real(exp((%.5f+%.5f*1i)*x))',...
            2*real(e(3)),2*imag(e(3))),...
        sprintf('imag(exp((%.5f+%.5f*1i)*x))',...
            2*real(e(3)),2*imag(e(3))),...
        sprintf('real(exp((%.5f+%.5f*1i)*x))',...
            real(e(1))+real(e(3)), imag(e(1))+imag(e(3))),...
        sprintf('imag(exp((%.5f+%.5f*1i)*x))',...
            real(e(1))+real(e(3)), imag(e(1))+imag(e(3))),...
        sprintf('real(exp((%.5f+%.5f*1i)*x))',...
            real(e(1))+real(e(3)), imag(e(1))-imag(e(3))),...
        sprintf('imag(exp((%.5f+%.5f*1i)*x))',...
            real(e(1))+real(e(3)), imag(e(1))-imag(e(3))),...
        '1'
    };
fx1 = fit(t_arr, y2int, basis);
val = coeffvalues(fx1);
ok_real = real(exc_ij)./...
    [val(1) val(2) val(9) val(7);...
    val(2) val(1) val(7) val(9);...
    val(9) val(7) val(4) val(5);...
    val(7) val(9) val(5) val(4)];
ok_imag = imag(exc_ij)./...
    [val(1) val(3) val(10) val(8);...
    val(3) val(1) val(8) val(10);...
    val(10) val(8) val(4) val(6);...
    val(8) val(10) val(6) val(4)];
% ACCEPTABLE VALUES ARE ~1 & ~0.5
fprintf('OK ~ 0.5 or 1.0\n');
ok = abs(ok_real) + abs(ok_imag)
