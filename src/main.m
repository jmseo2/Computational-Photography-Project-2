sample = im2single(imread('../images/grass.jpg'));
target = im2single(imread('../images/bear.jpg'));
disp(size(sample));
sample = sample(1:120, 1:120, :);
[sampleh, samplew, d] = size(sample);

[targeth, targetw, d2] = size(target);
outsize = [targeth, targetw];
patchsize = 29;

figure(10);
imshow(sample);

%quilt1 = quilt_random(sample, outsize, patchsize);
%figure(2);
%imshow(quilt1);

%patch1 = sample(50:50 + patchsize - 1, 50:50 + patchsize - 1, :);
%patch2 = sample(140:140+patchsize-1, 140:140+patchsize-1, :);

%figure(5);
%imshow(patch1);
%figure(6);
%imshow(patch2);

%overlap1 = patch1(patchsize - 4:patchsize, :, :);
%overlap2 = patch2(1:5, :, :);

%ssd = (overlap1 - overlap2).^2;
%figure(7);
%imagesc(ssd);
%hold on
%cut(ssd);

%quilt2 = quilt_simple(sample, outsize, patchsize, 5, 0.1);
%figure(3);
%imshow(quilt2);

%quilt3 = quilt_cut(sample, outsize, patchsize, 5, 0.1, 0, 0, 0);
%figure(4);
%imshow(quilt3);

quilt4 = texture_transfer(sample, outsize, patchsize, 4, 0.05, im2double(target), 3);
figure(8);
imshow(quilt4);

