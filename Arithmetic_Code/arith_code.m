function [Z bits] = arith_code(X,n)

Xq = quant1(X,n,n);
X_seq = reshape(Xq,1,[]);

count_key = [];

for i=1:(256*256)
    if ismember(X_seq(i),count_key)==0
        count_key = [count_key (X_seq(i)+1)];
    elseif ismember(X_seq(i),count_key)==1
        continue
    end 
end 

[x y] = size(count_key);
count_value = zeros(1,y);

count_map = containers.Map(count_key,count_value);

for i=1:(256*256)
    if isKey(count_map,(X_seq(i)+1)) == 1
        count_map((X_seq(i)+1)) = count_map((X_seq(i)+1) + 1;
    else
        disp('Wrong key')
        return
    end
end

counts = cell2mat(values(count_map));

code = arithenco(X_seq,counts);
dseq = arithdeco(code,counts,length(X_seq));

dseq = quant2(X,n,n);

disp(dseq)

Z = reshape(dseq, 256, 256);
draw(Z);

code_size = size(code);
bits = code_size(2);

return
