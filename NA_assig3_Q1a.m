clc;
clear all;
function result = significant_digit(value, sig_digits)
    if value ~= 0
        result = round(value, sig_digits - floor(log10(abs(value))) - 1);
    end
end

% Define the matrix A and vector b
A = [2 1 1 0; 4 3 3 1; 8 7 9 5; 6 7 9 8];
% b = [4, 6, 8, -2]; % stored in array below taken transpose for column
% b = b.';
b = [4; 6; 8; -2]; % written b directly in column form
Aug = [A b];
disp('Augmented matrix is :')
disp(Aug)
n = length(b); % Number of rows

% Function for Gauss elimination with significant digits and function evaluation count
function [x, fun_eval] = gauss_elimination(Aug, n, sig_digits)
    fun_eval = 0; % Initialize function evaluation count
    
    % Forward elimination with partial pivoting
    for i = 1:n
        % Partial pivoting
        temp1 = Aug(i,i);
        temp2 = i; % Initialize temp2 (it is a variable to store the index of maximum value)
        for k = i+1:n
            if abs(Aug(k,i)) > abs(temp1)
                temp1 = Aug(k,i);
                temp2 = k;
            end
        end
        if temp2 ~= i
            % Swap rows
            a = Aug(temp2,:);
            Aug(temp2,:) = Aug(i,:);
            Aug(i,:) = a;
        end
        % Forward elimination
        for j = i+1:n
            factor = round(Aug(j,i) / Aug(i,i), sig_digits);
            fun_eval = fun_eval + 1; % Count division
            for k = i:n+1
                Aug(j,k) = Aug(j,k) - factor * Aug(i,k);
                fun_eval = fun_eval + 2; % Count subtraction and multiplication
            end
        end
    end
    % disp('Upper triangular form :')
    % disp(Aug)
    % Back substitution
    x = zeros(n, 1); % Initialize solution vector
    for i = n:-1:1
        x(i) = Aug(i,n+1);
        for j = i+1:n
            x(i) = x(i) - Aug(i,j) * x(j);
            fun_eval = fun_eval + 2; % Count subtraction and multiplication
        end
        x(i) = round(x(i) / Aug(i,i), sig_digits);
        x(i) = significant_digit(x(i), sig_digits);
        fun_eval = fun_eval + 1; % Count division
    end
end

% Obtain solutions with different significant digits and count function evaluations
d = [3, 5, 7, 10]; % Different significant digits to test
X = zeros(length(b), length(d));
fun_eval_list = zeros(1, length(d));

for i = 1:length(d)
    Aug = [A b]; % Reset the augmented matrix for each significant digit
    [X(:, i), fun_eval_list(i)] = gauss_elimination(Aug, n, d(i));
end

% Exact solution with 10 significant digits
Aug = [A b];
[x_star, fun_eval_star] = gauss_elimination(Aug, n, 10);

% Calculate ||x - x*||_2 for each significant digit
errors_2 = zeros(1, length(d));
errors_inf = zeros(1, length(d));
for i = 1:length(d)
    errors_2(i) = norm(X(:, i) - x_star, 2);    % ||x - x*||_2
    errors_inf(i) = norm(X(:, i) - x_star, Inf);% ||x - x*||_inf
end

% Display the results
disp('solution is:')
disp(X);
disp('Significant Digits:');
disp(d);
disp('Errors ||x - x*||_2:');
disp(errors_2);
disp('Errors ||x - x*||_inf:');
disp(errors_inf);
disp('Function Evaluations for each significant digit:');
disp(fun_eval_list);

% Tabular results
T = table(d', errors_2', errors_inf', fun_eval_list', 'VariableNames', {'Sig_Digits', 'Errors_2', 'Errors_inf', 'Func_Evals'});
disp(T);


