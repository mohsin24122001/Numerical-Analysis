function assign_11()
    % Fixed parameters
    y0 = 3.0;
    k = 0.06;
    h_main = 0.5;
    h_list = [0.1, 0.3, 0.5, 0.7, 0.8];

    function dy = f(y, ~)
        dy = -k * sqrt(y);
    end

    function y = y_exact(t)
        y = (sqrt(y0) - (k * t / 2)).^2;
    end

    % Euler's method
    function [results, fevals] = Euler_ODE(y0, t0, h)
        results = [];
        fevals = 0;
        y = y0;
        t = t0;
        while y > 1e-7 && t < 100
            fevals = fevals + 1;
            y_new = y + f(y, t) * h;
            t_new = t + h;
            y_analytical = y_exact(t_new);
            trunc_err = (-k * 0.5 * (y^-0.5) * h^2) / 2;
            relatv_err = abs((y_new - y_analytical) / y_analytical) * 100;
            results = [results; t_new, y_new, y_analytical, trunc_err, relatv_err];
            y = y_new;
            t = t_new;
        end
    end

    % Heun's method
    function [results, fevals] = Heuns_ODE(y0, t0, h)
        results = [];
        fevals = 0;
        y = y0;
        t = t0;
        while y > 1e-7 && t < 100
            fevals = fevals + 1;
            y_predict = y + f(y, t) * h;
            
            fevals = fevals + 1;
            y_new = y + 0.5 * (f(y, t) + f(y_predict, t + h)) * h;
            fevals = fevals + 1;
            t_new = t + h;
            y_analytical = y_exact(t_new);
            trunc_err = (-k * 0.5 * (y^-0.5) * h^3) / 12;
            relatv_err = abs((y_new - y_analytical) / y_analytical) * 100;
            results = [results; t_new, y_new, y_analytical, trunc_err, relatv_err];
            y = y_new;
            t = t_new;
        end
    end

    % Main execution
    [euler_results, euler_fevals] = Euler_ODE(y0, 0, h_main);
    [heuns_results, heuns_fevals] = Heuns_ODE(y0, 0, h_main);
    
    disp('Euler Method:');
    disp(array2table(euler_results, 'VariableNames', ...
        {'t', 'y_num', 'y_exact', 'trunc_err', 'rel_err'}));
    fprintf('Function evaluations: %d\n\n', euler_fevals);
    
    disp('Heun Method:');
    disp(array2table(heuns_results, 'VariableNames', ...
        {'t', 'y_num', 'y_exact', 'trunc_err', 'rel_err'}));
    fprintf('Function evaluations: %d\n\n', heuns_fevals);
    
    % Step size comparison
    comparison = [];
    for h = h_list
        [~, e_fevals] = Euler_ODE(y0, 0, h);
        [~, h_fevals] = Heuns_ODE(y0, 0, h);
        comparison = [comparison; h, e_fevals, h_fevals];
    end
    
    disp('Step Size Comparison:');
    disp(array2table(comparison, 'VariableNames', ...
        {'h', 'Euler_fevals', 'Heun_fevals'}));
end