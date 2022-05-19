function [ restrictedLowerMatrix, determinant ] = restrictedCholeskyAndDeterminant ( restrictedMatrix )
    [n, ~] = size(restrictedMatrix);
    restrictedLowerMatrix = zeros(n, 3); % lower matrix
    determinant = 1;
    
    % iterate row-wise...
    for i = 1 : n
        %... skipping the top left corner
        for j = max(4 - i, 1) : 3
            % calculate each sum explicitly
            if j == 1
                % zero dependencies
                sum = 0;
            elseif j == 2
                % depends on one to the left and one to the top left
                sum = restrictedLowerMatrix(i, j - 1) * restrictedLowerMatrix(i - 1, j);
            elseif j == 3
                % depends on this row
                sum = restrictedLowerMatrix(i, 1).^2 + restrictedLowerMatrix(i, 2).^2;
            end
    
            % then calculate the diagonals
            if j == 3 % if we're on the main diagonal
                restrictedLowerMatrix(i, j) = sqrt(restrictedMatrix(i, j) - sum);
    
                % we also use this info 
                determinant = determinant * restrictedLowerMatrix(i, j).^2;
            else % if we aren't on non-diagonal
                restrictedLowerMatrix(i, j) = 1.0 / restrictedLowerMatrix(i + j - 3, 3) * (restrictedMatrix(i, j) - sum);
            end
        end
    end
end