 clc 
 clear all;

 fp = fopen("Q1_input.txt","r");
 n=fscanf(fp,'no. of data points = %d',1);
 x= zeros(n,1);
 fx = zeros(n,1);
  for i=1:n
      x(i) = fscanf(fp,'%f',1);
      fx(i) = fscanf(fp,'%f',1);
  end
 sum =0;
  for i=1:n-1

      h = x(i+1) - x(i);
      sum = sum + (h/2)*(fx(i+1)+fx(i));
  end
  Ia = sum;
  I_act = 0.791240;
  error_a = (abs(I_act-Ia) / abs(I_act))*100;
  disp('Q1. Part a')
  fprintf('I_trapezoidal = %.8f\n',Ia)
  fprintf('error = %.8f\n',error_a)


I1 =((x(2) - x(1))/2)*(fx(1)+fx(2));


 I2 = (3*(x(3)-x(2)) *(fx(2) + 3*fx(3) + 3*fx(4) + fx(5)));
 I2 = I2 /8;
 I3 = (fx(5) + 4*fx(6) + fx(7))* ((x(7)-x(6))/3);

  I = I1+I2+I3;
  I_act = 0.79124045368;
  error = abs(I_act-I)/I;
  error=error*100;
  disp('Q1 part b')
  fprintf('I_combination = %.8f\n',I)
  fprintf(' Percentage error = %.6f\n',error)
  

