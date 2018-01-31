clear all;
ag=1;
flag =1;
t=0.05*ag;

TxtData1 = importdata('cam222.txt');
armjoints = importdata('ralPointFile.txt');
TxtData2 = importdata('cam111.txt');
m = size(TxtData1,1);
n = size(TxtData1,2)/2;
kx2 = 803.345902119970;ky2 = 803.055062922696;u02 = 380.962537796614;v02 = 233.830825833781;
kx1 = 813.345902119970;ky1 = 813.055062922696;u01 = 358.962537796614;v01 = 229.830825833781;
focalIndex = [kx1 ky1 u01 v01;kx2 ky2 u02 v02]';
RelatObjCoor = [-35,-80,0;
    35,-80,0; 
    35,-10,0; 
    -35,-10,0;
    -20,-65,0;
    20,-65,0; 
    20,-25,0; 
    -20,-25,0];
Init_X2 = [0;0;0;0;0;0;0;0;0;0.00000001;0;0;0.000001;0;0;0.000001;0;0];
Init_X1 = [0;0;0;0;0;0;0;0;0;0.00000001;0;0;0.000001;0;0;0.000001;0;0];

x1 = Init_X1;
x2 = Init_X2;x3 = x1;
P1 = 10*eye(18);P2 = P1;


N = 30;
qNk1 = zeros(18,N);qNk2 = zeros(18,N);
detNk1 = zeros(N*18,18);detNk2 = zeros(N*18,18);

SData_X1 = zeros(fix(m/ag),6);
SData_X2 = zeros(fix(m/ag),6);
SData_X3 = zeros(fix(m/ag),6);

sum1 = zeros(1,6);
sum2 = zeros(1,6);
sum3 = zeros(1,6);
sum1 = 0;sum2 = 0;
for i = 1:m/ag
    z1 = TxtData1(ag*i,:)';z2 = TxtData2(ag*i,:)';z = [z1,z2];  real = armjoints(ag*i,:)';tic;
    [ x1,P1 ] = NonlinerEKF83(z,x1,P1,focalIndex,t,RelatObjCoor,N,5);tim1 = toc;tic;
    [ x2,P2 ] = NonlinerEKF83(z,x2,P2,focalIndex,t,RelatObjCoor,N,4);tim2 = toc;
     sum1 = tim1+sum1;sum2 = tim2+sum2;
%     SData_X1(i,:) = [x1(1),x1(2),x1(3),x1(10)*180/pi,x1(11)*180/pi,x1(12)*180/pi];
%     SData_X2(i,:) = [x2(1),x2(2),x2(3),x2(10)*180/pi,x2(11)*180/pi,x2(12)*180/pi];
%     SData_X1(i,:) = abs([x1(1),x1(2),x1(3),x1(10)*180/pi,x1(11)*180/pi,x1(12)*180/pi]-[real(1:3,1);real(4:6,1)]');
%     SData_X2(i,:) = abs([x2(1),x2(2),x2(3),x2(10)*180/pi,x2(11)*180/pi,x2(12)*180/pi]-[real(1:3,1);real(4:6,1)]');
    SData_X1(i,1) = sum1;
    SData_X2(i,1) = sum2;
    %SData_X3(i,:) = [x3(1),x3(3),x3(5),x3(11)*180/pi,x3(9)*180/pi,x3(7)*180/pi];
end

a = 1:m/ag;

figure;

subplot(3,2,1);
plot(a,SData_X1(:,1),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,2);
plot(a,SData_X1(:,2),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,3);
plot(a,SData_X1(:,3),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,4);
plot(a,SData_X1(:,4),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,5);
plot(a,SData_X1(:,5),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,6);
plot(a,SData_X1(:,6),'Color',[0.2117,0.2117,0.2117]);hold on;
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
% plot(a,SData_X1(:,1));hold on;
% subplot(3,2,2);
% plot(a,SData_X1(:,2));hold on;
% subplot(3,2,3);
% plot(a,SData_X1(:,3));hold on;
% subplot(3,2,4);
% plot(a,SData_X1(:,4));hold on;
% subplot(3,2,5);
% plot(a,SData_X1(:,5));hold on;
% subplot(3,2,6);
% plot(a,SData_X1(:,6));hold on;
% 
% subplot(3,2,1);
% plot(a,SData_X2(:,1));
% subplot(3,2,2);
% plot(a,SData_X2(:,2));
% subplot(3,2,3);
% plot(a,SData_X2(:,3));
% subplot(3,2,4);
% plot(a,SData_X2(:,4));
% subplot(3,2,5);
% plot(a,SData_X2(:,5));
% subplot(3,2,6);
% plot(a,SData_X2(:,6));
% plottest;