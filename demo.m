clear;
clc;
global T;
global Q;
global nCb;
global bCn;
global Kp;
global Ki;
global ErrInt;
global Eular;
global CEular;
global gyroOffset;
global coe;
global angle;
coe = 2.0477;
T = 0.005;
%Q = zeros(4,1);
%nCb = zeros(3,3);
Kp = 3;
Ki = 0;
ErrInt = zeros(3,1);
%Eular = zeros(3,1);
%bCn = nCb';
gyroOffset = zeros(3,1);
raw = load('raw_static.txt');
getOffset(raw(:,[4, 5, 6]));
raw = load('raw.txt');
N = length(raw);
angle = zeros(3,N);
Eular = zeros(3,N);
CEular = zeros(3,N);
rawAccel = raw(:,[1, 2, 3])';
rawGyro = raw(:,[4, 5, 6])';
rawMag = raw(:,[7, 8, 9])';
rawGyro(:,1) = rawGyro(:,1) - gyroOffset;
rawGyro(:,1) = rawGyro(:,1) * 1000 / 32768 * pi / 180;
Q = [0;
     0.05;
     0.01;
     0.01];
nCb = [1-2*(Q(3)^2+Q(4)^2),   2*(Q(2)*Q(3)-Q(1)*Q(4)),    2*(Q(2)*Q(4)+Q(1)*Q(3));
       2*(Q(2)*Q(3)+Q(1)*Q(4)),   1-2*(Q(2)^2+Q(4)^2),    2*(Q(3)*Q(4)-Q(1)*Q(2));
       2*(Q(2)*Q(4)-Q(1)*Q(3)),   2*(Q(3)*Q(4)+Q(1)*Q(2)),    1-2*(Q(2)^2+Q(3)^2)];
bCn = nCb';
for k = 2:N
    rawGyro(:,k) = rawGyro(:,k) - gyroOffset;
    rawGyro(:,k) = rawGyro(:,k) * 1000 / 32768 * pi / 180;
    Eular(:,k) = AHRSupdate(rawAccel(:,k), rawGyro(:,k), rawMag(:,k));
    Eular(:,k) = Eular(:,k) * 180 / pi;
end
figure(1);
plot(Eular([1,2],:)');
Q = [0;
     0.05;
     0.01;
     0.01];
for k = 2:N
    rawGyro(:,k) = rawGyro(:,k) - gyroOffset;
    rawGyro(:,k) = rawGyro(:,k) * 1000 / 32768 * pi / 180;
    CEular(:,k) = AHRSupdateC(rawAccel(:,k), rawGyro(:,k), rawMag(:,k));
    CEular(:,k) = CEular(:,k) * 180 / pi;

end
figure(2)
plot(CEular([1,2],:)');
raw = raw';
for k=1:N
    angle(2,k) = acos(raw(1,k) / sqrt(raw(1,k)^2 + raw(3,k)^2));
    angle(1,k) = acos(raw(2,k) / sqrt(raw(2,k)^2 + raw(3,k)^2));
    angle(3,k) = acos(raw(1,k) / sqrt(raw(1,k)^2 + raw(2,k)^2));
    angle(:,k) = angle(:,k) * 180 / pi;
end
figure(3);
plot(angle');

