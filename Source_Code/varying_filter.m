N = 35;
filter = halfcos(N);

Xf=convse(transpose(X),filter);
Xf=convse(transpose(Xf),filter);

%draw(beside(X-Xcols,Xcols-128))
Xfh = X-Xf;
sum(X(:).^2)
sum(Xf(:).^2)
sum(Xfh(:).^2)