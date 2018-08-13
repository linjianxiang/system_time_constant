%dtEst = arxstructd(zIn,nkVec,na,nb);
%delay = arxstructd(zIn,nkVec,na,nb);
%zIn = [outSig, inSig];
%nkVec,na,nb are optional
%nkVect = 1:MaxDelay,nA = OrderofA,nb = OrderofB
function dtEst = arxstructd(zIn,nkVec,na,nb);
 switch nargin
     case 1
            na = 10; nb = 5; nkVec = 1:80;%nkVec = 1:20;
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