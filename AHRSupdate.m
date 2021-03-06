%AHRSupdate([1;3;5],[23;4;5],[24;4;53]);
function ypr = AHRSupdate(Accel,Gyro,Mag)
    global T;
    global Q;
    global nCb;
    global bCn;
    global Kp;
    global Ki;
    global ErrInt;
    Accel = Accel ./ sqrt(sum(Accel.^2));
    Mag = Mag ./ sqrt(sum(Mag.^2));
    M = nCb * Mag;
    M = [sqrt(M(1)^2+M(2)^2);
         0;
         M(3)];
    M = bCn * M;
    A = bCn * [0;
               0;
               1];
    CrossM = cross(Mag,M);
    CrossA = cross(Accel,A);
    Err =  CrossA + CrossM;
    ErrInt = ErrInt + Err * Ki * T;
    Gyro = Gyro + Kp * Err + ErrInt;
    delta = Gyro * T;
    deltaX = [0,    -delta(1), -delta(2), -delta(3);
              delta(1),    0,  delta(3),  -delta(2);
              delta(2),    -delta(3), 0,  delta(1);
              delta(3),    delta(2),  -delta(1), 0];
    Q = exp(0.5 * deltaX) * Q;
    Q = Q ./ sqrt(sum(Q.^2));
    bCn = getbCn(Q);
    nCb = bCn';
    ypr = bCn2eular(bCn);
%     if (bCn(2,2) == 0 && bCn(2,1) > 0)
%             Eular(3) = pi / 2;
%         else if (bCn(2,2) ==0 && bCn(2,1)<0)
%                 Eular(3) = 3 * pi / 2;
%             else if (bCn(2,2) > 0 && bCn(2,1)>=0)
%                     Eular(3) = Eular(3);
%                 else if bCn(2,2) < 0
%                         Eular(3) = Eular(3) + pi;
%                     else
%                             Eular(3) = Eular(3) + 2 * pi;
%                     end
%                 end
%             end
%     end
end

