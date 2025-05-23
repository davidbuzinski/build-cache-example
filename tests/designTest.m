function tests = designTest
tests = functiontests(localfunctions); 
end

function testSettlingTime(testCase) 
%%Test that the system settles to within 0.001 of zero under 2 seconds.

pause(1);
[position, time] = simulateSystem(springMassDamperDesign); 

positionAfterSettling = position(time > 2);


verifyEqual(testCase, positionAfterSettling, repmat(0,size(positionAfterSettling)), 'AbsTol', .001);
end

function testOvershoot(testCase)
 %Test to ensure that overshoot is less than 0.1

pause(1);
[position, ~] = simulateSystem(springMassDamperDesign);
overshoot = max(position);

verifyLessThan(testCase, overshoot, 0.1);
end

function testInvalidInput(testCase)
% Test to ensure we fail gracefully with bogus input

pause(1);
testCase.verifyError(@() simulateSystem('bunk'), ...
   'simulateSystem:InvalidDesign:ShouldBeStruct');
end

function testDampingTypes(testCase)
pause(1);
[~, ~] = simulateSystem(springMassDamperDesign("underdamped"));
[~, ~] = simulateSystem(springMassDamperDesign("overdamped"));
[~, ~] = simulateSystem(springMassDamperDesign("nicelydamped"));
[~, ~] = simulateSystem(springMassDamperDesign("criticallydamped",1000));
end


% function testWithInvalidStructInput(testCase)
% % Test to ensure we fail gracefully with bogus input
% 
% bunkStruct = struct;
% testCase.verifyError(@() simulateSystem(bunkStruct), ...
%    'simulateSystem:InvalidDesign:ShouldBeStruct');
% end


