function [ xd,Pd ] = distribute_strong_noliner_fusion(f, Q,P1,P2,Pp1,Pp2,Pd,x1,x2,x1p,x2p,xd)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
% L=numel(xd);                                 %numer of states 
% % m=numel(z);                                 %numer of measurements 
% alpha=1e-4;                                 %default, tunable 10^(-3)
% ki=3-L;                                       %default, tunable 
% beta=2;                                     %default, tunable 
% lambda=alpha^2*(L+ki)-L;                    %scaling factor 
% c=L+lambda;                                 %scaling factor 
% Wm=[lambda/c 0.5/c+zeros(1,2*L)];           %weights for means   均值权重
% Wc=Wm; 
% Wc(1)=Wc(1)+(1-alpha^2+beta);               %weights for covariance 
% c=sqrt(c); 
% X=sigmas(xd,Pd,c);                            %sigma points around x 
% [xfp,Sigmaxf,Pp,X2]=ut(f,X,Wm,Wc,L,Q);      %3.18-3.20
t = 0.5;
F = [eye(3),t*eye(3),t^2/2*eye(3);
     zeros(3,3),eye(3),t*eye(3);
     zeros(3,3),zeros(3,3),eye(3);];
F1 = [F,eye(9,9);eye(9,9),F];
xfp = f(xd);
Pp = F1*Pd*F1'+Q;
m = size(Pd,1);
epp = eye(m)/Pp;
epp1 = eye(m)/P1;
epp2 = eye(m)/P2;
eppp1 = eye(m)/Pp1;
eppp2 = eye(m)/Pp2;
Pd = eye(m)/(epp+epp1+epp2-eppp1-eppp2); %3.21
xd = Pd*(epp*xfp+epp1*x1+epp2*x2-eppp1*x1p-eppp2*x2p); %3.22

% Pd = eye(m)/(eye(m)/Pp+eye(m)/P1+eye(m)/P2-eye(m)/Pp1-eye(m)/Pp2); %3.21
% xd = Pd*(eye(m)/Pp*xfp+eye(m)/P1*x1+eye(m)/P2*x2-eye(m)/Pp1*x1p-eye(m)/Pp2*x2p); %3.22
end