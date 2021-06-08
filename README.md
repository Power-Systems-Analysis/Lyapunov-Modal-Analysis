# Lyapunov Modal Analysis

## About
This repository contains the implementation of the calculation of various Lyapunov Modal Analysis indicators. 

## Content
* [fn](../main/fn) - implementation of equation from [doc.pdf](../main/doc/doc.pdf)
* [test](../main/test) - checking the correctness of the calculation of some equation
* [examples](../main/examples) - examples of using
* [doc](../main/doc) - documentation


## Usage

```matlab
% Add path to 'fn'
addpath('../fn');
```

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
% for valid values k:
% a_arr(:,:,k) = u_arr(:,:,k) * diag(e_arr(:,k)) * v_arr(:,:,k)
```

```matlab
% c - observation matrix.
% for example
c = [
      1  0  0  0;
      0  0  1  0;
];
```

### Lyapunov Energy of the State

```matlab
es = fn_elyap_s(a)
% es - vector (column) of Lyapunov Energy of each state
% es(i) - Lyapunov Energy of the i-th state
```

```matlab
es_arr = fn_elyap_s_arr(a_arr)
% es_arr - array of vector (column) of Lyapunov Energy of each state
% es_arr(i, k) - Lyapunov Energy of the i-th state of the k-th matrix
```

### Lyapunov Energy of the Mode

```matlab
em = fn_elyap_m(u, e, v)
% em - vector (column) of Lyapunov Energy of each mode
% em(i) - Lyapunov Energy of the i-th mode
```

```matlab
em_arr = fn_elyap_m_arr(u_arr, e_arr, v_arr)
% em - array of vector (column) of Lyapunov Energy of each mode
% em_arr(i, k) - Lyapunov Energy of the i-th mode of the k-th matrix
```

### Modal contribution (MC)

```matlab
emc = fn_elyap_mc(u, e, v)
% emc - vector (column) of MC of each mode to the Lyapunov energy of states
% emc(i) - MC of the i-th mode to the Lyapunov energy of states
```

```matlab
emc_arr = fn_elyap_mc_arr(u_arr, e_arr, v_arr)
% emc_arr - array of vector (column) of MC of each mode to the Lyapunov energy of states
% emc_arr(i, k) - MC of the i-th mode to the Lyapunov energy of states of the k-th matrix
```

### Mode-in-state Lyapunov participation factor (MISLPF)

```matlab
[mislpf, es] = fn_mislpf(u, e, v)
% mislpf(i, j) - MISLPF of the i-th mode in the j-th state
% es(i) - Lyapunov Energy of the i-th state
```

```matlab
[mislpf_arr, es_arr] = fn_mislpf_arr(u_arr, e_arr, v_arr)
% mislpf_arr(i, j, k) - MISLPF of the i-th mode in the j-th state of the k-th matrix
% es_arr(i, k) - Lyapunov Energy of the i-th state of the k-th matrix
```

### Lyapunov modal interaction energy (LMIE)

```matlab
lmie = fn_lmie(u, e, v)
% lmie(i, j) - LMIE of the i-th and j-th modes in the system
```

```matlab
lmie_arr = fn_lmie_arr(u_arr, e_arr, v_arr)
% lmie_arr(i, j, k) - LMIE of the i-th and j-th modes in the system of the k-th matrix
```

### The L2 modal contribution  (L2 MC) and L2 modal interaction (L2 MI)

```matlab
[es, eijk_norm, eijk] = fn_l2(u, e, v, c)
% es(k) - energy of k-th states.
% eijk(i,j,k) - energy of i-th and j-th mods of the k-th observation state.
% eijk_norm(i,j,k) - normed energy of i-th and j-th mods of the k-th observation state.
```

```matlab
% Only L2 MC, light version of fn_l2 only for i-th and i-th mods.
[eik_norm, eik] = fn_l2_mc(u, e, v, c)
% eik(i,k) - energy of the i-th mode of the k-th observation state.
% eik_norm(i,k) - normed energy of the i-th mode of the k-th observation state.
```
