function output = quilt_simple(sample, outsize, patchsize, overlap, tol)

outh = outsize(1);
outw = outsize(2);
[sampleh, samplew, dim] = size(sample);
output = zeros(outh, outw, dim);

% choose a position of the sample randomly (top left corner)
sr = randi(sampleh - patchsize + 1);
sc = randi(samplew - patchsize + 1);
        
% copy the portion of the sample to the output image
output(1:1 + patchsize - 1, 1:1 + patchsize - 1, :) = sample(sr:sr + patchsize - 1, sc:sc + patchsize - 1, :);

for i = 1:patchsize-overlap:outh
    if i + patchsize - 1 > outh
        break;
    end
    for j = 1:patchsize-overlap:outw
        if j + patchsize - 1 > outw
            break;
        end
        
        % skip since we have already filled with a random sample
        if i == 1 && j == 1
            continue;
        end
        
        if i > 1 && j > 1
            type = 1;
            dy = overlap;
            dx = overlap;
        elseif j == 1
            type = 2;
            dy = overlap;
            dx = 0;
        else
            type = 3;
            dy = 0;
            dx = overlap;
        end
        
        output_patch = output(i:i + patchsize - 1, j:j + patchsize - 1, :);
        sample_patch = choose_sample(output_patch, sample, overlap, type, tol, 0, 0, 0);
        
        output(i + dy:i + patchsize - 1, j + dx:j + patchsize - 1, :) = sample_patch(dy + 1:patchsize, dx + 1:patchsize, :);
    end
end