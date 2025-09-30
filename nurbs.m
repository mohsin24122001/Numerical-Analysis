% Hyperbola parameters
a = 2;           % Semi-major axis
b = 1.5;         % Semi-minor axis
h = 0;           % Center x
k = 0;           % Center y

% Domain of x (must be |x - h| > a to satisfy equation)
x1 = linspace(h - 5*a, h - 1.01*a, 500);
x2 = linspace(h + 1.01*a, h + 5*a, 500);

% Compute y for both branches
y_upper1 = k + b * sqrt(((x1 - h).^2 / a^2) - 1);
y_lower1 = k - b * sqrt(((x1 - h).^2 / a^2) - 1);

y_upper2 = k + b * sqrt(((x2 - h).^2 / a^2) - 1);
y_lower2 = k - b * sqrt(((x2 - h).^2 / a^2) - 1);

% Plotting
figure;
hold on; grid on; axis equal;

% Left branch
plot(x1, y_upper1, 'b', 'LineWidth', 2);
plot(x1, y_lower1, 'b', 'LineWidth', 2);

% Right branch
plot(x2, y_upper2, 'r', 'LineWidth', 2);
plot(x2, y_lower2, 'r', 'LineWidth', 2);

% Asymptotes
x_asym = linspace(h - 5*a, h + 5*a, 2);
plot(x_asym, k + (b/a)*(x_asym - h), '--k');  % upper asymptote
plot(x_asym, k - (b/a)*(x_asym - h), '--k');  % lower asymptote

% Labels and title
title('Hyperbolic Curve: \frac{(x - h)^2}{a^2} - \frac{(y - k)^2}{b^2} = 1');
xlabel('x'); ylabel('y');
legend('Left Upper', 'Left Lower', 'Right Upper', 'Right Lower', 'Asymptotes');
