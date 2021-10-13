function [ expt ] = fn_expt_curves( e, t_arr )
% fn_expt_curves returns an array of (1-exp^((l_i+l_j)t)) curves for
% time moments t in t_arr
%   Input args:
%   e - Eigenvalues column-vector
%   t_arr - Time interval [t_0:dt:t_end]
%   Output args:
%   expt - 2D Array of complex exponential curves

n = size(e, 1);
t_count = length(t_arr);
% one column - one first eigenvalue
expt = zeros(n, n, t_count);
ev_pairs = conj(e) + e.'; % matrix of vector-columns of l*_i + l_j
for tau = 1:t_count
    expt(:, :, tau) = 1 - exp(ev_pairs .* t_arr(tau));
end;
end

