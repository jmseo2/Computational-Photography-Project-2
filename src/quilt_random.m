function output = quilt_random(sample, outsize, patchsize)

outh = outsize(1);
outw = outsize(2);
[sampleh, samplew, dim] = size(sample);

output = zeros(outh, outw, dim);

for i = 1:patchsize:outh
    if i + patchsize - 1 > outh
        break;
    end
    for j = 1:patchsize:outw
        if j + patchsize - 1 > outw
            break;
        end
        % choose a position of the sample randomly (top left corner)
        sr = randi(sampleh - patchsize + 1);
        sc = randi(samplew - patchsize + 1);
        
        % copy the portion of the sample to the output image
        output(i:i + patchsize - 1, j:j + patchsize - 1, :) = sample(sr:sr + patchsize - 1, sc:sc + patchsize - 1, :);
    end
end