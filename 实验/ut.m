function [y,Ysigmas,P,Deviations]=ut(f,X,Wm,Wc,n,R)
%Unscented Transformation 
%Input: 
%        f: nonlinear map 
%        X: sigma points 
%       Wm: weights for mean 
%       Wc: weights for covraiance 
%        n: numer of outputs of f 
%        R: additive covariance 
%Output: 
%        y: transformed mean 
%        Y: transformed smapling points 
%        P: transformed covariance 
%       Y1: transformed deviations 
L=size(X,2);       %L 为X的列数 
y=zeros(n,1); 
Ysigmas=zeros(n,L); 
for k=1:L                    
    Ysigmas(:,k)=f(X(:,k));        
    y=y+Wm(k)*Ysigmas(:,k);        
end 
Deviations=Ysigmas-y(:,ones(1,L)); 
%P=qr([sqrt(Wm(2:L))*Ysigmas(:,2:L) sqrtm(R*eye(4)]);
P=Deviations*diag(Wc)*Deviations'+R; 

end

