% Name : Mohsin Azam
%Roll no. 244103007
% Assignment_1 Que. 1 - Write a small code in to find the machine precession of your personal computer.


clc;
clear all ;
x=1 ; % Taken a random number for comparing
for a=1:50
    y = 10^-a + x ;
    if y==x
        break ;
    end
end    
precesion=10^-(a) ;
disp("machine precesion")
disp(precesion)
fprintf("%.20f",precesion);

      