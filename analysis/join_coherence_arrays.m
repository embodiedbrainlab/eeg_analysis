cd D:\dance_brain_study\final_arrays

filenames = dir;

file_index = 3:length(filenames);
array_index = 1:192:192*132;
finaldata = cell(25344,7);

for k = 1:numel(file_index)
    dataset = readcell(filenames(file_index(k)).name);
    finaldata(array_index(k):(array_index(k)+191),:) = dataset;
end

writematrix(finaldata,'D:\dance_brain_study\final_coherence_array.csv')

