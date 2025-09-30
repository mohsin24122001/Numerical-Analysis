clc
clear all;
a = 0;
b = 2;
a0 = (a+b)/2;
a1 = (b-a)/2;

function y = fx(x)   
         y =   (exp(x) * sin(x)) / (1+x^2);
end 

n = input('no. of gauss Quadrature points = ');

if n==2
    Xi = [-0.5773502691896257 0.5773502691896257];
    Wi = [1,1];
elseif n==3
    Xi = [0 -0.7745966692414834 0.7745966692414834];
    Wi = [0.8888888888888888 0.5555555555555556 0.5555555555555556];
elseif n==4
    Xi = [-0.3399810435848563 0.3399810435848563 -0.8611363115940526 0.8611363115940526];
    Wi = [0.6521451548625461 0.6521451548625461 0.3478548451374538 0.3478548451374538];
end

I=0;
for i=1:n

    I = I + Wi(i) * fx((a0 + a1 * Xi(i)));

end
fprintf('\n Value of Integral for %d gauss points is: \n %.16f \n',n,I)

 I_exact = 1.9401300220307203;

 error = abs((I_exact-I) / abs(I_exact)) * 100;

 fprintf('\n Value of percentage error for %d gauss points is: \n %.16f \n',n,error)




