function [ Aq ] = Qa( a,av )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
q1 = [cos(norm(a)/2);sin(norm(a)/2)/norm(a)*a];
q2 = [cos(norm(av)/2);sin(norm(av)/2)/norm(av)*av];
q2M = QM(q2);
q = q2M*q1;
Aq = 2*acos(q(1))/(sqrt(1-q(1)^2))*[q(2);q(3);q(4)];
end

