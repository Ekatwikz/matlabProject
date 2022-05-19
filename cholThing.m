A = [10 (2-sqrt(-1)) 1 0 0; 
   (2+sqrt(-1)) 5 3 0 0;
   1 3 10 3 1;
   0 0 3 4 2;
   0 0 1 2 2];

%count = 0;
[n, ~] = size(A);
UpperMatrix = zeros(n); % upper matrix

% for each column
for j = 1:n
    % for each row
    for i = 1:j - 1
        % sum over l_k,i * l_k,j for l_i,j
        sumForNonDiagonal = 0;
        for k = 1:i - 1
            sumForNonDiagonal = sumForNonDiagonal + UpperMatrix(k, i) * UpperMatrix(k, j);
        end
        
        % set l_i,j
        UpperMatrix(i, j) = (A(i, j) - sumForNonDiagonal) / UpperMatrix(i, i);
    end
    
    % sum over (l_k,j)^2, for the diagonal element
    sumForDiagonal = 0;
    for k=1:j - 1 
        sumForDiagonal = sumForDiagonal + UpperMatrix(k, j) * UpperMatrix(k, j);
    end
    
    % set diagonal element
    UpperMatrix(j, j) = sqrt(A(j, j) - sumForDiagonal);
end

LowerMatrix = transpose(UpperMatrix);
LowerMatrix * UpperMatrix
A
UpperMatrix