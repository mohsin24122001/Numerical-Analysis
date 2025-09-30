clc;
clear all;

fp = fopen('Q3_input.txt', 'r');
if fp == -1
    error('File could not be opened.');
end
% reads no. of data points
n = fscanf(fp, '%d', 1);

x = zeros(n, 1);
Fx = zeros(n, 1);
% reading points
for i = 1:n
    x(i) = fscanf(fp, '%f', 1);
    Fx(i) = fscanf(fp, '%f', 1);
end
fclose(fp);
% printing input data
fprintf('Sl.no.\t x \t\t     F(x)\n');
for i = 1:n
    fprintf('%d\t\t %.2f \t\t %.6f \n', i, x(i), Fx(i));
end

% lagrangian function
function result = lagrange_interpolation(x, Fx, x_eval)
% selecting 4 data points for 3rd order
    x_select = [x(1);x(3);x(5);x(7)];
    Fx_select = [Fx(1);Fx(3);Fx(5);Fx(7)];

    n = length(x_select);
    result = 0;
    for i = 1:n
        term = Fx_select(i);
        for j = 1:n
            if j ~= i
                term = term * (x_eval - x_select(j)) / (x_select(i) - x_select(j));
            end
        end
        result = result + term;
    end
end

x_eval = 3.5;
f_eval = lagrange_interpolation(x, Fx, x_eval);

fprintf('Lagrange Interpolation Result:\n');
fprintf('f(3.5) = %.6f\n', f_eval);

fprintf('Absolute Errors at Data Points:\n');
for i = 1:n
    f_interp = lagrange_interpolation(x, Fx, x(i));
    abs_error = abs(f_interp - Fx(i));
    fprintf('x = %.2f, F(x) = %.6f, Interpolated Value = %.6f, Absolute Error = %.6f\n', x(i), Fx(i), f_interp, abs_error);
end