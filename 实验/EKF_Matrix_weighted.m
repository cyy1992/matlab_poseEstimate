function [ x,P12 ] = EKF_Matrix_weighted( A,H1,H2,K1,K2,P1,P2,P12,x1,x2,Q)
%UNTITLED8 此处显示有关此函数的摘要
%   此处显示详细说明
m = size(K1,1);
FK1 = (eye(m) - K1*H1)*A;
FK2 = (eye(m) - K2*H2)*A;
P12 = FK1*P12*FK2'+(eye(m)-K1*H1)*Q*eye(m)*(eye(m)-K2*H2)';   %1.6
omg1 = (P2-P12')/(P1+P2-P12-P12');  %1.8
omg2 = (P1-P12)/(P1+P2-P12-P12');   %1.9
x = omg1*x1+omg2*x2;   %1.10
% x = omiga*[x1;x2]; %3.18
end