function [ out ] = calcDistance(partImageMean, DBFunction)

    out = abs(cell2mat(DBFunction(:,2)) - partImageMean .* cell2mat(DBFunction(:,1))  ); 

end

