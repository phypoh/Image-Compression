function C = dct_ii(N)

% DCT_II Discrete Cosine Transform matrix
%
%  C = DCT_II(N) Generates the 1-D DCT transform matrix of size N,
%  such that Y = C * X transforms N-vector X into Y.
%  Uses an orthogonal Type-II DCT 

C = ones(N,N) / sqrt(N);
theta = ([1:N] - 0.5) * (pi/N);
g = sqrt(2/N);
for i=2:N,
  C(i,:) = g * cos((i-1) * theta);
end

return
