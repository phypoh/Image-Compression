load bridge

%filters
h1 = [-1 2 6 2 -1]/8;
h2 = [-1 2 -1]/4;

X_zero = X-128;

%decimated and lowpass filtered version of X, aligned with even columns
U = rowdec(X_zero,h1);

%highpass image V, align decimated samples with odd columns of X
V = rowdec2(X_zero,h2);

%draw(beside(U,V))

E_U = sum(U(:).^2)
E_V = sum(V(:).^2)

UU = rowdec(U', h1)';
UV = rowdec2(U', h2)';
VU = rowdec(V', h1)';
VV = rowdec2(V', h2)';

draw([UU VU; UV VV])

%reconstruction
g1 = [1 2 1]/2;
g2 = [-1 -2 6 -2 -1]/4;
Ur = rowint(UU',g1)' + rowint2(UV',g2)';
Vr = rowint(VU',g1)' + rowint2(VV',g2)';
Xr = rowint(Ur,g1) + rowint2(Vr,g2);

max(abs(U(:)-Ur(:)))
max(abs(V(:)-Vr(:)))
max(abs(X_zero(:)-Xr(:)))

