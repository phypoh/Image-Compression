%Overall run scheme
load flamingo
warning off;
bit_limit = 40960;

qstep = 17;
numbits = 256^2*8;

numbits_map = containers.Map;
err = containers.Map;
ssimval = containers.Map;
Z_dict = containers.Map;

code_map = containers.Map;
qstep_map = containers.Map;
count_map = containers.Map;
Y_dict = containers.Map;
Y_min_map = containers.Map;


disp('Running DCT method...')
while numbits > bit_limit
    [code count_value Y_seq Y_min] = jpegenc_dct_arith(X, qstep);
    [Z bits] = jpegdec_dct_arith(code, count_value, Y_seq, qstep, Y_min);
    numbits = bits;
    qstep = qstep + 1;
end
disp('Done.')
numbits_map('dct') = bits;
err('dct') = std(abs(X(:)-Z(:)));
ssimval('dct') = ssim(Z,X);
Z_dict('dct') = Z;
code_map('dct') = code;
qstep_map('dct') = qstep-1;
count_map('dct') = count_value;
Y_dict('dct') = Y_seq;
Y_min_map('dct') = Y_min;


disp('Running LBT method...')
qstep = 17;
numbits = 256^2*8;
while numbits > bit_limit
    [code count_value Y_seq Y_min] = jpegenc_lbt_arith(X, qstep);
    [Z bits] = jpegdec_lbt_arith(code, count_value, Y_seq, qstep, Y_min);
    numbits = bits;
    qstep = qstep + 1;
end
disp('Done.')
numbits_map('lbt') = bits;
err('lbt') = std(abs(X(:)-Z(:)));
ssimval('lbt') = ssim(Z,X);
Z_dict('lbt') = Z;
code_map('lbt') = code;
qstep_map('lbt') = qstep-1;
count_map('lbt') = count_value;
Y_dict('lbt') = Y_seq;
Y_min_map('lbt') = Y_min;

disp('Running DWT method...')
qstep = 17;
numbits = 256^2*8;
while numbits > bit_limit
    [code count_value Y_seq Y_min] = jpegenc_dwt_arith(X, qstep);
    [Z bits] = jpegdec_dwt_arith(code, count_value, Y_seq, qstep, Y_min);
    numbits = bits;
    qstep = qstep + 1;
end
disp('Done.')
numbits_map('dwt') = bits;
err('dwt') = std(abs(X(:)-Z(:)));
ssimval('dwt') = ssim(Z,X);
Z_dict('dwt') = Z;
code_map('dwt') = code;
qstep_map('dwt') = qstep-1;
count_map('dwt') = count_value;
Y_dict('dwt') = Y_seq;
Y_min_map('dwt') = Y_min;


method = 'lbt';
ssimval_array = values(ssimval);
if ssimval('dct') == max([ssimval_array{:}])
    method = 'dct';
elseif ssimval('lbt') ==  max([ssimval_array{:}])
    method = 'lbt';
elseif ssimval('dwt') == max([ssimval_array{:}])
    method = 'dwt';
else
    disp('Error occured during comaprison. Setting default to lbt.')  
end

vlc = code_map(method);
qstep = qstep_map(method);
count_value = count_map(method);
Y_seq = Y_dict(method);
Y_min = Y_min_map(method);

fprintf('\nMethod: %s', method)
fprintf('\nNumber of bits: %i', numbits_map(method))
fprintf('\nRMS Value: %0.4f', err(method))
fprintf('\nSSIM Value: %0.4f\n', ssimval(method))
save('cmp.mat','vlc','qstep', 'method','count_value','Y_seq','Y_min')

draw(beside(X,Z))