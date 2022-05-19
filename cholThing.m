format short;

A = [10 4 1 0 0;
      4 5 3 2 0;
      1 3 10 3 1;
      0 2 3 4 2;
      0 0 1 2 2];

[~, n] = size(A);
LowerMatrix = zeros(n); % lower matrix
matrixDet = 1;

%from chol-banach algo on wikipedia:
% for each row...
for i = 1 : n
    % ... and for each column,
    % we can skip every value that's too far below the diagonal because
    % it'll be zero (TODO: prove)
    for j = max(i - 2 , 1) : i
        sum = 0;

        % we also don't need to sum from too far above
        for k = max(j - 2, 1) : j - 1
            %fprintf("L_(%d,%d):%.3f\tL_(%d,%d):%.3f\n", i, k, LowerMatrix(i, k), j, k, LowerMatrix(j, k));
            sum = sum + LowerMatrix(i, k) * LowerMatrix(j, k);
        end

        %fprintf("A(%d,%d):%.3f\n\n", i, j, A(i, j));
        if i == j
            LowerMatrix(i, i) = sqrt(A(i, i) - sum);
            matrixDet = matrixDet * LowerMatrix(i, i).^2;
        else
            LowerMatrix(i, j) = 1.0 / LowerMatrix(j , j) * (A(i, j) - sum);
        end
    end
end

LLTerror = LowerMatrix * transpose(LowerMatrix) - A;
DeterminantError = det(A) - matrixDet;
LowerMatrix;