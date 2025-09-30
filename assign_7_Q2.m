clc
clear all;

tol = [1e-2 1e-3 1e-4 1e-6 1e-8];

for i=1:length(tol)
    max_iter = 100;
    x0 = [1; 1; 1];
    f_eval =0;
    itr = 1;
    fprintf('result for tol. = %d \n',tol(i))
    fprintf('iteration \t   convergence \n')
    while itr < max_iter
        %calculating fx0
        [F,a] = fun(x0);
        f_eval = f_eval + a;
        % calculating Jx0
        [J,b] = jacobian(@fun, x0);
        f_eval = f_eval + b;
        % either solve  system of linear equation or directly take inverse
    
        %y = inv(J) * (F);
        
        % calling gauss elimination function
        [y, fun_eval] = gauss_elimination(J,F);
        f_eval = f_eval + fun_eval;
        % updating x 
        x1 = x0 - y;
    
        error = max(abs(x1 - x0)) / max(abs(x1));
        fprintf('%d \t\t\t   %.10f\n',itr,error);
        if error < tol(i)
            break;
        end
    
        x0 = x1;
        itr = itr + 1;
    end
    disp('X* is')
    disp(x1)
    fprintf('no. of function evaluation is %d \n',f_eval)

end

% function to calculate Function values
function [F,a] = fun(x)
    a=0;
    F = [16*x(1)^4 + 16*x(2)^4 + x(3)^4 - 16;
         x(1)^2 + x(2)^2 + x(3)^2 - 3;
         x(1)^3 - x(2)];
    a= a + 23;

end

% Function to compute Jacobian using central difference
function [J,b] = jacobian(fun, x0)
    h = 1e-6; % Step size for central difference
    n = length(x0);
    J = zeros(n, n);
    b=0;
    for i = 1:n
        % Perturb x(i) by +h and -h
        x_plus = x0;
        x_minus = x0;
        x_plus(i) = x_plus(i) + h;
        x_minus(i) = x_minus(i) - h;

        [F_plus,a] = fun(x_plus);
        [F_minus,a] = fun(x_minus);
        
        % Central difference approximation
        J(:, i) = (F_plus- F_minus) / (2*h);
        b= b+2*a+2;
    end
end

% gauss elemination function
function [y, fun_eval] = gauss_elimination(A,b)
    fun_eval = 0; % Initialize function evaluation count
    n = length(b);
    
    Aug = [A b];
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
            factor = Aug(j,i) / Aug(i,i);
            fun_eval = fun_eval + 1; % Count division
            for k = i:n+1
                Aug(j,k) = Aug(j,k) - factor * Aug(i,k);
                fun_eval = fun_eval + 2; % Count subtraction and multiplication
            end
        end
    end
    
    % Back substitution
    y = zeros(n, 1); % Initialize solution vector
    for i = n:-1:1
        y(i) = Aug(i,n+1);
        for j = i+1:n
            y(i) = y(i) - Aug(i,j) * y(j);
            fun_eval = fun_eval + 2; % Count subtraction and multiplication
        end
        y(i) = y(i) / Aug(i,i);
    end
end
