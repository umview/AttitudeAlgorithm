function ypr = AHRSupdateC(Accel,Gyro,Mag)
    global T;
    global Q;
    global Kp;
    global Ki;
    global ErrInt;
    global nCb;
    global bCn;
    Accel = Accel / sqrt(sum(Accel.^2));
    Mag = Mag / sqrt(sum(Mag.^2));
    mx = Mag(1);
    my = Mag(2);
    mz = Mag(3);
    ax = Accel(1);
    ay = Accel(2);
    az = Accel(3);
    gx = Gyro(1);
    gy = Gyro(2);
    gz = Gyro(3);
    q0 = Q(1);
    q1 = Q(2);
    q2 = Q(3);
    q3 = Q(4);
    q0q0 = q0 * q0;  
    q0q1 = q0 * q1;  
    q0q2 = q0 * q2;  
    q0q3 = q0 * q3;  
    q1q1 = q1 * q1;  
    q1q2 = q1 * q2;  
    q1q3 = q1 * q3;  
    q2q2 = q2 * q2;  
    q2q3 = q2 * q3;  
    q3q3 = q3 * q3;

	halfT = T / 2;

    hx = 2.0*mx*(0.5 - q2q2 - q3q3) + 2.0*my*(q1q2 - q0q3) + 2.0*mz*(q1q3 + q0q2);
    hy = 2.0*mx*(q1q2 + q0q3) + 2.0*my*(0.5 - q1q1 - q3q3) + 2.0*mz*(q2q3 - q0q1);
    hz = 2.0*mx*(q1q3 - q0q2) + 2.0*my*(q2q3 + q0q1) + 2.0*mz*(0.5 - q1q1 - q2q2);         
    bx = sqrt((hx*hx) + (hy*hy));
    bz = hz; 
    vx = 2.0*(q1q3 - q0q2);
    vy = 2.0*(q0q1 + q2q3);
    vz = q0q0 - q1q1 - q2q2 + q3q3;
    wx = 2.0*bx*(0.5 - q2q2 - q3q3) + 2.0*bz*(q1q3 - q0q2);
    wy = 2.0*bx*(q1q2 - q0q3) + 2.0*bz*(q0q1 + q2q3);
    wz = 2.0*bx*(q0q2 + q1q3) + 2.0*bz*(0.5 - q1q1 - q2q2);  
    ex = (ay*vz - az*vy) + (my*wz - mz*wy);
    ey = (az*vx - ax*vz) + (mz*wx - mx*wz);
    ez = (ax*vy - ay*vx) + (mx*wy - my*wx);

    if ex ~= 0.0 && ey ~= 0.0 && ez ~= 0.0
    
        ErrInt = ErrInt + ex * Ki * halfT;
        ErrInt = ErrInt + ey * Ki * halfT;	
        ErrInt = ErrInt + ez * Ki * halfT;
        gx = gx + Kp*ex + ErrInt;
        gy = gy + Kp*ey + ErrInt;
        gz = gz + Kp*ez + ErrInt;
    end
    tempq0 = q0 + (-q1*gx - q2*gy - q3*gz)*halfT;
    tempq1 = q1 + (q0*gx + q2*gz - q3*gy)*halfT;
    tempq2 = q2 + (q0*gy - q1*gz + q3*gx)*halfT;
    tempq3 = q3 + (q0*gz + q1*gy - q2*gx)*halfT;  
    q0 = tempq0 ./ sqrt(tempq0 .* tempq0 + tempq1 .* tempq1 + tempq2 .* tempq2 + tempq3 .* tempq3);
    q1 = tempq1 ./ sqrt(tempq0 .* tempq0 + tempq1 .* tempq1 + tempq2 .* tempq2 + tempq3 .* tempq3);
    q2 = tempq2 ./ sqrt(tempq0 .* tempq0 + tempq1 .* tempq1 + tempq2 .* tempq2 + tempq3 .* tempq3);
    q3 = tempq3 ./ sqrt(tempq0 .* tempq0 + tempq1 .* tempq1 + tempq2 .* tempq2 + tempq3 .* tempq3);

    
%     norm = sqrt(tempq0 * tempq0 + tempq1 * tempq1 + tempq2 * tempq2 + tempq3 * tempq3);
%     q0 = tempq0 / norm;
%     q1 = tempq1 / norm;
%     q2 = tempq2 / norm;
%     q3 = tempq3 / norm;
    Q(1) = q0(1);
    Q(2) = q1(1);
    Q(3) = q2(1);
    Q(4) = q3(1);
    bCn = getbCn(Q);
    nCb = bCn';
    ypr = bCn2eular(bCn);
%     %Roll
%     Eular(1) = atan((2.0 * (q0q1 + q2q3)) / (q0q0 - q1q1 - q2q2 + q3q3));
%     %Pitch
%     Eular(2) = -asin(2.0 * (q1q3 - q0q2));
%     %Yaw
%     Eular(3) = atan((2.0 * (q1q2 + q0q3)) / (q0q0 + q1q1 - q2q2 - q3q3));
end

