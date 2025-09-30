 clc 
 clear all;
 % switch case for all questions
 function [y,k] =  f(x, qn)
      k = 0;
      if qn == 1
          y = x^3 - 2*x -5;
          k = k+4;
      elseif qn == 2
          y = x * sin(x) - 1;
          k = k + 1;
      elseif qn == 3
          y = exp(-x) - x ;
          k = k + 1;
      end
end
% function to calculte derivative
function [dy,j] =  df (x,qn)
      h = 1e-6;
      j = 0;
      [y1,k] =  f(x+h,qn);
      [y2,k] =  f(x-h,qn);
      dy = (y1-y2) / (2*h);
      j = 2*k + 2;
end


% main function

e = [1e-2 1e-4 1e-5 1e-6 1e-9];
qn = input ('input question number(1 = a, 2 = b , 3 = c) = ');
for i=1:length(e)
    x0 = 1;
    max_itr = 10;
    f_eval = 0;
    itr = 1;
    fprintf('result for tol. = %d \n',e(i))
    fprintf('iteration \t   convergence \t   value of x\n ')
        while itr< max_itr 
             [y,k] =  f(x0,qn);

             [dy,j] =  df (x0,qn);
             
             g = - y / dy ;
             
             f_eval = f_eval +(j + k + 1);
             
             x1 = x0 + g;
             
             fprintf('%d \t\t\t   %.8f \t   %f \n',itr,g,x1);
             
             if abs(g) <  e(i)
                 break;
             end
             x0 = x1;
             itr = itr +1;
        end
    
    fprintf('root is %f \n ',x0)
    fprintf('no of function evaluation is %d \n',f_eval)
end






