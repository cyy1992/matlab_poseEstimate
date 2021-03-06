function [truth] = GetTruth(T1,a,t)
T2 = [rodrigues([pi/2,0,0]),[0,76.35,42]';0,0,0,1];
T3 = T1*T2;
T4 = [rodrigues([-pi/2,0,0]),[0,-42,76.35]';0,0,0,1];
Tobj = [rodrigues(a),t;0,0,0,1];
T5 = T3*Tobj*T4;
a1 = rodrigues(T5(1:3,1:3))*180/pi;
t1 = T5(1:3,4);
truth = [t1;a1;];