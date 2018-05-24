function output = UnMixing(rows,cols,image_YUV,image_double,spillingCoefficient,nb_classes,class_matrix,scribble_means,scribble_vars)

    %% VAR AND MEAN OF THE TRUE 
    vec_image = reshape(image_YUV, [], 1, size(image_double,3));
    nColors = nb_classes;
    for i=1:nColors    
        positions = find(class_matrix==i);
        pixels = vec_image(positions,1,:);

        original_means(i,1,:) = [mean(pixels(:,:,1)) mean(pixels(:,:,2)) mean(pixels(:,:,3))];
        original_vars(i,1,:) = [std(pixels(:,:,1)) std(pixels(:,:,2)) std(pixels(:,:,3))];    
    end

    %% Pixel transformation
    for x=1:cols
       for y=1:rows      
           index = class_matrix(y,x);
           image_YUV2(y,x,:) = scribble_means(index,1,:) + spillingCoefficient*scribble_vars(index, 1, :) .* ...
               ((image_YUV(y,x,:) - original_means(index, 1, :))./ original_vars(index, 1, :));

           if index == 1
              image_YUV2(y,x,:) = [0 0 0]; %black in YUV
              image_YUV(y,x,:) = [0 0 0]; %black in YUV
           end       
       end
    end

    image_keyed = yuv2rgb(image_YUV2);
%     image_original = yuv2rgb(image_YUV);
%     
%     figure; imshow(image_keyed);
%     figure; imshow(image_original);
    output = image_keyed;

end