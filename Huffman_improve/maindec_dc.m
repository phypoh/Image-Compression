load bridge
load cmp

if method == 'dct'
    Z = jpegdec_dct_dc(vlc, qstep);
elseif method == 'lbt'
    Z = jpegdec_lbt_dc(vlc, qstep);
elseif method == 'dwt'
    Z = jpegdec_dwt_dc(vlc, qstep);
end

numbits = vlctest(vlc)
rms = std(abs(X(:)-Z(:)))

draw(beside(X,Z))