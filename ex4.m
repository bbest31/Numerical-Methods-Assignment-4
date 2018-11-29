%% Ex 4


b = [1 2.7 5.8 6.6 7.5 9.9];
A = fliplr(vander(0:5));
% Change n in col specification param 1:n to desired poly degreee
f0 = A(:,1)\b';
f1 = A(:,1:2)\b';
f2 = A(:,1:3)\b';
f3 = A(:,1:4)\b';
f4 = A(:,1:5)\b';
f5 = A(:,1:6)\b';

y0 = funcVals(f0);
y1 = funcVals(f1);
y2 = funcVals(f2);
y3 = funcVals(f3);
y4 = funcVals(f4);
y5 = funcVals(f5);


plot(0:5,b,'*-',0:5,y0,'-o',0:5,y1,'--o',0:5,y2,'-o',0:5,y3,'--o',0:5,y4,'-o',0:5,y5,'--o');
legend('f0', 'f1','f2', 'f3', 'f4', 'f5');
function y_i = polynomialVals(x,i)
    s = size(x);
    y_i = 0;
    for j=1:s(1)
        if(j == 1)
            y_i = y_i + x(j);
        else
            y_i = y_i + x(j)*i^(j-1);
        end
    end
end

function y = funcVals(x)
y = [];
for i=0:5
    y_i = polynomialVals(x,i);
    y = [y; y_i];
end
end

function t = plotTangent()
x = linspace(-2, 2, 500);
y = x .^ 2 + 2;
plot(x, y, 'b-', 'LineWidth', 2);
grid on;
fontSize = 20;
xlabel('X', 'FontSize', fontSize);
ylabel('Y', 'FontSize', fontSize);
ylim([0, 7]);
% Pick a point at -1 (or wherever) and plot the tangent
xTangent = -1;
% Equation of the tangent is y = slope*x + offset
% From the equation y=x^2 we know the slope is 2*x.
% Find the slope at x = xTangent.
slope = 2 * xTangent;
% We want to plot the tangent line where it just touches the curve,
% so we need to know the y value at xTangent.
yTangent = xTangent .^ 2 + 2;  % Y value of curve at x = xTangent.
hold on;
plot(xTangent, yTangent, 'r*', 'LineWidth', 2, 'MarkerSize', 10);
% Use point slope formula of a line to get equation for y
% y-y0 = slope*(x-x0).
% y = slope * (x - xTangent) + yOffset
yTangentLine = slope * (x - xTangent) + yTangent;
plot(x, yTangentLine, 'b-', 'LineWidth', 2);
end