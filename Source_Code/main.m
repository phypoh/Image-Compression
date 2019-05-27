%Overall run scheme
load bridge
qstep = 17;

method = 'dwt';

bit_limit = 40960;
numbits = 256^2*8;

if method == 'dct'
    while numbits > bit_limit
        [vlc bits huffval] = jpegenc(X, qstep);
        Z = jpegdec(vlc, qstep);
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

numbits = sum(vlc(:,2))
[peaksnr, snr] = psnr(X, Z)
err = std(abs(X(:)-Z(:)))
  
%fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
draw(beside(X,Z))