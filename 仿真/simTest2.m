clear all;

t = 0.05;
RelatObjCoor = [0 0 0;20 0 0; 20 20 0; 0 20 0];
sita = -1/6*pi;

kx1 = 500;	ky1 = 500	; u01= 0	; v01 = 0;
kx2 = 500	; ky2 = 500	;  u02 = 0	; v02 = 0;
 syms a1 b1 c1
    ra1 = [1,0,0;0,cos(a1),sin(a1);0,-sin(a1),cos(a1)];
    ra2 = [cos(b1),0,-sin(b1);0,1,0;sin(b1),0,cos(b1)];
    ra3 = [cos(c1),sin(c1),0;-sin(c1),cos(c1),0;0,0,1];
    a1 = 0;b1 = 1/6*pi;c1 = 0;
    rr1=ra1*ra2*ra3;
    rr1=eval(subs(rr1));
    ta = [0;0;60];
    trr1 = [rr1,ta;0,0,0,1];

    a1 = 0;b1 = -1/6*pi;c1 = 0;
    rr2=ra1*ra2*ra3;
    rr2=eval(subs(rr2));
    tb = [0;0;60];
    trr2 = [rr2,tb;0,0,0,1];

    a1 = 0;b1 = 0;c1 = 0;
    rr3=ra1*ra2*ra3;
    rr3=eval(subs(rr3));
    tc = [0;0;30*sqrt(3)];
    trr3 = [rr3,tc;0,0,0,1];

    T12 = trr1/trr2;
    T13 = trr1/trr3;T31 = trr3/trr1;
    T= trr2/trr3;T32 = trr3/trr2;
    euler2 = rodrigues(T(1:3,1:3));
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

   
   % Q = diag([0,0.0000025,0,0.0000001,0,0.0000025,0,0.0000036,0,0.0000036,0,0.0000036],0);
P = 0.1*eye(12);
Q = 100000*diag([0,0.0000025,0,0.0000001,0,0.0000025,0,0.0000036,0,0.0000036,0,0.0000036],0);
% R = 0.06*eye(8);
R1 = diag([0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09]);
R2 = diag([0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09]);
Rj = diag([0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09,0.06,0.07,0.08,0.09]);
m = 180;nm = 10;
t1 = 0;t2 =0;td =0;tm =0;tj=0;

 for j = 1:nm
     dim = 1*pi/180;
     Init_X1 = [20*sin(dim);0;20*sin(dim);0;50;0;0;0;0;0;0;0];
P1 = 0.5*eye(12);P2 = eye(12);x1 = Init_X1;x2 = x1;Pd = eye(12);xd = x1;xj= x1;Pj =eye(12);
v1 = mvnrnd(0,0.06,m);
v2 = mvnrnd(0,0.07,m);
v3 = mvnrnd(0,0.08,m);
v4 = mvnrnd(0,0.09,m);
v5 = mvnrnd(0,0.06,m);
v6 = mvnrnd(0,0.07,m);
v7 = mvnrnd(0,0.08,m);
v8 = mvnrnd(0,0.09,m);
v11 = mvnrnd(0,0.06,m);
v21 = mvnrnd(0,0.07,m);
v31 = mvnrnd(0,0.08,m);
v41 = mvnrnd(0,0.09,m);
v51 = mvnrnd(0,0.06,m);
v61 = mvnrnd(0,0.07,m);
v71 = mvnrnd(0,0.08,m);
v81 = mvnrnd(0,0.09,m);
st1 = zeros(1,m);st2 = zeros(1,m);std = zeros(1,m);stm = zeros(1,m);stj= zeros(1,m);

