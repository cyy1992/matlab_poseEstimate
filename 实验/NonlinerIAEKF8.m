function [ x,P] = NonlinerIAEKF8(z,x,P,focalIndex,t,RelatObjCoor,euler2,T,N,flag)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
persistent qNk1 qNk2 detNk1 detNk2 qlast1 qlast2 Q1 Q2;
persistent fusiond_qNk1 fusiond_qNk2 fusiond_detNk1 fusiond_detNk2 fusiond_qlast1 fusiond_qlast2 xd1 Pd1 xd2 Pd2 Qd1 Qd2;
persistent fusionm_qNk1 fusionm_qNk2 fusionm_detNk1 fusionm_detNk2 fusionm_qlast1 fusionm_qlast2 xm1 Pm1 xm2 Pm2 Qm1 Qm2 Pm12;
persistent fusionj_qNk fusionj_detNk fusionj_qlast fusionj_Q;
mp = size(P,1);
mq = size(x,1);
num_z = size(z,2);
kx1 = focalIndex(1,1);
ky1 = focalIndex(2,1);
u01 = focalIndex(3,1);
v01 = focalIndex(4,1);
kx2 = focalIndex(1,2);
ky2 = focalIndex(2,2);
u02 = focalIndex(3,2);
v02 = focalIndex(4,2);
temp_Ak =  [1,t;0,1];
A_k = blkdiag(temp_Ak,temp_Ak,temp_Ak,temp_Ak,temp_Ak,temp_Ak);
f=@(x)[x(1)+t*x(2);x(2);x(3)+t*x(4);x(4);x(5)+t*x(6);x(6);x(7)+t*x(8);x(8);x(9)+t*x(10);x(10);x(11)+t*x(12);x(12);];
h1=@(x)[kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(1,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(1,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(2,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(2,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(3,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(3,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(4,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(4,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(5,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(5,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(5,3))/(x(5)-sin(x(9))*RelatObjCoor(5,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(5,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(5,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(5,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(5,3))/(x(5)-sin(x(9))*RelatObjCoor(5,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(5,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(6,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(6,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(6,3))/(x(5)-sin(x(9))*RelatObjCoor(6,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(6,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(6,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(6,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(6,3))/(x(5)-sin(x(9))*RelatObjCoor(6,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(6,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(7,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(7,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(7,3))/(x(5)-sin(x(9))*RelatObjCoor(7,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(7,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(7,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(7,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(7,3))/(x(5)-sin(x(9))*RelatObjCoor(7,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(7,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(8,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(8,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(8,3))/(x(5)-sin(x(9))*RelatObjCoor(8,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(8,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(8,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(8,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(8,3))/(x(5)-sin(x(9))*RelatObjCoor(8,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(8,3))+v01]; 

h2=@(x)[kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*(sin(x(11)+euler2(3)))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+v02; 
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(5,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(5,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(5,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(5,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(5,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(5,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(5,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(5,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(5,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(5,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(5,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(5,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(6,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(6,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(6,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(6,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(6,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(6,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(6,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(6,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(6,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(6,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(6,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(6,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(7,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(7,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(7,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(7,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(7,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(7,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(7,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(7,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(7,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(7,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(7,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(7,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(8,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(8,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(8,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(8,1)+cos(x(9)+euler2(2))*(sin(x(11)+euler2(3)))*RelatObjCoor(8,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(8,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(8,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(8,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(8,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(8,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(8,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(8,3))+v02]; 

h=@(x)[kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(1,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(1,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(2,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(2,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(3,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(3,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(4,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(4,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(5,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(5,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(5,3))/(x(5)-sin(x(9))*RelatObjCoor(5,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(5,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(5,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(5,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(5,3))/(x(5)-sin(x(9))*RelatObjCoor(5,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(5,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(6,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(6,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(6,3))/(x(5)-sin(x(9))*RelatObjCoor(6,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(6,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(6,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(6,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(6,3))/(x(5)-sin(x(9))*RelatObjCoor(6,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(6,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(7,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(7,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(7,3))/(x(5)-sin(x(9))*RelatObjCoor(7,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(7,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(7,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(7,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(7,3))/(x(5)-sin(x(9))*RelatObjCoor(7,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(7,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(8,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(8,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(8,3))/(x(5)-sin(x(9))*RelatObjCoor(8,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(8,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(8,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(8,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(8,3))/(x(5)-sin(x(9))*RelatObjCoor(8,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(8,3))+v01; 
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*(sin(x(11)+euler2(3)))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+v02; 
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(5,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(5,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(5,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(5,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(5,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(5,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(5,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(5,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(5,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(5,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(5,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(5,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(6,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(6,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(6,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(6,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(6,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(6,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(6,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(6,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(6,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(6,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(6,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(6,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(7,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(7,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(7,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(7,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(7,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(7,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(7,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(7,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(7,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(7,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(7,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(7,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(8,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(8,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(8,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(8,1)+cos(x(9)+euler2(2))*(sin(x(11)+euler2(3)))*RelatObjCoor(8,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(8,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(8,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(8,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(8,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(8,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(8,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(8,3))+v02]; 

R = 0.1*diag([0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09]);
R = blkdiag(R,R);
Q = 1*diag([0,0.25,0,0.5,0,0.25,0,0.36,0,0.36,0,0.36],0);
focalIndex1 = [kx1;ky1];
focalIndex2 = [kx2;ky2];
if flag == 1
    if isempty(qNk1)
        qNk1 = zeros(12,N);
    end
    if isempty(detNk1)
        detNk1 = zeros(N*12,12);
    end
    if isempty(qlast1)
        qlast1 = zeros(12,1);
    end
    if isempty(Q1)
        Q1 = Q;
    end
    [x,~,P,~,~,qNk1,detNk1,Q1,qlast1,~] = IAekf8(A_k,f,x,P,h1,z,Q1,R,qNk1,detNk1,N,qlast1,focalIndex1,RelatObjCoor,T,euler2);
elseif flag == 2
    if isempty(qNk2)
        qNk2 = zeros(12,N);
    end
    if isempty(detNk2)
        detNk2 = zeros(N*12,12);
    end
    if isempty(qlast2)
        qlast2 = zeros(12,1);
    end
    if isempty(Q2)
        Q2 = Q;
    end
    [x,~,P,~,~,qNk2,detNk2,Q2,qlast2,~] = IAekf8(A_k,f,x,P,h1,z,Q2,R,qNk2,detNk2,N,qlast2,focalIndex2,RelatObjCoor,T,euler2);
elseif flag == 3
    if (num_z>1)
        if isempty(fusionm_qNk1)
            fusionm_qNk1 = zeros(12,N);
        end
        if isempty(fusionm_detNk1)
            fusionm_detNk1 = zeros(N*12,12);
        end
        if isempty(fusionm_qlast1)
            fusionm_qlast1 = zeros(12,1);
        end
        if isempty(fusionm_qNk2)
            fusionm_qNk2 = zeros(12,N);
        end
        if isempty(fusionm_detNk2)
            fusionm_detNk2 = zeros(N*12,12);
        end
        if isempty(fusionm_qlast2)
            fusionm_qlast2 = zeros(12,1);
        end
        if isempty(xm1)
            xm1 = x;
        end
        if isempty(xm2)
            xm2 = x;
        end
        if isempty(Qm1)
            Qm1 = Q;
        end
        if isempty(Qm2)
            Qm2 = Q;
        end
        if isempty(Pm1)
            Pm1 = eye(mp);
        end
        if isempty(Pm2)
            Pm2 = eye(mp);
        end
        if isempty(Pm12)
            Pm12 = eye(mp);
        end
        z1 = z(:,1);z2 = z(:,2);
        [xm1,~,Pm1,~,Km1,fusionm_qNk1,fusionm_detNk1,Qm1,fusionm_qlast1,H_k1] = IAekf8(A_k,f,xm1,Pm1,h1,z1,Qm1,R,fusionm_qNk1,fusionm_detNk1,N,fusionm_qlast1,focalIndex1,RelatObjCoor,T,euler2);
        [xm2,~,Pm2,~,Km2,fusionm_qNk2,fusionm_detNk2,Qm2,fusionm_qlast2,H_k2] = IAekf8(A_k,f,xm2,Pm2,h2,z2,Qm2,R,fusionm_qNk2,fusionm_detNk2,N,fusionm_qlast2,focalIndex2,RelatObjCoor,T,euler2);
        Qe = (Qm1+Qm2)/2;
        [ x,Pm12 ] = EKF_Matrix_weighted( A_k,H_k1,H_k2,Km1,Km2,Pm1,Pm2,Pm12,xm1,xm2,Qe);
    end
    
elseif flag == 4
    if (num_z>1)
        if isempty(fusiond_qNk1)
            fusiond_qNk1 = zeros(12,N);
        end
        if isempty(fusiond_detNk1)
            fusiond_detNk1 = zeros(N*12,12);
        end
        if isempty(fusiond_qlast1)
            fusiond_qlast1 = zeros(12,1);
        end
        if isempty(fusiond_qNk2)
            fusiond_qNk2 = zeros(12,N);
        end
        if isempty(fusiond_detNk2)
            fusiond_detNk2 = zeros(N*12,12);
        end
        if isempty(fusiond_qlast2)
            fusiond_qlast2 = zeros(12,1);
        end
        if isempty(xd1)
            xd1 = x;
        end
        if isempty(xd2)
            xd2 = x;
        end
        if isempty(Qd1)
            Qd1 = Q;
        end
        if isempty(Qd2)
            Qd2 = Q;
        end
        if isempty(Pd1)
            Pd1 = eye(mp);
        end
        if isempty(Pd2)
            Pd2 = eye(mp);
        end
        z1 = z(:,1);z2 = z(:,2);
        [xd1,xdp1,Pd1,Pdp1,~,fusiond_qNk1,fusiond_detNk1,Qd1,fusiond_qlast1,~] = IAekf8(A_k,f,xd1,Pd1,h1,z1,Qd1,R,fusiond_qNk1,fusiond_detNk1,N,fusiond_qlast1,focalIndex1,RelatObjCoor,T,euler2);
        [xd2,xdp2,Pd2,Pdp2,~,fusiond_qNk2,fusiond_detNk2,Qd2,fusiond_qlast2,~] = IAekf8(A_k,f,xd2,Pd2,h2,z2,Qd2,R,fusiond_qNk2,fusiond_detNk2,N,fusiond_qlast2,focalIndex2,RelatObjCoor,T,euler2);
        Qef = (Qd1+Qd2)/2;
        [ x,P ] = distribute_EKF_noliner_fusion(A_k,f, Qef,Pd1,Pd2,Pdp1,Pdp2,P,xd1,xd2,xdp1,xdp2,x);        
    end
elseif flag == 5
    if (num_z>1)
        if isempty(fusionj_qNk)
            fusionj_qNk = zeros(12,N);
        end
        if isempty(fusionj_detNk)
            fusionj_detNk = zeros(N*12,12);
        end
        if isempty(fusionj_qlast)
            fusionj_qlast = zeros(12,1);
        end
        if isempty(fusionj_Q)
            fusionj_Q = Q;
        end
        kx = [kx1,kx2];ky = [ky1,ky2];        
        z1 = z(:,1);z2 = z(:,2);
        z3 = [z1;z2];
        focalIndex3 = [kx;ky];
        Rj = blkdiag(R,R);
        [x,~,P,~,~,fusionj_qNk,fusionj_detNk,fusionj_Q,fusionj_qlast,~] = IAekf8(A_k,f,x,P,h,z3,fusionj_Q,Rj,fusionj_qNk,fusionj_detNk,N,fusionj_qlast,focalIndex3,RelatObjCoor,T,euler2);
    end
end