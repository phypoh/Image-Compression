function bits = vlctest(vlc)

% VLCTEST Test the validity of a vlc matrix
%  bits = VLCTEST(vlc) Returns the total number of bits to code
%  the vlc data.
%
%  The function also tests for (incorrect) negative entries and
%  entries with the wrong number of bits.

% Check for positive entries
neg = find(vlc(:,1) < 0);
if ~isempty(neg),
  disp('Negative entries in vlc(:,1) at rows:');
  [vlc(neg,1) neg]
end

% Check for wrong number of bits
invalid = find((2.^vlc(:,2) - 1) < vlc(:,1));
if ~isempty(invalid),
  disp('Invalid [data,nbits] entries in vlc(:,1:2) at rows:');
  [vlc(invalid,:) invalid]
end

% Calculate total number of bits to code vlc(:,1) entries.
bits = sum(vlc(:,2));
return