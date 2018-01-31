function Xsigmas = sigmas( x,P,c )
%Sigma points around reference point 
%Inputs: 
%       x : reference point 
%       P : covariance 
%       c : coefficient 
%Output: 
%       Xsigmas : Sigma points

A = c*chol(P)'; %R=chol(X)������һ����������R��ʹR'R=X
Y = x(:,ones(1,numel(x))); %ones(a,b)����a��b��ȫ1����     ones(a)����a��a��ȫ1����
Xsigmas = [x Y+A Y-A];

end

