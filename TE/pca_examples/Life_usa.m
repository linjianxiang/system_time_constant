%% load data
load cities
categories 

%% plot data
figure()
boxplot(ratings,'orientation','horizontal','labels',categories)
%from the boxplot we observe that:
%There is more variability in the ratings of the arts and housing than in the ratings of crime and climate.

%% check pairwise correlation -- Check the pairwise correlation between the variables.
C = corr(ratings,ratings);
%The correlation among some variables is as high as 0.85. Principal components analysis constructs independent new variables which are linear combinations of the original variables.

% the explaination of correlation:
% https://www.mathsisfun.com/data/correlation.html

%% Compute principal components
w = 1./var(ratings);
[wcoeff,score,latent,tsquared,explained] = pca(ratings,'VariableWeights',w);

% Note that when variable weights are used, the coefficient matrix is not orthonormal

%% Component coefficients
% wcoeff, contains the coefficients of the principal components.
% The first three principal component coefficient vectors are:
c3 = wcoeff(:,1:3)

%% transform coefficients
%transform the coefficients so that they are orthonormal
coefforth = inv(diag(std(ratings)))*wcoeff
% std() -- returns the standard deviation 

%% check coefficients are orthonormal
I = coefforth'*coefforth;
I(1:3,1:3) % I is a diagonal with value of one

%% component scores
%The second output, score, contains the coordinates of the original data in the new coordinate system defined by the principal components
cscores = zscore(ratings)*coefforth
% ratings is a mltidimensional array, zscore
% each column of zscore(ratings) has mean of 0 and standard deviation 1

% cscores and score are identical matrices.

%% plot component scores
% plot of the first two columns of score
figure()
plot(score(:,1),score(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

% use gname labels points out of the main region

%% Extract observation names
metro = [43 65 179 213 234 270 314]; % found by gname
names(metro,:) % these cities has more extreme data

%% Component Variances
latent
% latent, is a vector containing the variance explained by the corresponding principal component. Each column of score has a sample variance equal to the corresponding row of latent.

%% percent variance explained
explained
%explained, is a vector containing the percent variance explained by the corresponding principal component.