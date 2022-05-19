format long;
A = [0 0 10;
     0 4  5;
     1 3 10;
     2 3  4;
     1 2  2
     1 1  6
     1 1  9
     2 1 15];

[n, ~] = size(A);
LowerMatrix = zeros(n, 3); % lower matrix
MatrixDet = 1;

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
            sum = LowerMatrix(i, j - 1) * LowerMatrix(i - 1, j);
        elseif j == 3
            % depends on this row
            sum = LowerMatrix(i, 1).^2 + LowerMatrix(i, 2).^2;
        end

        % then calculate the diagonals
        if j == 3 % if we're on the main diagonal
            LowerMatrix(i, j) = sqrt(A(i, j) - sum);

            % we also use this info 
            MatrixDet = MatrixDet * LowerMatrix(i, j).^2;
        else % if we aren't on non-diagonal
            LowerMatrix(i, j) = 1.0 / LowerMatrix(i + j - 3, 3) * (A(i, j) - sum);
        end
    end
end

LowerMatrix
MatrixDet