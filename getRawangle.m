raw = load('raw.txt');
raw = raw';
N = length(raw);
angle = zeros(3,N);
for k=1:N
    angle(1,k) = atan(raw(1,k) / raw(3,k));
    angle(2,k) = atan(raw(2,k) / raw(3,k));
    angle(3,k) = atan(raw(1,k) / raw(2,k));
    angle(:,k) = angle(:,k) * 180 / pi;
end
plot(angle');