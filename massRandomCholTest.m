function [ averagePercentDeterminantError, averagePercentLowerMatrixPercentError ] = massRandomCholTest (matrixSize, minRand, maxRand, testCount)
    totalPercentError = 0;
    totalLowerMatrixPercentError = zeros(matrixSize);

    % do a bunch of random tests based on given parameters, accumulate the
    % total
    for i = 1 : testCount
        [ determinantPercentError, lowerMatrixPercentError ] = randomCholTest(matrixSize, minRand, maxRand);
        totalPercentError = totalPercentError + determinantPercentError;
        totalLowerMatrixPercentError = totalLowerMatrixPercentError + lowerMatrixPercentError;
    end

    % calculate the average from the total
    averagePercentDeterminantError = totalPercentError / testCount;
    averagePercentLowerMatrixPercentError = totalLowerMatrixPercentError ./ testCount;
end