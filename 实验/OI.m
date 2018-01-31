Txtcam = importdata('cam222.txt');
armjoints = importdata('ralPointFile.txt');

TxtCam1 = Txtcam(:,1:16);
m = size(TxtCam1,1);
n = size(TxtCam1,2)/2;

% kx1 = 803.345902119970;ky1 = 803.055062922696;u01 = 380.962537796614;v01 = 233.830825833781;
% kx1 = 825.054901757104;ky1 = 824.444768253781;u01 = 320.664199846859;v01 = 240.936118674671;
kx1 = 813.345902119970;ky1 = 813.055062922696;u01 = 358.962537796614;v01 = 229.830825833781;

focalIndex = [kx1,ky1,u01,v01];
RelatObjCoor = [-35,-80,0;
    35,-80,0; 
    35,-10,0; 
    -35,-10,0;
    -20,-65,0;
    20,-65,0; 
    20,-25,0; 
    -20,-25,0];
Pbal = zeros(3,1);
for j = 1:n
    Point = RelatObjCoor(j,:)';
    Pbal =  Point+Pbal;
end
Pbal = Pbal/n;
R = rodrigues([0.0901925  0.135009  -0.0176352]);
saveR = zeros(m,3);savet = zeros(m,3);saveTruth = zeros(m,6); 
saven = zeros(m,1);
k1 = 0.171155585097036;k2 = -0.577698858593896;
flag = 1;
for i = 1:m
    pi1 = TxtCam1(i,:)';

    [V,t1,t2] = Vt( pi1,focalIndex);
    t3 = zeros(3,1);
    for j = 1:n
        Point = RelatObjCoor(j,:)';
        t3 = t1(3*(j-1)+1:3*j,:)*R*Point+t3;
    end
    t = -1/n*(t2\t3);
    M = zeros(3,3);
    error = zeros(1,1);
    Qbal = zeros(3,1);
    for j = 1:n
        Point = RelatObjCoor(j,:)';
        error = error + norm((R*Point+t-V(3*(j-1)+1:3*j,:)*(R*Point+t)));
        Qbal = V(3*(j-1)+1:3*j,:)*(R*Point+t)+Qbal;
    end
    Qbal = Qbal/n;
    for j = 1:n
        Point = RelatObjCoor(j,:)';
        M = M+(V(3*(j-1)+1:3*j,:)*(R*Point+t)-Qbal)*(Point-Pbal)';
    end
    ni = 100;
    
    while(error>0.6)
        [Vsd,S,U] = svd(M);
        tempSvd = diag([1,1,det(Vsd*U')]);
        R = Vsd*tempSvd*U';
        t3 = zeros(3,1);
        for j = 1:n
            Point = RelatObjCoor(j,:)';
            t3 = t1(3*(j-1)+1:3*j,:)*R*Point+t3;
        end
        t = -1/n*(t2\t3);
        M = zeros(3,3);
        error = zeros(1,1);
        Qbal = zeros(3,1);
        for j = 1:n
            Point = RelatObjCoor(j,:)';
            error = error + norm((R*Point+t-V(3*(j-1)+1:3*j,:)*(R*Point+t)));
            Qbal = V(3*(j-1)+1:3*j,:)*(R*Point+t)+Qbal;
        end
        Qbal = Qbal/n;
        for j = 1:n
            Point = RelatObjCoor(j,:)';
            M = M+(V(3*(j-1)+1:3*j,:)*(R*Point+t)-Qbal)*(Point-Pbal)';
        end
        if ni < 0
            break;
        else 
            ni = ni-1;
        end
    end
    a = rodrigues(R);

    if (flag == 1)&&(error < 1.6)
        T1 = [R,t;0,0,0,1];
        flag = 0;
    end
%     T1 = [0.942376556470990	-0.0778592561508261	-0.325368040909858	-7.10520496604813
%     0.0332947048568110	0.989540530837435	-0.140360252416645	21.1181951765110
%     0.332893208765780	0.121439178445865	0.935112098892970	341.656091188022
%     0	0	0	1];
%     T1 = [0.906786492107317	-0.0790553498639462	-0.414111711244194	-48.1549455787361
%         0.0207567564019525	0.989441830013643	-0.143436474032662	17.8534716070452
%         0.421078870041440	0.121470641214829	0.898853418821713	330.530478109650
%         0	0	0	1];
    ob = GetW(T1,R,t);    
    savet(i,:) = ob(1:3,1);
    saveR(i,:) = ob(4:6,1);
%     a1 = armjoints(i,4:6)/180*pi;
%     t1 = armjoints(i,1:3)';
%     truth = GetTruth(T1,a1,t1);
%     saveR(i,:) = a';
%     savet(i,:) = t';
%     saveTruth(i,:) = truth';
    saveTruth(i,:) = armjoints(i,:)';
    saven(i,:) = 1000-ni;
end
i = 1:m;
figure(3);
subplot(3,2,1);
plot(i,savet(:,1));hold on;
subplot(3,2,2);
plot(i,savet(:,2));hold on;
subplot(3,2,3);
plot(i,savet(:,3));hold on;
subplot(3,2,4);
plot(i,saveR(:,1));hold on;
subplot(3,2,5);
plot(i,saveR(:,2));hold on;
subplot(3,2,6);
plot(i,saveR(:,3));hold on;

subplot(3,2,1);
plot(i,saveTruth(:,1),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,2);
plot(i,saveTruth(:,2),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,3);
plot(i,saveTruth(:,3),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,4);
plot(i,saveTruth(:,4),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,5);
plot(i,saveTruth(:,5),'Color',[0.2117,0.2117,0.2117]);hold on;
subplot(3,2,6);
plot(i,saveTruth(:,6),'Color',[0.2117,0.2117,0.2117]);hold on;