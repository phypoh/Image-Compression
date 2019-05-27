%Overall run scheme
load lighthouse
bit_limit = 40960;


qstep = 17;
numbits = 256^2*8;

numbits_map = containers.Map;
err = containers.Map;
ssimval = containers.Map;
Z_dict = containers.Map;


disp('Running DCT method...')
while numbits > bit_limit
    [vlc bits huffval] = jpegenc_dct(X, qstep);
    Z = jpegdec_dct(vlc, qstep);
    numbits = sum(vlc(:,2));
    qstep = qstep + 1;
end
disp('Done.')
numbits_map('dct') = sum(vlc(:,2));
err('dct') = std(abs(X(:)-Z(:)));
ssimval('dct') = ssim(Z,X);
Z_dict('dct') = Z;

disp('Running LBT method...')
qstep = 17;
numbits = 256^2*8;
while numbits > bit_limit
    [vlc bits huffval] = jpegenc_lbt(X, qstep);
    Z = jpegdec_lbt(vlc, qstep);
    numbits = sum(vlc(:,2));
    qstep = qstep + 1;
end
disp('Done.')
numbits_map('lbt') = sum(vlc(:,2));
err('lbt') = std(abs(X(:)-Z(:)));
ssimval('lbt') = ssim(Z,X);
Z_dict('lbt') = Z;


disp('Running DWT method...')
qstep = 17;
numbits = 256^2*8;
while numbits > bit_limit
    [vlc bits huffval] = jpegenc_dwt(X, qstep);
    Z = jpegdec_dwt(vlc, qstep);
    numbits = sum(vlc(:,2));
    qstep = qstep + 1;
end
disp('Done.')
numbits_map('dwt') = sum(vlc(:,2));
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