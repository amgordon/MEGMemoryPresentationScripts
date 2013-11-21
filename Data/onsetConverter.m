function a = onsetConverter(indices,phase)
%% converts index numbers to onsets for each phase

% one scan = Bstudy + CStudy
% for the Btudy phase, each trial = 12s [4s cue, 8s baseline]. We also need
% to add the time of each AC block or 310s.
% for the Cstudy phase, each trial = 16s [2s cue, 6s instruction, 8s
% baseline] plus 238s [216s for the BStudy segement of the scan plus 22s delay in between B and C Study] 

if strcmp(phase,'BStudy')
    fields = fieldnames(indices);
    for f = 1:length(fields)
        indices.(fields{f}) = (indices.(fields{f})-1)*12 + floor((indices.(fields{f})-1)/18)*310;
    end
elseif strcmp(phase,'CStudy')
    fields = fieldnames(indices);
    for f = 1:length(fields)
        indices.(fields{f}) = (indices.(fields{f})-1)*16 + ceil(indices.(fields{f})/18)*238;
    end
end
a = indices;

