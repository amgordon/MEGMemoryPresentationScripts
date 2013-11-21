% A simple function that lets you find unions of more than two sets of
% vectors.

function final_vector = superUnion(vectors)
    final_vector = [];
    for v = vectors; 
        final_vector = union(final_vector, v);
    end
end