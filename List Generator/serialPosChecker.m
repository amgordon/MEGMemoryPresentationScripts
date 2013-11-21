function [ check ] = serialPosChecker(list,conditions,stdev)
   

for con = 1:length(conditions)
    avgPos(con) = mean(find(strcmp(conditions{con},list)));
end

sd = std(avgPos);


if sd<stdev
    check = 1;
else
    check = 0;
end

end

