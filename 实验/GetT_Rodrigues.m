function [ cTo ] = GetT_Rodrigues(x,cTw) 
% 利用罗德里格斯求取转换矩阵cTo（即在相机坐标系下物体坐标系的位置和姿态）
wlTo = [1 0 0 0
      0 0 1 -42
      0 -1 0 76.35
      0 0 0 1];
R = rodrigues([x(10);x(11);x(12)]);
t = x(1:3,1);
wTwl = [R,t;0,0,0,1];
cTo = cTw*wTwl*wlTo;
end

