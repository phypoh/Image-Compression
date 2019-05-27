step_size = 17;

Xq = quantise(X, step_size);

%draw(Xq)

rmsX = std(X(:)-Xq(:))