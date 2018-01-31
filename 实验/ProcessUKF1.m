clear;
flag_x1 = 1;
flag_x2 = 1;
flag_xj = 1;ag=1;
flag = 1;
t=0.05*ag;
% ch = 0;
ch = 0;
%  m = 260;
%  m = 239;
TxtData1 = importdata('cam1.txt');
armjoints = importdata('ralPointFile.txt');
TxtData2 = importdata('cam2.txt');
m = size(TxtData1,1);% Rt=[0.891645542812330,-0.0253519132701749,-0.452023789724000;0.0468332400881701,0.998239479040235,0.0363949187157362;0.450305311545122,-0.0536211057236119,0.891263094386404];
% kx1 = 842.421218293945;ky1 = 842.849732532109;u01 = 319.399607306323;v01 = 264.729901470455;
n = size(TxtData1,2)/2;
kx2 = 815.923050526959	;ky2 = 815.581330135379	;u02 = 359.178612192535	;v02 = 227.227821454986	;
kx1 = 813.345902119970;ky1 = 813.055062922696;u01 = 358.962537796614;v01 = 229.830825833781;
tt = [113.385280428544,2.61621104491784,6.50834571014155]';
euler2 =  -[0.0517
    0.2077
   -0.0255];
Rt = rodrigues(euler2);
T = [Rt,tt];
Init_X1 = [-7.10520496604813;0;21.1181951765110;0;341.656091188022;0;0.133880103255010;0;-0.336624429568102;0;0.0568423839879205;0];
x1 = Init_X1;
x2 = Init_X1;x3 = x1;
P1 = 1*eye(12);P2 = eye(12);P3 =P1;
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
qNk1 = zeros(12,N);qNk2 = zeros(12,N);
detNk1 = zeros(N*12,12);detNk2 = zeros(N*12,12);
f=@(x)[x(1)+t*x(2);x(2);x(3)+t*x(4);x(4);x(5)+t*x(6);x(6);x(7)+t*x(8);x(8);x(9)+t*x(10);x(10);x(11)+t*x(12);x(12);];
h1=@(x)[kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(1,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(1,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(7))*RelatObjCoor(1,2)+cos(x(9))*cos(x(7))*RelatObjCoor(1,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(1,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(1,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(1,3))/(x(5)-sin(x(9))*RelatObjCoor(1,1)+cos(x(9))*sin(x(7))*RelatObjCoor(1,2)+cos(x(9))*cos(x(7))*RelatObjCoor(1,3))+v01;
       kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(2,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(2,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(7))*RelatObjCoor(2,2)+cos(x(9))*cos(x(7))*RelatObjCoor(2,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(2,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(2,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(2,3))/(x(5)-sin(x(9))*RelatObjCoor(2,1)+cos(x(9))*sin(x(7))*RelatObjCoor(2,2)+cos(x(9))*cos(x(7))*RelatObjCoor(2,3))+v01;
       kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(3,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(3,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(7))*RelatObjCoor(3,2)+cos(x(9))*cos(x(7))*RelatObjCoor(3,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(3,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(3,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(3,3))/(x(5)-sin(x(9))*RelatObjCoor(3,1)+cos(x(9))*sin(x(7))*RelatObjCoor(3,2)+cos(x(9))*cos(x(7))*RelatObjCoor(3,3))+v01;
       kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(4,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(4,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(7))*RelatObjCoor(4,2)+cos(x(9))*cos(x(7))*RelatObjCoor(4,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(4,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(4,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(4,3))/(x(5)-sin(x(9))*RelatObjCoor(4,1)+cos(x(9))*sin(x(7))*RelatObjCoor(4,2)+cos(x(9))*cos(x(7))*RelatObjCoor(4,3))+v01;
       kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(5,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(5,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(5,3))/(x(5)-sin(x(9))*RelatObjCoor(5,1)+cos(x(9))*sin(x(7))*RelatObjCoor(1,2)+cos(x(9))*cos(x(7))*RelatObjCoor(5,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(5,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(5,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(5,3))/(x(5)-sin(x(9))*RelatObjCoor(5,1)+cos(x(9))*sin(x(7))*RelatObjCoor(1,2)+cos(x(9))*cos(x(7))*RelatObjCoor(5,3))+v01;
       kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(6,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(6,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(6,3))/(x(5)-sin(x(9))*RelatObjCoor(6,1)+cos(x(9))*sin(x(7))*RelatObjCoor(2,2)+cos(x(9))*cos(x(7))*RelatObjCoor(6,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(6,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(6,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(6,3))/(x(5)-sin(x(9))*RelatObjCoor(6,1)+cos(x(9))*sin(x(7))*RelatObjCoor(2,2)+cos(x(9))*cos(x(7))*RelatObjCoor(6,3))+v01;
       kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(7,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(7,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(7,3))/(x(5)-sin(x(9))*RelatObjCoor(7,1)+cos(x(9))*sin(x(7))*RelatObjCoor(3,2)+cos(x(9))*cos(x(7))*RelatObjCoor(7,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(7,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(7,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(7,3))/(x(5)-sin(x(9))*RelatObjCoor(7,1)+cos(x(9))*sin(x(7))*RelatObjCoor(3,2)+cos(x(9))*cos(x(7))*RelatObjCoor(7,3))+v01;
       kx1*(x(1)+cos(x(11))*cos(x(9))*RelatObjCoor(8,1)+(cos(x(11))*sin(x(9))*sin(x(7))-sin(x(11))*cos(x(7)))*RelatObjCoor(8,2)+(cos(x(11))*sin(x(9))*cos(x(7))+sin(x(11))*sin(x(7)))*RelatObjCoor(8,3))/(x(5)-sin(x(9))*RelatObjCoor(8,1)+cos(x(9))*sin(x(7))*RelatObjCoor(4,2)+cos(x(9))*cos(x(7))*RelatObjCoor(8,3))+u01;
       ky1*(x(3)+sin(x(11))*cos(x(9))*RelatObjCoor(8,1)+(sin(x(11))*sin(x(9))*sin(x(7))+cos(x(11))*cos(x(7)))*RelatObjCoor(8,2)+(sin(x(11))*sin(x(9))*cos(x(7))-cos(x(11))*sin(x(7)))*RelatObjCoor(8,3))/(x(5)-sin(x(9))*RelatObjCoor(8,1)+cos(x(9))*sin(x(7))*RelatObjCoor(4,2)+cos(x(9))*cos(x(7))*RelatObjCoor(8,3))+v01]; 

Q = 0.1*diag([0,0.5,0,0.5,0,0.5,0,0.5,0,0.5,0,0.5],0);
% R = 0.06*eye(8);
R = 5*diag([0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05]);

R1 = R;
N = 30;
qNk1 = zeros(12,N);qNk2 = zeros(12,N);
detNk1 = zeros(N*12,12);detNk2 = zeros(N*12,12);
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
%     e1 = e;
%     [x1,xp1,P1,Pp1,X2,Z2,K,e] = ukfProcess(f,x1,P1,h1,z1,Q,R1);
%     e2 = e;
%     while(e2'*e2<e1'*e1)
%         e1 = e2;
%          [x1,xp1,P1,Pp1,X2,Z2,K,e] = ukfProcess(f,x1,P1,h1,z1,Q,R1);
%         e2 = e;
%     end
%     
    [ x2,P2 ] = NonlinerUKF8(z1,x2,P2,focalIndex,t,RelatObjCoor,euler2,T,1);
%     [ x3,P3] = NonlinerIAEKF8(z1,x3,P3,focalIndex,t,RelatObjCoor,euler2,T,N,1);
%     sum1 = sum1 +abs([x1(1)-0.415,x1(3)+7.23,x1(5),x1(7)*180/pi,x1(9)*180/pi,x1(11)*180/pi]-armjoints(ag*i,:));
%     sum2 = sum2 +abs([x2(1)-0.415,x2(3)+7.23,x2(5),x2(11)*180/pi,x2(9)*180/pi,x2(7)*180/pi]-armjoints(ag*i,:));
%     sum3 = sum3 +abs([x3(1)-0.415,x3(3)+7.23,x3(5),x3(11)*180/pi,x3(9)*180/pi,x3(7)*180/pi]-armjoints(ag*i,:));
    if flag == 1
T1 = [0.942376556470990	-0.0778592561508261	-0.325368040909858	-7.10520496604813
0.0332947048568110	0.989540530837435	-0.140360252416645	21.1181951765110
0.332893208765780	0.121439178445865	0.935112098892970	341.656091188022
0	0	0	1];
        flag = 0;
    end
%     R1 = rodrigues(PnpResult1(i,4:6)/180*pi);
%     t1 = PnpResult1(i,1:3)';
    Rr = rodrigues([x1(7),x1(9),x1(11)]);
    Tt = [x1(1);x1(3);x1(5)];
    ob = GetW(T1,Rr,Tt);    
    
    SData_X1(i,:) = [ob(1),ob(2),ob(3),ob(4),ob(5),ob(6)];
    
    Rr2 = rodrigues([x2(7),x2(9),x2(11)]);
    Tt2 = [x2(1);x2(3);x2(5)];
    ob2 = GetW(T1,Rr2,Tt2);
    SData_X2(i,:) = [ob2(1),ob2(2),ob2(3),ob2(4),ob2(5),ob2(6)];
%     SData_X3(i,:) = [x3(1),x3(3),x3(5),x3(11)*180/pi,x3(9)*180/pi,x3(7)*180/pi];
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

subplot(3,2,1);
plot(a,SData_X2(:,1),'r');
subplot(3,2,2);
plot(a,SData_X2(:,2),'r');
subplot(3,2,3);
plot(a,SData_X2(:,3),'r');
subplot(3,2,4);
plot(a,SData_X2(:,4),'r');
subplot(3,2,5);
plot(a,SData_X2(:,5),'r');
subplot(3,2,6);
plot(a,SData_X2(:,6),'r');
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