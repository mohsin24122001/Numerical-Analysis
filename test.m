clc;
clear;

% Define the function to integrate
f = @(x) (exp(x).*sin(x))./(1 + x.^2);

% Compute the numerical integral from 0 to 2
integral_value = integral(f, 0, 2);

% Display the result
fprintf('The numerical value of the integral is: %.16f \n',integral_value);
disp(integral_value);
