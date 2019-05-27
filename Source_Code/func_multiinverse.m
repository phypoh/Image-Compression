function Y = func_multiinverse(Y, N)

m = 256/(2^N);

for i = 1:(N+1)
    t = 1:m;
    Y(t,t) = idwt(Y(t,t));
    m = m*2;
end

return