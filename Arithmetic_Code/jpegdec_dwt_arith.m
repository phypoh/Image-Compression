function [Z bits] = jpegdec_dwt_arith(code, counts, key_values, qstep, output, N)

% JPEGDEC Decodes a (simplified) JPEG bit stream to an image
%
%  Z = jpegdec(vlc, qstep, N, M, bits huffval, dcbits, W, H) Decodes the
%  variable length bit stream in vlc to an image in Z.
%
%  vlc is the variable length output code from jpegenc
%  qstep is the quantisation step to use in decoding
%  N is the width of the DCT block (defaults to 8)
%  M is the width of each block to be coded (defaults to N). Must be an
%  integer multiple of N - if it is larger, individual blocks are
%  regrouped.
%  if bits and huffval are supplied, these will be used in Huffman decoding
%  of the data, otherwise default tables are used
%  dcbits determines how many bits are used to decode the DC coefficients
%  of the DCT (defaults to 8)
%  W and H determine the size of the image (defaults to 256 x 256)
%
%  Z is the output greyscale image

% Presume some default values if they have not been provided
error(nargchk(2, 6, nargin, 'struct'));
if (nargin<6)
    N = 8;
    if (nargin<5)
        output = false;
    end
end


level = 3;


dseq = arithdeco(code,counts,256*256);


if output
    fprintf(1, 'Inverse quantising to step size of %i\n', qstep);
end


for k=1:(256*256)
    dseq(k) = key_values(dseq(k));
end

Zi = reshape(dseq, 256, 256);
code_size = size(code);
bits = code_size(2);


if output
    fprintf(1, 'Inverse Level %i DWT\n', level);
end
Z = func_multiinverse(Zi, level);
Z = Z + 128;


return