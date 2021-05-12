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
for i = 1:10
    a = [
          -1  100     i    0;
        -100   -1     0    0;
           0    0    -2  100;
           0    0  -100   -2;
    ];
    a_arr(:,:,i) = a;
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

### Lyapunov Energy of the State

```matlab
es = fn_elyap_s(a)
% es - vector (column) of Lyapunov Energy of each state
% es(k) - Lyapunov Energy of the k-th state
```

```matlab
es_arr = fn_elyap_s_arr(a_arr)
% es_arr - array of vector (column) of Lyapunov Energy of each state
% es_arr(k, i) - Lyapunov Energy of the k-th state of the i-th matrix
```

### Lyapunov Energy of the Mode

```matlab
em = fn_elyap_m(u, e, v)
% em - vector (column) of Lyapunov Energy of each mode
% em(k) - Lyapunov Energy of the k-th mode
```

```matlab
em_arr = fn_elyap_m_arr(u_arr, e_arr, v_arr)
% em - array of vector (column) of Lyapunov Energy of each mode
% em_arr(k, i) - Lyapunov Energy of the k-th mode of the i-th matrix
```

### Modal contribution (MC)

```matlab
emc = fn_elyap_mc(u, e, v)
% emc - vector (column) of MC of each mode to the Lyapunov energy of states
% emc(k) - MC of the k-th mode to the Lyapunov energy of states
```

```matlab
emc_arr = fn_elyap_mc_arr(u_arr, e_arr, v_arr)
% emc_arr - array of vector (column) of MC of each mode to the Lyapunov energy of states
% emc_arr(k, i) - MC of the k-th mode to the Lyapunov energy of states of the i-th matrix
```
