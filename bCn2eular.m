function ypr = bCn2eular(bCn)
    ypr(1)=atan(bCn(2,1)/bCn(2,2));%Yaw
    ypr(2)=asin(bCn(2,3));%Pitch
    ypr(3)=atan(-bCn(1,3)/bCn(3,3));%Roll
    %ypr = ypr / pi * 180;
end