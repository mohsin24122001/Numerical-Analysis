clc
clear all;

fp=fopen('Example_input.txt','r');
%n=0;
n = fscanf(fp,'x F(x) (n+1) = %d\n',1);
x= zeros(n,1);
Fx=zeros(n,1);

for i=1:n
    x(i) = fscanf(fp,'%d',1);
    Fx(i) = fscanf(fp,'%f',1);
end
fclose(fp);

fprintf('Sl.no.\t x \t\t F(x)\n')
for i=1:n
 fprintf('%d\t\t %d \t\t %f \n',i,x(i),Fx(i));
end
% first divide difference function
function F1_0 = firstdividediff(x1,Fx1,x0,Fx0)
        F1_0 = (Fx1 - Fx0) / (x1 -x0);
end


% first divide difference calculation
for i=1:n-1
    F1st(i) = firstdividediff(x(i+1),Fx(i+1),x(i),Fx(i));
end

fprintf('First divide difference value \n')
for i=1:n-1
 fprintf('f[%d,%d] = %.7f\n',i+1,i,F1st(i));
end

% 2nd divide difference function

function F_i_j_k = seconddividediff(F_i_j,F_j_k,x_i,x_k)

         F_i_j_k = (F_i_j - F_j_k) / (x_i - x_k);

end



% 2nd divide difference calculation
for j = 1 :n-2
    F2nd(j) = seconddividediff(F1st(j+1),F1st(j),x(j+2),x(j));
end

fprintf('second divide difference value \n')
for i=1:n-2
 fprintf('f[%d,%d,%d] = %.8f\n',i+2,i+1,i,F2nd(i));
end

% 3rd divide difference function
function F3rd = thirddividediff(F3_2_1,F2_1_0,x3,x0)
              F3rd = (F3_2_1 - F2_1_0) / (x3 - x0);
end

% 3rd divide difference calculation
for j = 1 :n-3
    F3rd(j) = thirddividediff(F2nd(j+1),F2nd(j),x(j+3),x(j));
end

fprintf('3rd divide difference value \n')
for i=1:n-3
 fprintf('f[%d,%d,%d,%d] = %.9f\n',i+3,i+2,i+1,i,F3rd(i));
end

% foe 3rd order polynomial
a=F3rd(1);
b=F2nd(1);
c=F1st(1);
d=Fx(1);

X=2;
% polynomial is f(i)
f(X) = a * (X - x(1))*(X - x(2))*(X - x(3)) + b * (X - x(1))*(X - x(2)) + c * (X - x(1)) + d; 
fprintf(' function value by interpolation at X=2 is %.7f',f(i))