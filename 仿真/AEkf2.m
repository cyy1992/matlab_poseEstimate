function [x,x_pre,P,P_pre,qNk,detNk,Q,qlast,R,rNk,tNk,rlast] = AEkf2(f,x,P,h,z,Q,R,qNk,detNk,N,qlast,rNk,tNk,rlast)
m = size(P,1);L  =size(z,1);
temp_Ak =  [1,0.05;0,1];
A_k = blkdiag(temp_Ak,temp_Ak,temp_Ak,temp_Ak,temp_Ak,temp_Ak);
RelatObjCoor = [0 0 0;20 0 0; 20 20 0; 0 20 0];
kx = 500;ky = 500;
x_pre = f(x);
P_pre = A_k*P*A_k'+Q;
nq = size(qNk,2);
z_pre = h(x_pre);

det = A_k*P*A_k';
H_k = [                                      kx/x(5), 0,                                          0, 0,                                                                                                                 -(kx*x(1))/x(5)^2, 0,                                                                                                                      0, 0,                                                                                                                                                                                                                                                                   0, 0,                                                                                                                                                                                                                                                   0, 0;
                                          0, 0,                                      ky/x(5), 0,                                                                                                                 -(ky*x(3))/x(5)^2, 0,                                                                                                                      0, 0,                                                                                                                                                                                                                                                                   0, 0,                                                                                                                                                                                                                                                   0, 0;
                       kx/(x(5) + 20*sin(x(9))), 0,                                          0, 0,                                                                           -(kx*(x(1) + 20*cos(x(7))*cos(x(9))))/(x(5) + 20*sin(x(9)))^2, 0,                                                                             -(20*kx*cos(x(9))*sin(x(7)))/(x(5) + 20*sin(x(9))), 0,                                                                                                                                                         - (20*kx*cos(x(7))*sin(x(9)))/(x(5) + 20*sin(x(9))) - (20*kx*cos(x(9))*(x(1) + 20*cos(x(7))*cos(x(9))))/(x(5) + 20*sin(x(9)))^2, 0,                                                                                                                                                                                                                                                   0, 0;
                                          0, 0,                       ky/(x(5) + 20*sin(x(9))), 0,                                                                           -(ky*(x(3) - 20*cos(x(9))*sin(x(7))))/(x(5) + 20*sin(x(9)))^2, 0,                                                                             -(20*ky*cos(x(7))*cos(x(9)))/(x(5) + 20*sin(x(9))), 0,                                                                                                                                                           (20*ky*sin(x(7))*sin(x(9)))/(x(5) + 20*sin(x(9))) - (20*ky*cos(x(9))*(x(3) - 20*cos(x(9))*sin(x(7))))/(x(5) + 20*sin(x(9)))^2, 0,                                                                                                                                                                                                                                                   0, 0;
 kx/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))), 0,                                          0, 0, -(kx*(x(1) + 20*cos(x(7))*cos(x(9)) + 20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11)))^2, 0, -(kx*(20*cos(x(9))*sin(x(7)) - 20*cos(x(7))*cos(x(11)) + 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))), 0, - (kx*(20*cos(x(7))*sin(x(9)) - 20*cos(x(7))*cos(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))) - (kx*(20*cos(x(9)) + 20*sin(x(9))*sin(x(11)))*(x(1) + 20*cos(x(7))*cos(x(9)) + 20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11)))^2, 0, (20*kx*cos(x(9))*cos(x(11))*(x(1) + 20*cos(x(7))*cos(x(9)) + 20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11)))^2 - (kx*(20*sin(x(7))*sin(x(11)) - 20*cos(x(7))*cos(x(11))*sin(x(9))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))), 0;
                                          0, 0, ky/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))), 0, -(ky*(x(3) + 20*cos(x(7))*cos(x(11)) - 20*cos(x(9))*sin(x(7)) - 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11)))^2, 0, -(ky*(20*cos(x(7))*cos(x(9)) + 20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))), 0,   (ky*(20*sin(x(7))*sin(x(9)) - 20*cos(x(9))*sin(x(7))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))) - (ky*(20*cos(x(9)) + 20*sin(x(9))*sin(x(11)))*(x(3) + 20*cos(x(7))*cos(x(11)) - 20*cos(x(9))*sin(x(7)) - 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11)))^2, 0, (20*ky*cos(x(9))*cos(x(11))*(x(3) + 20*cos(x(7))*cos(x(11)) - 20*cos(x(9))*sin(x(7)) - 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11)))^2 - (ky*(20*cos(x(7))*sin(x(11)) + 20*cos(x(11))*sin(x(7))*sin(x(9))))/(x(5) + 20*sin(x(9)) - 20*cos(x(9))*sin(x(11))), 0;
              kx/(x(5) - 20*cos(x(9))*sin(x(11))), 0,                                          0, 0,                                   -(kx*(x(1) + 20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11)))^2, 0,                                    (kx*(20*cos(x(7))*cos(x(11)) - 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11))), 0,                                                                                        (20*kx*cos(x(7))*cos(x(9))*sin(x(11)))/(x(5) - 20*cos(x(9))*sin(x(11))) - (20*kx*sin(x(9))*sin(x(11))*(x(1) + 20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11)))^2, 0,                                                (20*kx*cos(x(9))*cos(x(11))*(x(1) + 20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11)))^2 - (kx*(20*sin(x(7))*sin(x(11)) - 20*cos(x(7))*cos(x(11))*sin(x(9))))/(x(5) - 20*cos(x(9))*sin(x(11))), 0;
                                          0, 0,              ky/(x(5) - 20*cos(x(9))*sin(x(11))), 0,                                   -(ky*(x(3) + 20*cos(x(7))*cos(x(11)) - 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11)))^2, 0,                                   -(ky*(20*cos(x(11))*sin(x(7)) + 20*cos(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11))), 0,                                                                                      - (20*ky*sin(x(9))*sin(x(11))*(x(3) + 20*cos(x(7))*cos(x(11)) - 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11)))^2 - (20*ky*cos(x(9))*sin(x(7))*sin(x(11)))/(x(5) - 20*cos(x(9))*sin(x(11))), 0,                                                (20*ky*cos(x(9))*cos(x(11))*(x(3) + 20*cos(x(7))*cos(x(11)) - 20*sin(x(7))*sin(x(9))*sin(x(11))))/(x(5) - 20*cos(x(9))*sin(x(11)))^2 - (ky*(20*cos(x(7))*sin(x(11)) + 20*cos(x(11))*sin(x(7))*sin(x(9))))/(x(5) - 20*cos(x(9))*sin(x(11))), 0];
nr = size(rNk,2);
r = z - h(x);
Temp = H_k*P_pre*H_k';
rbal = rlast + 1/N*(r - rNk(:,nr-N+1));
% R = R+1/(N-1)*((r-rbal)*(r-rbal)'-(rNk(:,nr-N+2)-rbal)*(rNk(:,nr-N+2)-rbal)'+(r - rNk(:,nr-N+2))*(r - rNk(:,nr-N+2))'+(N-1)/N*(tNk((L*(nr-1)+1):(L*nr),1:L)-Temp));
rlast = rbal;
rNk(:,nr+1) = rbal;
tNk = [tNk;Temp];

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




