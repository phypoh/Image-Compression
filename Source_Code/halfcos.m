function h = halfcos(N)

%HALFCOS  Half cosine function.
%  HALFCOS(N) is a half-cosine of length N samples. The amplitude
%  gives unit gain at zero frequency.

h = cos(([1:N]'/(N+1) - 0.5) * pi);
h = h / sum(h);
% for example if N=7, we want h to go from Gcos(-3pi/8), Gcos(-2pi/8,....,
% Gcos(2pi/8), Gcos(3pi/8).
% (1/8-1/2)pi = -3pi/8 etc....

return


