clear all;
raw = load('raw_coe_2.txt');
accel = raw(:,2);
gyro = raw(:,4)-(-8.6200);
N = length(raw);
Integral = zeros(1,N);
Integral(1) = accel(1);
for k = 2:N
   Integral(k) = Integral(k-1) + gyro(k)*2.0477*0.005;
end
plot(Integral);
hold on;
plot(accel);