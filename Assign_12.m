clc
clear all;

h = [0.1 0.3 0.5 0.7 0.8];

for i = 1:5
    fprintf('\nResult for h = %f \n', h(i))
    fprintf('Time\t\tRK4 Height\t\tHeun Height\t\tRK4 Error\t\tHeun Error\n')

    t0 = 0;
    y0_rk = 3;   % Initial height for RK4
    y0_hn = 3;   % Initial height for Heun

    while y0_rk > 0 && y0_hn > 0
        % RK4
        k1 = f(y0_rk);
        k2 = f(y0_rk + 0.5 * k1 * h(i));
        k3 = f(y0_rk + 0.5 * k2 * h(i));
        k4 = f(y0_rk + k3 * h(i));
        y_rk = y0_rk + (1/6) * (k1 + 2*k2 + 2*k3 + k4) * h(i);

        % Heun's Method
        f0 = f(y0_hn);
        y_predict = y0_hn + f0 * h(i);
        f1 = f(y_predict);
        y_hn = y0_hn + 0.5 * (f0 + f1) * h(i);

        % True solution and errors
        true_y = Trf(t0);
        error_rk = abs((true_y - y_rk) / true_y);
        error_hn = abs((true_y - y_hn) / true_y);

        % Print
        fprintf('%.1f\t\t%.8f\t%.8f\t%.8f\t%.8f\n', ...
            t0, y_rk, y_hn, error_rk, error_hn);

        % Update for next step
        y0_rk = y_rk;
        y0_hn = y_hn;
        t0 = t0 + h(i);
    end
end

% Function definitions
function Y = f(y)
    k = 0.06;
    Y = -k * sqrt(y);
end

function true = Trf(t)
    k = 0.06;
    true = (-0.03 * t + sqrt(3))^2;
end
