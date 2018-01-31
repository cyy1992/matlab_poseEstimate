m =180;
dim = 1*pi/180;
px = zeros(m,1);py = zeros(m,1);
for k = 1:m
    sx = 20*sin(k*dim*2)+10;
    sy = 30*cos(k*dim*1.2);
    px(k) = sx;
    py(k) = sy;
end
plot(1:m,px);hold on;
plot(1:m,py);