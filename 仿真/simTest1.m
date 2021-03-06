t = 0.05;
RelatObjCoor = [0 0 0;20 0 0; 20 20 0; 0 20 0];
kx1 = 500;	ky1 = 500	; u01= 0	; v01 = 0;
kx2 = 500	; ky2 = 500	;  u02 = 0	; v02 = 0;
Rt=[0.958202785083049	0.00955678315900937	-0.285930219729814
-0.00297597740565321	0.999720789715787	0.0234411213154025
0.286074406785313	-0.0216104258563789	0.957963685781845];

tt=[88.9567640797340	1.21933013142356	9.12704941110768];
T = [Rt,tt'];
euler2 = rodrigues(Rt)';

f=@(x)[x(1)+t*x(2);x(2);x(3)+t*x(4);x(4);x(5)+t*x(6);x(6);x(7)+t*x(8);x(8);x(9)+t*x(10);x(10);x(11)+t*x(12);x(12);];
h1=@(x)[kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(1,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(1,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(2,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(2,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(3,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(3,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(4,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(4,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+v01]; 
h2=@(x)[kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*(sin(x(11)+euler2(3)))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+v02]; 
h=@(x)[kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(1,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(1,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(11))*RelatObjCoor(1,2)+cos(x(9))*cos(x(11))*RelatObjCoor(1,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(2,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(2,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(11))*RelatObjCoor(2,2)+cos(x(9))*cos(x(11))*RelatObjCoor(2,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(3,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(3,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(11))*RelatObjCoor(3,2)+cos(x(9))*cos(x(11))*RelatObjCoor(3,3))+v01;
       kx1*(x(1)+cos(x(7))*cos(x(9))*RelatObjCoor(4,1)+(cos(x(7))*sin(x(9))*sin(x(11))-sin(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7))*sin(x(9))*cos(x(11))+sin(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+u01;
       ky1*(x(3)+sin(x(7))*cos(x(9))*RelatObjCoor(4,1)+(sin(x(7))*sin(x(9))*sin(x(11))+cos(x(7))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7))*sin(x(9))*cos(x(11))-cos(x(7))*sin(x(11)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(11))*RelatObjCoor(4,2)+cos(x(9))*cos(x(11))*RelatObjCoor(4,3))+v01;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(1,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(1,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(1,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(1,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(1,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(1,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(2,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(2,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(2,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(2,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(2,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(2,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(3,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(3,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(3,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(3,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(3,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(3,3))+v02;
       kx2*(T(1,:)*[x(1);x(3);x(5);1]+cos(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))-sin(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(cos(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))+sin(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*(sin(x(11)+euler2(3)))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+u02;
       ky2*(T(2,:)*[x(1);x(3);x(5);1]+sin(x(7)+euler2(1))*cos(x(9)+euler2(2))*RelatObjCoor(4,1)+(-sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*sin(x(11)+euler2(3))+cos(x(7)+euler2(1))*cos(x(11)))*RelatObjCoor(4,2)+(sin(x(7)+euler2(1))*sin(x(9)+euler2(2))*cos(x(11)+euler2(3))-cos(x(7)+euler2(1))*sin(x(11)+euler2(3)))*RelatObjCoor(4,3))/(T(3,:)*[x(1);x(3);x(5);1]-sin(x(9)+euler2(2))*RelatObjCoor(4,1)+cos(x(9)+euler2(2))*sin(x(11)+euler2(3))*RelatObjCoor(4,2)+cos(x(9)+euler2(2))*cos(x(11)+euler2(3))*RelatObjCoor(4,3))+v02];  

syms a1 b1 c1;
ra1 = [1,0,0;0,cos(a1),sin(a1);0,-sin(a1),cos(a1)];
ra2 = [cos(b1),0,-sin(b1);0,1,0;sin(b1),0,cos(b1)];
ra3 = [cos(c1),sin(c1),0;-sin(c1),cos(c1),0;0,0,1];
rr1=ra1*ra2*ra3;
rr1 = rr1';

P = 0.1*eye(12);
Q = 100000*diag([0,0.0000025,0,0.0000001,0,0.0000025,0,0.0000036,0,0.0000036,0,0.0000036],0);Q1 = Q;Qe = Q;
% R = 0.06*eye(8);
R1 = 5*diag([0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09]);Re = R1;
R2 = 5*diag([0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09]);
Rj = diag([0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09]);
m = 180;nm = 1;
t1 = 0;t2 =0;td =0;tm =0;tj=0;

a1 = pi/36*rand(1);
b1 = pi/36*rand(1);
c1 = pi/36*rand(1);

 for j = 1:nm
    dim = 1*pi/360;
    Init_X1 = [20*sin(dim);0;20*sin(dim);0;50;0;a1;0;b1;0;c1;0];
    xe1 = Init_X1;
    P1 = 0.5*eye(12);P2 = eye(12);x1 = Init_X1;x2 = x1;Pd = eye(12);xd = x1;xj= x1;Pj =eye(12);Pe1 = P1;
    v1 = mvnrnd(0,0.6,m);
    v2 = mvnrnd(0,0.7,m);
    v3 = mvnrnd(0,0.8,m);
    v4 = mvnrnd(0,0.9,m);
    v5 = mvnrnd(0,0.6,m);
    v6 = mvnrnd(0,0.7,m);
    v7 = mvnrnd(0,0.8,m);
    v8 = mvnrnd(0,0.9,m);
    v11 = mvnrnd(0,0.6,m);
    v21 = mvnrnd(0,0.7,m);
    v31 = mvnrnd(0,0.8,m);
    v41 = mvnrnd(0,0.9,m);
    v51 = mvnrnd(0,0.6,m);
    v61 = mvnrnd(0,0.7,m);
    v71 = mvnrnd(0,0.8,m);
    v81 = mvnrnd(0,0.9,m);
    st1 = zeros(1,m);st2 = zeros(1,m);std = zeros(1,m);stm = zeros(1,m);stj= zeros(1,m);
%     N = 30;
%     qNk1 = zeros(12,N);qNk2 = zeros(12,N);
%     detNk1 = zeros(N*12,12);detNk2 = zeros(N*12,12);
%     qlast1 = zeros(12,1);qlast2 = zeros(12,1);
N = 20;
qNk = zeros(12,N);
detNk = zeros(N*12,12);
rNk = zeros(8,N);
tNk = zeros(N*8,8);
    for k = 1:m
        sx = 20*sin(k*dim)+rand(1);
        sy = 20*cos(k*dim)+rand(1);
        sz = 50+k/10+rand(1);
        a1 = a1+pi/20*rand(1);
        b1 = pi/18*rand(1);
        c1 = pi/180*rand(1);
        rr1=rodrigues([a1;b1;c1]);
        C3x = [sx; sy; sz;];
        C3z1 = [rr1,C3x]*[0;0;0;1];
        C3z2 = [rr1,C3x]*[20;0;0;1]; 
        C3z3 = [rr1,C3x]*[20;20;0;1]; 
        C3z4 = [rr1,C3x]*[0;20;0;1]; 
        C3z = [C3z1,C3z2,C3z3,C3z4];
        z1 = zeros(8,1);z2 = zeros(8,1);
        C3z = [C3z1,C3z2,C3z3,C3z4];
        C1x = C3x;C1z = C3z;
        C2x = T*[C3x;1];C2z = T*[C3z;1 1 1 1];
        for i =1:4
            z1(2*i-1,1) = 500*C3z(1,i)/C3z(3,i);z1(2*i,1) = 500*C3z(2,i)/C3z(3,i);%+v2(i*k);+v1(i*k)
            z2(2*i-1,1) = 500*C2z(1,i)/C2z(3,i);z2(2*i,1) = 500*C2z(2,i)/C2z(3,i);%+v4(i*k);+v3(i*k)
        end
%         figure(2);
%         plot(z2(1),z2(2),'r*');hold on;
%         plot(z2(3),z2(4),'b+');hold on;
%         plot(z2(5),z2(6),'y*');hold on;
%         plot(z2(7),z2(8),'g+');hold on;
        z1 = z1+[v11(k);v21(k);v31(k);v41(k);v51(k);v61(k);v71(k);v81(k)];
        z2 = z2+[v1(k);v2(k);v3(k);v4(k);v5(k);v6(k);v7(k);v8(k)];
        z =[z1;z2];
        [x1,x1p,P1,Pp1,DevX1,DevZ1,K1] = ukf(f,x1,P1,h1,z1,Q,R2);

%         [A_k1,H_k1,xe1,x1_pre,Pe1,P1_pre,Ke1,qNk1,detNk1,Q1,qlast1] = AEkf(f,xe1,Pe1,h1,z1,Q1,Re,qNk1,detNk1,N,qlast1);
[A_k,H_k,xe1,x1_pre,Pe1,P1_pre,Ke1,qNk,detNk,rNk,tNk,Qe,Re] = IAekf(f,xe1,Pe1,h1,z1,Qe,Re,qNk,detNk,rNk,tNk,N);
        [x2,x2p,P2,Pp2,DevX2,DevZ2,K2] = ukf(f,x2,P2,h2,z2,Q,R2);
        [xj,xjp,Pj,Ppj,DevXj,DevZj,Kj] = ukf(f,xj,Pj,h,z,Q,Rj);
        xr = [C3x(1);0;C3x(2);0;C3x(3);0;a1;0;b1;0;c1;0];
        
       [ xd,Pd ] = distribute_strong_noliner_fusion(f, Q,P1,P2,Pp1,Pp2,Pd,x1,x2,x1p,x2p,xd);
       [ xm ] = strong_nolinear_Matrix_weighted( x1,x2,DevX1,DevX2,DevZ1,DevZ2,K1,K2,P1,P2,Q);
        SData_Xr(k,:) = x1';SData_X1(k,:) = xe1';
        
        SData_X2(k,:) =xj';
%             SData_Xj(k,:)  = (xj-xr)';
    %     SData_X2 = [SData_X2;(x2-xr)'];SData_Xd = [SData_Xd;(xd-xr)'];SData_Xm = [SData_Xm;(xj-xr)'];
    end
end
a = 1:m;
% plot(a,SData_Xr(:,7),'r*');hold on;

figure(3);
subplot(3,2,1);hold on;
plot(a,SData_X1(:,1));
plot(a,SData_Xr(:,1));
plot(a,SData_X2(:,1));

subplot(3,2,2);hold on;
plot(a,SData_X1(:,3));
plot(a,SData_Xr(:,3));
plot(a,SData_X2(:,3));
subplot(3,2,3);hold on;
plot(a,SData_X1(:,5));
plot(a,SData_Xr(:,5));
plot(a,SData_X2(:,5));
subplot(3,2,4);hold on;
plot(a,SData_X1(:,11)*180/pi);
plot(a,SData_Xr(:,7)*180/pi);
plot(a,SData_X2(:,11)*180/pi);
subplot(3,2,5);hold on;
plot(a,SData_X1(:,9)*180/pi);
plot(a,SData_Xr(:,9)*180/pi);
plot(a,SData_X2(:,9)*180/pi);
subplot(3,2,6);hold on;
plot(a,SData_X1(:,7)*180/pi);
plot(a,SData_Xr(:,11)*180/pi);
plot(a,SData_X2(:,7)*180/pi);
