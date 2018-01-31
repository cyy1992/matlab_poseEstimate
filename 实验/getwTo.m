function T = getwTo(x)
T = [cos(x(12))*cos(x(11)), -1.0*(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10))), (cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10))), 76.35*(cos(x(12))*sin(x(11))*cos(x(10))+sin(x(12))*sin(x(10))) - 42.0*(cos(x(12))*sin(x(11))*sin(x(10))-sin(x(12))*cos(x(10))) + x(1);
 sin(x(12))*cos(x(11)), -1.0*(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10))), (sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10))), 76.35*(sin(x(12))*sin(x(11))*cos(x(10))-cos(x(12))*sin(x(10))) - 42.0*(sin(x(12))*sin(x(11))*sin(x(10))+cos(x(12))*cos(x(10))) + x(2);
 -sin(x(11)), -1.0*cos(x(11))*cos(x(10)), cos(x(11))*sin(x(10)), 76.35*cos(x(11))*cos(x(10)) - 42.0*cos(x(11))*sin(x(10)) + x(3);
    0,         0,    0,                           1.0];
end