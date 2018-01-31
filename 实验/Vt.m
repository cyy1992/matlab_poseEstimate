function [V,t1,t2] = Vt( pi,focalIndex)
%V 此处显示有关此函数的摘要
%   此处显示详细说明
n = size(pi,1)/2;
V = zeros(3*n,3);
fx = focalIndex(1);
fy = focalIndex(2);
u0 = focalIndex(3);
v0 = focalIndex(4);
t1 = zeros(3*n,3);
t2 = zeros(3,3);
for i =1:n
    point = [(pi(2*i-1)-u0)/fx;(pi(2*i)-v0)/fy;1];
    V(3*(i-1)+1:3*i,:) = point*point'/(point'*point);
    t1(3*(i-1)+1:3*i,:) = eye(3)-V(3*(i-1)+1:3*i,:);
    t2 = eye(3)-t1(3*(i-1)+1:3*i,:)+t2;
end
t2 = eye(3)-1/n*t2;
end

