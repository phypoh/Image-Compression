%Optimising step size

load lighthouse

%Initialisation of parameters
N=4;
step_size = 17;
A = 1;
D = 255;
gold_ratio = 0.382;

X_zero = X-128;


%Initialising rmsX, the rms error we want to conform to
Xq = quantise(X_zero, step_size);
rmsX = std(X_zero(:)-Xq(:));

rmsdiff = 100;

while rmsdiff > 0.0001
    
    interval = gold_ratio*(D-A);
    B = A + interval;
    C = D - interval;
    disp([B C])
    
    rmsA = abs(rmsX - func_rms_quantise(A, X, N));
    rmsB = abs(rmsX - func_rms_quantise(B, X, N));
    rmsC = abs(rmsX - func_rms_quantise(C, X, N));
    rmsD = abs(rmsX - func_rms_quantise(D, X, N));
    
    if rmsB <= rmsC
        D = C;
        final_step = C
    elseif rmsB > rmsC
        A = B;
        final_step = B
    end
    
    rmsdiff = min([abs(rmsB) abs(rmsC)])
    
end

CN = dct_ii(N);
Y = colxfm(colxfm(X_zero, CN)', CN)';
Yq = quantise(Y, final_step);
Yr = regroup(Yq,N);
Xbits = bpp(quantise(X_zero, step_size))*256^2
Ybits = dctbpp(Yr,N)
ratio = Xbits/Ybits

Z = colxfm(colxfm(Yq',CN')', CN');
draw(beside(X_zero, beside(Xq, Z)))
