load lighthouse

s = 1;


%Parameters
[I, ~] = size(X);
step_size = 17;
N = 8;
t = [(1+N/2):(I-N/2)];
X_zero = X-128;
CN = dct_ii(N);


s = 1;
Xp1 = X_zero;
[Pf, Pr] = pot_ii(N, s);
Xp1(t,:) = colxfm(Xp1(t,:),Pf);
Xp1(:,t) = colxfm(Xp1(:,t)',Pf)';
Y1 = colxfm(colxfm(Xp1, CN)', CN)';
Z1 = colxfm(colxfm(Y1',CN')', CN');
Z1(:,t) = colxfm(Z1(:,t)',Pr')';
Z1(t,:) = colxfm(Z1(t,:),Pr');


bases1 = [zeros(1,8);Pf'; zeros(1,8)];
draw1 = 255*bases1(:)*bases1(:)';


s = 1.2;
Xp12 = X_zero;
[Pf, Pr] = pot_ii(N, s);
Xp12(t,:) = colxfm(Xp12(t,:),Pf);
Xp12(:,t) = colxfm(Xp12(:,t)',Pf)';
Y12 = colxfm(colxfm(Xp12, CN)', CN)';
Z12 = colxfm(colxfm(Y12',CN')', CN');
Z12(:,t) = colxfm(Z12(:,t)',Pr')';
Z12(t,:) = colxfm(Z12(t,:),Pr');
bases12 = [zeros(1,8);Pf'; zeros(1,8)];
draw12 = 255*bases12(:)*bases12(:)';

s = 1.5;
Xp15 = X_zero;
[Pf, Pr] = pot_ii(N, s);
Xp15(t,:) = colxfm(Xp15(t,:),Pf);
Xp15(:,t) = colxfm(Xp15(:,t)',Pf)';
Y15 = colxfm(colxfm(Xp15, CN)', CN)';
Z15 = colxfm(colxfm(Y15',CN')', CN');
Z15(:,t) = colxfm(Z15(:,t)',Pr')';
Z15(t,:) = colxfm(Z15(t,:),Pr');
bases15 = [zeros(1,8);Pf'; zeros(1,8)];
draw15 = 255*bases15(:)*bases15(:)';

s = 2;
Xp2 = X_zero;
[Pf, Pr] = pot_ii(N, s);
Xp2(t,:) = colxfm(Xp2(t,:),Pf);
Xp2(:,t) = colxfm(Xp2(:,t)',Pf)';
Y2 = colxfm(colxfm(Xp2, CN)', CN)';
Z2 = colxfm(colxfm(Y2',CN')', CN');
Z2(:,t) = colxfm(Z2(:,t)',Pr')';
Z2(t,:) = colxfm(Z2(t,:),Pr');
bases2 = [zeros(1,8);Pf'; zeros(1,8)];
draw2 = 255*bases2(:)*bases2(:)';

%draw(beside(draw1,beside(draw12, beside(draw15, draw2))))
draw(beside(draw1,draw2))
%draw(beside(Xp1/2,beside(Xp12/2, beside(Xp15/2, Xp2/2))))
%draw(beside(Xp1/2,Xp2/2))
%draw(beside(Z1/2,beside(Z12/2, beside(Z15/2, Z2/2))))
%draw(beside(Z1/2,Z2/2))