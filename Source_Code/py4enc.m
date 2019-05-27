load lighthouse;

h = 1/4*[1 2 1];
%h = 1/16*[1 4 6 4 1];

X_zero = X-128;

X1 = deci(X_zero,h);
X2 = deci(X1,h);
X3 = deci(X2,h);
X4 = deci(X3,h);


%X1 = X1 - 128;
%X2 = X2 - 128;
%X3 = X3 - 128;
%X4 = X4 - 128;

Y0 = interpol(X1,h);
Y0 = X_zero-Y0;
Y1 = interpol(X2,h);
Y1 = X1-Y1;
Y2 = interpol(X3,h);
Y2 = X2-Y2;
Y3 = interpol(X4,h);
Y3 = X3-Y3;


%draw(beside(Y0,beside(Y1,beside(Y2,beside(Y3,X4)))))