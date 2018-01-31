function [ x,P ] = NonlinerUKF82(z,x,P,focalIndex,t,RelatObjCoor,flag)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
persistent xm1 xm2 xd1 xd2;
m = size(z,2);
n = size(z,1)/2;
kx1 = focalIndex(1,1);
ky1 = focalIndex(2,1);
u01 = focalIndex(3,1);
v01 = focalIndex(4,1);
kx2 = focalIndex(1,2);
ky2 = focalIndex(2,2);
u02 = focalIndex(3,2);
v02 = focalIndex(4,2);

F = [eye(3),t*eye(3),t^2/2*eye(3);
     zeros(3,3),eye(3),t*eye(3);
     zeros(3,3),zeros(3,3),eye(3);];
f=@(x)[F*x(1:9,1);x(10:12,1)+t*x(13:15,1)+t*t/2*x(16:18,1);x(13:15,1)+t*x(16:18,1);x(16:18,1)];
F1 = [kx1,0,u01;0,ky1,v01];
F2 = [kx2,0,u02;0,ky2,v02];F3 = [0,0,1];
RelatObjCoor1 = [RelatObjCoor,ones(n,1)];

T11 = [0.990056736839648	0.138700201042969	-0.0234502040304307	-19.7744975543823
-0.00760084430112634	-0.113713938449350	-0.993484457537333	89.9650614299275
-0.140463109051234	0.983784221479984	-0.111529012201685	406.556094441695];
T22 = [0.906786492107317	-0.414111711244194	0.0790553498639462	-71.5835134131045
0.0207567564019525	-0.143436474032662	-0.989441830013643	87.9730234192150
0.421078870041440	0.898853418821713	-0.121470641214829	377.556605156914];
h1=@(x)[ F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(1,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(1,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(2,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(2,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(3,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(3,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(4,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(4,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(5,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(5,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(6,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(6,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(7,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(7,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(8,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(8,:)')];
h2=@(x)[ F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(1,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(1,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(2,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(2,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(3,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(3,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(4,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(4,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(5,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(5,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(6,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(6,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(7,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(7,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(8,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(8,:)')];
h = @(x)[F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(1,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(1,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(2,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(2,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(3,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(3,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(4,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(4,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(5,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(5,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(6,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(6,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(7,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(7,:)');
         F1*GetT_Rodrigues(x,T11)*RelatObjCoor1(8,:)'/(F3*GetT_Rodrigues(x,T11)*RelatObjCoor1(8,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(1,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(1,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(2,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(2,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(3,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(3,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(4,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(4,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(5,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(5,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(6,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(6,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(7,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(7,:)');
         F2*GetT_Rodrigues(x,T22)*RelatObjCoor1(8,:)'/(F3*GetT_Rodrigues(x,T22)*RelatObjCoor1(8,:)')];
     
Q = 1*diag([0,0,0,0.5,0.5,0.5,0.1,0.1,0.1,0,0,0,0.5,0.5,0.5,0.1,0.1,0.1],0);
% R = 0.06*eye(8);
R = 1*diag([0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05]);
if flag == 1
    [x,~,P,~,~,~,~] = ukf(f,x,P,h1,z,Q,R);
elseif flag == 2
    [x,~,P,~,~,~,~] = ukf(f,x,P,h2,z,Q,R);
elseif flag == 3
    if (m>1)
        if isempty(xm1)
            xm1 = x;
        end
        if isempty(xm2)
            xm2 = x;
        end
        z1 = z(:,1);z2 = z(:,2);
        [xm1,~,P1,~,DevX1,DevZ1,K1] = ukf(f,xm1,P,h1,z1,Q,R);
        [xm2,~,P2,~,DevX2,DevZ2,K2] = ukf(f,xm2,P,h2,z2,Q,R);
        [ x ] = strong_nolinear_Matrix_weighted( xm1,xm2,DevX1,DevX2,DevZ1,DevZ2,K1,K2,P1,P2,Q);
    end
elseif flag == 4
    if (m>1)
        if isempty(xd1)
            xd1 = x;
        end
        if isempty(xd2)
            xd2 = x;
        end
        z1 = z(:,1);z2 = z(:,2);
        [xd1,xp1,P1,Pp1,~,~,~] = ukf(f,xd1,P,h1,z1,Q,R);
        [xd2,xp2,P2,Pp2,~,~,~] = ukf(f,xd2,P,h2,z2,Q,R);
        [ x,P ] = distribute_strong_noliner_fusion(f, Q,P1,P2,Pp1,Pp2,P,xd1,xd2,xp1,xp2,x); 
    end
elseif flag == 5
    if (m>1)
        z1 = z(:,1);z2 = z(:,2);
        z3 = [z1;z2];
        Rj = blkdiag(R,R);
        [x,~,P,~,~,~,~] = ukf(f,x,P,h,z3,Q,Rj);
    end
end
end

