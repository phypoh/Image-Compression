load lighthouse

method = 'dwt';

X_zero = X;

%Initialisation of parameters (LBT)
X_zero = X-128;

if method == 'lbt'
    N=16;
    s = 1;
    CN = dct_ii(N);
    [Pf, Pr] = pot_ii(N, s);
    [I, ~] = size(X);
    t = [(1+N/2):(I-N/2)];
    
    Ybits = 10^6;
    step_size = 1;
    
    while Ybits > 40960 
        step_size = step_size + 1;
        Xp = X_zero;
        Xp(t,:) = colxfm(Xp(t,:),Pf);
        Xp(:,t) = colxfm(Xp(:,t)',Pf)';

        Y = colxfm(colxfm(Xp, CN)', CN)';
        Yq = quantise(Y, step_size);
        Ybits = dctbpp(Yq,N);
    end
    
    Z = colxfm(colxfm(Yq',CN')', CN');
    Z(:,t) = colxfm(Z(:,t)',Pr')';
    Z(t,:) = colxfm(Z(t,:),Pr');

elseif method == 'dwt'
    N=3;
    Ybits = 10^6;
    step_size = 1;
    
    while Ybits > 40960
        step_size = step_size + 1;
        dwtstep = func_dwtstepmse(N)*step_size;
        Y = func_multilevel(X_zero, N);
        [Yq, dwtent] = func_quantdwt(Y, dwtstep);

        bits = 0;
        for i = 1:N
            bits = bits + dwtent(1, i)*(2^(8-i))^2;
            bits = bits + dwtent(2, i)*(2^(8-i))^2;
            bits = bits + dwtent(3, i)*(2^(8-i))^2;
        end
        bits = bits + dwtent(1, N+1)*(2^(8-N-1))^2;
        Ybits = bits;
    end
    Z = func_multiinverse(Yq, N);
end

Z = Z + 128;
disp(Ybits)
rms = std(X(:)-Z(:))
draw(Z)