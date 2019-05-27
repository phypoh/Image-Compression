function Y = func_multilevel(X, N)

m = 256;

Y = dwt(X);

for i = 1:N
    m = m/2;
    t = 1:m;
    Y(t,t) = dwt(Y(t,t));
end

return