%Quantising Laplacian Pyramid

step_size = 17;

h = 1/4*[1 2 1];

%Quantise everything
Y0q = quantise(Y0, step_size);
Y1q = quantise(Y1, step_size);
Y2q = quantise(Y2, step_size);
Y3q = quantise(Y3, step_size);

X2q = quantise(X2, step_size);

%Interpolation
%Z3q = interpol(X4q,h) + Y3q;
%Z2q = interpol(Z3q,h) + Y2q;
Z1q = interpol(X2q,h) + Y1q;
Z0q = interpol(Z1q,h) + Y0q;

std(X(:)-Z0q(:))

draw(Z0q)