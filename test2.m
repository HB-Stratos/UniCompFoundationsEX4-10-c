1; clear; clc; close all; format compact;


rule3('MIIIIIIIIIIIIIIII')







function out = rule3(in)
    %possiblePatterns = ['U',   '' ,    ''; 'UI',  'IU',   ''; 'UII', 'IUI', 'IIU'];
    out = "";
    inChars = char(in);
    foundIs = find(inChars=='I');
    if size(in, 2) <= 3, return; end %there can be no tripple I below this number
   
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


function ret = removeCharAt(CharArray, Position)
    ret = [CharArray(1, 1:Position-1), CharArray(1, Position+1:end)];
end