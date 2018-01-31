function [x,x_pre,P,P_pre,K,qNk,detNk,Q,qlast,R,rNk,tNk,rlast] = AEkf2(A_k,f,x,P,h,z,Q,R,qNk,detNk,N,qlast,H_k,rNk,tNk,rlast)
m = size(P,1);L  =size(z,1);

x_pre = f(x);
P_pre = A_k*P*A_k'+Q;
nq = size(qNk,2);
z_pre = h(x_pre);

det = A_k*P*A_k';
temp_k = H_k*P_pre*H_k'+ R;
K = P_pre*H_k'/temp_k;
if isnan(K)
    iii = 0;
end
x = x_pre + K*(z - z_pre);
P = P_pre-K*H_k*P_pre;
det = det-P;
q = x-x_pre;
qNk(:,nq+1) = q;
qbal = qlast + 1/N*(q - qNk(:,nq-N+1));

Q = Q+1/(N-1)*((q-qbal)*(q-qbal)'-(qNk(:,nq-N+1)-qbal)*(qNk(:,nq-N+1)-qbal)'+1/N*(q - qNk(:,nq-N+1))*(q - qNk(:,nq-N+1))'+(N-1)/N*(detNk((m*(nq-1)+1):(m*nq),1:m)-det));
detNk = [detNk;det];
qlast = qbal;

nr = size(rNk,2);
r = z - h(x);
Temp = H_k*P_pre*H_k';
rbal = rlast + 1/N*(r - rNk(:,nr-N+1));
% R = R+1/(N-1)*((r-rbal)*(r-rbal)'-(rNk(:,nr-N+2)-rbal)*(rNk(:,nr-N+2)-rbal)'+(r - rNk(:,nr-N+2))*(r - rNk(:,nr-N+2))'+(N-1)/N*(tNk((L*(nr-1)+1):(L*nr),1:L)-Temp));
rlast = rbal;
rNk(:,nr+1) = rbal;
tNk = [tNk;Temp];


