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
        %fprintf("L_(%d,%d):%.3f\tL_(%d,%d):%.3f\n", i, k, LowerMatrix(i, k), j, k, LowerMatrix(j, k));
        %k = max(4 - i, 1);
        if j == 1 || i == 1 || i == 2 && j == 2
            % zero dependencies
            sum = 0;
        elseif j == 2 || i == 2 && j == 3
            sum = LowerMatrix(i, j - 1) * LowerMatrix(i - 1, j);
        elseif j == 3
            % depends on this row
            sum = LowerMatrix(i, 1).^2 + LowerMatrix(i, 2).^2;
        end
        fprintf("i:%d j:%d sum:%d\n", i, j, sum);

        if i == 3 % if we're on the diagonal
            LowerMatrix(i, j) = sqrt(A(i, j) - sum);
            matrixDet = matrixDet * LowerMatrix(i, j).^2;
        else % non-diagonal
            LowerMatrix(i, j) = 1.0 / LowerMatrix(j , 3) * (A(i, j) - sum);
        end

        %fprintf("A(%d,%d):%.3f\n\n", i, j, A(i, j));
    end
end

LowerMatrix