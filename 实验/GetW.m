function Ob = GetW(T1,R,t)
% T1 表示最开始的cTo,此时的w'和w重合
% T2 表示oTw',开始时刻时 oTw' = oTw
% 所以 T3 表示cTw
% T5 = T3\Tobj*T2 = wTc * cTo * oTw' = wTw' 
T2 = [rodrigues([pi/2,0,0]),[0,76.35,42]';0,0,0,1];
T3 = T1*T2;
Tobj = [R,t;0,0,0,1];
T5 = T3\Tobj*T2;
a1 = rodrigues(T5(1:3,1:3))*180/pi;
t1 = T5(1:3,4);
Ob = [t1;a1;];