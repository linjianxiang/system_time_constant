%pks
%locs
%n-th largest
%output [peak_n, index]
function [peak_n, index] = nth_largest(pks,locs,n)
      switch nargin
          case 2 % defualt n is 2 --second largest 
              [B,I] = sort(pks,'descend');
              peak_n = B(2);
              index = locs(I(2));
          otherwise % the n-th largest
              [B,I] = sort(pks,'descend');
              peak_n = B(n);
              index = locs(I(n));
      end

end