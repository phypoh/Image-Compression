%Optimising step size

load lighthouse

method = 'lbt';

step_size = 17;
X_zero = X-128;
A = 1;
D = 255;
gold_ratio = 0.382;



Xq = quantiseRise(X_zero, step_size);
rmsX = std(X_zero(:)-Xq(:));
Xbits = bpp(quantiseRise(X_zero, step_size))*256^2;

if method == 'lbt'
    %Initialisation of parameters
    N=16;
    s = 1;

    %Initialising rmsX, the rms error we want to conform to
    rmsdiff = 100;
    while rmsdiff > 0.001
        interval = gold_ratio*(D-A);
        B = A + interval;
        C = D - interval;

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

    CN = dct_ii(N);
    [Pf, Pr] = pot_ii(N, s);
    [I,~] = size(X);
    t = [(1+N/2):(I-N/2)];
    Xp = X_zero;
    Xp(t,:) = colxfm(Xp(t,:),Pf);
    Xp(:,t) = colxfm(Xp(:,t)',Pf)';

    Y = colxfm(colxfm(Xp, CN)', CN)';

    Yq = quantiseRise(Y, step_size);

    Ybits = dctbpp(Yq,N);
    ratio = Xbits/Ybits

    Z = colxfm(colxfm(Yq',CN')', CN');
    Z(:,t) = colxfm(Z(:,t)',Pr')';
    Z(t,:) = colxfm(Z(t,:),Pr');
end

if method == 'dwt'
    N=3;
    
    rmsdiff = 100;

    while rmsdiff > 0.01

        interval = gold_ratio*(D-A);
        B = A + interval;
        C = D - interval;

        rmsA = abs(rmsX - func_rms_quantise_dwt_mse(A, X, N));
        rmsB = abs(rmsX - func_rms_quantise_dwt_mse(B, X, N));
        rmsC = abs(rmsX - func_rms_quantise_dwt_mse(C, X, N));
        rmsD = abs(rmsX - func_rms_quantise_dwt_mse(D, X, N));

        if rmsB <= rmsC
            D = C;
            final_step = C;
        elseif rmsB > rmsC
            A = B;
            final_step = B;
        end

        rmsdiff = min([abs(rmsB) abs(rmsC)]);

    end

    dwtstep = func_dwtstepmse(N)*final_step;
    Y = func_multilevel(X_zero, N);
    [Yq, dwtent] = func_quantdwt(Y, dwtstep);

    bits = 0;
    for i = 1:N
        bits = bits + dwtent(1, i)*(2^(8-i))^2;
        bits = bits + dwtent(2, i)*(2^(8-i))^2;
        bits = bits + dwtent(3, i)*(2^(8-i))^2;
    end
    bits = bits + dwtent(1, N+1)*(2^(8-N-1))^2;

    Xbits = bpp(Xq)*256*256;
    Ybits = bits;
    ratio = Xbits/Ybits

    Z = func_multiinverse(Yq, N);
end
draw(Z)