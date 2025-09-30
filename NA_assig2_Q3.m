% Name : Mohsin Azam
% Roll no. 244103007
% Assignment_2 Que. 3 - Write a code to generate a 10 × 10 random matrix and find out its trace.
clc;
clear all;

% Set matrix size
m = 10;
n = 10;

% Prompt for limits for random matrix elements
disp('Enter the two integers for limits between which random matrix elements can be generated:');
p = input('Lower limit: ');
q = input('Upper limit: ');

% Initialize trace
T = 0;

% Generate matrix and calculate trace
A = zeros(m, n);  % Pre-allocate matrix
for i = 1:m
    for j = 1:n
        A(i, j) = p + (q - p) * rand;  % Generate random matrix elements
        if i == j
            T = T + A(i, j);  % Add diagonal elements
        end
    end
end

% Display the matrix
disp('Matrix is:');
disp(A);

% Display the trace
fprintf('Trace of the matrix is: %f\n', T);
