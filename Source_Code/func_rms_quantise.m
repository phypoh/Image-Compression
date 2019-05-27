function rms = func_rms_quantise(step_size, X, N)

CN = dct_ii(N);
X_zero = X-128;
Y = colxfm(colxfm(X_zero, CN)', CN)';

Yq = quantise(Y, step_size);

Yr = regroup(Yq,N);

Z = colxfm(colxfm(Yq',CN')', CN');


rms = std(Z(:)-X_zero(:));

return 