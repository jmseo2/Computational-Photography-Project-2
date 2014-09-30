function sample_patch_res = choose_sample(output_patch, sample, overlap, type, tol, target_patch, prev_patch, num_itr)

patchsize = size(output_patch, 1);
[sampleh, samplew, d] = size(sample);
if type == 0 && sum(size(target_patch)) == 2
    sr = randi(sampleh - patchsize + 1);
    sc = randi(samplew - patchsize + 1);
    sample_patch_res = sample(sr:sr+patchsize-1, sc:sc+patchsize-1, :);
    return;
end

mask = compute_overlap_mask(patchsize, overlap, type);
if type == 0
    half = (patchsize - 1) / 2;
    overlap_error = zeros(sampleh - 2 * half, samplew - 2 * half, d); 
else
    overlap_error = ssd_patch(output_patch, sample, mask);
end

if sum(size(target_patch)) > 2
    alpha = 0.8 * (num_itr - 1) / 2 + 0.1;
    %alpha = 0.7;
    existing_error = ssd_patch(prev_patch, sample, ones(patchsize, patchsize, 3));
    correspondance_error = ssd_patch(target_patch, sample, ones(patchsize, patchsize, 3));
    if num_itr == 1
        ssd = alpha * overlap_error + (1 - alpha) * correspondance_error;
    else
        ssd = alpha * (overlap_error + existing_error) + (1 - alpha) * correspondance_error;
    end
else
    ssd = overlap_error;
end

ssd = ssd(:, :, 1) + ssd(:, :, 2) + ssd(:, :, 3);
min_ssd = min(min(ssd));

[y, x] = find(ssd <= min_ssd * (1 + tol));
num_elements = size(y);

rand_idx = randi(num_elements(1));
y_res = y(rand_idx);
x_res = x(rand_idx);

sample_patch_res = sample(y_res:y_res + patchsize - 1, x_res:x_res + patchsize - 1, :);

