function ypr = attitudeUpdate(Gyro)
    global T;
    global Q;
    global nCb;
    global bCn;
    delta = Gyro * T;
    deltaX = [0,    -delta(1), -delta(2), -delta(3);
              delta(1),    0,  delta(3),  -delta(2);
              delta(2),    -delta(3), 0,  delta(1);
              delta(3),    delta(2),  -delta(1), 0];
    Q = exp(0.5 * deltaX) * Q;
    Q = Q / sqrt(sum(Q.^2));
    bCn = getbCn(Q);
    nCb = bCn';
    ypr = bCn2eular(bCn);
end