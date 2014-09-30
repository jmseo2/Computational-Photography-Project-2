function ssd = ssd_patch(patch, sample, mask)
    patchsize = size(patch, 1);
    [sampleh, samplew, d] = size(sample);
    
    sample_fil1 = imfilter(sample.^2, mask);
    sample_fil2 = -2 * imfilter(sample, patch);
    sample_fil3 = imfilter(ones(sampleh, samplew, d), patch.^2);
    
    half = (patchsize - 1) / 2;
    ssd = sample_fil1 + sample_fil2 + sample_fil3;
    
    ssd = ssd(1+half:sampleh-half, 1+half:samplew-half, :);
