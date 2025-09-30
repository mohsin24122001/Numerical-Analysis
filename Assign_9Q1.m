
clc 
clear all;

function y = f(x)
       y = 0.2 +25*x -200*x^2 + 675*x^3 - 900* x^4 +400*x^5 ;
end

function dy = df(x)
          dy = 25 -400*x + 2025*x^2 - 3600*x^3 + 2000*x^4;
end

function dy = forward_1st_order(x,h)
     dy = (f(x+h)- f(x)) / h;
end
function dy = forward_2nd_order(x,h)
  
   dy = (-f(x+(2*h)) + 4*f(x+h) - 3* f(x))/ (2*h) ;
end

function dy = backward_1st_order(x,h)

            dy = (f(x)-f(x-h)) / h;
end

function dy = backward_2nd_order(x,h)

            dy = (3*f(x) -4*f(x-h) + f(x-2*h))/ (2*h);
end

function dy = central_1st_order(x,h)
    
            dy = (f(x+h) - f(x-h))/ (2*h);
end

function dy = central_2nd_order(x,h)

            dy = (-f(x+2*h) + 8*f(x+h) - 8*f(x-h) + f(x-2*h))/ (12*h);
end


x = 0.6;
h = input('enter the value of stepsize h = [0.03 0.06 0.09]:');

df_f1 = forward_1st_order(x,h);
df_f2 = forward_2nd_order(x,h);
df_b1 = backward_1st_order(x,h);
df_b2 = backward_2nd_order(x,h);
df_c1 = central_1st_order(x,h);
df_c2 = central_2nd_order(x,h);
disp('values of derivatives are')
fprintf(' forward_1st_order = %.8f \n forward_2nd_order = %.8f \n backward_1st_order = %.8f \n backward_2nd_order = %.8f \n central_1st_order = %.8f \n central_2nd_order = %.8f \n',df_f1,df_f2,df_b1,df_b2,df_c1,df_c2)
df_true = df(x);
disp('value of errors are :')
error = abs(df_true - df_f1);
fprintf(' forward first order error = %.8f \n',error)

error = abs(df_true - df_f2);
fprintf(' forward 2nd order error = %.8f \n',error)

error = abs(df_true - df_b1);
fprintf(' backward first order error = %.8f \n',error)

error = abs(df_true - df_b2);
fprintf(' backward 2nd order error = %.8f \n',error)

error = abs(df_true - df_b2);
fprintf(' backward 2nd order error = %.8f \n',error)

error = abs(df_true - df_c1);
fprintf(' central first order error = %.8f \n',error)

error = abs(df_true - df_c2);
fprintf(' central 2nd order error = %.8f \n',error)