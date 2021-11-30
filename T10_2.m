1; clear; clc; close all; format compact;

eyeSize = 10;

check = eye(eyeSize);


AddingMatrix = [1];
for i = 1:eyeSize-1
        
    addedCollumnVector = zeros(i, 1);
    AddingMatrix = [AddingMatrix, addedCollumnVector];

    addedRowVector = zeros(1, i+1);
    addedRowVector(end) = 1;

    AddingMatrix = [AddingMatrix; addedRowVector];

end
disp("Adding Matrix is:")
disp(AddingMatrix);



FilledMatrix = zeros(eyeSize);
for i = 1:eyeSize

    FilledMatrix(i,i) = 1;

end
disp("Filled Matrix is:")
disp(FilledMatrix);





