% Name : Mohsin Azam
%Roll no. 244103007
% Assignment_2 Que. 1 -Write a code to evaluate sine(x) using Taylor’s series. Consider different number of 
% terms at a time and find out the relative error. You can plot the variation in relative error 
% with number of terms used (at least 6 terms). 

clc;
clear all;
disp("Enter the number of terms for which you want to calculate vaue of sin");
n=input("n=");
disp("Enter the value in degree,  at which you want to calculate value of sin");
a=input("a=");
x= a*(pi/180);% converting angle in radian
F_act = sin(x); % calculating avtual value of sin

% factorial function
function fact = factorial(n)
    fact = 1;
    for k = 2:n
        fact = fact * k;
    end
end
%F_x is calculating sin series value by calculating n_th term of sin series
F_x = 0;
for n = 1:n
        coeff = (-1)^(n+1);
        num = x^(2*n - 1);
        denom = factorial(2*n - 1);
        F_x = F_x + (coeff * num) / denom;
 end

fprintf("value of sin(x) is: %f\n",F_x);
fprintf("actual value of sin(x) is: %f\n",F_act);
rel_error = abs ((F_act-F_x)/F_act);
fprintf("relative error for %.1f number of terms is : %f\n",n,rel_error);
