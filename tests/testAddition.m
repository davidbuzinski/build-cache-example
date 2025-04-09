classdef testAddition < matlab.unittest.TestCase
    methods (Test)
        function addTest(testCase)
            x = 2;
            y = 2;
            testCase.verifyEqual(add(x,y), 4);
        end
    end
end