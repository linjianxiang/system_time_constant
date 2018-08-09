%zIn = [outSig, inSig];
function dtEst = arxstructd(zIn,nkVec,na,nb);
 switch nargin
     case 1
            na = 10; nb = 5; nkVec = 1:20;
            nkMax = length(nkVec);
            nn = [na*ones(nkMax,1), nb*ones(nkMax,1), nkVec'];
            V = arxstruc(zIn,zIn,nn);
            modelStruc = selstruc(V,0);
            dtEst = modelStruc(3);
     case 4
            nkMax = length(nkVec);
            nn = [na*ones(nkMax,1), nb*ones(nkMax,1), nkVec'];
            V = arxstruc(zIn,zIn,nn);
            modelStruc = selstruc(V,0);
            dtEst = modelStruc(3);
 end
end