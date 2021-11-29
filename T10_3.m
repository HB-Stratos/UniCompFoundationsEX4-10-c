1; clear; clc; close all; format compact;


M = ["MI"];
stepDepth = 10;

% for i=1:stepDepth
%     Mlater = M; %Mlater is used to not change M before all rules were applied
%     for j = 1, size(M, 2)
%        
%         %RULE1-----------------
%         rule1out = rule1(M(j))
%         if rule1out ~= ""
%             Mlater = [M, rule1out]; 
%         end
%         %RULE2-----------------
%         rule2out = rule2(M(j))
%         if rule2out ~= ""
%             Mlater = [M, rule2out]; 
%         end
%         %RULE3-----------------
%         rule3out = rule3(M(j))
%         if rule3out ~= ""
%             Mlater = [M, rule3out]; 
%         end
%         %RULE4-----------------
%         rule4out = rule4(M(j))
%         if rule4out ~= ""
%             Mlater = [M, rule4out]; 
%         end
% 
%     end
%     M = Mlater;
% end

mow = rule1("MUUIIUUUII")
meow = rule2("MUUIIUUUII")
meeow = rule3("MUUIIUUUIII")


%  xI => xIU
function ret = rule1(input)
    ret = "";
    inputChars = char(input);
    
    %If there are no I's return with empty array
    %if(sum(inputChars=='I') == 0) ,return; end %%Defunct, integrated later
   
    charIndex = findFirstInstanceOfChar(inputChars, 'I');
    if charIndex == 0, return; end %return empty if no char found

    ret = insertCharAt(inputChars, charIndex, 'U');
    ret = (convertCharsToStrings(ret));
end

%  Mx => Mxx
function ret = rule2(input)
    ret = "";
    inputChars = char(input);
   
    charIndex = findFirstInstanceOfChar(inputChars, 'M');
    if charIndex == 0, return; end %return empty if no char found

    if charIndex+1 > size(inputChars, 2), return; end %return empty if there is no char to be duplicated

    %toBeDuplicated = inputChars(charIndex + 1);
    %ret = insertCharAt(inputChars, charIndex + 1, toBeDuplicated);

    ret = [inputChars, inputChars(2:end)];
end

%  xIIIy => xUy
function ret = rule3(input)
    ret = "";
    inputChars = char(input);
   
    charIndex = findFirstInstanceOfChar(inputChars, 'I');
    if charIndex == 0, return; end %return empty if no char found
    if charIndex+2 > size(inputChars, 2), return; end %return empty if there is no space for two more chars for a tripple I

    if inputChars(charIndex+1) == 'I' && inputChars(charIndex+2) == 'I'
        ret = insertCharAt(inputChars, charIndex+2, 'U');
        ret = removeCharAt(charIndex);
        ret = removeCharAt(charIndex);
        ret = removeCharAt(charIndex);
    end
end

%  xUUy => xy
function ret = rule4(input)
    ret = [];

    
end


%https://de.mathworks.com/matlabcentral/answers/361458-add-character-in-a-certain-position-in-character-array-matlab2015b
function NewCharArray = insertCharAt( CharArray, Position, WhatToInsert)
  NewCharArray = char( strcat( cellstr(CharArray(:,1:Position)), cellstr(WhatToInsert), cellstr(CharArray(:, Position+1:end)) ) );
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

function charIndex = findFirstInstanceOfChar(input, charToFind)
    for charIndex = 1:size(input, 2)
        if(input(charIndex) == charToFind)
            return;
        end
    end
    charIndex = 0;
end

function charIndex = findInstanceOfCharAfterIndex(input, charToFind, findAfter)
    charIndex = findFirstInstanceOfChar(input(findAfter+1:end)) + findAfter;
end









