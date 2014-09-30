function output = texture_transfer(sample, outsize, patchsize, overlap, tol, target, max_num_itr)

prev_img = zeros(outsize(1), outsize(2), 3);
for i = 1:max_num_itr
    img = quilt_cut(sample, outsize, patchsize, overlap, tol, target, prev_img, i);
    prev_img = img;
    patchsize = round(patchsize / 2);
    overlap = overlap - 1;
    figure(i);
    imshow(prev_img);
end

output = prev_img;