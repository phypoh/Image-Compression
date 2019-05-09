function vlc = huffenc(rsa, ehuf)

% HUFFENC Convert a run-length encoded stream to huffman coding
%
%  [vlc] = HUFFENC(rsa) Performs Huffman encoding on the run-length
%  information in rsa, as produced by RUNAMPL.
%
%  The codewords are variable length integers in vlc(:,1)
%  whose lengths are in vlc(:,2). ehuf contains the huffman codes and
%  their lengths. The global matrix huffhist is updated for use in HUFFGEN

% huffhist is global to avoid in-efficient copying each time this function
% is called.
global huffhist

% check that the size is within sensible limits
if (max(rsa(:,2))>10)
    disp('Warning: Size of value in run-amplitude code is too large for Huffman table');
    rsa(find(rsa(:,2)>10),3) = 2^10-1;
    rsa(find(rsa(:,2)>10),2) = 10;
end

[r,c] = size(rsa);

vlc = [];
for i=1:r,
  run = rsa(i,1);

% If run > 15, use repeated codes for 16 zeros.
  while run > 15,
    code = 15*16 + 1;
    huffhist(code) = huffhist(code) + 1;
    vlc = [vlc; ehuf(code,:)];
    run = run - 16;
  end

% Code the run and size.
  code = run*16 + rsa(i,2) + 1;
  huffhist(code) = huffhist(code) + 1;
  vlc = [vlc; ehuf(code,:)];

% If size > 0, add in the remainder (which is not coded).
  if rsa(i,2) > 0,
    vlc = [vlc; rsa(i,[3 2])];
  end
  
end

return 