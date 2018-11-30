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


% plot(0:5,b,'*-',0:5,y0,'-o',0:5,y1,'--o',0:5,y2,'-o',0:5,y3,'--o',0:5,y4,'-o',0:5,y5,'--o');
% legend('f0', 'f1','f2', 'f3', 'f4', 'f5');

syms x


func_0 = @(x) 5.5833;  
func_1 = @(x) 1.3190 + 1.7057*x;
func_2 = @(x) 1.0036 + 2.1789*x - 0.0946*x^2;
func_3 = @(x) 0.7897 + 3.1557*x - 0.6294*x^(2) + 0.0713*x^3;
func_4 = @(x) 0.9718 + 0.12*x + 2.6340*x^(2) - 0.9912*x^(3) + 0.1063*x^4;
func_5 = @(x) 1 - 3.1783*x + 8.3042*x^(2) - 4.2125*x^(3) + 0.8458*x^(4) - 0.0592*x^(5);

% f5_vals = eval(func_5,x,);
% 
% plot(linspace(0,0.01,5),f5_vals);

f0_prime = slopes(func_0, x);
f1_prime = slopes(func_1, x);
f2_prime = slopes(func_2, x);
f3_prime = slopes(func_3, x);
f4_prime = slopes(func_4, x);
f5_prime = slopes(func_5, x);
h = 0.0001;

F = forwardDiff(func_2,x,h);
B = backwardDiff(func_2,x,h);
C = centralDiff(func_2,x,h);

f = f2_prime;

plot(0:5,f,'*-',0:5,F,'o-',0:5,B,'o--',0:5,C,'*--');
legend('f prime','forward diff', 'backward diff','central diff');

[f, F, B, C]

function fwd = forwardDiff(func, x, h)
fwd = [];
for i=0:5
   f_i = eval(subs(func,x,i+h))-eval(subs(func,x,i));
   f_i = f_i/h;
   fwd = [fwd; f_i];
end
end

function bck = backwardDiff(func, x, h)
bck = [];
for i=0:5
   f_i = eval(subs(func,x,i))-eval(subs(func,x,i-h));
   f_i = f_i/h;
   bck = [bck; f_i];
end
end

function cent = centralDiff(func, x, h)
cent = [];
for i=0:5
   f_i = eval(subs(func,x,i+h))-eval(subs(func,x,i-h));
   f_i = f_i/(2*h);
   cent = [cent; f_i];
end
end


function y = slopes(func, x)
y = [];
for i=0:5
    y_i = eval( (subs(diff(func,x,1),x,i)) );
    y = [y; y_i];
end
end

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
% Pick a point at -1 (or wherever) and plot the tangent
xTangent = 3;
% Equation of the tangent is y = slope*x + offset
% From the equation y=x^2 we know the slope is 2*x.
% Find the slope at x = xTangent.
slope = 3* xTangent;
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