clear all;
clc;
global T;
global Q;
global Q0;
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
Q0 = zeros(4,1);
%nCb = zeros(3,3);
Kp = 20.0;
Ki = 0.2;
%Eular = zeros(3,1);
%bCn = nCb';
gyroOffset = zeros(3,1);
raw = load('raw.txt');
getOffset = getOffset(raw(1:700,[4, 5, 6]));
raw = load('raw.txt');
N = length(raw);
angle = zeros(3,N);
Eular = zeros(3,N);
CEular = zeros(3,N);
rawAccel = raw(:,[1, 2, 3])';
rawGyro = raw(:,[4, 5, 6])';
rawMag = raw(:,[7, 8, 9])';
for k = 1:N
    rawGyro(:,k) = rawGyro(:,k) - gyroOffset;
    rawGyro(:,k) = rawGyro(:,k) * 1000 / 32768;
    rawGyro(:,k) = deg2rad(rawGyro(:,k));
end

Q0 = QuaternionInit(rawAccel(:,1), rawMag(:,1));
Q = Q0;
ErrInt = zeros(3,1);
bCn = getbCn(Q);
nCb = bCn';
Eular(:,1) = bCn2eular(bCn);
Eular(:,1) = rad2deg(Eular(:,1));
% for k = 2:N
%     %Eular(:,k) = AHRSupdate(rawAccel(:,k), rawGyro(:,k), rawMag(:,k));
%     Eular(:,k) = attitudeUpdate(rawGyro(:,k));
%     Eular(:,k) = rad2deg(Eular(:,k));
% end
% figure(1);
% plot(Eular([1,2,3],:)');
Q = Q0;
ErrInt = zeros(3,1);
CEular(:,1) = Eular(:,1);
for k = 2:N
    CEular(:,k) = AHRSupdateC(rawAccel(:,k), rawGyro(:,k), rawMag(:,k));
    CEular(:,k) = rad2deg(CEular(:,k));
end
figure(2)
plot(CEular([1,2,3],:)');
raw = raw';
for k=1:N
    angle(1,k) = atan(raw(1,k) / raw(3,k));
    angle(2,k) = atan(raw(2,k) / raw(3,k));
    angle(3,k) = acos(raw(7,k) / sqrt(raw(7,k)^2 + raw(8,k)^2 + raw(9,k)^2));
    %angle(3,k) = acos(raw(1,k) / sqrt(raw(1,k)^2 + raw(2,k)^2 + raw(3,k)^2));
    %angle(3,k) = atan(raw(8,k) / raw(9,k));
    angle(:,k) = rad2deg(angle(:,k));

end
figure(3);
plot(angle');
% hold on;
% plot(Eular');
% %plot(CEular');

