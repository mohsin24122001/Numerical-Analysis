% Name : Mohsin Azam
% Roll no. 244103007
% Assignment_2 Que. 4 - Write a code to compute matrix-vector multiplication of any given size.
clc;
clear all;

% Input the size of the matrix and vector
m = input('Enter the number of rows in the matrix: ');
n = input('Enter the number of columns in the matrix (size of the vector): ');

% Initialize the matrix and vector
A = zeros(m, n);
v = zeros(n, 1);

% Input matrix elements
fprintf('Enter the elements of the matrix: \n');
for i = 1:m
    for j = 1:n
        fprintf('A(%d, %d) = \t', i, j);
        A(i, j) = input('');
    end
end

% Input vector elements
fprintf('Enter the elements of the vector: \n');
for j = 1:n
    fprintf('v(%d) = ', j);
    v(j) = input('');
end

% Matrix-Vector Multiplication
M = A * v;

% Display the result
fprintf('Result of matrix-vector multiplication is:  \n');
disp(M);
