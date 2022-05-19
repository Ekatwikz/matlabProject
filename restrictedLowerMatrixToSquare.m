function [ lowerSquareMatrix ] = restrictedLowerMatrixToSquare ( restrictedLowerMatrix )
    [n, ~] = size(restrictedLowerMatrix);
    lowerSquareMatrix = zeros(n);

    for i = 1 : n
        lowerSquareMatrix(i, i) = restrictedLowerMatrix(i, 3);
    
        % here we're getting values from the left of the diagonal,
        % if we can.
        % we may note that the symmetry allows this to be implemented in other
        % ways too
        if i > 1
            lowerSquareMatrix(i, i - 1) = restrictedLowerMatrix(i, 2);
        end
        if i > 2
            lowerSquareMatrix(i, i - 2) = restrictedLowerMatrix(i, 1);
        end
    end
end