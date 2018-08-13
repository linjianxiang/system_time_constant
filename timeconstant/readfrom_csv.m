%read from csv
num = xlsread(filename);
zIn = zeros(length(num),2);
zIn(:,1) = num(:,output_col);
zIn(:,2) = num(:,input_col);