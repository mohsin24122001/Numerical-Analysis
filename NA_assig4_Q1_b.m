clc;
clear all;
% Jacobi Function
function [X, fun_eval] = jacobi(A,b,n,X_o,tol,Max_itr)
    fun_eval=0;
    k=1;
    for l=1:length(tol)
    while k < Max_itr
        for i=1:n
            sum =0;
            for j=1:n
                if j ~= i
                    sum = sum + (-A(i,j) * X_o(j));
                    fun_eval = fun_eval+1;
                end
            end
            X(i) = (1/A(i,i))*(sum + b(i));
            fun_eval = fun_eval +2;
        end
        if max(abs(X - X_o)) / max(abs(X)) < tol(l)
              break;
        end
        X_o = X;
        k = k+1;
    end
   % printing results
   fprintf('for tol =  %f \n',tol(l));
   fprintf('no. of function evaluations = %d \n',fun_eval);
   fprintf('value of X  is: \n');
   fprintf('no of ieration is: %d\n',k);
   for t=1:n
       fprintf("x_%d = %d\n",t,X(t));
   end
   fprintf("*****************************\n")
   
    end
end
%????????????????????????????????????????????????????????????????????????
disp(' Jacobi method')
% inital inputs
A = [1 1 1;
    1 2 2;
    1 3 1;];
b = [7;13;13];
n = length(b);
tol = [1e-2 1e-3 1e-5 1e-6];
Max_itr = 100;
X_o = zeros(n,1);% initial Guess
%Calling jacobi method
[X, fun_eval] = jacobi(A,b,n,X_o,tol,Max_itr);
