raw = load('raw.txt');
raw = raw';
N = length(raw);
angle = zeros(3,N);
for k=1:N
    angle(1,k) = acos(raw(1,k) / sqrt(raw(1,k)^2 + raw(3,k)^2));
    angle(2,k) = acos(raw(2,k) / sqrt(raw(2,k)^2 + raw(3,k)^2));
    angle(3,k) = acos(raw(1,k) / sqrt(raw(1,k)^2 + raw(2,k)^2));
    angle(:,k) = angle(:,k) * 180 / pi;
end
plot(angle');