function [x1,xp1,P1,Pp1,Xp1,Zp1,K1,x2,xp2,P2,Pp3,Xp2,Zp2,K2]=ukf66(fstate,x1,x2,P1,P2,hmeas1,hmeas2,z1,z2,Q,R)
% UKF   Unscented Kalman Filter for nonlinear dynamic systems 
% [x, P] = ukf(f,x,P,h,z,Q,R) returns state estimate, x and state covariance, P  
% for nonlinear dynamic system (for simplicity, noises are assumed as additive): 
%           x_k+1 = f(x_k) + w_k 
%           z_k   = h(x_k) + v_k 
% where w ~ N(0,Q) meaning w is gaussian noise with covariance Q 
%       v ~ N(0,R) meaning v is gaussian noise with covariance R 
% Inputs:   f: function handle for f(x) 
%           x: "a priori" state estimate 
%           P: "a priori" estimated state covariance 
%           h: fanction handle for h(x) 
%           z: current measurement 
%           Q: process noise covariance  
%           R: measurement noise covariance 
% Output:   x: "a posteriori" state estimate 
%           P: "a posteriori" state covariance 
% 
% By Yi Cao at Cranfield University, 04/01/2008 
% Modified by JD Liu 2010-4-20 
L=numel(x1);                                 %numer of states 
m=numel(z1);                                 %numer of measurements 
alpha=1e-2;                                 %default, tunable 10^(-3)
ki=3-L;                                       %default, tunable 
beta=2;                                     %default, tunable 
lambda=alpha^2*(L+ki)-L;                    %scaling factor 
c=L+lambda;                                 %scaling factor 
Wm=[lambda/c 0.5/c+zeros(1,2*L)];           %weights for means   均值权重
Wc=Wm; 
Wc(1)=Wc(1)+(1-alpha^2+beta);               %weights for covariance 
c=sqrt(c); 
X1=sigmas(x1,P1,c);                            %sigma points around x 
X2=sigmas(x2,P2,c); 
[xp1,Xpp1,Pp1,Xp1]=ut(fstate,X1,Wm,Wc,L,Q);          %unscented transformation of process 
[xp2,Xpp2,Pp3,Xp2]=ut(fstate,X2,Wm,Wc,L,Q);
% X1=sigmas(x1,P1,c);                         %sigma points around x1 
% X2=X1-x1(:,ones(1,size(X1,2)));             %deviation of X1 
[zp1,Z1,Pp2,Zp1]=ut(hmeas1,Xpp1,Wm,Wc,m,R);       %unscented transformation of measurments 
[zp2,Z2,Pp22,Zp2]=ut(hmeas2,Xpp2,Wm,Wc,m,R);
P121=Xp1*diag(Wc)*Zp1';                        %transformed cross-covariance 
P122=Xp2*diag(Wc)*Zp2';    
K1=P121/Pp2; 
K2=P122/Pp22; 

x1=xp1+K1*(z1-zp1);                              %state update 
x2=xp2+K2*(z2-zp2); 
P1=Pp1-K1*P121';                               %covariance update 
P2=Pp3-K2*P122'; 
end

