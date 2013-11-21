function cells = superFind(data, searchElements)
    cells = [];
    for s = 1:length(searchElements);
        cells = union(cells, find(strcmp(data,searchElements(s))));
    end
end