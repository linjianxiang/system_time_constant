function e = MDL(X_bar,n,p)
    N = length(X_bar);
    pi2 = sum((X_bar-mean(X_bar)).^2)/(N-1);
    e = n/2 *log(pi2) + p/2*log(n);
end