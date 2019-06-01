%Overall run scheme
load lighthouse

bit_limit = 40960;

qstep = 30;
numbits = 256^2*8;

numbits_map = containers.Map;
err = containers.Map;
ssimval = containers.Map;
Z_dict = containers.Map;


disp('Running DCT method...')
while numbits > bit_limit
    [code counts key_values] = jpegenc_dct_arith(X, qstep);
    [Z bits] = jpegdec_dct_arith(code, counts, key_values, qstep);
    numbits = bits;
    qstep = qstep + 1;
    disp([qstep bits])
end
disp('Done.')
numbits_map('dct') = bits;
err('dct') = std(abs(X(:)-Z(:)));
ssimval('dct') = ssim(Z,X);
Z_dict('dct') = Z;

disp('Running LBT method...')
qstep = 30;
numbits = 256^2*8;
while numbits > bit_limit
    [code counts key_values] = jpegenc_lbt_arith(X, qstep);
    [Z bits] = jpegdec_lbt_arith(code, counts, key_values, qstep);
    numbits = bits;
    qstep = qstep + 1;
    disp([qstep bits])
end
disp('Done.')
numbits_map('lbt') = bits;
err('lbt') = std(abs(X(:)-Z(:)));
ssimval('lbt') = ssim(Z,X);
Z_dict('lbt') = Z;


disp('Running DWT method...')
qstep = 30;
numbits = 256^2*8;
while numbits > bit_limit
    [code counts key_values] = jpegenc_dwt_arith(X, qstep);
    [Z bits] = jpegdec_dwt_arith(code, counts, key_values, qstep);
    numbits = bits;
    qstep = qstep + 1;
    disp([qstep bits])
end
disp('Done.')
numbits_map('dwt') = bits;
err('dwt') = std(abs(X(:)-Z(:)));
ssimval('dwt') = ssim(Z,X);
Z_dict('dwt') = Z;

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

fprintf('\nMethod: %s', method)
fprintf('\nNumber of bits: %i', numbits_map(method))
fprintf('\nRMS Value: %0.4f', err(method))
fprintf('\nSSIM Value: %0.4f\n', ssimval(method))

draw(beside(X,Z))