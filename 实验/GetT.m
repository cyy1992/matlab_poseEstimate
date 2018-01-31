function [ T ] = GetT(x,a11,R11,t11)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
q11 = [cos(norm(a11)/2);sin(norm(a11)/2)/norm(a11)*a11];
qm11 = QM(q11);
a22 = [-pi/2,0,0]';t22 = [0,-42,76.35]';
q22 = [cos(norm(a22)/2);sin(norm(a22)/2)/norm(a22)*a22];
a = [x(12,1);x(11,1);x(10,1)]; t12 = x(1:3,1);
q1 = [cos(norm(a)/2);sin(norm(a)/2)/norm(a)*a];

q2 = qm11*q1;
qm2 = QM(q2);
R2 = QR(q2);
q3 = qm2*q22;
R = QR(q3);
t2 = R2*t22;
t1 = R11*t12+t11;
t = t1+t2;
T = [R,t;];
end

