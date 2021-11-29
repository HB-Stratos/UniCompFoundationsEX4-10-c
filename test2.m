1; clear; clc; close all; format compact;


rule3('MUIIIIIIIIIIUIIII')







function ret = rule3(in)
    %possiblePatterns = ['U',   '' ,    ''; 'UI',  'IU',   ''; 'UII', 'IUI', 'IIU'];
    ret = "";
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
            allUpositions = [allUpositions, mat2cell(possibleUpositions.', size(possibleUpositions, 2), ones(1, size(possibleUpositions, 1)))]
        end
        
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
    if Position == 0
        ret = CharArray(2:end);
    elseif Position == size(CharArray, 2)
        ret = CharArray(1:end-1);
    else
        ret = [CharArray(1, 1:Position-1), CharArray(1, Position+1:end)];
    end
end