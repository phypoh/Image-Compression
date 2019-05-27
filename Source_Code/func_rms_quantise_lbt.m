function rms = func_rms_quantise_lbt(step_size, X, N, s)

%Parameters
[I, ~] = size(X);

CN = dct_ii(N);
X_zero = X-128;
[Pf, Pr] = pot_ii(N, s);

t = [(1+N/2):(I-N/2)];
Xp = X_zero;
Xp(t,:) = colxfm(Xp(t,:),Pf);
Xp(:,t) = colxfm(Xp(:,t)',Pf)';

Y = colxfm(colxfm(Xp, CN)', CN)';

Yq = quantise(Y, step_size);

Z = colxfm(colxfm(Yq',CN')', CN');
Zp = Z;
Zp(:,t) = colxfm(Zp(:,t)',Pr')';
Zp(t,:) = colxfm(Zp(t,:),Pr');


rms = std(Zp(:)-X_zero(:));

return 