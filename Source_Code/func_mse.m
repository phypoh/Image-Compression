function rms = func_mse(step_size, X, Y0, Y1, Y2, Y3, X4)

step_Y0 = 1;
step_Y1 = 1.5;
step_Y2 = 2.75;
step_Y3 = 5.375;
step_X4 = 10.6875;

h = 1/4*[1 2 1];
%h = 1/16*[1 4 6 4 1];

%Quantise everything
Y0q = quantise(Y0, step_size*step_Y0);
Y1q = quantise(Y1, step_size*step_Y1);
Y2q = quantise(Y2, step_size*step_Y2);
Y3q = quantise(Y3, step_size*step_Y3);

X4q = quantise(X4, step_size*step_X4);

bpp(X4q)
bpp(Y0q)
bpp(Y1q)
bpp(Y2q)
% bpp(Y3q)

%Interpolation
%Z3q = interpol(X4q,h) + Y3q;
Z2q = interpol(X4q,h) + Y2q;
Z1q = interpol(Z2q,h) + Y1q;
Z0q = interpol(Z1q,h) + Y0q;

rms = std(X(:)-Z0q(:))

draw(Z0q)

return