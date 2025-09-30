clc;
clear all;

% Q1 *****************
% A=[-4 0 0.5 0.5;
%     0.5 -2 0 0.5;
%     0.5 0.5 0 0 ;
%     0 1 1 4];
% x0 = [0; 0; 0; 1;];

%*********************** Q2
A = [1 -1 0;
    -2 4 -2;
    0 -1 2];
x0 =[-1; 2; 1];

max_iter = 1000;
tol = 1e-6;
n= size(A,1);

%x0 = rand(n,1); % we can use random initial guess

itr = 1;
while itr < max_iter
     y = A * x0;
     x = y / max(abs(y));
     if max(abs(x - x0)) < tol
         break;
     end
     x0 = x;
     itr = itr +1;
end
disp(' maximum  eigan value is : ')
disp (max(abs(y)))
disp('corresponding eigan vector is :')
disp(x)