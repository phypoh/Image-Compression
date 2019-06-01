function [Z bits] = arith_code(X,n)

% Quantise to 1,2,3,4...
Xq = quant1(X,n,n);
X_seq = reshape(Xq,1,[]);

X_seq = X_seq + 1; % To make sure min value is 1

step_num = floor(256/n); % Take round down integer

count_value = zeros(1,step_num);

for i=1:step_num
    count_value(i) = sum(X_seq(:) == i);
end

% Encode
code = arithenco(X_seq,count_value);
% Decode
dseq = arithdeco(code,count_value,length(X_seq));

disp(dseq)

dseq = dseq - 1; % make back to zero
Zq = reshape(dseq, 256, 256); %reshape to matrix

Z = quant2(Zq,n,n); %back to 1:256

draw(Z);

code_size = size(code); 
bits = code_size(2); % number of bits used

return
