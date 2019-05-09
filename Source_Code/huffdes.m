function [bits, huffval] = huffdes(huffhist)

% HUFFDES Design Huffman table
%
%  [bits, huffval] = huffdes(huffhist) Generates the JPEG tables bits and
%  huffval from the 256-point histogram of values huffhist.
%  This is based on the algorithms in the JPEG Book Appendix K.2.

% Scale huffhist to sum to just less than 32K, allowing for the 162 ones we are about to add.
huffhist = huffhist * (127*256) / sum(huffhist);

% Add 1 to all valid points so they are given a code word.
% With the scaling, this should ensure that all probabilities exceed
% 1 in 2^16 so that no code words exceed 16 bits in length.
% This is probably a better method with poor statistics
% than the JPEG method of fig K.3.
freq = reshape(huffhist,16,16);
freq(2:11,:) = freq(2:11,:) + 1.1;  
freq(1,[1 16]) = freq(1,[1 16]) + 1.1;


% Reshape to a vector and add a 257th point to reserve the FFFF codeword.
% Also add a small negative ramp so that min() always picks the
% larger index when 2 points have the same probability.
freq = [freq(:); 1] - [1:257]'*1e-6;

codesize = zeros(257,1);
others = -ones(257,1);

% Find Huffman code sizes: JPEG fig K.1, procedure Code_size

% Find non-zero entries in freq and loop until 1 entry left.
nz = find(freq > 0);
while length(nz) > 1,

% Find v1 for least value of freq(v1) > 0.
  [y,i] = min(freq(nz));
  v1 = nz(i);

% Find v2 for next least value of freq(v2) > 0.
  nz = nz([1:(i-1)  (i+1):length(nz)]);  % Remove v1 from nz.
  [y,i] = min(freq(nz));
  v2 = nz(i);

% Combine frequency values to gradually reduce the code table size.
  freq(v1) = freq(v1) + freq(v2);
  freq(v2) = 0;

% Increment the codeword lengths for all codes in the two combined sets.
% Set 1 is v1 and all its members, stored as a linked list using 
% non-negative entries in vector others(). The members of set 1 are the
% frequencies that have already been combined into freq(v1).
  codesize(v1) = codesize(v1) + 1;
  while others(v1) > -1,
    v1 = others(v1);
    codesize(v1) = codesize(v1) + 1;
  end
  others(v1) = v2; % Link set 1 with set 2.

% Set 2 is v2 and all its members, stored as a linked list using 
% non-negative entries in vector others(). The members of set 2 are the
% frequencies that have already been combined into freq(v2).
  codesize(v2) = codesize(v2) + 1;
  while others(v2) > -1,
    v2 = others(v2);
    codesize(v2) = codesize(v2) + 1;
  end
  nz = find(freq > 0);
end

% Find no. of codes of each size: JPEG fig K.2, procedure Count_BITS

bits = zeros(max(16, max(codesize)),1);
for i = 1:256,
  if codesize(i) > 0, 
    bits(codesize(i)) = bits(codesize(i)) + 1;
  end
end

% Code length limiting not needed since 1's added earlier to all valid
% codes.
if max(codesize) > 16,
  disp('Warning! HUFFDES.M: max(codesize) > 16'); % This should not happen.
end

% Sort codesize values into ascending order and generate huffval:
% JPEG fig K.4, procedure Sort_input.

huffval = [];
t = 1:256;
for i = 1:16,
  ii = find(codesize(t) == i);
  huffval = [huffval; ii];
end

% Correct for indices of codesize going 1:256 instead of 0:255.
huffval = huffval - 1;

if length(huffval) ~= sum(bits),
  disp('Warning! HUFFDES.M: length of huffval ~= sum(bits)'); % This should not happen.
end
return
