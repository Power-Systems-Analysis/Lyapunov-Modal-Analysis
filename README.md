# Lyapunov Modal Analysis

## About
This repository contains the implementation of the calculation of various Lyapunov Modal Analysis indicators. 

## Content
* [fn](../main/fn) - implementation of equation from [doc.pdf](../main/doc/doc.pdf)
* [test](../main/test) - checking the correctness of the calculation of some equation
* [examples](../main/examples) - examples of using
* [doc](../main/doc) - documentation


## Usage

### Notations

```matlab
% a - dynamic matrix
% for example
a = [
      -1  100     1         0;
    -100   -1     0         0;
       0    0    -2       100;
       0    0  -100        -2;
];
```

```matlab
[u, e, v] = fn_eig(a)
% e - eigenvalues (columns)
% u - right eigenvectors (columns)
% v - left eigenvectors (rows)
% a = u * diag(e) * v
```

```matlab
% a_arr - array of dynamic matrices
% for example
for k = 1:10
    a = [
          -1  100     k    0;
        -100   -1     0    0;
           0    0    -2  100;
           0    0  -100   -2;
    ];
    a_arr(:,:,k) = a;
end
```

```matlab
% Sorting eigenvalues
[u_arr, e_arr, v_arr] = fn_eigenshuffle(a_arr)
% e_arr - array of eigenvalues (columns)
% u_arr - array of right eigenvectors (columns)
% v_arr - array of left eigenvectors (rows)
% for valid values i:
% a_arr(:,:,i) = u_arr(:,:,i) * diag(e_arr(:,i)) * v_arr(:,:,i)
```

### Lyapunov Energy of State

```matlab
e = fn_elyap_s(a)
% e - vector (column) of Lyapunov Energy of each state
% e(k) - Lyapunov Energy of k-th state
```

```matlab
es_arr = fn_elyap_s_arr(a_arr)
% es_arr - array of vector (column) of Lyapunov Energy of each state
% es_arr(k, i) - Lyapunov Energy of k-th state of i-th matrix
```
