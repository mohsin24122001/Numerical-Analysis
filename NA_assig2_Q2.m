% Name : Mohsin Azam
% Roll no. 244103007
% Assignment_2 Que. 2 - Implement the above problem following Horner’s algorithm and see the difference in 
%number of arithmetic operations between both the cases. The algorithm or method can 
%be found in numerical analysis book or internet.
clc;
clear all;

disp("Enter the number of terms for which you want to calculate value of sin");
n = input("n=");
disp("Enter the value in degrees, at which you want to calculate value of sin");
a = input("a=");
x = a * (pi / 180); % Converting angle to radians
F_act = sin(x); % Calculating actual value of sin

% factorial function
function fact = factorial(n)
    fact = 1;
    for k = 2:n
        fact = fact * k;
    end
end

% Taylor Series Sine Calculation
function F_x = taylor_sine(x, n)
    F_x = 0;
    for n = 1:n
        coeff = (-1)^(n+1);
        num = x^(2*n - 1);
        denom = factorial(2*n - 1);
        F_x = F_x + (coeff * num) / denom;
    end
end


% Taylor Series Calculation
F_x_taylor = taylor_sine(x, n);

% Horner's Method Sine Calculation
function F_x = horner_sine(x, n)
    F_x = x;
    term = x;
    sign = -1;
    for k = 1:n-1
        term = term * (x^2 / ((2*k)*(2*k + 1)));
        F_x = F_x + sign * term;
        sign = -sign;
    end
end


% Horner's Method Calculation
F_x_horner = horner_sine(x, n);

% Displaying Results
fprintf("Value of sin(x) using Taylor Series is: %f\n", F_x_taylor);
fprintf("Value of sin(x) using Horner's Method is: %f\n", F_x_horner);
fprintf("Actual value of sin(x) is: %f\n", F_act);

rel_error_taylor = abs((F_act - F_x_taylor) / F_act);
rel_error_horner = abs((F_act - F_x_horner) / F_act);

fprintf("Relative error for %d terms using Taylor Series is: %f\n", n, rel_error_taylor);
fprintf("Relative error for %d terms using Horner's Method is: %f\n", n, rel_error_horner);

% Comparing Arithmetic Operations
operations_taylor = n * (2 + 3) + (n - 1) * 2; % n multiplications, n additions, (n-1) subtractions, n divisions
operations_horner = n - 1 + (n - 1); % (n-1) multiplications and (n-1) additions

fprintf("Number of arithmetic operations using Taylor Series: %d\n", operations_taylor);
fprintf("Number of arithmetic operations using Horner's Method: %d\n", operations_horner);
