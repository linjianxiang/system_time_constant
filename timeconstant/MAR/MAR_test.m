function [A,X_bar,E,C] = MAR_test(X,Y,p);
    X = X-mean(X);
    Y = Y-mean(Y);
    m = length(X);
    n = m-p; % from 1 to m-p
    M = zeros(n,p);
    A = zeros(1,n);
    % construct M
    for i = 1:n
        for j = 1:p
            M(i,j) = X((i+(p-j)));
        end
    end
%     A = inv(M'*M)*M'*X(p+1:end)';
%     X_bar = M*A;
%     E = X(p+1:end)-X_bar';
%     C = E'*E/(n);

    A = inv(M'*M)*M'*Y(p+1:end)';
    X_bar = M*A;
    E = Y(p+1:end)-X_bar';
    %C = E'*E/(n);
    C = (E.^2)';

end