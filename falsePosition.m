    function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%falsePostion uses the false positioning method (or linear interpolation method) to find roots of a
%function. 
%   Inputs:
%       func = the function being evaluated
%       xl = the lower guess of root(lower x value of where the root really is located)
%       xu = the upper guess (higher x value of where the root really is located)
%       es = the desired relative error (defults to 0.0001%)
%       maxiter = the number of iterations desired (defults to 200)
%   Outputs:
%       root = the estimated root location
%       fx = the value of the function at the root location
%       ea = the approximate relative error (%)
%       iter = the number of iterations preformed

if nargin < 3; %Checks to see if the user inputs the required amount of inputs for the function.
    error('at least 3 inputs are required')
end
if nargin < 4 || isempty(es); %If the user does not enter a specific desired relative error, 0.0001 is automatically assigned. 
    es = 0.0001;
end
if nargin < 5 || isempty(maxiter); %If the user does not enter a specific desire of iterations, 200 is automatically assigned.
    maxiter = 200;
end
guesstest = func(xl) * func(xu); %Tests to see if the lower and upper root guesses bracket the a root. 
if guesstest > 0; %If the guesses do not bracket the root and error is displayed. 
    error('x value guesses do not bracket root')
end
iteration = 0; %Sets the first iteration so they can be counted as every iteration happens.
xr = xl;  %Sets the first root estimate to the lower guess.
ea = 100;
while ea >= es || iteration < maxiter %Runs the function until the the realtive error or number of iterations are met.
    xrold = xr;
    iteration = iteration + 1; %Counts the iteration.
    xr = xu - ((func(xu)*(xl-xu))/(func(xl)-func(xu))); %Formula for false position to calculate the next value closer to the root. 
    ea = abs((xr-xrold)/xr)*100; %Calculates the approximate relative error.
    test = func(xl) * func(xr); %Test to see if we need to make the new root guess the lower or upper guess. 
    if test > 0; %If the test above is positive then the new root is set as the new upper guess. 
        xl = xr;
    elseif test < 0; %If the test above is negative then the new root is set as the new lower guess.
        xu = xr;
    else
        ea = 0;
    end
end;
root = xr
fx = func(xr)
ea = ea
iter = iteration
end


