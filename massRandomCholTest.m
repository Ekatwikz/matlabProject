function [ averagePercentDeterminantError, averagePercentLowerMatrixPercentError, totalRandomizerRetries ] = massRandomCholTest (matrixSize, minRand, maxRand, testCount)
    totalPercentError = 0;
    totalLowerMatrixPercentError = zeros(matrixSize);

    % do a bunch of random tests based on given parameters, accumulate the
    % total
    totalRandomizerRetries = 0;
    for i = 1 : testCount
        [ determinantPercentError, lowerMatrixPercentError, randomMatrixGenerationAttempts ] = randomCholTest(matrixSize, minRand, maxRand);
        totalPercentError = totalPercentError + determinantPercentError;
        totalLowerMatrixPercentError = totalLowerMatrixPercentError + lowerMatrixPercentError;

        totalRandomizerRetries = totalRandomizerRetries + randomMatrixGenerationAttempts - 1;
    end

    % calculate the average from the total
    averagePercentDeterminantError = totalPercentError / testCount;
    averagePercentLowerMatrixPercentError = totalLowerMatrixPercentError ./ testCount;
end