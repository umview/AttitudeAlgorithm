raw = load('raw.txt');
raw = raw';
N = length(raw);
angle = zeros(3,N);
for k=1:N
    angle(1,k) = atan(raw(1,k) / raw(3,k));%Roll
    angle(2,k) = atan(raw(2,k) / raw(3,k));%Pitch
    %Yaw
    angle(3,k) = acos(raw(7,k) / sqrt(raw(7,k)^2 + raw(8,k)^2 + raw(9,k)^2));
    %angle(3,k) = acos(raw(1,k) / sqrt(raw(1,k)^2 + raw(2,k)^2 + raw(3,k)^2));
    %angle(3,k) = atan(raw(8,k) / raw(9,k));
    angle(:,k) = angle(:,k) * 180 / pi;
end
hold on;
plot(angle');