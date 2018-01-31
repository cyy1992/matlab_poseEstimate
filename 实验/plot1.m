armjoints = importdata('ralPointFile.txt');
load('SData_ekf1.mat');
load('SData_ekf2.mat');
load('SData_ekfC.mat');
load('SData_ekfD.mat');
load('SData_ukf1.mat');
load('SData_ukf2.mat');
load('SData_ukfC.mat');
load('SData_ukfD.mat');
ag = 5;
m = size(SData_ukf1(1:ag:end,4));
a = 1:m;

figure;
% subplot(3,1,1);plot(a,SData_ukf1(:,1));hold on;plot(a,SData_ukf2(:,1));hold on;plot(a,SData_ukfC(:,1));hold on;plot(a,SData_ukfD(:,1));hold on;
% subplot(3,1,2);plot(a,SData_ukf1(:,2));hold on;plot(a,SData_ukf2(:,2));hold on;plot(a,SData_ukfC(:,2));hold on;plot(a,SData_ukfD(:,2));hold on;
% subplot(3,1,3);plot(a,SData_ukf1(:,3));hold on;plot(a,SData_ukf2(:,3));hold on;plot(a,SData_ukfC(:,3));hold on;plot(a,SData_ukfD(:,3));hold on;
% subplot(3,1,1);hold on;
% plot(a,armjoints(:,1),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
% subplot(3,1,2);hold on;
% plot(a,armjoints(:,2),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
% subplot(3,1,3);hold on;
% plot(a,armjoints(:,3),'Color',[0.7,0.7,0.7],'LineWidth',1.5);

subplot(3,1,1);plot(a,SData_ukf1(1:ag:end,4));hold on;plot(a,SData_ukf2(1:ag:end,4));hold on;plot(a,SData_ukfC(1:ag:end,4));hold on;plot(a,SData_ukfD(1:ag:end,4));hold on;
subplot(3,1,2);plot(a,SData_ukf1(1:ag:end,5));hold on;plot(a,SData_ukf2(1:ag:end,5));hold on;plot(a,SData_ukfC(1:ag:end,5));hold on;plot(a,SData_ukfD(1:ag:end,5));hold on;
subplot(3,1,3);plot(a,SData_ukf1(1:ag:end,6));hold on;plot(a,SData_ukf2(1:ag:end,6));hold on;plot(a,SData_ukfC(1:ag:end,6));hold on;plot(a,SData_ukfD(1:ag:end,6));hold on;


subplot(3,1,1);hold on;
plot(a,armjoints(1:ag:end,4),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
subplot(3,1,2);hold on;
plot(a,armjoints(1:ag:end,5),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
subplot(3,1,3);hold on;
plot(a,armjoints(1:ag:end,6),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
magnify;


% subplot(3,1,1);plot(a,SData_ekf1(:,4));hold on;plot(a,SData_ekf2(:,4));hold on;plot(a,SData_C(:,4));hold on;plot(a,SData_D(:,4));hold on;
% subplot(3,1,2);plot(a,SData_ekf1(:,5));hold on;plot(a,SData_ekf2(:,5));hold on;plot(a,SData_C(:,5));hold on;plot(a,SData_D(:,5));hold on;
% subplot(3,1,3);plot(a,SData_ekf1(:,6));hold on;plot(a,SData_ekf2(:,6));hold on;plot(a,SData_C(:,6));hold on;plot(a,SData_D(:,6));hold on;


% subplot(3,1,1);hold on;
% plot(a,armjoints(:,4),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
% subplot(3,1,2);hold on;
% plot(a,armjoints(:,5),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
% subplot(3,1,3);hold on;
% plot(a,armjoints(:,6),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
% magnify;
