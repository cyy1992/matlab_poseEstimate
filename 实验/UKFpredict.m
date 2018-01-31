function [ x1,P1 ] = UKFpredict(fstate,x,P,Q)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
L=numel(x);                                 %numer of states 
% m=numel(z);                                 %numer of measurements 
alpha=1e-2;                                 %default, tunable 10^(-3)
ki=3-L;                                       %default, tunable 
beta=2;                                     %default, tunable 
lambda=alpha^2*(L+ki)-L;                    %scaling factor 
c=L+lambda;                                 %scaling factor 
Wm=[lambda/c 0.5/c+zeros(1,2*L)];           %weights for means   均值权重
Wc=Wm; 
Wc(1)=Wc(1)+(1-alpha^2+beta);               %weights for covariance 
c=sqrt(c); 
X=sigmas_Predict(x,P,c);                            %sigma points around x 
[x1,X1,P1,X2]=ut(fstate,X,Wm,Wc,L,Q);          %unscented transformation of process 

end

