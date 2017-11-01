%% load data
load simOut_D_feedTemp.mat;
output_Variables=[
    'Feed flow component A (stream 1)                     ';
    'Feed flow component D (stream 2)                     ';
    'Feed flow component E (stream 3)                     ';
    'Feed flow components A & C (stream 4)                ';
    'Recycle flow to reactor from separator (stream 8)    ';
    'Reactor feed (stream 6)                              ';
    'Reactor pressure                                     ';
    'Reactor level                                        ';
    'Reactor temperature                                  ';
    'Purge flow (stream 9)                                ';
    'Separator temperature                                ';
    'Separator level                                      ';
    'Separator pressure                                   ';
    'Sperator underflow (liquid phase)                    ';
    'Stripper level                                       ';
    'Stripper pressure                                    ';
    'Stripper underflow (stream 11)                       ';
    'Stripper temperature                                 ';
    'Stripper steam flow                                  ';
    'Compressor work                                      ';
    'Reactor cooling water outlet temperature             ';
    'Condenser cooling water outlet temperature           ';
    'Concentration of A in Reactor feed (stream 6)        ';
    'Concentration of B in Reactor feed (stream 6)        ';
    'Concentration of C in Reactor feed (stream 6)        ';
    'Concentration of D in Reactor feed (stream 6)        ';
    'Concentration of E in Reactor feed (stream 6)        ';
    'Concentration of F in Reactor feed (stream 6)        ';
    'Concentration of A in Purge (stream 9)               ';
    'Concentration of B in Purge (stream 9)               ';
    'Concentration of C in Purge (stream 9)               ';
    'Concentration of D in Purge (stream 9)               ';
    'Concentration of E in Purge (stream 9)               ';
    'Concentration of F in Purge (stream 9)               ';
    'Concentration of G in Purge (stream 9)               ';
    'Concentration of H in Purge (stream 9)               ';
    'Concentration of D in stripper underflow (stream  11)'; 
    'Concentration of E in stripper underflow (stream  11)';                                                
    'Concentration of F in stripper underflow (stream  11)';                                                
    'Concentration of G in stripper underflow (stream  11)';
    'Concentration of H in stripper underflow (stream  11)'];

%% plot data
figure()
boxplot(simout,'orientation','horizontal','labels',output_Variables)

%% check pairwise correlation -- Check the pairwise correlation between the variables.
C = corr(simout,simout);

%% Compute principal components
w = 1./var(simout);
[wcoeff,score,latent,tsquared,explained] = pca(simout,'VariableWeights',w);

%% Component coefficients
% wcoeff, contains the coefficients of the principal components.
% The first three principal component coefficient vectors are:
c3 = wcoeff(:,1:3);

%% transform coefficients
%transform the coefficients so that they are orthonormal
coefforth = inv(diag(std(simout)))*wcoeff;
% std() -- returns the standard deviation 

%% check coefficients are orthonormal
I = coefforth'*coefforth;
I(1:3,1:3); % I is a diagonal with value of one

%% component scores
%The second output, score, contains the coordinates of the original data in the new coordinate system defined by the principal components
cscores = zscore(simout)*coefforth;
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

%% Create scree plot
%in this case first nine components that explain 95% of the total variance
figure()
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')


%% Hotelling's T-squared statistic.
[st2,index] = sort(tsquared,'descend'); % sort in descending order
extreme = index(1);
%visualize the result
biplot(coefforth(:,1:2),'scores',score(:,1:2),'varlabels',output_Variables);
axis([-.26 0.6 -.51 .51]);

%% three dimensional bi-plot
figure()
biplot(coefforth(:,1:3),'scores',score(:,1:3));
axis([-.26 0.8 -.51 .51 -.61 .81]);
view([30 40]);