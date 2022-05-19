A = [0 0 10;
     0 4  5;
     1 3 10;
     2 3  4;
     1 2  2];

[n, ~] = size(A);
LowerMatrix = zeros(n, 3); % lower matrix
matrixDet = 1;

for i = 1 : n
    for j = max(4 - i, 1) : 3
        %fprintf("dep:");
        if j == 1 || i == 1 || i == 2 && j == 2
            % zero dependencies
            fprintf("0 ");
            sum = 0;
        elseif j == 2
            % depends on one to the left and one to the top left
            fprintf("1 ");
            sum = LowerMatrix(i, j - 1) * LowerMatrix(i - 1, j);
        elseif j == 3
            fprintf("2 ");
            % depends on this row
            sum = LowerMatrix(i, 1).^2 + LowerMatrix(i, 2).^2;
        end

        if j == 3 % if we're on the diagonal
            LowerMatrix(i, j) = sqrt(A(i, j) - sum);
            matrixDet = matrixDet * LowerMatrix(i, j).^2;
        else % non-diagonal
            if j == 1
                LM = LowerMatrix(i - 2 , 3);
            elseif j == 2
                LM = LowerMatrix(i - 1 , 3);
            end
            %fprintf("tmp:%d ", LM);
            LowerMatrix(i, j) = 1.0 / LM * (A(i, j) - sum);
        end

        %fprintf("sum:%d A(%d,%d):%.3f\n", sum, i, j, A(i, j));
        fprintf("A(%d,%d):%.3f\n", i, j, LowerMatrix(i, j));
    end
end

LowerMatrix