load bridge
load cmp

if method == 'dct'
    Z = jpegdec_dct(vlc, qstep);
elseif method == 'lbt'
    Z = jpegdec_lbt(vlc, qstep);
elseif method == 'dwt'
    Z = jpegdec_dwt(vlc, qstep);
end

numbits = vlctest(vlc)
rms = std(abs(X(:)-Z(:)))

draw(beside(X,Z))
