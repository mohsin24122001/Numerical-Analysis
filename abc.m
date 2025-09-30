function ode_comparison()
    % Define the ODE function
    f = @(y, t) -0.06 * sqrt(y);
    
    % Exact solution
    y_exact = @(t) (sqrt(3) - 0.06 * t / 2).^2;
    
    % Derivative of f with respect to y (for truncation error calculation)
    f_diff = @(y, t) -0.06 * 0.5 * (y.^(-0.5));
    
    % Parameters
    y0 = 3;
    t0 = 0;
    h_list = [0.1, 0.3, 0.5, 0.7, 0.8];
    
    % Run Euler's method
    euler_results = cell(length(h_list), 1);
    for i = 1:length(h_list)
        euler_results{i} = euler_method(f, y_exact, f_diff, y0, t0, h_list(i));
    end
    
    % Run Heun's method
    heun_results = cell(length(h_list), 1);
    for i = 1:length(h_list)
        heun_results{i} = heun_method(f, y_exact, f_diff, y0, t0, h_list(i));
    end
    
    % Display results
    disp('Euler''s Method Results:');
    display_results(euler_results, h_list, 'Euler');
    
    disp('Heun''s Method Results:');
    display_results(heun_results, h_list, 'Heun');
end

function results = euler_method(f, y_exact, f_diff, y0, t0, h)
    results = [];
    y = y0;
    t = t0;
    max_steps = 1000; % Prevent infinite loops
    
    for step = 1:max_steps
        if y <= 1e-7
            break;
        end
        
        % Euler step
        y_new = y + f(y, t) * h;
        t_new = t + h;
        
        % Analytical solution
        y_analytical = y_exact(t_new);
        if y_analytical <= 0
            break;
        end
        
        % Error calculations
        trunc_err = (f_diff(y, t) * h^2) / 2;
        relatv_err = abs((y_new - y_analytical) / y_analytical) * 100;
        
        % Store results
        results = [results; h, t_new, y_new, y_analytical, trunc_err, relatv_err];
        
        % Update for next iteration
        y = y_new;
        t = t_new;
    end
end

function results = heun_method(f, y_exact, f_diff, y0, t0, h)
    results = [];
    y = y0;
    t = t0;
    eps = 1e-6;
    max_steps = 1000; % Prevent infinite loops
    
    for step = 1:max_steps
        if y <= 1e-7
            break;
        end
        
        % Predictor step
        y_predict = y + f(y, t) * h;
        
        % Corrector step
        y_new = y + 0.5 * (f(y, t) + f(y_predict, t + h)) * h;
        
        t_new = t + h;
        y_analytical = y_exact(t_new);
        if y_analytical <= 0
            break;
        end
        
        % Error calculations (simplified for Heun's method)
        % Note: The exact truncation error for Heun's is more complex
        trunc_err = (1/12) * h^3 * (f_diff(y, t) * f(y, t) + f(y, t)^2 * f_diff(y, t));
        relatv_err = abs((y_new - y_analytical) / y_analytical) * 100;
        
        % Store results
        results = [results; h, t_new, y_new, y_analytical, trunc_err, relatv_err];
        
        % Update for next iteration
        y = y_new;
        t = t_new;
    end
end

function display_results(results, h_list, method_name)
    for i = 1:length(h_list)
        fprintf('\nResults for h = %.1f (%s''s method):\n', h_list(i), method_name);
        fprintf('%-10s %-10s %-15s %-15s %-15s %-15s\n', ...
                'h', 't', ['y_' method_name], 'y_exact', 'trunc_err', 'relatv_err');
        
        current_results = results{i};
        if ~isempty(current_results)
            for j = 1:min(size(current_results, 1), 5) % Display first 5 steps
                fprintf('%-10.1f %-10.2f %-15.6f %-15.6f %-15.6f %-15.6f\n', ...
                        current_results(j, 1), current_results(j, 2), ...
                        current_results(j, 3), current_results(j, 4), ...
                        current_results(j, 5), current_results(j, 6));
            end
            if size(current_results, 1) > 5
                fprintf('... (showing first 5 of %d steps)\n', size(current_results, 1));
            end
        else
            fprintf('No results for this step size\n');
        end
    end
end