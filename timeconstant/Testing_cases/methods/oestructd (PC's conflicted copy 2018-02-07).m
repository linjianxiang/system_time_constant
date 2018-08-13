%delay = oestructd(zIn,nkVec,nf,nb)
%zIn = [outSig, inSig];
%nkVec,nf,nb are optional
%nkVect = 1:MaxDelay,nf = OrderofF,nb = OrderofB
function dtEst = oestructd(zIn,nkVec,nf,nb);
 switch nargin
     case 1
        nf = 2; nb = 1; nkVec = 1:80; % nkVec = 1:20;
        for nnn = 1:length(nkVec)
        model = oe(zIn,[nb nf nkVec(nnn)], 'Covariance','None');
        lossFunc(nnn) = model.NoiseVariance;
        end%for
        [minVal, nnnmin] = min(lossFunc);
        dtEst = nkVec(nnnmin);
     case 4
        for nnn = 1:length(nkVec)
        model = oe(zIn,[nb nf nkVec(nnn)], 'Covariance','None');
        lossFunc(nnn) = model.NoiseVariance;
        end%for
        [minVal, nnnmin] = min(lossFunc);
        dtEst = nkVec(nnnmin);
 end
end