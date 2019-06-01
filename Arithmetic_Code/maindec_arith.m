load flamingo
load cmp

if method == 'dct'
    [Z bits] = jpegdec_dct_arith(vlc, count_value, Y_seq, qstep, Y_min);
elseif method == 'lbt'
    [Z bits] = jpegdec_lbt_arith(vlc, count_value, Y_seq, qstep, Y_min);
elseif method == 'dwt'
    [Z bits] = jpegdec_dwt_arith(vlc, count_value, Y_seq, qstep, Y_min);
end

numbits = bits
rms = std(abs(X(:)-Z(:)))

draw(beside(X,Z))