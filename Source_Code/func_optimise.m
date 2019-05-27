function rms = func_optimise(step_size, X, Y0, Y1, Y2, Y3, X4)


h = 1/4*[1 2 1];
%h = 1/16*[1 4 6 4 1];

%Quantise everything
Y0q = quantise(Y0, step_size);
Y1q = quantise(Y1, step_size);
Y2q = quantise(Y2, step_size);
Y3q = quantise(Y3, step_size);

X4q = quantise(X4, step_size);

%Interpolation
Z3q = interpol(X4q,h) + Y3q;
Z2q = interpol(Z3q,h) + Y2q;
Z1q = interpol(Z2q,h) + Y1q;
Z0q = interpol(Z1q,h) + Y0q;

rms = std(X(:)-Z0q(:));

draw(Z0q)

return