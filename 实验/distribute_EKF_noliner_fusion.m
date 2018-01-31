function [ xd,Pd ] = distribute_EKF_noliner_fusion(A_k,f, Q,P1,P2,Pp1,Pp2,Pd,x1,x2,x1p,x2p,xd)
m = size(Pd,1);
xfp = f(xd);
Pp = A_k*Pd*A_k'+Q;
Pd = eye(m)/(eye(m)/Pp+eye(m)/P1+eye(m)/P2-eye(m)/Pp1-eye(m)/Pp2); %3.21
xd = Pd*(eye(m)/Pp*xfp+eye(m)/P1*x1+eye(m)/P2*x2-eye(m)/Pp1*x1p-eye(m)/Pp2*x2p); %3.22
end