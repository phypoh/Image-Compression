function C = dct_iv(N)

% DCT_IV Discrete Cosine Transform matrix
%
%  C = DCT_IV(N) Generates the 1-D DCT transform matrix of size N,
%  such that Y = C * X transforms N-vector X into Y.
%  Uses an orthogonal Type-IV DCT 

C = ones(N,N) / sqrt(N);
theta = ([1:N] - 0.5) * (pi/N);
g = sqrt(2/N);
for i=1:N,
  C(i,:) = g * cos((i-0.5) * theta);
end

return
