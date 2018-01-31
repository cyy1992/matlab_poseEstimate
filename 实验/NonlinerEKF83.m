function [ x,P] = NonlinerEKF83(z,x,P,focalIndex,t,RelatObjCoor,N,flag)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
persistent qNk1 qNk2 detNk1 detNk2 qlast1 qlast2 Q1 Q2;
persistent fusiond_qNk1 fusiond_qNk2 fusiond_detNk1 fusiond_detNk2 fusiond_qlast1 fusiond_qlast2 xd1 Pd1 xd2 Pd2 Qd1 Qd2;
persistent fusionm_qNk1 fusionm_qNk2 fusionm_detNk1 fusionm_detNk2 fusionm_qlast1 fusionm_qlast2 xm1 Pm1 xm2 Pm2 Qm1 Qm2 Pm18;
persistent fusionj_qNk fusionj_detNk fusionj_qlast fusionj_Q;
persistent R1 rNk tNk rlast;
mp = size(P,1);
mq = size(x,1);
num_z = size(z,2);
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
A_k = [F,zeros(9,9);zeros(9,9),F];

F1 = [kx1,0,u01;0,ky1,v01];
F2 = [kx2,0,u02;0,ky2,v02];F3 = [0,0,1];
RelatObjCoor1 = [RelatObjCoor,ones(n,1)];
T11 = [0.990056736839648	0.138700201042969	-0.0234502040304307	-19.7744975543823
-0.00760084430112634	-0.113713938449350	-0.993484457537333	89.0650614299275
-0.140463109051234	0.983784221479984	-0.111529012201685	406.556094441695];
T22 = [0.906786492107317	-0.414111711244194	0.0790553498639462	-71.8835134131045
0.0207567564019525	-0.143436474032662	-0.989441830013643	87.3730234192150
0.421078870041440	0.898853418821713	-0.121470641214829	377.556605156914];

