function boundaries = calBoundaries(ste, threshold)
    num_frames = length(ste);
    boundaries = [];
    for i = 2:num_frames-1
        if ste(i) > threshold && ste(i-1) < threshold
            boundaries = [boundaries i];
        elseif ste(i) < threshold && ste(i-1) > threshold
            boundaries = [boundaries i];
        end
    end
end
