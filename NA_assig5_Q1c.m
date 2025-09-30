clc;
clear all;

%required inputs 
max_itr = 1000;



a=6; %size of matrix
[A, b] = hilbertMat_Vector(a); % call hillburt matrix function
n= length(b);% size of system
x0=zeros(n,1); % initial guess value
e = [1e-3 1e-4 1e-5 1e-6 1e-8]; %  various tolerance value

% Calling Conjugate function for various tolerances
for i=1:length(e)
    % calling function
    [x,fun_eval,k]= conjugate_gradient(A,b,e(i),x0,max_itr);
    % printing results
    fprintf('data for tolerance = %.8f \n',e(i))
    fprintf('no of function eval is : %d \n',fun_eval)
    fprintf('no. of iteration is : %d \n',k)
    disp('value of x')
    disp(x)
end

% Function to generate n*n matrix and vector
function [H, b] = hilbertMat_Vector(n)
    % Generate the n x n Hilbert matrix
    H = zeros(n, n);
    for i = 1:n
        for j = 1:n
            H(i, j) = 1 / (i + j - 1);
        end
    end

    % Generate the vector b
    b = zeros(n, 1);
    for i = 1:n
        sum = 0;
        for j=1:n
             sum = sum + H(i,j);
        end
        b(i) = sum; %sum(H(i, :)); this will calculate directly b(i)
    end
end

% conjugate  gradient  function
function [x,fun_eval,k]= conjugate_gradient(A,b,e,x0,max_itr)
f_count = 0;
r0=b - A * x0;
f_count = f_count + 36;%for matrix multiplication of (m*n) and (n*p) no. of operation is m*n*p
%disp(r0)
s0=r0;
k=1;
fileID = fopen('data.txt','w');
fprintf(fileID,'iteration     residual\n');
while k<max_itr
        alpha = (r0' * s0) / (s0' * A * s0);
        f_count = f_count + 49;%for matrix multiplication of (m*n) and (n*p) no. of operation is m*n*p
        x1 = x0 + alpha * s0;
        f_count = f_count + 6;%for matrix multiplication of (m*n) and (n*p) no. of operation is m*n*p
        r1 = r0 - alpha * A * s0;
        f_count = f_count + 42;%for matrix multiplication of (m*n) and (n*p) no. of operation is m*n*p
        beta1 =( r1' * r1) / (r0' * r0);
        f_count = f_count + 13;%for matrix multiplication of (m*n) and (n*p) no. of operation is m*n*p
        s1 = r1 + beta1 * s0;
        f_count = f_count + 6;%for matrix multiplication of (m*n) and (n*p) no. of operation is m*n*p
        resi = max(abs(r1));
        fprintf(fileID,'\n%d\t         %.8f ',k,resi);
        if resi < e
            break;
        end
        k = k+1;
        s0 = s1;
        r0 = r1;
        x0 = x1;
        
end
x = x1;
fun_eval = f_count;
fclose(fileID);
end

