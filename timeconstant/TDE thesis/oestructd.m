%zIn = [outSig, inSig];
function dtEst = oestructd(zIn);
nf = 2; nb = 2; nkVec = 1:50; %nkVec = 1:20;
for nnn = 1:length(nkVec)
model = oe(zIn,[nb nf nkVec(nnn)], 'Covariance','None');
lossFunc(nnn) = model.NoiseVariance;
end%for
[minVal, nnnmin] = min(lossFunc);
dtEst = nkVec(nnnmin);
end