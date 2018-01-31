function plotTrue(m)
armjoints = importdata('ralPointFile.txt');
% m = size(armjoints,1);
% m = 150;
a = 1:m;

subplot(3,2,1);hold on;
plot(a,armjoints(1:m,1),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
subplot(3,2,2);hold on;
plot(a,armjoints(1:m,2),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
subplot(3,2,3);hold on;
plot(a,armjoints(1:m,3)+0.2,'Color',[0.7,0.7,0.7],'LineWidth',1.5);
subplot(3,2,4);hold on;
plot(a,armjoints(1:m,4)+0.7,'Color',[0.7,0.7,0.7],'LineWidth',1.5);
subplot(3,2,5);hold on;
plot(a,armjoints(1:m,5)-0.85,'Color',[0.7,0.7,0.7],'LineWidth',1.5);
subplot(3,2,6);hold on;
plot(a,armjoints(1:m,6),'Color',[0.7,0.7,0.7],'LineWidth',1.5);
end