function [x,x_pre,P,P_pre,K,qNk,detNk,Q,qlast] = AEkf(A_k,f,x,P,h,z,Q,R,qNk,detNk,N,qlast,H_k)
m = size(P,1);

x_pre = f(x);
P_pre = A_k*P*A_k'+Q;
nq = size(qNk,2);
z_pre = h(x_pre);

det = A_k*P*A_k';
temp_k = H_k*P_pre*H_k'+ R;
K = P_pre*H_k'/temp_k;
x = x_pre + K*(z - z_pre);
P = P_pre-K*H_k*P_pre;
det = det-P;
q = x-x_pre;
qNk(:,nq+1) = q;
qbal = qlast + 1/N*(q - qNk(:,nq-N+1));

Q = Q+1/(N-1)*((q-qbal)*(q-qbal)'-(qNk(:,nq-N+1)-qbal)*(qNk(:,nq-N+1)-qbal)'+1/N*(q - qNk(:,nq-N+1))*(q - qNk(:,nq-N+1))'+(N-1)/N*(detNk((m*(nq-1)+1):(m*nq),1:m)-det));
detNk = [detNk;det];
qlast = qbal;


