1;
clear; clc;
tbl = [1,2,4,8,16,32,64]
argument = 1.5
argument_integer = round(argument) % complete this turning argument into an integer that can be used to index arrays
conclusion_low = tbl(argument_integer)
conclusion_high = tbl(argument_integer+1)
fprintf("Conclusion of TypeCast Version: %f <= 2ˆ%.2f <= %f\n",conclusion_low, argument, conclusion_high)
