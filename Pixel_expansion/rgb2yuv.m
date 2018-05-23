function output = rgb2yuv(input)
    sz = size(input);
    width = sz(2);
    height = sz(1);
    
    input = reshape(input, [], 1, size(input,3));
    R = input(:,:,1);
    G = input(:,:,2);
    B = input(:,:,3);

    Y = 0.299 * R + 0.587 * G + 0.114 * B;
    U = -0.14713 * R - 0.28886 * G + 0.436 * B;
    V = 0.615 * R - 0.51499 * G - 0.10001 * B;
    
    yuv(:,:,:) = [Y U V];
    output = reshape(yuv, [height width 3]);
end