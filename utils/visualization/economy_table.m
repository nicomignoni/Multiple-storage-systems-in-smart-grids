function EconomyTable = economy_table(economy)

    communities = fieldnames(economy);
    for i=1:numel(communities) 
        indicators = fieldnames(economy.(communities{i}));
        for j=1:numel(indicators)
            summary(i,j) = sum(economy.(communities{i}).(indicators{j}), 'all');
        end
    end
    
    EconomyTable = array2table(summary, 'VariableNames', fieldnames(economy.Prosumers), ...
                                        'RowNames', communities);
end

