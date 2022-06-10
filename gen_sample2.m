function sample = gen_sample(sample_size)
    sample = zeros(128,128);
    size1 = size(sample);
    sizex = size1(1);
    sizey = size1(2);
    for i = 1:128;
        for j = 1:128;
            x = randi([0 10000], 1, 1);
            if x > 9950;
                sample(i,j) = 1;
            end
        end
    end
    se = strel('disk',12,4);
    samplelarge = imdilate(sample, se);
    se = strel('disk',4,4);
    samplesmall = imdilate(sample, se);
    for i = 1:128;
        for j = 1:128;
            x = randi([0 10000], 1, 1);
            if samplesmall(i,j) == 1;
                sample(i,j) = 1;
            end
            if x>9998 && samplelarge(i,j) == 1
                sample(i,j) = 1;
                %can speed up if random number generated only if samplelarge = 1
            end
        end
    end
    se = strel('disk',6,4);
    sample = imdilate(sample, se);
    
end