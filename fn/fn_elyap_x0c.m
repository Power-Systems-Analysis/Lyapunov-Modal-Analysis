function [ exc_ij ] = fn_elyap_x0c( u, e, v, c, x0 )
%fn_elyap_x0c - Mode-In-Multiple-States Lyapunov Energy x_0,C-dependent
%   Input args:
%   e - Eigenvalues column-vector
%   v - Left column-eigenvectors [EVL|input|MATLAB W]
%   u - Right column-eigenvectors [EVR|output|MATLAB V]
%   c - Observability row-matrix
%   x0 - Initial state column-vector
%   state - Number of a state|output
%   Output args:
%   exc_ij - 2D array of complex-valued Lyapunov energies
%==========================================================================
% MIMSLEX_ij Get E_xkij, based in equations (19) (31) and (33) with 
% arbitrary x0, i.e. initial conditions perturbation;

n = size(e, 1);
exc_ij = zeros(n, n);
for i = 1:n % i - number of the 1st mode in a pair
    % this loop is based on [DOC.PDF EQ.19] but with initial condition
    exc_col = zeros(n, 1);
    int_pairs = 1 ./ (conj(e(i))+e);% by all L_i* + L_j foreach j
    for j = 1:n % j - number of the 2nd mode in a pair
        exc_col(j) = -int_pairs(j) * ...
            ((x0' * conj(v(:,i)) * (u(:,i))' * c.') *...
            (c * u(:,j) * v(:,j).' * x0));
    end;
    exc_ij(:, i) = exc_col;
end;
end

