function Q = QuaternionInit(Accel , Mag)
    Gamma = atan(Accel(1) / Accel(3));
    Theta = atan(Accel(2) / Accel(3));
    Psi = acos(Mag(1) / sqrt(Mag(1)^2 + Mag(2)^2 + Mag(3)^2));
    disp('Gamma0');disp(Gamma);
    disp('Theta0');disp(Theta);
    disp('Psi0');disp(Psi);
    Q = [cos(Psi / 2) * cos(Theta / 2) * cos(Gamma / 2) + sin(Psi / 2) * sin(Theta / 2) * sin(Gamma / 2);
         cos(Psi / 2) * sin(Theta / 2) * cos(Gamma / 2) + sin(Psi / 2) * cos(Theta / 2) * sin(Gamma / 2);
         cos(Psi / 2) * cos(Theta / 2) * sin(Gamma / 2) - sin(Psi / 2) * sin(Theta / 2) * cos(Gamma / 2);
         cos(Psi / 2) * sin(Theta / 2) * sin(Gamma / 2) - sin(Psi / 2) * cos(Theta / 2) * cos(Gamma / 2)];
end