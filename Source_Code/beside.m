function y=beside(x1,x2)

%BESIDE  Arrange two images beside each other.
%  Y = BESIDE(X1, X2) puts X1 and X2 beside each other in Y.
%  Y is padded with zeros as necessary and the images are
%  separated by a blank column.

% work out size of Y
[m1,n1]=size(x1);
[m2,n2]=size(x2);
m = max(m1,m2);
y=zeros(m,n1+n2+1);

y((m-m1)/2+[1:m1],[1:n1])=x1;
y((m-m2)/2+[1:m2],n1+1+[1:n2])=x2;

return
