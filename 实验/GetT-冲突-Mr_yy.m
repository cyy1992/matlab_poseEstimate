function [ T ] = GetT(x)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
a11 = [0 0 0]';t11 = [0 0 0]';R11 = eye(3);
q11 = [cos(norm(a11)/2);sin(norm(a11)/2)/norm(a11)*a11];
qm11 = QM(q11);
a22 = [0 0 0]';t22 = [0 0 0]';
q22 = [cos(norm(a22)/2);sin(norm(a22)/2)/norm(a22)*a22];
a = [x(7);x(9);x(11)]; t12 = [x(1);x(3);x(5)];
q1 = [cos(norm(a)/2);sin(norm(a)/2)/norm(a)*a];

q2 = qm11*q1;
qm2 = QM(q2);
R2 = QR(q2);
q3 = qm2*q22;
R = QR(q3);
t2 = R2*t22;
t1 = R11*t12+t11;
t = t1+t2;
T = [R,t;0,0,0,1];
end

