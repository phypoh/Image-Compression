%Transform Image X with DCT into Y, quantise then regroup it

load lighthouse

%Parameters
[I, ~] = size(X);
step_size = 17;
N = 4;
s = 1;

X_zero = X-128;
CN = dct_ii(N);
[Pf, Pr] = pot_ii(N, s);


t = [(1+N/2):(I-N/2)];
Xp = X_zero;
Xp(t,:) = colxfm(Xp(t,:),Pf);
Xp(:,t) = colxfm(Xp(:,t)',Pf)';

Y = colxfm(colxfm(Xp, CN)', CN)';
%Yq = quantise(Y, step_size);

%Yr = regroup(Yq,N);
%draw(Yr/8)

Z = colxfm(colxfm(Y',CN')', CN');
Zp = Z;
Zp(:,t) = colxfm(Zp(:,t)',Pr')';
Zp(t,:) = colxfm(Zp(t,:),Pr');

draw(Zp)

max(abs(Zp(:)-X_zero(:)))
std(Zp(:)-X_zero(:))