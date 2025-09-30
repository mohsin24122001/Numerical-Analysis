clc;
clear all;

% Open the file for reading
fp = fopen('Q1_input.txt', 'r');
if fp == -1
    error('File could not be opened.');
end

% Read the number of data points
n = fscanf(fp, '%d', 1);

% Initialize arrays
x = zeros(n, 1);
Fx = zeros(n, 1);

% Read data points
for i = 1:n
    x(i) = fscanf(fp, '%f', 1); % Read x value
    Fx(i) = fscanf(fp, '%f', 1); % Read F(x) value
end
fclose(fp);

% Display the data
fprintf('Sl.no.\t x \t\t F(x)\n');
for i = 1:n
    fprintf('%d\t\t %.2f \t\t %.6f \n', i, x(i), Fx(i));
end

% Compute divided differences
% Create a divided difference table (n x n matrix)
F = zeros(n, n);
F(:, 1) = Fx; % First column is F(x)

for j = 2:n
    for i = 1:n-j+1
        F(i, j) = (F(i+1, j-1) - F(i, j-1)) / (x(i+j-1) - x(i));
    end
end

% Display divided differences
fprintf('\nDivided Difference Table:\n');
disp(F);

% Polynomial interpolation
% Coefficients for the polynomial are the first row of the divided difference table
coefficients = F(1, :);


x_eval = 1.3; % You can change this value to evaluate at any point
result = coefficients(1); % Start with the first coefficient

for i = 2:n
    term = coefficients(i);
    for j = 1:i-1
        term = term * (x_eval - x(j));
    end
    result = result + term;
end

fprintf('\nFunction value by interpolation at x=%.2f is %.7f\n', x_eval, result);
function fabs = absolute(x)
        fabs = x^2 / (x^2 + 1);
end
fabs = absolute(x_eval);
disp('absolute value is ;')
disp(fabs)
error = abs(result - fabs) / abs(result);
error = error * 100;
fprintf('absolute eror at x = %.2f is: %f percent',x_eval,error)
