%Transform Image X with DCT into Y, quantise then regroup it

load lighthouse

step_size = 17;

N = 8;
CN = dct_ii(N);
X_zero = X-128;
Y = colxfm(colxfm(X_zero, CN)', CN)';

Yq = quantise(Y, step_size);

Yr = regroup(Yq,N);
draw(Yr/8)

Z = colxfm(colxfm(Yq',CN')', CN');


max(abs(Z(:)-X_zero(:)))
std(Z(:)-X_zero(:))

Xq = quantise(X_zero, step_size);
max(abs(Xq(:)-X_zero(:)));
std(Xq(:)-X_zero(:));


