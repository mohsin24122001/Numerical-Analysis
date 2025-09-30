clc;
clear all;

% Open the file for reading
fp = fopen('Q2_input.txt', 'r');
if fp == -1
    error('File could not be opened.');
end

% Read the number of data points
n = fscanf(fp, '%d', 1);
n = n-1;

% Initialize arrays
x = zeros(n, 1);
Fx = zeros(n, 1);

% Read data points
for i = 1:n+1
    x(i) = fscanf(fp, '%f', 1); % Read x value
    Fx(i) = fscanf(fp, '%f', 1); % Read F(x) value
end
fclose(fp);

% Display the data
fprintf('Sl.no.\t x \t\t\t F(x)\n');
for i = 1:n+1
    fprintf('%d\t\t %.2f \t\t %.6f \n', i, x(i), Fx(i));
end

A = zeros(n+1,n+1);
b = zeros(n+1,1);

for i=1:n+1
    if i==1
        A(i,i)=1;
        continue;

    elseif i==n+1
        A(i,i) = 1;
        continue;
   
    else
        A(i,i-1) = x(i) - x(i-1);
        A(i,i) = 2*(x(i+1) - x(i-1));
        A(i,i+1) = x(i+1) - x(i);
    
        b(i) = (6/(x(i+1) - x(i))) * (Fx(i+1) - Fx(i)) + (6/(x(i) - x(i-1))) * (Fx(i-1) - Fx(i));
    
    end

end
fprintf('Co-eff. matrix(A) of D2f variable is: \n')
disp(A)
disp(' Constant vector b is:')
disp(b)
d2f = zeros((n-2),1);

d2f = inv(A) * b;
fprintf('value of double derivative at all knots is: \n')
disp(d2f)
% function calculation starts
x_eval = 27;
for i=1:n
    if (x(i) < x_eval) && (x_eval < x(i+1))
        i=i+1;
        f_eval = d2f(i-1) * (x(i) - x_eval)^3 / (6*(x(i) - x(i-1))) + d2f(i) * (x_eval - x(i-1))^3 / (6*(x(i) - x(i-1)))  + ((Fx(i-1)/(x(i)-x(i-1)) - (d2f(i-1)*(x(i) - x(i-1))/6))*(x(i) - x_eval)) + ((Fx(i)/(x(i)-x(i-1))) - (d2f(i)*(x(i) - x(i-1))/6))*(x_eval - x(i-1));
        i = i-1;
    end


    %f_eval(i) = d2f(i-1) * (x(i) - x_eval)^3 / (6*(x(i) - x(i-1))) + d2f(i) * (x_eval - x(i-1))^3 / (6*(x(i) - x(i-1)))  + ((Fx(i-1)/(x(i)-x(i-1)) - (d2f(i-1)*(x(i) - x(i-1))/6))*(x(i) - x_eval)) + ((Fx(i)/(x(i)-x(i-1))) - (d2f(i)*(x(i) - x(i-1))/6))*(x_eval - x(i-1));

   
end
fprintf('Interpolated value of function at x = %.2f is : %f \n',x_eval,f_eval)


f_true = 7.986;
fprintf('true value at x = %.2f is : %f\n',x_eval,f_true)
error = abs(f_true - f_eval) / abs(f_true);
absol_error = error *100;
fprintf('absolute error is : %f percent \n',absol_error)
