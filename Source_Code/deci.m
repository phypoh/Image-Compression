function X1 = deci(X, h)

%DECIM Decimate a matrix to quarter size, 2D

X1 = rowdec(X, h);
%X1 = rowdec(X1, h);
X1 = rowdec(transpose(X1), h);
%X1 = rowdec(X1, h);

X1 = transpose(X1);

return