function [ ultimate_x ] = strong_nolinear_Matrix_weighted( x1,x2,DevX1,DevX2,DevZ1,DevZ2,K1,K2,P1,P2,Q)
%UNTITLED7 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
L=numel(x1);                                 %״̬���� 
alpha=1e-3;                                 %default, tunable 10^(-3)
ki=0;                                       %default, tunable 
beta=2;                                     %default, tunable 
lambda=alpha^2*(L+ki)-L;                    %scaling factor 
c=L+lambda;                                 %scaling factor 
Wm=[lambda/c 0.5/c+zeros(1,2*L)];           %��ֵȨ��
Wc=Wm; 
Wc(1)=Wc(1)+(1-alpha^2+beta);               %weights for covariance
Pxx = DevX1*diag(Wc)*DevX2';
Pxz = DevX1*diag(Wc)*DevZ2';
Pzx = DevZ1*diag(Wc)*DevX2';
Pzz = DevZ1*diag(Wc)*DevZ2';
P12 = Pxx - Pxz*K2'-K1*Pzx+K1*Pzz*K2'; %3.14
PP = [P1,P12;P12',P2]; %3.15
m = size(P1,1);
e = [eye(m);eye(m)];
ppp=inv(e'*inv(PP)*e);
omiga = ppp*e'/(PP); %3.17
ultimate_x = omiga*[x1;x2]; %3.18
end