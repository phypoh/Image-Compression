function rms = func_rms_quantise_dwt_mse(step_size, X, N)

%Parameters
X_zero = X-128;
dwtstep = func_dwtstepmse(N)*step_size;

Y = func_multilevel(X_zero, N);
[Yq, dwtent] = func_quantdwt(Y, dwtstep);
disp(dwtent)

Zq = func_multiinverse(Yq, N);

rms = std(Zq(:)-X_zero(:));

return 