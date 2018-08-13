%zIn = [outSig, inSig];
function dtEst = arxstructd(zIn,nkVec,na,nb);
 switch nargin
     case 1
            na = 2; nb = 2; nkVec = 1:50; %nkVec = 1:20;
            nkMax = length(nkVec);
            nn = [na*ones(nkMax,1), nb*ones(nkMax,1), nkVec'];
            %nn = [(1:nkMax)', (1:nkMax)', nkVec'];
            V = arxstruc(zIn,zIn,nn);
            modelStruc = selstruc(V,0);
            dtEst = modelStruc(3);
            %M = arx(zIn,modelStruc)
     case 4
            nkMax = length(nkVec);
            nn = [na*ones(nkMax,1), nb*ones(nkMax,1), nkVec'];
            V = arxstruc(zIn,zIn,nn);
            modelStruc = selstruc(V,0);
            dtEst = modelStruc(3);
 end
end