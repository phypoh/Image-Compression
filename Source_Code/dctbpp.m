function bits = dctbpp(Yr, N)

%Takes quantised regrouped DCT transformed Yr and calculates total number
%of bit required to code image Yr

bits = 0;

[block_num, ~] = size(Yr);
block_num = block_num/N;

for i = [1:N]
    for j = [1:N]
        Ys = Yr((i-1)*block_num+1:i*block_num, (j-1)*block_num+1:j*block_num);
        bits = bits + bpp(Ys);
    end
end

bits = bits*block_num^2;

return