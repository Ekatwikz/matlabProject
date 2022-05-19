format short;

fprintf("Test 1:\n");
[ averagePercentDeterminantError, averagePercentLowerMatrixPercentError ] = massRandomCholTest(3, -1, 1, 1000)

fprintf("Test 2:\n");
[ averagePercentDeterminantError, averagePercentLowerMatrixPercentError ] = massRandomCholTest(10, -100, -50, 1000)

fprintf("Test 3:\n");
[ averagePercentDeterminantError, averagePercentLowerMatrixPercentError ] = massRandomCholTest(4, 1000, 5000, 1000)

fprintf("Test 4:\n");
[ averagePercentDeterminantError, averagePercentLowerMatrixPercentError ] = massRandomCholTest(7, -0.0000000000000001, 0.0000000000000001, 1000)

fprintf("Test 5:\n");
%[ averagePercentDeterminantError, averagePercentLowerMatrixPercentError ] = massRandomCholTest(15, -50, 50, 1000)