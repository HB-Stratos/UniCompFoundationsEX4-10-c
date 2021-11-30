%It still has a few bugs like not being able to process 14 consecutive I's
%because of a memory overflow. 
%Regardless, this took me 6 hours and I am quite proud of what I was able
%to achive. If not in code written here then in learning more about matlab.
%It is now 01:30am, I will be heading to bed. 

1; clear; clc; close all; format compact;


M = ["MI"];
% you can use this as a test
%rule1(M(end))
for i=1:10
    input_element = M(i);
    % apply all rules on this
    new = rule1(input_element);
    if strcmp(new,"") == 0
        M = [M,new]; % add this string for the future
    end
    new = rule2(input_element);
    if strcmp(new,"") == 0
        M = [M,new]; % add this string for the future
    end
    new = rule3(input_element);
    if strcmp(new{1},"") == 0
        M = [M,new]; % add this string for the future
    end
    new = rule4(input_element);
    if strcmp(new,"") == 0
        M = [M,new]; % add this string for the future
    end
    % repeat this code with rule2..4
    fprintf("== ITERATION %d ===", i);
    disp(M);
end



function ret = rule1(in)
ret = "";
in = char(in);
if in(end) == 'I'
    ret = [in,'U'];
    ret =convertCharsToStrings(ret);
end
end

function ret = rule2(in)
in = char(in);
ret = convertCharsToStrings([in, in(2:end)]);
end

%this function cannot be properly implemented as what would it do with 
% IIII - It could be UI or IU, but the function only allows a single output
%nevermind multiple outputs are possible
%there is a memory overflow in here that prevents more than 14 I's to be
%processed, but at this point I am done with this.
function out = rule3(in)
    out = "";
    inChars = char(in);
    foundIs = find(inChars=='I');
    if size(foundIs, 2) < 3, return; end %there can be no tripple I below this number
   
    %https://de.mathworks.com/matlabcentral/answers/540698-how-to-split-vector-according-to-conditions
    V = foundIs;
    d = find(diff([0 V]) > 1);
    p = diff([1 d numel(V)+1]);
    Out = mat2cell(V, 1, p);

    for i = 2:size(Out, 2)
        consecutiveIs = Out{i};
        amountOfIs = size(consecutiveIs, 2);
        if(amountOfIs < 3), continue; end
        maxNumberOfUs = floor(amountOfIs/3);
        allUpositions = cell(0);
        for ii = 1:maxNumberOfUs
            finalLength = amountOfIs - 2*ii;
            possibleUpositions = [1:ii, zeros(1, finalLength-ii)]~=0;
            possibleUpositions = unique(perms(possibleUpositions), 'rows');
            allUpositions = [allUpositions, mat2cell(possibleUpositions.', size(possibleUpositions, 2), ones(1, size(possibleUpositions, 1)))];
        end
        fills = generatePossibleFills(allUpositions, amountOfIs);
        
        
        startIndex = consecutiveIs(1, 1);
        if i==2
            for ii = 1:size(fills, 1)
                out = char(out);
                out(ii, :) = [inChars(1:startIndex-1), fills(ii, :), inChars(startIndex + size(fills, 2) : end) ];
            end
        else
            outLength = size(out, 1);
            for ii = 1:size(fills, 1)*size(out, 1)
                out = char(out);
                clampedii = mod(ii, outLength)+1;
                out(ii, :) = [out(clampedii, 1:startIndex-1), fills(1+mod(ii-1, size(fills, 1)), :), out(clampedii, startIndex + size(fills, 2) : end) ];
            end
        end

    end
    out = mat2cell(out, ones(1, size(out, 1)), size(out, 2));
    temp = cell(0);
    for i = 1:size(out, 1)
        temp(1, i) = {convertCharsToStrings(cleanupCharArray(out{i}))};
    end
    out = temp;
end

function ret = generatePossibleFills(cellArray, displacedLength)
    ret = [];
    for i = 1:size(cellArray, 2)
        currentVector = cellArray{i};
        temp = repmat('-', 1, displacedLength);
        for ii = 1:size(temp, 2)
            if ii > size(currentVector, 1), break; end
            if currentVector(ii) == 1
                temp(ii) = 'U';
            else
                temp(ii) = 'I';
            end
        end
        ret = [ret; temp];
    end

end


function ret = cleanupCharArray(in)
    for i = size(in, 2): -1 :1
        if in(i) == '-'
            in = removeCharAt(in, i);
        end
    end
    ret = in;
end



function out = rule4(in)
    out = "";
    in = char(in);
    i=1;
    ret = {};
    while i <= size(in, 2)
        if in(i) == 'U' && i+1 <= size(in, 2) && in(i+1) == 'U'
            in = removeCharAt(in, i);
            in = removeCharAt(in, i);
            ret = {ret, convertCharsToStrings(in)};
        end
        i = i+1;
    end
    if(size(ret, 2) ~= 0)
        out = ret(2:end);
    end
end





function ret = removeCharAt(CharArray, Position)
    ret = [CharArray(1, 1:Position-1), CharArray(1, Position+1:end)];
end