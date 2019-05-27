load lighthouse

X_zero = X-128;

m = 256;

Y = dwt(X_zero);

m = m/2;
t = 1:m;
Y(t,t) = dwt(Y(t,t));
draw(Y)