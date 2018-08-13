%zIn = [outSig, inSig];
% [na nb nk] define the polynomial orders of an ARX model.
% na ¡ª Order of the polynomial A(q).
% Specify na as an Ny-by-Ny matrix of nonnegative integers. Ny is the number of outputs.
% nb ¡ª Order of the polynomial B(q) + 1.
% nb is an Ny-by-Nu matrix of nonnegative integers. Ny is the number of outputs and Nu is the number of inputs.
% nk ¡ª Input-output delay expressed as fixed leading zeros of the B polynomial.
% Specify nk as an Ny-by-Nu matrix of nonnegative integers. Ny is the number of outputs and Nu is the number of inputs.
function dtEst = arxstructd(zIn,nkVec,na,nb);
 switch nargin
     case 1
            na = 10; nb = 5; nkVec = 1:80;%nkVec = 1:20;
            nkMax = length(nkVec);
            nn = [na*ones(nkMax,1), nb*ones(nkMax,1), nkVec'];
            V = arxstruc(zIn,zIn,nn); %Compute loss functions for single-output ARX models
            
            %selstruc: first: find the index of min of the row1 of V, then get the value of that index
            %from row 2 to 2+2*nu (nu =floor((nl1-2)/2),[nl1,nm1] = size(V);)
            modelStruc = selstruc(V,0); %Select the model order with the best fit to the validation data.
            dtEst = modelStruc(3);
     case 4
            nkMax = length(nkVec);
            nn = [na*ones(nkMax,1), nb*ones(nkMax,1), nkVec'];
            V = arxstruc(zIn,zIn,nn);
            modelStruc = selstruc(V,0);
            dtEst = modelStruc(3);
 end
end