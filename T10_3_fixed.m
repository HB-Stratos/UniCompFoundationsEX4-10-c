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
function ret = rule3(in)
    possiblePatterns = ['U',   '' ,    '';
                        'UI',  'IU',   '';
                        'UII', 'IUI', 'IIU'];
    ret = "";
    in = char(in);
    foundIs = find(in=='I');
    if size(in, 2) <= 3, return; end

    for i = 1:size(foundIs, 2)-2
        %if a tripple I was found 
        if foundIs(i+1)==foundIs(i)+1 && foundIs(i+2)==foundIs(i)+2 
            if i+4 <= size(foundIs, 2) && fou
        end
    end

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