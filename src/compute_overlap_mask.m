function mask = compute_overlap_mask(patchsize, overlap, type)

mask = zeros(patchsize, patchsize, 3);
% L shape overlap
if type == 1
    mask(1:overlap, :, :) = ones(overlap, patchsize, 3);
    mask(:, 1:overlap, :) = ones(patchsize, overlap, 3);
% norizontal overlap
elseif type == 2
    mask(1:overlap, :, :) = ones(overlap, patchsize, 3);
% vertical overlap
else
    mask(:, 1:overlap, :) = ones(patchsize, overlap, 3);
end