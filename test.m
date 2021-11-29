1; clear; clc; close all; format compact;


rule3('MUIIIIIII')







function ret = rule3(in)
    %possiblePatterns = ['U',   '' ,    ''; 'UI',  'IU',   ''; 'UII', 'IUI', 'IIU'];
    ret = "";
    in = char(in);
    foundIs = find(in=='I');
    if size(in, 2) <= 3, return; end

    for i = 1:size(foundIs, 2)-2
        insertAt = 0;
        insertThis = [];
        %if a tripple I was found 
        if foundIs(i+1)==foundIs(i)+1 && foundIs(i+2)==foundIs(i)+2 
            insertAt = foundIs(i);
            insertThis = ['U--'];
            %if there are 4 consecutive Is
            if i+3 <= size(foundIs, 2) && foundIs(i+3)== foundIs(i)+3
                insertThis = ['UI--'; 'IU--'];
                %if there are 5 consecutive Is
                if i+4 <= size(foundIs, 2) && foundIs(i+4)== foundIs(i)+4
                    insertThis = ['UII--'; 'IUI--'; 'IIU--'];
                    %if there are 6 consecutive Is act as if it was three
                    if i+4 <= size(foundIs, 2) && foundIs(i+4)== foundIs(i)+4
                        insertThis = ['U--'];
                    end
                end
            end
            foundIs(i:i+size(insertThis, 2)-1) = -1;
            temp = in;
            for i = 1: size(insertThis, 1)
                temp(insertAt:insertAt+size(insertThis, 2)-1) = insertThis(i, 1:end);
                in = [in; temp];
            end
            in = in(2:end, 1:end);
        end

    end
    
    ret = [];
    for i = 1:size(in, 1)
        ret = [ret, convertCharsToStrings(cleanupCharArray(in(i, 1:end)))];
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