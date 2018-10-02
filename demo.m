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
global gyroOffset;
global coe;
coe = 2.0477;
T = 0.005;
%Q = zeros(4,1);
%nCb = zeros(3,3);
Kp = 5;
Ki = 0.001;
ErrInt = zeros(3,1);
%Eular = zeros(3,1);
%bCn = nCb';
gyroOffset = zeros(3,1);

raw = load('raw_static.txt');
getOffset(raw(:,[4, 5, 6]));
raw = load('raw_coe_2.txt');
N = length(raw);
Eular = zeros(3,N);
rawAccel = raw(:,[1, 2, 3])';
rawGyro = raw(:,[4, 5, 6])';
rawMag = raw(:,[7, 8, 9])';

Q = [0;0.1;0.1;0.1];
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
hold on;
plot(Eular');
%plot(raw');
%plot(rawAccel');

