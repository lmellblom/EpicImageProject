function [ out ] = calcDistance(partImageMean, DBFunction)


    %out = abs(cell2mat(DBFunction(:,2)) - partImageMean .* cell2mat(DBFunction(:,1))  ); 
    
    % ||p||^2 + ||q||^2 - 2*p*q , p=databas, q=inbild
    p2 = cell2mat(DBFunction(:,2))';
    p = cell2mat(DBFunction(:,1))';
    q = partImageMean';
    
    out = sqrt(abs(sum(p.*p + q.*q - 2*p.*q))); 

end

