%Optimising step size
load bridge

%Initialisation of parameters
N=6;
step_size = 17;
A = 1;
D = 255;
gold_ratio = 0.382;

X_zero = X-128;

%Initialising rmsX, the rms error we want to conform to
Xq = quantise(X_zero, step_size);
rmsX = std(X_zero(:)-Xq(:));

rmsdiff = 100;

while rmsdiff > 0.001
    
    interval = gold_ratio*(D-A);
    B = A + interval;
    C = D - interval;
    disp([B C rmsdiff]);
    
    rmsA = abs(rmsX - func_rms_quantise_dwt_equal(A, X, N));
    rmsB = abs(rmsX - func_rms_quantise_dwt_equal(B, X, N));
    rmsC = abs(rmsX - func_rms_quantise_dwt_equal(C, X, N));
    rmsD = abs(rmsX - func_rms_quantise_dwt_equal(D, X, N));
    
    if rmsB <= rmsC
        D = C;
        final_step = C;
    elseif rmsB > rmsC
        A = B;
        final_step = B;
    end
    
    rmsdiff = min([abs(rmsB) abs(rmsC)]);
    
end

final_step
rmsdiff

dwtstep = zeros(3, N+1) + final_step;
Y = func_multilevel(X_zero, N);
[Yq, dwtent] = func_quantdwt(Y, dwtstep);

bits = 0;
for i = 1:N
    bits = bits + dwtent(1, i)*(2^(8-i))^2;
    bits = bits + dwtent(2, i)*(2^(8-i))^2;
    bits = bits + dwtent(3, i)*(2^(8-i))^2;
end
bits = bits + dwtent(1, n+1)*(2^(8-N-1))^2

Xbits = bpp(Xq)*256*256;
Ybits = bits;
ratio = Xbits/Ybits

Zq = func_multiinverse(Yq, N);
draw(beside(X_zero, beside(Xq, Zq)))