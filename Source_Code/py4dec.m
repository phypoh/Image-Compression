%Decoding the Laplacian pyramid imageed
%h = 1/4*[1 2 1];
h = 1/16*[1 4 6 4 1];

%Interpolation
Z3 = interpol(X4,h) + Y3;
Z2 = interpol(Z3,h) + Y2;
Z1 = interpol(Z2,h) + Y1;
Z0 = interpol(Z1,h) + Y0;

max(abs(X_zero(:)-Z0(:)))

draw(beside(Z3,beside(Z2,beside(Z1,Z0))))