function [Pf Pr] = pot_ii(N, s, O)

% POT_II Photo Overlap Transform matrix
%
%  [Pf Pr] = POT_II(N, s, O) Generates the 1-D POT transform matrices 
%  of size N, equivalent to the pre-filtering stage of a Type-II fast
%  Lapped Orthogonal Transform (LOT-II)
%
%  Y = Pf * X pre-filters N-vector X into Y.
%  X = Pr' * Y post-filters N-vector Y into X.
%
%  s is the scaling factor which determines the orthogonality of the
%  transform. s=1 generates a LOT (Pr = Pf), otherwise 1<s<2 generates
%  an LBT. The default is the Golden Ratio, (1+5^0.5)/2
%  O determines how much overlap there is. O must be greater than zero
%  and no greater than N/2. Default is N/2, which implies complete
%  overlap with the corresponding DCT

error(nargchk(1, 3, nargin, 'struct'));
if (nargin<3)
  O = N/2;
  if (nargin<2)
    s = (1+5^0.5)/2;
  end
else
  if ((O>(N/2)) || (O<1)) error('O is not a legal value'); end
end

% Generate component matrices
I = eye(N/2);
J = fliplr(I);
% flips elements in left/right direction
Z = zeros(N/2,N/2);
Cii = dct_ii(O);
Civ = dct_iv(O);

% Generate forward and reverse scaling matrices
Sf = diag([s ones(1,(O-1))]);
Sr = diag([1/s ones(1,(O-1))]);

% Generate forward and reverse filtering matrices
if (O < N/2) 
  VI = eye(N/2-O);
  VJ = fliplr(VI);
  VZ = zeros(O,N/2-O);
  Vf = [VJ*Cii'*Sf*Civ*VJ VZ; VZ' VI];
  Vr = [VJ*Cii'*Sr*Civ*VJ VZ; VZ' VI];
else
  Vf = J*Cii'*Sf*Civ*J;
  Vr = J*Cii'*Sr*Civ*J;
end

% Generate forward and reverse transform
Pf = 0.5*[I J; J -I]*[I Z; Z Vf]*[I J; J -I];
Pr = 0.5*[I J; J -I]*[I Z; Z Vr]*[I J; J -I];
