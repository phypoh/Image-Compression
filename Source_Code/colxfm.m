function Y = colxfm(X,C)

%COLXFM Column transformation.
%  Y = COLXFM(X, C) transforms the columns of X using the
%  transformation given in C. The height of X must be a
%  multiple of the size of C.

N = length(C);
[m,n] = size(X);

if rem(m,N) ~= 0,
  error('Error in colxfm: Height not a multiple of transform size.')
end

Y = zeros(m,n);
t = [1:N] - 1;

% Transform columns of each horizontal stripe of pixels, N high
% by n wide.
for i=1:N:m,
  Y(i+t,:) = C * X(i+t,:);
end
return