for k = 1:m
    sx = 20*sin(k*dim);
    sy = 20*cos(k*dim);
    sz = 50+k/10;
    a1 = pi/100*rand(1);
    b1 = b1+pi/180*rand(1);
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
    C2x = T23*C3x;C2z = T23*C3z;
    for i =1:4
        z1(2*i-1,1) = 500*C3z(1,i)/C3z(3,i);z1(2*i,1) = 500*C3z(2,i)/C3z(3,i);%+v2(i*k);+v1(i*k)
        z2(2*i-1,1) = 500*C2z(1,i)/C2z(3,i);z2(2*i,1) = 500*C2z(2,i)/C2z(3,i);%+v4(i*k);+v3(i*k)
    end
    z1 = z1+[v11(k);v21(k);v31(k);v41(k);v51(k);v61(k);v71(k);v81(k)];
    z2 = z2+[v1(k);v2(k);v3(k);v4(k);v5(k);v6(k);v7(k);v8(k)];
    z =[z1;z2];
    [x1,x1p,P1,Pp1,DevX1,DevZ1,K1] = ukf(f,x1,P1,h1,z1,Q,R2);
    [x2,x2p,P2,Pp2,DevX2,DevZ2,K2] = ukf(f,x2,P2,h2,z2,Q,R2);
    [xj,xjp,Pj,Ppj,DevXj,DevZj,Kj] = ukf(f,xj,Pj,h,z,Q,Rj);
    
    xr = [C3x(1);0;C3x(2);0;C3x(3);0;0;0;0;0;0;0];
%    [ xd,Pd ] = distribute_strong_noliner_fusion(f, Q,P1,P2,Pp1,Pp2,Pd,x1,x2,x1p,x2p,xd);
%    [ xm ] = strong_nolinear_Matrix_weighted( x1,x2,DevX1,DevX2,DevZ1,DevZ2,K1,K2,P1,P2,Q);
    SData_Xr(k,:) = xr';SData_X1(k,:) = (x1-xr)';SData_X2(k,:) =(x2-xr)';SData_Xj(k,:)  = (xj-xr)';
%     SData_X2 = [SData_X2;(x2-xr)'];SData_Xd = [SData_Xd;(xd-xr)'];SData_Xm = [SData_Xm;(xj-xr)'];
end
end
 figure(1);
plot3(SData_Xr(:,1),SData_Xr(:,3),SData_Xr(:,5),'b*');hold on;
plot3(SData_Xr(:,1)+SData_X1(:,1),SData_Xr(:,3)+SData_X1(:,3),SData_Xr(:,5)+SData_X1(:,5),'r*');hold on;
plot3(SData_Xr(:,1)+SData_X2(:,1),SData_Xr(:,3)+SData_X2(:,3),SData_Xr(:,5)+SData_X2(:,5),'g*');
plot3(SData_Xr(:,1)+SData_Xj(:,1),SData_Xr(:,3)+SData_Xj(:,3),SData_Xr(:,5)+SData_Xj(:,5),'k*');
a = 1:m;
figure(3);
subplot(3,2,1);hold on;
plot(a,SData_X1(:,1));plot(a,SData_X2(:,1));
plot(a,SData_Xj(:,1));
subplot(3,2,2);hold on;
plot(a,SData_X1(:,3));plot(a,SData_X2(:,3));
plot(a,SData_Xj(:,3));
subplot(3,2,3);hold on;
plot(a,SData_X1(:,5));plot(a,SData_X2(:,5));
plot(a,SData_Xj(:,5));
subplot(3,2,4);hold on;
plot(a,SData_X1(:,7)*180/pi);plot(a,SData_X2(:,7)*180/pi);
plot(a,SData_Xj(:,7)*180/pi);
subplot(3,2,5);hold on;
plot(a,SData_X1(:,9)*180/pi);plot(a,SData_X2(:,9)*180/pi);
plot(a,SData_Xj(:,9)*180/pi);
subplot(3,2,6);hold on;
plot(a,SData_X1(:,11)*180/pi);plot(a,SData_X2(:,11)*180/pi);
plot(a,SData_Xj(:,11)*180/pi);

