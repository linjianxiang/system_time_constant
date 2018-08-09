function dtEst = met1structd(zIn, Ts)
 switch nargin
     case 1
        inSig = zIn(:,2);
        outSig = zIn(:,1);
        order = 10;
        modelSs = n4sid(iddata(outSig, inSig, 1),...
        order,'cov','none');
        [A,B,C,D,F] = polydata(idpoly(modelSs));
        BFilt = 1;
        AFilt = C;
        uFilt = filter(BFilt,AFilt,inSig);
        yFilt = filter(BFilt,AFilt,outSig);
        zIn = [yFilt, uFilt];
        na = 10; nb = 1; nkVec = 1:80;%nkVec = 1:20;
        dtEst = arxstructd(zIn,nkVec,na,nb);
     case 2
        inSig = zIn(:,2);
        outSig = zIn(:,1);
        order = 10;
        modelSs = n4sid(iddata(outSig, inSig, Ts),...
        order,'cov','none');
        [A,B,C,D,F] = polydata(idpoly(modelSs));
        BFilt = 1;
        AFilt = C;
        uFilt = filter(BFilt,AFilt,inSig);
        yFilt = filter(BFilt,AFilt,outSig);
        zIn = [yFilt, uFilt];
        na = 10; nb = 1; nkVec = 1:80;%nkVec = 1:20;
        dtEst = arxstructd(zIn,nkVec,na,nb);
 end
end