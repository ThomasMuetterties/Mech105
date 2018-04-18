function [ I ] = Simpson( x , y )
%Simpson integrates experimental data using Simpson's 1/3 rule.
%   Inputs:
%       x = indepent varaiable numbers/matrix
%       y = depedent varaiable numbers/matrix
%   Output:
%       I = value for integral for supplied experimental data
if nargin < 2  %Makes sure there are two imputs
    error('Needs two inputs')
end
if nargin > 2  %Makes sure there are no more then two inputs
    error('Only need two inputs')
end

[n1,m1] = size(x); %Sets the # of rows of x to n1 and # of columns to m1
[n2,m2] = size(y); %Sets the # of rows of y to n2 and # of columns to m2
if n1 == 1 && m1 > 1  %If the x matrix entered is a row matrix this makes a column matrix
    x = x.';
end
if n2 == 1 && m2 > 1  %If the y matrix entered is a row matrix this makes a column matrix
    y = y.';
end

[n1,m1] = size(x); %Resets the # of rows of x to n1 and # of columns to m1
[n2,m2] = size(y); %Resets the # of rows of y to n2 and # of columns to m2
if (m1 ~= 1) || (m2 ~= 1)  %Makes sure that that there is only one column
    error('x and y should only be one column')
end
if n1 ~= n2  %Makes sure there is an equal number of dependent variable data points as there are independent variable data points
    error('Indepedent and dependent do not have same number of values')
end


H = x(2)-x(1); %Sets H to the step size of the independent variable/x matrix
for s = 1:(n1-1) %Checks to make sure the vaules in the x matrix are even spaced
    t = s-1;
    l = (x((1+s),1))-(x((1+t),1));
    if l ~= H
        error('Values for independent variable are not equally spaced')
    end
end
% Equation for Simpsons's 1/3 composite =
% (h/3)(f(1)+4(f(2+,4+,6+,...))+2(f(3+,5+,+7,...))+f(n1))

v = mod(n1,2);  %Checks to see if the number of intervals is odd or even, determines if the Trap Rule needs to be used on last interval
if v == 1
    yeven = 0;
    yodd = 0;
    for u = 2:2:n1;  %Adds up the even dependent data inputs starting at 2 stoping 1 value away from the last
        yeven = yeven + y(u,1);
    end
    for u = 3:2:(n1-1);  %Adds up the odd dependent data inputs starting at 3 stoping 2 values away from the last
        yodd = yodd + y(u,1);
    end
    I = (H/3)*(y(1,1)+(4*yeven)+(2*yodd)+y(n1,1)) %Plugs all the numbers into the Simpson's 1/3 Rule to give the value of the integral
 
else
    warning('Trapazoid Rule has been used for last interval due too even number of data points')
   yeven = 0;
    yodd = 0;
    for u = 2:2:(n1-1)  %Adds up the even dependent data inputs starting at 2 stoping 2 values away from the last
        yeven = yeven + y(u,1);
    end
    for u = 3:2:(n1-2)  %Adds up the odd dependent data inputs starting at 3 stoping 3 values away from the last
        yodd = yodd + y(u,1);
    end
    Trap = (H*(y((n1)-1,1)+y(n1,1)))/2;  %This is the area of the last interval using the Trapazoid Rule
    I = (H/3)*(y(1,1)+(4*yeven)+(2*yodd)+y(n1,1)) + Trap  %The integral of the data set using the Simpson's 1/3 Rule and using the Trap. Rule for the last interval. 
end

end

