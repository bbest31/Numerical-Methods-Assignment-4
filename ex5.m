%% Excercise 5
% distance travelled
dist = [0 1.25 2.5 3.75 5 6.25 7.5 8.75 10];
% fuel efficiency at that moment
y = [0.26 0.208 0.172 0.145 0.126 0.113 0.104 0.097 0.092]; 

A = fliplr(vander(dist));

f = A\y';

a = 0;
b = 10;

syms x

func = @(x) 0.26 - 0.0555.*x + 0.0174.*x.^2 - 0.0072.*x.^3 + 0.0021.*x.^4 - 0.0004.*x.^5;

I = integral(func,a,b);

M = midpointRule(a,b,func,x);
T = trapezoidRule(a,b,func,x);
S = simpsonRule(a,b,func,x);

[I M T S]

function M = midpointRule(a,b,func,x)
    f = eval(subs(func,x,((a+b)/2)));
    M = (b-a)*f;
end

function T = trapezoidRule(a,b,func,x)
    f = eval(subs(func,x,a)) + eval(subs(func,x,b));
    T = ((b-a)/2)*f;
end

function S = simpsonRule(a,b,func,x)
f = eval(subs(func,x,a)) + 4*eval(subs(func,x,((a+b)/2))) + eval(subs(func,x,b));
S = ((b-a)/6) * f;
end