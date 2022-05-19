function [ determinantPercentError, lowerMatrixPercentError ] = randomCholTest (matrixSize, minRand, maxRand)
    SquareLowerMatrix = zeros(matrixSize); % for testing
    
    % generate random tridiagonal lower matrix, we'll use it to generate
    % symmetric pentadiag matrix
    for i = 1 : matrixSize
        SquareLowerMatrix(i, i) = minRand + rand() * (maxRand - minRand);
    
        % here we're putting values below the diagonal, if we can
        if i < matrixSize
            SquareLowerMatrix(i + 1, i) = minRand + rand() * (maxRand - minRand);
        end
        if i < matrixSize - 1
            SquareLowerMatrix(i + 2, i) = minRand + rand() * (maxRand - minRand);
        end
    end
    
    % generate pentadiagonal from lower
    SquareMatrix = SquareLowerMatrix * transpose(SquareLowerMatrix);
    
    % this is important because (TODO, think about this lol)
    SquareLowerMatrix = transpose(chol(SquareMatrix));
    
    % convert the square pentadiagonal matrix to restricted storage representation with only 3
    % diagonals stored (due to symmetry and sparseness)
    % then calculate the cholesky
    [ restrictedLowerMatrix, determinant ] = restrictedCholeskyAndDeterminant(squareMatrixToRestricted(SquareMatrix));
    
    % calculate % error in determinant
    determinantPercentError = 100 * (determinant - det(SquareMatrix) ) / det(SquareMatrix);
    
    % calculate % error of matrix values in decomposition
    lowerMatrixPercentError = 100 * (restrictedLowerMatrixToSquare(restrictedLowerMatrix) - SquareLowerMatrix) ./ SquareLowerMatrix;
    
    % we replace NaNs (from 0 / 0, these were outside the diagonals we calculated)
    % with 0s
    lowerMatrixPercentError(isnan(lowerMatrixPercentError)) = 0;
end