% Name : Mohsin Azam
%Roll no. 244103007
% Assignment_1 Que. 3 - Develop a Class of complex number, having funtionality of adding, subtracting, multiplying 
% two complex numbers and also to find the complex conjugate of a complex number. Show 
% its capabilities using examples.
clc;
clear all;
% Example usage x+iy and p+iq
disp("two complex x+iy and p+iq") ;
x=input("x=");
y=input("y=");
p=input("p=");
q=input("q=");
c1 = ComplexNumber(x , y);
c2 = ComplexNumber(p , q);
%In the MATLAB code, char is used to convert the ComplexNumber object into a human-readable string format. 
% This helps in displaying the result in an easily understandable way. The char method is overridden in the 
% ComplexNumber class to format the complex number as a string (e.g., "4 + 2i").

%Complex Numbers
disp(['complex number 1: ',char(c1)])
disp(['complex number 2: ',char(c2)])

% Addition
disp(['Addition: ' char(c1 + c2)])  

% Subtraction
disp(['Subtraction: ' char(c1 - c2)])  

% Multiplication
disp(['Multiplication: ' char(c1 * c2)]) 

% Complex Conjugate
disp(['Complex Conjugate of c1: ' char(c1.conjugate())])   
disp(['Complex Conjugate of c2: ' char(c2.conjugate())])  
