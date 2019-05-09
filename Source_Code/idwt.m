function Y = idwt(X,g1,g2)

% IDWT Inverse Discrete Wavelet Transform
%  Y = IDWT(X, G1, G2) returns a 1-level 2-D inverse discrete
%  wavelet transform on X.
%
%  If filters G1 and G2 are given, then they are used,
%  otherwise the LeGall filter pair are used.

if nargin < 3,
  g1=[1 2 1]/2;
  g2=[-1 -2 6 -2 -1]/4;
end

[m,n] = size(X);

m2 = m/2;
t = 1:m2;
Y=rowint(X(t,:)',g1)' + rowint2(X(t+m2,:)',g2)';

n2 = n/2;
t = 1:n2;
Y=rowint(Y(:,t),g1) + rowint2(Y(:,t+n2),g2);
