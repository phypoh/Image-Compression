function dwtstep = func_dwtstepmse(N)

blank = zeros(256, 256);

Yblank = func_multilevel(blank, N);

dwtstep = zeros(3, N+1);

for i = 1:N
    left = 2^(8-i-1);
    right = (2^(8-i)+2^(8-i+1))/2;

    Y1blank = Yblank;
    Y1blank(left, right) = Y1blank(left, right) + 1;
    Y1 = func_multiinverse(Y1blank, N);
    dwtstep(1, i) = 1/sqrt(sum(Y1(:).^2));

    Y2blank = Yblank;
    Y2blank(right, left) = Y2blank(left, right) + 1;
    Y2 = func_multiinverse(Y2blank, N);
    dwtstep(2, i) = 1/sqrt(sum(Y2(:).^2));

    Y3blank = Yblank;
    Y3blank(right, right) = Y3blank(left, right) + 1;
    Y3 = func_multiinverse(Y3blank, N);
    dwtstep(3, i) = 1/sqrt(sum(Y3(:).^2));
end

Ylowpass = Yblank;
Ylowpass(2^(8-N-1)-1, 2^(8-N-1)-1) = Ylowpass(2^(8-N-1)-1, 2^(8-N-1)-1) + 1;
Ylowpass = func_multiinverse(Ylowpass, N);
dwtstep(1, N+1) = 1/sqrt(sum(Ylowpass(:).^2));

return