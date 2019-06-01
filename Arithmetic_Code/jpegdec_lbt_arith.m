function [Z bits] = jpegdec_lbt_arith(code, count_value, Y_seq, qstep, Y_seq_min, output, N)

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
error(nargchk(2, 7, nargin, 'struct'));
if (nargin<7)
    N = 8;
    if (nargin<6)
        output = false;
    end
end

% Decode
dseq = arithdeco(code,count_value,length(Y_seq));

if output
    fprintf(1, 'Inverse quantising to step size of %i\n', qstep);
end

dseq = dseq - 1 - abs(Y_seq_min); % make back to zero

Zq = reshape(dseq, 256, 256); %reshape to matrix

Zi = quant2(Zq,qstep,qstep); %back to 1:256

code_size = size(code); 
bits = code_size(2); % number of bits used

if output
    fprintf(1, 'Inverse %i x %i LBT\n', N, N);
end
C8=dct_ii(N);
s = 1;
[Pf, Pr] = pot_ii(N, s);

Z=colxfm(colxfm(Zi',C8')',C8');
[I, ~] = size(Z);
t = [(1+N/2):(I-N/2)];

Z(:,t) = colxfm(Z(:,t)',Pr')';
Z(t,:) = colxfm(Z(t,:),Pr');
Z = Z + 128;

return