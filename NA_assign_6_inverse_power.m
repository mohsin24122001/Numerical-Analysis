clc;
clear all;
% gauss elemination function
function [y, fun_eval] = gauss_elimination(A,b, n)
    fun_eval = 0; % Initialize function evaluation count
    
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

% Q1 ***************************
% A=[-4 0 0.5 0.5;
%     0.5 -2 0 0.5;
%     0.5 0.5 0 0 ;
%     0 1 1 4];
% x0 = [0; 0; 0; 1];

% Q2 ***************************
A = [1 -1 0;
    -2 4 -2;
    0 -1 2];
x0 =[-1; 2; 1];

max_iter = 1000;
tol = 1e-6;
n= size(A,1);

%x0 = rand(n,1); % you can take initial guess random

itr = 1;
while itr < max_iter
     %y = inv(A) * x0; % you can solve either using direct method or below gauss elimination
     
     % calling gauss elimination function
     [y, fun_eval] = gauss_elimination(A,x0, n);

     x = y / max(abs(y));
     if max(abs(x - x0)) < tol
         break;
     end
     x0 = x;
     itr = itr +1;
end
disp(' minimum  eigan value is : ')
% max(abs(y)) will give the maximum eigan value of A inverse but for
% minimum eigan value of A will have to take 1/ (max eigan vlue of A
% inverse)
disp (1/max(abs(y)))  
disp('corresponding eigan vector is :')
disp(x)