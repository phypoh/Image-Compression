function X_imp = func_impulse(X, amp)

X_imp = X;
X_imp(size(X_imp)/2,size(X_imp)/2) = X_imp(size(X_imp)/2,size(X_imp)/2) +amp;

return