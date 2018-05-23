function output = yuv2rgb(input)
    sz = size(input);
    width = sz(2);
    height = sz(1);
    
    input = reshape(input, [], 1, size(input,3));
    Y = input(:,:,1);
    U = input(:,:,2);
    V = input(:,:,3);
    
    R = Y + 1.139834576 * V;
    G = Y -.3946460533 * U -.58060 * V;
    B = Y + 2.032111938 * U;
    
    rgb(:,:,:) = [R G B];
    output = reshape(rgb, [height width 3]);
end