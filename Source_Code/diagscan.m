function [scan] = diagscan(N)

% DIAGSCAN Generate diagonal scanning pattern
%
%  [scan] = DIAGSCAN(N) Produces a diagonal scanning index for
%  an NxN matrix
%
%  The first entry in the matrix is assumed to be the DC coefficient
%  and is therefore not included in the scan

slast = N+1;
scan = slast;
while (slast ~= N*N)
  while ((slast > N) & (rem(slast,N) ~= 0)) 
    slast = slast - (N-1);
    scan = [scan slast];
  end
  if (slast == N*N) break; end
  if (slast < N)
    slast = slast + 1;
  else
    slast = slast + N;
  end
  scan = [scan slast];
  if (slast == N*N) break; end
  while ((slast < (N*N-N+1)) & (rem(slast, N) ~= 1))
    slast = slast + (N-1);
    scan = [scan slast];
  end
  if (slast == N*N) break; end
  if (slast < (N*N-N+1))
    slast = slast + N;
  else
    slast = slast + 1;
  end
  scan = [scan slast];
end

