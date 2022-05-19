A = [0 0 10;
     0 4  5;
     1 3 10;
     2 3  4;
     1 2  2];

[n, ~] = size(A);
LowerMatrix = zeros(n, 3); % lower matrix
MatrixDet = 1;

for i = 1 : n
    for j = max(4 - i, 1) : 3
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

        if j == 3 % if we're on the diagonal
            LowerMatrix(i, j) = sqrt(A(i, j) - sum);
            MatrixDet = MatrixDet * LowerMatrix(i, j).^2;
        else % if we aren't on non-diagonal
            if j == 1
                LM = LowerMatrix(i - 2 , 3);
            elseif j == 2
                LM = LowerMatrix(i - 1 , 3);
            end

            LowerMatrix(i, j) = 1.0 / LowerMatrix(i + j - 3, 3) * (A(i, j) - sum);
        end
    end
end

LowerMatrix
MatrixDet