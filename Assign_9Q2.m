clc
clear all;
fp = fopen('Q2_input.txt','r');
n = fscanf(fp,'no. of data points = %d',1);
y = zeros(n);
v = zeros(n);

% Read data points
for i = 1:n
    y(i) = fscanf(fp, '%f', 1); % Read x value
    v(i) = fscanf(fp, '%f', 1); % Read F(x) value
end
fclose(fp);
% Display the data
fprintf('Sl.no.\t y \t\t\t V\n');
for i = 1:n+1
    fprintf('%d\t\t %.2f \t\t %.6f \n', i, y(i), v(i));
end
y0 = 0;
i=2;
dv_dy=v(i-1)*(2*y0-y(i)-y(i-1))/((y(i-1)-y(i))*(y(i-1)-y(i+1))) + v(i)*(2*y0-y(i-1)-y(i+1))/((y(i)-y(i-1))*(y(i)-y(i+1))) + v(i+1)*(2*y0-y(i)-y(i-1))/((y(i+1)-y(i-1))*(y(i+1)-y(i)));
fprintf('value of dv/dy at y=0 is: \n %.8f \n',dv_dy)
U= 1.8 * 1e-5;
T = U * dv_dy;
fprintf('The shear stress T (N/m2)at the surface (y = 0) is \n %.8f\n',T)