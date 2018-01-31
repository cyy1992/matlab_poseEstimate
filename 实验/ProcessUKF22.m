clear all;
flag_x1 = 1;
flag_x2 = 1;
flag_xj = 1;ag=1;
flag =1;
t=0.05*ag;
% ch = 0;
ch = 0;
%  m = 260;
%  m = 239;
TxtData1 = importdata('cam1.txt');
armjoints = importdata('ralPointFile.txt');
PnpResult1 = importdata('pnp1.txt');
TxtData2 = importdata('cam2.txt');
m = size(TxtData1,1);% Rt=[0.891645542812330,-0.0253519132701749,-0.452023789724000;0.0468332400881701,0.998239479040235,0.0363949187157362;0.450305311545122,-0.0536211057236119,0.891263094386404];
% kx1 = 842.421218293945;ky1 = 842.849732532109;u01 = 319.399607306323;v01 = 264.729901470455;
n = size(TxtData1,2)/2;
kx2 = 818.086365732527;ky2 = 817.128180829000;u02 = 361.905958857945;v02 = 226.845448574816;

kx1 = 849.921218293945;ky1 = 844.29732532109;u01 = 319.399607306323;v01 = 251.929901470455;
kx1 = 848.0021218293945;ky1 = 847.8049732532109;u01 = 318.399607306323;v01 = 280.829901470455;
kx1 = 839.921218293945;ky1 = 837.29732532109;u01 = 313.399607306323;v01 = 265.929901470455;
kx1 = 848.0021218293945;ky1 = 847.761570101376	;u01 = 315.427157552599	;v01 = 264.106246845724	;

tt = [112.005196173910;3.16303348852451;-1.69908506874230];
euler2 =  [-0.0572
   -0.23922  
    0.0254];
Rt = rodrigues(euler2);
T = [Rt,tt];
Init_X1 = [PnpResult1(1,1);PnpResult1(1,2);PnpResult1(1,3);0;0;0;0;0;0;PnpResult1(1,4)/180*pi;PnpResult1(1,5)/180*pi;PnpResult1(1,6)/180*pi;0.0001;0;0;0;0;0];
x1 = Init_X1;
x2 = Init_X1;x3 = x1;
P1 = 1*eye(18);P2 = eye(18);P3 =P1;
focalIndex = [kx1 ky1 u01 v01;kx2 ky2 u02 v02]';
RelatObjCoor = [-35,-80,0;
    35,-80,0; 
    35,-10,0; 
    -35,-10,0;
    -20,-65,0;
    20,-65,0; 
    20,-25,0; 
    -20,-25,0];
N = 30;
qNk1 = zeros(18,N);qNk2 = zeros(18,N);
detNk1 = zeros(N*18,18);detNk2 = zeros(N*18,18);
F = [eye(3),t*eye(3),t^2/2*eye(3);
     zeros(3,3),eye(3),t*eye(3);
     zeros(3,3),zeros(3,3),eye(3);];
