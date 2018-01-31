a = [0.0517;0.2077;-0.0255];
q1 = [cos(norm(a)/2);sin(norm(a)/2)/norm(a)*a];
tic;R = QR(q1);toc;
tic;rodrigues(a);toc;