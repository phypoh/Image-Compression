function y = conv2se(h1, h2, X)
% CONV2SE Symmetrical extension of CONV2
%
%  Y = CONV2SE(h1, h2, X) Convolves X with h1 and h2, using symmetrical
%  extension, otherwise as CONV2

narginchk(3,3);
nargoutchk(1,1);

[m, n] = size(X);

n1 = max(size(h1));
if (mod(n1,2)==0)
  n1 = n1/2;
  X2 = conv2(h1, 1, X([n1:-1:1 1:m m:-1:(m-n1+1)],:), 'valid');
else
  n1 = (n1-1)/2;
  X2 = conv2(h1, 1, X([(n1+1):-1:2 1:m (m-1):-1:(m-n1)],:), 'valid');
end

n2 = max(size(h2));
if (mod(n2,2)==0)
  n2 = n2/2;
  y = conv2(1, h2, X2(:,[n2:-1:1 1:n n:-1:(n-n2+1)],:), 'valid');
else
  n2 = (n2-1)/2;
  y = conv2(1, h2, X2(:,[(n2+1):-1:2 1:n (n-1):-1:(n-n2)],:), 'valid');
end