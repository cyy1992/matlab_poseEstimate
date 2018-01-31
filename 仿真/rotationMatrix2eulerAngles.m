function eulerAngles = rotationMatrix2eulerAngles(R)

% eulerAngles = rotationMatrix2eulerAngles(R)
%
% This function returns the rotation angles in degrees about the x, y and z axis for a
% given rotation matrix
% 
% Copyright : This code is written by david zhao from SCUT,1257650237@qq,com. The code
%              may be used, modified and distributed for research purposes with
%              acknowledgement of the author and inclusion this copyright information.
%
% Disclaimer : This code is provided as is without any warrantly.

if abs(R(3,1)) ~= 1
    theta1 = -asin(R(3,1));
    theta2 = pi - theta1;
    psi1 = atan2(R(3,2)/cos(theta1), R(3,3)/cos(theta1));
    psi2 = atan2(R(3,2)/cos(theta2), R(3,3)/cos(theta2));
    pfi1 = atan2(R(2,1)/cos(theta1), R(1,1)/cos(theta1));
    pfi2 = atan2(R(2,1)/cos(theta2), R(1,1)/cos(theta2));
    theta = theta1; % could be any one of the two
    psi = psi1;
    pfi = pfi1;
else
    phi = 0;
    delta = atan2(R(1,2), R(1,3));
    if R(3,1) == -1
        theta = pi/2;
        psi = phi + delta;
    else
        theta = -pi/2;
        psi = -phi + delta;
    end
end

%psi is along x-axis...........theta is along y-axis........pfi is along z
%axis
% eulerAngles = [psi theta pfi]; %for rad;
eulerAngles = [psi theta pfi]; %for degree;