f=@(x)[F*x(1:9,1);x(10:12,1)+t*x(13:15,1)+t*t/2*x(16:18,1);x(13:15,1)+t*x(16:18,1);x(16:18,1)];
h1=@(x)[ F1*T11*getwTo(x)*RelatObjCoor1(1,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(1,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(2,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(2,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(3,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(3,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(4,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(4,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(5,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(5,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(6,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(6,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(7,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(7,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(8,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(8,:)')];
h2=@(x)[ F2*T22*getwTo(x)*RelatObjCoor1(1,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(1,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(2,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(2,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(3,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(3,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(4,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(4,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(5,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(5,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(6,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(6,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(7,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(7,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(8,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(8,:)')];
h=@(x)[F1*T11*getwTo(x)*RelatObjCoor1(1,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(1,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(2,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(2,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(3,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(3,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(4,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(4,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(5,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(5,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(6,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(6,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(7,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(7,:)');
         F1*T11*getwTo(x)*RelatObjCoor1(8,:)'/(F3*T11*getwTo(x)*RelatObjCoor1(8,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(1,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(1,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(2,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(2,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(3,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(3,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(4,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(4,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(5,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(5,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(6,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(6,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(7,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(7,:)');
         F2*T22*getwTo(x)*RelatObjCoor1(8,:)'/(F3*T22*getwTo(x)*RelatObjCoor1(8,:)')];
Q = 0.0001*diag([0,0,0,0.5,0.5,0.5,0.1,0.1,0.1,0,0,0,0.5,0.5,0.5,0.1,0.1,0.1],0);
% R = 0.06*eye(8);
R = 0.001*diag([0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05]);
if flag == 1
    if isempty(qNk1)
        qNk1 = zeros(18,N);
    end
    if isempty(detNk1)
        detNk1 = zeros(N*18,18);
%         for k = 1:N
%             detNk1(18*(k-1)+1:18*k,1:18) = Q;
%         end
    end
    if isempty(qlast1)
        qlast1 = zeros(18,1);
    end
    if isempty(Q1)
        Q1 = Q;
    end
    
    if isempty(R1)
        R1 = R;
    end
    if isempty(rNk)
        rNk = zeros(16,N);
    end
    if isempty(tNk)
        tNk = zeros(N*16,16);
        for k = 1:N
            tNk(16*(k-1)+1:16*k,1:16) = R;
        end
    end
    if isempty(rlast)
        rlast = zeros(16,1);
    end
    
    H_k1 = ekf_jacobian83( f,x,1);
    [x,~,P,~,~,qNk1,detNk1,Q1,qlast1,R1,rNk,tNk,rlast] = AEkf2(A_k,f,x,P,h1,z,Q1,R1,qNk1,detNk1,N,qlast1,H_k1,rNk,tNk,rlast);
elseif flag == 2
    if isempty(qNk2)
        qNk2 = zeros(18,N);
    end
    if isempty(detNk2)
        detNk2 = zeros(N*18,18);
    end
    if isempty(qlast2)
        qlast2 = zeros(18,1);
    end
    if isempty(Q2)
        Q2 = Q;
    end
    H_k2 = ekf_jacobian83( f,x,2);
    [x,~,P,~,~,qNk2,detNk2,Q2,qlast2] = AEkf(A_k,f,x,P,h2,z,Q2,R,qNk2,detNk2,N,qlast2,H_k2);
elseif flag == 3
    if (num_z>1)
        if isempty(fusionm_qNk1)
            fusionm_qNk1 = zeros(18,N);
        end
        if isempty(fusionm_detNk1)
            fusionm_detNk1 = zeros(N*18,18);
        end
        if isempty(fusionm_qlast1)
            fusionm_qlast1 = zeros(18,1);
        end
        if isempty(fusionm_qNk2)
            fusionm_qNk2 = zeros(18,N);
        end
        if isempty(fusionm_detNk2)
            fusionm_detNk2 = zeros(N*18,18);
        end
        if isempty(fusionm_qlast2)
            fusionm_qlast2 = zeros(18,1);
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
        if isempty(Pm18)
            Pm18 = eye(mp);
        end
        z1 = z(:,1);z2 = z(:,2);
        H_k1 = ekf_jacobian83(f,xm1,1);
        [xm1,~,Pm1,~,Km1,fusionm_qNk1,fusionm_detNk1,Qm1,fusionm_qlast1] = AEkf(A_k,f,xm1,Pm1,h1,z1,Qm1,R,fusionm_qNk1,fusionm_detNk1,N,fusionm_qlast1,H_k1);
        H_k2 = ekf_jacobian83(f,xm2,2);
        [xm2,~,Pm2,~,Km2,fusionm_qNk2,fusionm_detNk2,Qm2,fusionm_qlast2] = AEkf(A_k,f,xm2,Pm2,h2,z2,Qm2,R,fusionm_qNk2,fusionm_detNk2,N,fusionm_qlast2,H_k2);
        Qe = (Qm1+Qm2)/2;
        [ x,Pm18 ] = EKF_Matrix_weighted( A_k,H_k1,H_k2,Km1,Km2,Pm1,Pm2,Pm18,xm1,xm2,Qe);
    end
    
elseif flag == 4
    if (num_z>1)
        if isempty(fusiond_qNk1)
            fusiond_qNk1 = zeros(18,N);
        end
        if isempty(fusiond_detNk1)
            fusiond_detNk1 = zeros(N*18,18);
        end
        if isempty(fusiond_qlast1)
            fusiond_qlast1 = zeros(18,1);
        end
        if isempty(fusiond_qNk2)
            fusiond_qNk2 = zeros(18,N);
        end
        if isempty(fusiond_detNk2)
            fusiond_detNk2 = zeros(N*18,18);
        end
        if isempty(fusiond_qlast2)
            fusiond_qlast2 = zeros(18,1);
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
        H_k1 = ekf_jacobian83( f,xd1,1);
        
        [xd1,xdp1,Pd1,Pdp1,~,fusiond_qNk1,fusiond_detNk1,Qd1,fusiond_qlast1] = AEkf(A_k,f,xd1,Pd1,h1,z1,Qd1,R,fusiond_qNk1,fusiond_detNk1,N,fusiond_qlast1,H_k1);
        H_k2 = ekf_jacobian83( f,xd2,2);
        [xd2,xdp2,Pd2,Pdp2,~,fusiond_qNk2,fusiond_detNk2,Qd2,fusiond_qlast2] = AEkf(A_k,f,xd2,Pd2,h2,z2,Qd2,R,fusiond_qNk2,fusiond_detNk2,N,fusiond_qlast2,H_k2);
        Qef = (Qd1+Qd2)/2;
        [ x,P ] = distribute_EKF_noliner_fusion(A_k,f, Qef,Pd1,Pd2,Pdp1,Pdp2,P,xd1,xd2,xdp1,xdp2,x);        
    end
elseif flag == 5
    if (num_z>1)
        if isempty(fusionj_qNk)
            fusionj_qNk = zeros(18,N);
        end
        if isempty(fusionj_detNk)
            fusionj_detNk = zeros(N*18,18);
        end
        if isempty(fusionj_qlast)
            fusionj_qlast = zeros(18,1);
        end
        if isempty(fusionj_Q)
            fusionj_Q = Q;
        end
        z1 = z(:,1);z2 = z(:,2);
        z3 = [z1;z2];
        H_k = ekf_jacobian83( f,x,3);
        Rj = blkdiag(R,R);
        [x,~,P,~,~,fusionj_qNk,fusionj_detNk,fusionj_Q,fusionj_qlast] = AEkf(A_k,f,x,P,h,z3,fusionj_Q,Rj,fusionj_qNk,fusionj_detNk,N,fusionj_qlast,H_k);
    end
end