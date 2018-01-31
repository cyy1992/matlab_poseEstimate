function [ cTo ] = GetT_Rodrigues(x,cTw) 
% �����޵����˹��ȡת������cTo�������������ϵ����������ϵ��λ�ú���̬��
wlTo = [1 0 0 0
      0 0 1 -42
      0 -1 0 76.35
      0 0 0 1];
R = rodrigues([x(10);x(11);x(12)]);
t = x(1:3,1);
wTwl = [R,t;0,0,0,1];
cTo = cTw*wTwl*wlTo;
end

