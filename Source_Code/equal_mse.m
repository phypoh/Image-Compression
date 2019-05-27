%Optimising step size

py4enc

%Initialisation of parameters
A = 1;
D = 17;
gold_ratio = 0.382;

X_zero = X-128;


%Initialising rmsX, the rms error we want to conform to
Xq = quantise(X_zero, step_size);
rmsX = std(X_zero(:)-Xq(:));

rmsdiff = 100;

while rmsdiff > 0.01
    
    interval = gold_ratio*(D-A);
    B = A + interval;
    C = D - interval;
    %disp([B C])
    
    rmsA = abs(rmsX - func_mse(A, X_zero, Y0, Y1, Y2, Y3, X3));
    rmsB = abs(rmsX - func_mse(B, X_zero, Y0, Y1, Y2, Y3, X3));
    rmsC = abs(rmsX - func_mse(C, X_zero, Y0, Y1, Y2, Y3, X3));
    rmsD = abs(rmsX - func_mse(D, X_zero, Y0, Y1, Y2, Y3, X3));
    
    if rmsB <= rmsC
        D = C
    elseif rmsB > rmsC
        A = B
    end
    
    rmsdiff = min([abs(rmsB) abs(rmsC)])
    
end
