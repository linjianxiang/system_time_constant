%zIn = [outSig, inSig];
% Output error model orders.[nb nf nk]
% For a system represented by:
% y(t)=B(q)/F(q)*u(t-nk)+e(t)
% where y(t) is the output, u(t) is the input and e(t) is the error.
% nb ¡ª Order of the B polynomial + 1. nb is an Ny-by-Nu matrix. Ny is the number of outputs and Nu is the number of inputs.
% nf ¡ª Order of the F polynomial. nf is an Ny-by-Nu matrix. Ny is the number of outputs and Nu is the number of inputs.
% nk ¡ª Input delay, expressed as the number of samples. nk is an Ny-by-Nu matrix. Ny is the number of outputs and Nu is the number of inputs. The delay appears as leading zeros of the B polynomial.
% For estimation using continuous-time data, only specify [nb nf] and omit nk.
function dtEst = oestructd(zIn);
nf = 2; nb = 1; nkVec = 1:80; % nkVec = 1:20;
for nnn = 1:length(nkVec)
model = oe(zIn,[nb nf nkVec(nnn)], 'Covariance','None');
lossFunc(nnn) = model.NoiseVariance;
end%for
[minVal, nnnmin] = min(lossFunc);
dtEst = nkVec(nnnmin);
end