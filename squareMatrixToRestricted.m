function [ lowerRestrictedMatrix ] = squareMatrixToRestricted ( lowerSquareMatrix )
    [n, ~] = size(lowerSquareMatrix);
    lowerRestrictedMatrix = zeros(n, 3);

    for i = 1 : n
        lowerRestrictedMatrix(i, 3) = lowerSquareMatrix(i, i);
    
        % here we're getting values from the left of the diagonal,
        % if we can.
        % we may note that the symmetry allows this to be implemented in other
        % ways too
        if i > 1
            lowerRestrictedMatrix(i, 2) = lowerSquareMatrix(i, i - 1);
        end
        if i > 2
            lowerRestrictedMatrix(i, 1) = lowerSquareMatrix(i, i - 2);
        end
    end
end