f=@(x)[F*x(1:9,1);Qa(x(10:12,1),t*x(13:15,1)+t*t/2*x(16:18,1));x(13:15,1)+t*x(16:18,1);x(16:18,1)];
h1=@(x)[kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(1,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(1,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(1,3))/(x(3)-sin(x(11))*RelatObjCoor(1,1)+cos(x(11))*sin(x(10))*RelatObjCoor(1,2)+cos(x(11))*cos(x(10))*RelatObjCoor(1,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(1,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(1,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(1,3))/(x(3)-sin(x(11))*RelatObjCoor(1,1)+cos(x(11))*sin(x(10))*RelatObjCoor(1,2)+cos(x(11))*cos(x(10))*RelatObjCoor(1,3))+v01;
       kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(2,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(2,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(2,3))/(x(3)-sin(x(11))*RelatObjCoor(2,1)+cos(x(11))*sin(x(10))*RelatObjCoor(2,2)+cos(x(11))*cos(x(10))*RelatObjCoor(2,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(2,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(2,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(2,3))/(x(3)-sin(x(11))*RelatObjCoor(2,1)+cos(x(11))*sin(x(10))*RelatObjCoor(2,2)+cos(x(11))*cos(x(10))*RelatObjCoor(2,3))+v01;
       kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(3,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(3,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(3,3))/(x(3)-sin(x(11))*RelatObjCoor(3,1)+cos(x(11))*sin(x(10))*RelatObjCoor(3,2)+cos(x(11))*cos(x(10))*RelatObjCoor(3,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(3,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(3,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(3,3))/(x(3)-sin(x(11))*RelatObjCoor(3,1)+cos(x(11))*sin(x(10))*RelatObjCoor(3,2)+cos(x(11))*cos(x(10))*RelatObjCoor(3,3))+v01;
       kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(4,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(4,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(4,3))/(x(3)-sin(x(11))*RelatObjCoor(4,1)+cos(x(11))*sin(x(10))*RelatObjCoor(4,2)+cos(x(11))*cos(x(10))*RelatObjCoor(4,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(4,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(4,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(4,3))/(x(3)-sin(x(11))*RelatObjCoor(4,1)+cos(x(11))*sin(x(10))*RelatObjCoor(4,2)+cos(x(11))*cos(x(10))*RelatObjCoor(4,3))+v01;
       kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(5,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(5,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(5,3))/(x(3)-sin(x(11))*RelatObjCoor(5,1)+cos(x(11))*sin(x(10))*RelatObjCoor(1,2)+cos(x(11))*cos(x(10))*RelatObjCoor(5,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(5,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(5,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(5,3))/(x(3)-sin(x(11))*RelatObjCoor(5,1)+cos(x(11))*sin(x(10))*RelatObjCoor(1,2)+cos(x(11))*cos(x(10))*RelatObjCoor(5,3))+v01;
       kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(6,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(6,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(6,3))/(x(3)-sin(x(11))*RelatObjCoor(6,1)+cos(x(11))*sin(x(10))*RelatObjCoor(2,2)+cos(x(11))*cos(x(10))*RelatObjCoor(6,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(6,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(6,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(6,3))/(x(3)-sin(x(11))*RelatObjCoor(6,1)+cos(x(11))*sin(x(10))*RelatObjCoor(2,2)+cos(x(11))*cos(x(10))*RelatObjCoor(6,3))+v01;
       kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(7,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(7,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(7,3))/(x(3)-sin(x(11))*RelatObjCoor(7,1)+cos(x(11))*sin(x(10))*RelatObjCoor(3,2)+cos(x(11))*cos(x(10))*RelatObjCoor(7,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(7,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(7,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(7,3))/(x(3)-sin(x(11))*RelatObjCoor(7,1)+cos(x(11))*sin(x(10))*RelatObjCoor(3,2)+cos(x(11))*cos(x(10))*RelatObjCoor(7,3))+v01;
       kx1*(x(1)+cos(x(12))*cos(x(11))*RelatObjCoor(8,1)+(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10)))*RelatObjCoor(8,2)+(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10)))*RelatObjCoor(8,3))/(x(3)-sin(x(11))*RelatObjCoor(8,1)+cos(x(11))*sin(x(10))*RelatObjCoor(4,2)+cos(x(11))*cos(x(10))*RelatObjCoor(8,3))+u01;
       ky1*(x(2)+sin(x(12))*cos(x(11))*RelatObjCoor(8,1)+(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10)))*RelatObjCoor(8,2)+(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10)))*RelatObjCoor(8,3))/(x(3)-sin(x(11))*RelatObjCoor(8,1)+cos(x(11))*sin(x(10))*RelatObjCoor(4,2)+cos(x(11))*cos(x(10))*RelatObjCoor(8,3))+v01]; 

Q = 0.1*diag([0,0,0,0.5,0.5,0.5,1,1,1,0,0,0,0.5,0.5,0.5,1,1,1],0);
% R = 0.06*eye(8);
R = 0.1*diag([0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05]);

R1 = R;
N = 30;
qNk1 = zeros(18,N);qNk2 = zeros(18,N);
detNk1 = zeros(N*18,18);detNk2 = zeros(N*18,18);
k1 = 0.171155585097036;k2 = -0.577698858593896;
SData_X1 = zeros(fix(m/ag),6);
SData_X2 = zeros(fix(m/ag),6);
SData_X3 = zeros(fix(m/ag),6);

sum1 = zeros(1,6);
sum2 = zeros(1,6);
sum3 = zeros(1,6);
for i = 1:m/ag
    z1 = TxtData1(ag*i,:)';z2 = TxtData2(ag*i,:)';z = [z1,z2];
    for j = 1:n
        r = ((z1(2*j-1)-u01)/kx1)^2+((z1(2*j)-v01)/ky1)^2;
        z1(2*j-1) = (z1(2*j-1)-u01)*(1+k1*r+k2*r*r)+u01;
        z1(2*j) = (z1(2*j)-v01)*(1+k1*r+k2*r^2)+v01;
    end
   [x1,~,P1,~,~,~,~,e] = ukfProcess(f,x1,P1,h1,z1,Q,R1);
%    [x2,~,P2,~,~,~,~,e] = ukfProcess(f,x2,P2,h2,z2,Q,R1);
%     e1 = e;
%     [x1,xp1,P1,Pp1,X2,Z2,K,e] = ukfProcess(f,x1,P1,h1,z1,Q,R1);
%     e2 = e;
%     while(e2'*e2<e1'*e1)
%         e1 = e2;
%          [x1,xp1,P1,Pp1,X2,Z2,K,e] = ukfProcess(f,x1,P1,h1,z1,Q,R1);
%         e2 = e;
%     end
    
%     [ x2,P2 ] = NonlinerEKF8(z1,x2,P2,focalIndex,t,RelatObjCoor,euler2,T,N,1);
%     [ x3,P3] = NonlinerIAEKF8(z1,x3,P3,focalIndex,t,RelatObjCoor,euler2,T,N,1);
%     sum1 = sum1 +abs([x1(1)-0.415,x1(3)+7.23,x1(5),x1(7)*180/pi,x1(9)*180/pi,x1(11)*180/pi]-armjoints(ag*i,:));
%     sum2 = sum2 +abs([x2(1)-0.415,x2(3)+7.23,x2(5),x2(11)*180/pi,x2(9)*180/pi,x2(7)*180/pi]-armjoints(ag*i,:));
%     sum3 = sum3 +abs([x3(1)-0.415,x3(3)+7.23,x3(5),x3(11)*180/pi,x3(9)*180/pi,x3(7)*180/pi]-armjoints(ag*i,:));
    if flag == 1
        T1 = [0.999976900310448	-0.00666534540190988	-0.00133117098153324	-2.15960227684756;
                0.00653488290508947	0.996660330527098	-0.0813970568204560	8.06341473165461;
                0.00186926480885022	0.0813864775272221	0.996680865234597	384.241169494381;
                0	0	0	1];
        flag = 0;
    end
%     R1 = rodrigues(PnpResult1(i,4:6)/180*pi);
%     t1 = PnpResult1(i,1:3)';
    Rr = rodrigues(x1(10:12,1));
    Tt = x1(1:3,1);
    ob = GetW(T1,Rr,Tt);    
    
    SData_X1(i,:) = [ob(1),ob(2),ob(3),ob(4),ob(5),ob(6)];
    SData_X2(i,:) = [x2(1),x2(3),x2(5),x2(11)*180/pi,x2(9)*180/pi,x2(7)*180/pi];
    SData_X3(i,:) = [x3(1),x3(3),x3(5),x3(11)*180/pi,x3(9)*180/pi,x3(7)*180/pi];
%     SData_X3(i,:) = abs(PnpResult1(i,:)-armjoints(i,:));
end

a = 1:m/ag;
% SData_X1(:,7) =SData_X1(:,7)*180/pi;
% SData_X1(:,9) = SData_X1(:,9)*180/pi;
% SData_X1(:,11) = SData_X1(:,11)*180/pi;

% figure;
% 
% if flag_x1 
%     subplot(3,2,1);
%     plot(a,SData_X1(:,1));hold on;
%     subplot(3,2,2);
%     plot(a,SData_X1(:,3));hold on;
%     subplot(3,2,3);
%     plot(a,SData_X1(:,5));hold on;
%     subplot(3,2,4);
%     plot(a,SData_X1(:,7));hold on;
%     subplot(3,2,5);
%     plot(a,SData_X1(:,9));hold on;
%     subplot(3,2,6);
%     plot(a,SData_X1(:,11));hold on;
% end
% 
% subplot(3,2,1);hold on;
% plot(a,armjoints(:,1),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,2);hold on;
% plot(a,armjoints(:,2),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,3);hold on;
% plot(a,armjoints(:,3),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,4);hold on;
% plot(a,armjoints(:,4),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,5);hold on;
% plot(a,armjoints(:,5),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,6);hold on;
% plot(a,armjoints(:,6),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% 
% subplot(3,2,1);hold on;
% plot(a,PnpResult1(:,1),'Color',[0.6,0.6,0.6],'LineWidth',1.5);
% subplot(3,2,2);hold on;
% plot(a,PnpResult1(:,2),'Color',[0.6,0.6,0.6],'LineWidth',1.5);
% subplot(3,2,3);hold on;
% plot(a,PnpResult1(:,3),'Color',[0.6,0.6,0.6],'LineWidth',1.5);
% subplot(3,2,4);hold on;
% plot(a,PnpResult1(:,4),'Color',[0.6,0.6,0.6],'LineWidth',1.5);
% subplot(3,2,5);hold on;
% plot(a,PnpResult1(:,5),'Color',[0.6,0.6,0.6],'LineWidth',1.5);
% subplot(3,2,6);hold on;
% plot(a,PnpResult1(:,6),'Color',[0.6,0.6,0.6],'LineWidth',1.5);


figure(1);

subplot(3,2,1);
plot(a,SData_X1(:,1));hold on;
subplot(3,2,2);
plot(a,SData_X1(:,2));hold on;
subplot(3,2,3);
plot(a,SData_X1(:,3));hold on;
subplot(3,2,4);
plot(a,SData_X1(:,4));hold on;
subplot(3,2,5);
plot(a,SData_X1(:,5));hold on;
subplot(3,2,6);
plot(a,SData_X1(:,6));hold on;
% 
% subplot(3,2,1);
% plot(a,SData_X2(:,1),'r');
% subplot(3,2,2);
% plot(a,SData_X2(:,2),'r');
% subplot(3,2,3);
% plot(a,SData_X2(:,3),'r');
% subplot(3,2,4);
% plot(a,SData_X2(:,4),'r');
% subplot(3,2,5);
% plot(a,SData_X2(:,5),'r');
% subplot(3,2,6);
% plot(a,SData_X2(:,6),'r');
% subplot(3,2,1);
% plot(a,SData_X3(:,1),'Color',[0.2117,0.2117,0.2117]);
% subplot(3,2,2);
% plot(a,SData_X3(:,2),'Color',[0.2117,0.2117,0.2117]);
% subplot(3,2,3);
% plot(a,SData_X3(:,3),'Color',[0.2117,0.2117,0.2117]);
% subplot(3,2,4);
% plot(a,SData_X3(:,4),'Color',[0.2117,0.2117,0.2117]);
% subplot(3,2,5);
% plot(a,SData_X3(:,5),'Color',[0.2117,0.2117,0.2117]);
% subplot(3,2,6);
% plot(a,SData_X3(:,6),'Color',[0.2117,0.2117,0.2117]);
% subplot(3,2,1);hold on;
% plot(a,armjoints(:,1)-2.7,'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,2);hold on;
% plot(a,armjoints(:,2)-9.5,'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,3);hold on;
% plot(a,armjoints(:,3),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,4);hold on;
% plot(a,armjoints(:,4),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,5);hold on;
% plot(a,armjoints(:,5),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);
% subplot(3,2,6);hold on;
% plot(a,armjoints(:,6),'Color',[0.2117,0.2117,0.2117],'LineWidth',1.5);