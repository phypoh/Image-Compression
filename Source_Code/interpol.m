function Y = interpol(X1, h)

%INTERPOL Interpolate a matrix to four times the size, 2D
two_h = 2*h;

Y = rowint(X1, two_h);
%Y = rowint(Y, two_h);
Y = rowint(transpose(Y), two_h);
%Y = rowint(Y, two_h);

Y = transpose(Y);

return