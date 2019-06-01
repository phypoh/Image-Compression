function [Yq, dwtent] = func_quantdwt(Y, dwtstep)

[m,n] = size(dwtstep);

n = n-1;
dwtent = zeros(3,n+1);

Yq = Y;

for i = 1:n
   top = 1:2^(8-i);
   left = top;
   bottom = 2^(8-i):2^(8-i+1);
   right = bottom;
    
   Yq(top, right) = quant1(Yq(top, right), dwtstep(1,i), dwtstep(1,i));
   dwtent(1,i) = bpp(Yq(top,right));
   
   Yq(bottom, left) = quant1(Yq(bottom,left), dwtstep(2,i),dwtstep(2,i));
   dwtent(2,i) = bpp(Yq(bottom, left));
   
   Yq(bottom, right) = quant1(Yq(bottom, right), dwtstep(3,i),dwtstep(3,i));
   dwtent(3,i) = bpp(Yq(bottom, right));
end

%quantise lowpass image
Yq(1:2^(8-n), 1:2^(8-n)) = quant1(Yq(1:2^(8-n), 1:2^(8-n)), dwtstep(1,n+1),dwtstep(1,n+1));
dwtent(1, n+1) = bpp(Yq(1:2^(n-1), 1:2^(n-1)));

return