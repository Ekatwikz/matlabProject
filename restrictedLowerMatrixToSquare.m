function [ lowerSquareMatrix ] = restrictedLowerMatrixToSquare ( restrictedLowerMatrix )
    [n, ~] = size(restrictedLowerMatrix);
    lowerSquareMatrix = zeros(n);

    for i = 1 : n
        % 3rd column is the diagonal
        lowerSquareMatrix(i, i) = restrictedLowerMatrix(i, 3);
    
        % 2nd column is right below
        if i > 1
            lowerSquareMatrix(i, i - 1) = restrictedLowerMatrix(i, 2);
        end

        % 1st column is below that
        if i > 2
            lowerSquareMatrix(i, i - 2) = restrictedLowerMatrix(i, 1);
        end
    end
end