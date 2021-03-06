%% Excercise 5
% distance travelled
dist = [0 1.25 2.5 3.75 5 6.25 7.5 8.75 10];
% fuel efficiency at that moment
y = [0.26 0.208 0.172 0.145 0.126 0.113 0.104 0.097 0.092]; 
y2 = [];
y3 = [];
y4 = [];


A = fliplr(vander(0:1.25:10));

f = A\y';

a = 0;
b = 10;

syms x

func = @(x) 0.26 - 0.0555.*x + 0.0174.*x.^2 - 0.0072.*x.^3 + 0.0021.*x.^4 ...
    - 0.00036727.*x.^5 + 0.000037865.*x.^6-0.0000021221.*x.^7 + 0.000000049932.*x.^8;

func_2 = @(x) 0.2536-0.0356.*x + 0.002.*x.^2;
func_3 = @(x) 0.2593-0.0454.*x + 0.0046.*x.^2 - 0.0002.*x.^3;

for i=1:9
    y2 = [y2 eval(subs(func,x,dist(i)))];
    y3 = [y3 eval(subs(func_2,x,dist(i)))];
    y4 = [y4 eval(subs(func_3,x,dist(i)))];
end
plot(dist,y,'*-',dist,y2,'o-',dist,y3,'o-',dist,y4,'o-')
legend('data','f_{1}', 'f_{2}', 'f_{3}')

I = integral(func_2,a,8);
M = 0;
S = 0;
T = trapz(dist,y3);

for i=1:3
    
    if (i == 1)
        M = M + midpointRule(0,2.5,func,x);
        S = S + simpsonRule(0,2.5,func,x);
    elseif (i == 2)
        M = M + midpointRule(3.75,6.25,func,x);
        S = S + simpsonRule(3.75,6.25,func,x);
    else
        M = M + midpointRule(7.5,10,func,x);
        S = S + simpsonRule(7.5,10,func,x);
    end
end

[I M T S]

function M = midpointRule(a,b,func,x)
    f = eval(subs(func,x,((a+b)/2)));
    M = (b-a)*f;
end

function S = simpsonRule(a,b,func,x)
f = eval(subs(func,x,a)) + 4*eval(subs(func,x,((a+b)/2))) + eval(subs(func,x,b));
S = ((b-a)/6) * f;
end