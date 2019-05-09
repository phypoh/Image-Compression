function Y = regroup(X,N)

% REGROUP change ordering of a matrix
%
%  Y = REGROUP(X,N) Regroups the rows and columns of X, such that rows/cols
%  that are N apart in X, are adjacent in Y.
%
%  If N is a 2-element vector, N(1) is used for the columns
%  and N(2) for the rows.

if length(N) < 2, N = [N; N]; end

[m,n] = size(X);

if rem(m,N(1)) ~= 0 | rem(n,N(2)) ~= 0,
  error('Error in regroup: X dimensions are not multiples of N')
end

% Regroup row and column indices.
tm = reshape(reshape(1:m,N(1),m/N(1))',1,m);
tn = reshape(reshape(1:n,N(2),n/N(2))',1,n);

Y = X(tm,tn);



