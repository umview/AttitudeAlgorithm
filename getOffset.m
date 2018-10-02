function getOffset(Gyro)
    global gyroOffset;
    gyroOffset = mean(Gyro)';
end