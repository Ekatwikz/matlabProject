format short;

n = 9;
SquareLowerMatrix = zeros(n, n); % for testing
%RestrictedSquareMatrix = zeros(n, 3); % input for function with restricted storage

minaRand = -0.0000000000000001;
maxRand = 0.000000000000000001;

% generate random tridiagonal lower matrix, we'll use it to generate
% symmetric pentadiag matrix
for i = 1 : n
    SquareLowerMatrix(i, i) = minaRand + rand() * (maxRand - minaRand);

    % here we're putting values below the diagonal, if we can
    if i < n
        SquareLowerMatrix(i + 1, i) = minaRand + rand() * (maxRand - minaRand);
    end
    if i < n - 1
        SquareLowerMatrix(i + 2, i) = minaRand + rand() * (maxRand - minaRand);
    end
end

% generate pentadiagonal from lower
SquareMatrix = SquareLowerMatrix * transpose(SquareLowerMatrix);

% this is important because (todo, think about this lol)
SquareLowerMatrix = transpose(chol(SquareMatrix));

% convert the square pentadiagonal matrix to restricted storage representation with only 3
% diagonals stored (due to symmetry and sparseness)
% then calculate the cholesky
[ restrictedLowerMatrix, determinant ] = restrictedCholeskyAndDeterminant(squareMatrixToRestricted(SquareMatrix));

% calculate % error in determinant
determinantPercentError = 100 * (determinant - det(SquareMatrix) ) / det(SquareMatrix)

% calculate % error of matrix values in decomposition
lowerMatrixPercentError = 100 * (restrictedLowerMatrixToSquare(restrictedLowerMatrix) - SquareLowerMatrix) ./ SquareLowerMatrix;

% we replace NaNs (0 / 0 these were outside the diagonal we calculated)
% with 0s
lowerMatrixPercentError(isnan(lowerMatrixPercentError)) = 0