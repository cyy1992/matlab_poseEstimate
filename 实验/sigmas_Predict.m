function Xsigmas = sigmas_Predict( x,P,c )
%Sigma points around reference point 
%Inputs: 
%       x : reference point 
%       P : covariance 
%       c : coefficient 
%Output: 
%       Xsigmas : Sigma points
e = eig(P);
e_size = size(e,1);
flag = 0;
for i = 1:e_size
    if(e(i)<0)
        flag = 1;
        break;
    end
end
if(flag ==0)
    A = c*chol(P)'; %R=chol(X)������һ����������R��ʹR'R=X
else
    A = eye(e_size);
end
Y = x(:,ones(1,numel(x))); %ones(a,b)����a��b��ȫ1����     ones(a)����a��a��ȫ1����
Xsigmas = [x Y+A Y-A];

end