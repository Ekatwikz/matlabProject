A = [10 2 1 0 0; 
   2 5 3 0 0;
   1 3 10 3 1;
   0 0 3 4 2;
   0 0 1 2 2];

[n, ~] = size(A);
LowerMatrix = zeros(n); % upper matrix

% for each column
for k = 1:n
    % sum over (l_k,j)^2, for the diagonal element
    sumForDiagonal = 0;
    for j=1:k - 1
        sumForDiagonal = sumForDiagonal + LowerMatrix(k, j) * LowerMatrix(k, j);
    end
    % set diagonal element
    LowerMatrix(k, k) = sqrt(A(k, k) - sumForDiagonal);

    for i = k + 1:n
        sumForNonDiagonal = 0
        for j = 1:k-1
            sumForNonDiagonal = LowerMatrix(i, j) * LowerMatrix(k, j)
        end
        % set non-diagonal:
        LowerMatrix(i, k) = (A(i, k) - sumForNonDiagonal) / LowerMatrix(k, k)
    end
end

 LowerMatrix * transpose(LowerMatrix)
A
LowerMatrix