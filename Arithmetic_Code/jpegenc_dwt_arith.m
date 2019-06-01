function [code counts key_values] = jpegenc_dwt_arith(X, qstep, output, N)
    
% JPEGENC Encode an image to a (simplified) JPEG bit stream
%
%  [vlc bits huffval] = jpegenc(X, qstep, N, M, opthuff, dcbits) Encodes the
%  image in X to generate the variable length bit stream in vlc.
%
%  X is the input greyscale image
%  qstep is the quantisation step to use in encoding
%  N is the width of the DCT block (defaults to 8)
%  M is the width of each block to be coded (defaults to N). Must be an
%  integer multiple of N - if it is larger, individual blocks are
%  regrouped.
%  if opthuff is true (defaults to false), the Huffman table is optimised
%  based on the data in X
%  dcbits determines how many bits are used to encode the DC coefficients
%  of the DCT (defaults to 8)
%
%  vlc is the variable length output code, where vlc(:,1) are the codes, and
%  vlc(:,2) the number of corresponding valid bits, so that sum(vlc(:,2))
%  gives the total number of bits in the image
%  bits and huffval are optional outputs which return the Huffman encoding
%  used in compression

% This is global to avoid too much copying when updated by huffenc
global huffhist  % Histogram of usage of Huffman codewords.

% Presume some default values if they have not been provided
error(nargchk(2, 7, nargin, 'struct'));
if ((nargout~=1) && (nargout~=3)) error('Must have one or three output arguments'); end
if (nargin<4)
    N = 8;
    if (nargin<3)
        output = false;
    end
end

 
% DWT on input image X.
level = 3;
X_zero = X-128;

if output 
    fprintf(1, 'Forward Level %N DWT\n', level);
end

dwtstep = func_dwtstepmse(level)*qstep;

Y = func_multilevel(X_zero, level);
% Quantise to integers.
if output
    fprintf(1, 'Quantising to step size of %i\n', qstep); 
end
[Yq, dwtent] = func_quantdwt_arith(Y, dwtstep);

Y_seq = reshape(Yq,1,[]);

count_key = [];

for i=1:(256*256)
    if ismember(Y_seq(i),count_key)==0
        count_key = [count_key Y_seq(i)];
    elseif ismember(Y_seq(i),count_key)==1
        continue
    end 
end 

[x y] = size(count_key);
count_value = zeros(1,y);

count_map = containers.Map(count_key,count_value);

for i=1:(256*256)
    if isKey(count_map,Y_seq(i)) == 1
        count_map(Y_seq(i)) = count_map(Y_seq(i)) + 1;
    else
        disp('Wrong key')
        return
    end
end

counts = cell2mat(values(count_map));
key_values = cell2mat(keys(count_map));

for i=1:(256*256)
    for j=1:y
        if key_values(j) == Y_seq(i)
            Y_seq(i) = j;
        end
    end
end

code = arithenco(Y_seq,counts);

return
