function  luFactor( A )
%luFactor completes LU factorization on a square coefficent matrix using pivoting.
%   Inputs:
%       A = Coefficient Matrix
%   Outputs:
%       L = Lower Triangular Matrix
%       U = Upper Triangilar Matrix
%       P = The Pivot Matrix

if nargin > 1 %Checks to make sure only one input is entered
    error('only one matrix/input allowed')
end

[m,n] = size(A);  %Sets m to the number of rows and n to the number of columns. 
if m ~= n      %Checks to see if the matrix is a square matrix.
    error('needs to be a square matrix')
end

L = [ 1 0 0; 0 1 0; 0 0 1]; %Makes the base L matrix
U = A;                      % Makes U the A matrix
P = [ 1 0 0; 0 1 0; 0 0 1]; %Makes the base P matrix

%Pivoting for the first column
x = abs(A(1,1)); %Sets x to the first value in the first row
y = abs(A(2,1)); %Sets y to the first value in the second row
z = abs(A(3,1)); %Sets z to the first value in the third row
if (y > x) && (y > z) %Pivots the second row to the first if the first value in the second row is the largest
    U([1 2],:)=U([2 1],:);
    P([1 2],:)=P([2 1],:); %Changes the pivot matrix to adjust for the pivot
elseif (z > x) && (z > y) %Pivots the third row to the first if the first value in the third row is the largest
    U([1 3],:)=U([3 1],:);
    P([1 3],:)=P([3 1],:); %Changes the pivot matrix to adjust for the pivot
end

%Guass Elimination to remove the first values in the second and third rows
ratio2to1 = U(2,1)/U(1,1); %Finds what the ratio the first row needs to be multiplied by to get zero in the (2,1) spot
ratio3to1 = U(3,1)/U(1,1); %Finds what the ratio the first row needs to be multiplied by to get zero in the (3,1) spot

L(2,1) = ratio2to1; %Plugs in the new value for the L matrix into the second row first column
L(3,1) = ratio3to1; %Plugs in the new value for the L matrix into the third row first column

if ratio2to1 ~= 0
    row1r1 = U(1,:)*ratio2to1; %Multiplies row by the ratio compared to the second row
    newrow2 = U(2,:)-row1r1; %Subtracts the new row one values from the second row to get new row two values
    U(2,:) = newrow2;  %Replaces the second row with the new second row
end
if ratio3to1 ~=0
    row1r2 = U(1,:)*ratio3to1; %Multiplies first row by the ratio compared to the third row
    newrow3 = U(3,:)-row1r2; %Subtracts the new row one values from the third row to get new row three values
    U(3,:) = newrow3;  %Replaces the third row with the new third row
end

%Pivoting again between the second and third rows
y = abs(U(2,2)); %Sets y to the second value in the second row
z = abs(U(3,2)); %Sets z to the second value in the third row
if z > y %Pivots the third row to the second if the first value in the third row is larger than the the first value in the second row
     U([2 3],:)=U([3 2],:);
     P([2 3],:)=P([3 2],:); %Changes the pivot matrix to adjust for the pivot
     L([2 3],1)=L([3 2],1); %Changes the the L matrix due to pivoting
end

%Guass Elimination to remove the second values in the third row
ratio3to2 = U(3,2)/U(2,2); %Finds what the ratio the second row needs to be multiplied by to get zero in the (3,2) spot

row2r3 = U(2,:)*ratio3to2; %Multiplies second row by the ratio compared to the third row
newrow3two = U(3,:)-row2r3; %Subtracts the new row two values from the third row to get new row three values

U(3,:) = newrow3two; %Replaces the third row with the new third row

L(3,2) = ratio3to2;%Plugs in the new value for the L matrix into the third row second column

L = L
U = U
P = P
end

