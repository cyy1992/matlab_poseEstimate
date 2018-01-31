function [ xd,Pd ] = distribute_strong_noliner_fusion(f, Q,P1,P2,Pp1,Pp2,Pd,x1,x2,x1p,x2p,xd)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
L=numel(xd);                                 %numer of states 
% m=numel(z);                                 %numer of measurements 
alpha=1e-4;                                 %default, tunable 10^(-3)
ki=3-L;                                       %default, tunable 
beta=2;                                     %default, tunable 
lambda=alpha^2*(L+ki)-L;                    %scaling factor 
c=L+lambda;                                 %scaling factor 
Wm=[lambda/c 0.5/c+zeros(1,2*L)];           %weights for means   均值权重
Wc=Wm; 
Wc(1)=Wc(1)+(1-alpha^2+beta);               %weights for covariance 
c=sqrt(c); 
X=sigmas(xd,Pd,c);                            %sigma points around x 
[xfp,Sigmaxf,Pp,X2]=ut(f,X,Wm,Wc,L,Q);      %3.18-3.20
m = size(Pd,1);

Pd = eye(m)/(eye(m)/Pp+eye(m)/P1+eye(m)/P2-eye(m)/Pp1-eye(m)/Pp2); %3.21
xd = Pd*(eye(m)/Pp*xfp+eye(m)/P1*x1+eye(m)/P2*x2-eye(m)/Pp1*x1p-eye(m)/Pp2*x2p); %3.22
end