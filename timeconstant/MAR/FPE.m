function e = FPE(X_bar,n,p)
    N = length(X_bar);
    pi2 = sum((X_bar-mean(X_bar)).^2)/(N-1);
    e = pi2*(n+p+1)/(n-p-1); % calculate fpe
end