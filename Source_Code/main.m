%Overall run scheme
load lighthouse
qstep = 17;

method = 'dwt';

bit_limit = 40960;
numbits = 256^2*8;

if method == 'dct'
    while numbits > bit_limit
        [vlc bits huffval] = jpegenc_dct(X, qstep);
        Z = jpegdec_dct(vlc, qstep);
        numbits = sum(vlc(:,2));
        qstep = qstep + 1;
    end
 
elseif method == 'lbt'
    while numbits > bit_limit
        [vlc bits huffval] = jpegenc_lbt(X, qstep);
        Z = jpegdec_lbt(vlc, qstep);
        numbits = sum(vlc(:,2));
        qstep = qstep + 1;
    end
elseif method == 'dwt'
    while numbits > bit_limit
        [vlc bits huffval] = jpegenc_dwt(X, qstep);
        Z = jpegdec_dwt(vlc, qstep);
        numbits = sum(vlc(:,2));
        qstep = qstep + 1;
    end
end

numbits = sum(vlc(:,2));
%[peaksnr, snr] = psnr(X, Z)
err = std(abs(X(:)-Z(:)));
ssimval = ssim(Z,X);,


fprintf('\nMethod: %s\nNumber of bits: %i\nRMS Value: %0.4f. \nSSIM value: %0.4f.\n', method, numbits, err, ssimval);
draw(beside(X,Z))