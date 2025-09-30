% Name : Mohsin Azam
%Roll no. 244103007
% Assignment_1 Que. 2 - Write a small code in to print first 20 Fibonacci
% numbers.
clc;
clear all ;
% Defined an array A to store fibonacci series
A(1) = 0; % it reperesents second term of series
A(2) = 1; % it reperesents second term of series

for i=3:20
    A(i)=A(i-1)+A(i-2);
end 
disp("fibonacci series is:")
fprintf("%d\t",A) ;