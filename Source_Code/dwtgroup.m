function Y = dwtgroup(X,n)

% DWTGROUP Change ordering of elements in a matrix
%
%  Y = DWTGROUP(X,n) Regroups the rows and columns of X, such that an
%  n-level DWT image composed of separate subimages is regrouped into 2^n x
%  2^n blocks of coefs from the same spatial region (like the DCT).
%
%  If n is negative the process is reversed.

Y = X;

if n==0, 
  return
elseif n<0,
  n = -n;
  invert = 1;
else
  invert = 0;
end

sx = size(X);
N = round(2^n);

if rem(sx(1),N) ~= 0 | rem(sx(2),N) ~= 0,
  error('Error in dwtgroup: X dimensions are not multiples of 2^n')
end

if invert==0,

% Determine size of smallest sub-image.
  sx = sx/N;

% Regroup the 4 subimages at each level, starting with the smallest
% subimages in the top left corner of Y.
  k = 1;  % Size of blocks of pels at each level.
  tm = 1:sx(1);
  tn = 1:sx(2);

% Loop for each level.
  for i = 1:n,  
    tm2 = [reshape(tm,k,sx(1)/k); reshape(tm+sx(1),k,sx(1)/k)];
    tn2 = [reshape(tn,k,sx(2)/k); reshape(tn+sx(2),k,sx(2)/k)];

    sx = sx * 2;
    k = k * 2;
    tm = 1:sx(1);
    tn = 1:sx(2);
    Y(tm,tn) = Y(tm2(:),tn2(:));
  end

else

% Invert the grouping:
% Determine size of largest sub-image.
  sx = size(X)/2;

% Regroup the 4 subimages at each level, starting with the largest
% subimages in Y.
  k = N/2;  % Size of blocks of pels at each level.

% Loop for each level.
  for i = 1:n,  
    tm = 1:sx(1);
    tn = 1:sx(2);
    tm2 = [reshape(tm,k,sx(1)/k); reshape(tm+sx(1),k,sx(1)/k)];
    tn2 = [reshape(tn,k,sx(2)/k); reshape(tn+sx(2),k,sx(2)/k)];

    Y(tm2(:),tn2(:)) = Y(1:(sx(1)*2),1:(sx(2)*2));

    sx = sx / 2;
    k = k / 2;
  end

end

return