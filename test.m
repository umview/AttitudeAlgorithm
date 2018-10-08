%------------test----------------------%
t = load('raw.txt');
Accel = t(:,[1,2,3])';
Gyro = t(:,[4,5,6])';
Mag = t(:,[7,8,9])';
Q = QuaternionInit(Accel(:,1), Mag(:,1));
bCn = getbCn(Q);

Q
bCn
