function [x,x_pre,P,P_pre,K,qNk,detNk,Q,qlast,H_k] = IAekf8(A_k,f,x,P,h,z,Q,R,qNk,detNk,N,qlast,focalIndex,RelatObjCoor,T,euler)
m = size(P,1);
x_pre = f(x);
P_pre = A_k*P*A_k'+Q;
kx = focalIndex(1,:);
ky = focalIndex(2,:);
nq = size(qNk,2);
x_kpk = x_pre;
H_k = ekf_jacobian8( f,kx,ky,x,RelatObjCoor,T,euler,1);
Kk = P_pre*H_k'/(R+H_k*P_pre*H_k');
z_kpre = h(x_kpk);
x_k = x_kpk + Kk*(z-z_kpre);
e1 = z-z_kpre;
for jj=1:5
    x_pre = x_k;
    H_k = ekf_jacobian8( f,kx,ky,x_pre,RelatObjCoor,T,euler,-1);
    z_kpre = h(x_k);
    Kk = P_pre*H_k'/(R+H_k*P_pre*H_k');
    x_k = x_k + Kk*(z-z_kpre);  
    e2 = z-z_kpre;
%     if(e2'*e2<e1'*e1)
%         break;
%     end
    e1 = e2;
end
det = A_k*P*A_k';
K = Kk;
x = x_k;
P = P_pre-K*H_k*P_pre;
det = det-P;
q = x-x_pre;
qNk(:,nq+1) = q;
qbal = qlast + 1/N*(q - qNk(:,nq-N+1));
Q = Q+1/(N-1)*((q-qbal)*(q-qbal)'-(qNk(:,nq-N+1)-qbal)*(qNk(:,nq-N+1)-qbal)'+1/N*(q - qNk(:,nq-N+1))*(q - qNk(:,nq-N+1))'+(N-1)/N*(detNk((m*(nq-1)+1):(m*nq),1:m)-det));
detNk = [detNk;det];
qlast = qbal;
