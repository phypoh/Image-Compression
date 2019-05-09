function Y = convse(X, h)
%CONVSE Convolution with symmetrical extension
%  Y = CONVSE(X, H) Filters the rows of image X using H,
%  with symmetric extension of X.

narginchk(2,2);
nargoutchk(1,1);

[r, c] = size(X);
m = length(h);
m2 = fix((m)/2);

if rem(m,2) > 0,
  xe = [((m2+1):-1:2)  (1:c)  (c-(1:m2))];
else
  xe = [(m2:-1:1) (1:c) (c+1-(1:m2))];
end
t = 0:(c-1);

Y = zeros(r,c);
for i=1:m,
  Y = Y + h(i) * X(:,xe(t+i));
end

return