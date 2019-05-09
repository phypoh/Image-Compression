function ra = runampl(a)

% RUNAMPL Create a run-amplitude encoding from input stream
%
%  [ra] = RUNAMPL(a) Converts the stream of integers in 'a' to a
%  run-amplltude encoding in 'ra'
%
%  Column 1 of ra gives the runs of zeros between each non-zero value.
%  Column 2 gives the JPEG sizes of the non-zero values (no of
%  bits excluding leading zeros).
%  Column 3 of ra gives the values of the JPEG remainder, which
%  is normally coded in offset binary.

% Check for any non-integer values in a
if (sum(abs(rem(a,1))))
  disp('Warning! RUNAMPL.M: Attempting to create run-amplitude from non-integer values');
end

% Generate indices to non-zero elements of a.
b = find(a(:));
if isempty(b),
  ra = [0 0 0];
  return
end

% List non-zero elements as a column vector.
c = reshape(a(b),length(b),1);

% Generate JPEG size vector ca = floor(log2(abs(c))+1)
ca = zeros(size(c));
k = 1;
cb = abs(c);
maxc = max(cb);
ka = 1;

% Form ca, and ka containing increasing powers of 2. 
while k <= maxc,
  ca = ca + (cb >= k);
  k = k * 2;
  ka = [ka; k];
end

% Find negative elements of c and add (2^ca - 1) to these to give the
% residuals of length ca bits.
cneg = find(c < 0);
c(cneg) = c(cneg) + ka(ca(cneg)+1) - 1;

% Assemble the 3 columns of ra.
ra=[diff([0;b])-1 ca c];

% Add end-of-block code (0,0,0) to all blocks for easy decoding.
ra = [ra; [0 0 0]];

% If last element of a(:) is zero, add end-of-block code (0,0,0)
% if a(length(a(:))) == 0,
%   ra = [ra; [0 0 0]];
% end
