function Xsigmas = sigmas( x,P,c )
%Sigma points around reference point 
%Inputs: 
%       x : reference point 
%       P : covariance 
%       c : coefficient 
%Output: 
%       Xsigmas : Sigma points

A = c*chol(P)'; %R=chol(X)：产生一个上三角阵R，使R'R=X
Y = x(:,ones(1,numel(x))); %ones(a,b)产生a行b列全1数组     ones(a)产生a行a列全1数组
Xsigmas = [x Y+A Y-A];

end

