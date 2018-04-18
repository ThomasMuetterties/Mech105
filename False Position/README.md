# Description:
falsePostion uses the false positioning method (or linear interpolation method) to find roots of a function.
The lower and upper guesses of the root have to enclose the root so the location of the root has to be somewhat known.

## Inputs:
    
    func = the function being evaluated
    xl = the lower guess of root(lower x value of where the root really is located)
    xu = the upper guess (higher x value of where the root really is located)
    es = the desired relative error (defults to 0.0001%)
    maxiter = the number of iterations desired (defults to 200)

## Outputs:

    root = the estimated root location
    fx = the value of the function at the root location
    ea = the approximate relative error (%)
    iter = the number of iterations preformed
