function output = quilt_cut(sample, outsize, patchsize, overlap, tol, target, prev_img, num_itr)

outh = outsize(1);
outw = outsize(2);
output = zeros(outh, outw, 3);
        
for i = 1:patchsize-overlap:outh
    if i + patchsize - 1 > outh
        break;
    end
    for j = 1:patchsize-overlap:outw
        if j + patchsize - 1 > outw
            break;
        end

        if i == 1 && j == 1
            type = 0;
        elseif i > 1 && j > 1
            type = 1;
        elseif j == 1
            type = 2;
        else
            type = 3;
        end
        
        target_patch = 0;
        prev_patch = 0;
        if sum(size(target)) > 2
            target_patch = target(i:i + patchsize - 1, j:j + patchsize - 1, :);
            prev_patch = prev_img(i:i + patchsize - 1, j:j + patchsize - 1, :);
        end
        
        output_patch = output(i:i + patchsize - 1, j:j + patchsize - 1, :);
        sample_patch = choose_sample(output_patch, sample, overlap, type, tol, target_patch, prev_patch, num_itr);
        
        ssd_patch = (output_patch - sample_patch).^2;
        
        mask = zeros(patchsize, patchsize);
        if type == 1 || type == 2
            top_mask = [cut(ssd_patch(1:overlap, :, :)); zeros(patchsize-overlap, patchsize)];
            mask = mask | top_mask;
        end
        if type == 1 || type == 3
            transpose = zeros(overlap, patchsize, 3);
            for k = 1:3
                transpose(:, :, k) = ssd_patch(:, 1:overlap, k).';
            end
            left_mask = [cut(transpose).', zeros(patchsize, patchsize-overlap)];
            mask = mask | left_mask;
        end
        
        mask2 = ones(patchsize, patchsize) - mask;
        for k = 1:3
            output_patch(:, :, k) = output_patch(:, :, k) .* mask;
            sample_patch(:, :, k) = sample_patch(:, :, k) .* mask2 + output_patch(:, :, k);
        end
        
        output(i:i + patchsize - 1, j:j + patchsize - 1, :) = sample_patch;
    end
end