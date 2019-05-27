%Optimising step size

load lighthouse

%Initialisation of parameters
N=16;
s = 1;
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
    disp([B C])
    
    rmsA = abs(rmsX - func_rms_quantise_lbt(A, X, N, s));
    rmsB = abs(rmsX - func_rms_quantise_lbt(B, X, N, s));
    rmsC = abs(rmsX - func_rms_quantise_lbt(C, X, N, s));
    rmsD = abs(rmsX - func_rms_quantise_lbt(D, X, N, s));
    
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

CN = dct_ii(N);
[Pf, Pr] = pot_ii(N, s);

Xbits = bpp(quantise(X_zero, step_size))*256^2;

t = [(1+N/2):(I-N/2)];
Xp = X_zero;
Xp(t,:) = colxfm(Xp(t,:),Pf);
Xp(:,t) = colxfm(Xp(:,t)',Pf)';

Y = colxfm(colxfm(Xp, CN)', CN)';

Yq = quantise(Y, step_size);

Ybits = dctbpp(Yq,N)
ratio = Xbits/Ybits

Z = colxfm(colxfm(Yq',CN')', CN');
Zp = Z;
Zp(:,t) = colxfm(Zp(:,t)',Pr')';
Zp(t,:) = colxfm(Zp(t,:),Pr');

