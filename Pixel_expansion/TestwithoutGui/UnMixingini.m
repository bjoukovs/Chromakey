<<<<<<< HEAD:Pixel_expansion/TestwithoutGui/UnMixing.m
function output = UnMixing(rows,cols,image_YUV,image_double,spillingCoefficient,nb_classes,class_matrix,scribble_means,scribble_vars)
=======
function output = UnMixing(image_double,spillingCoefficient,nb_classes,class_matrix,scribble_means,scribble_vars,backgrounds, luminanceCorrection,corrections)


    [rows,cols, ~] = size(image_double);
    
    image_YUV = rgb2yuv(image_double);
>>>>>>> origin/master:Pixel_expansion/UnMixing.asv

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
<<<<<<< HEAD:Pixel_expansion/TestwithoutGui/UnMixing.m
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
=======
    lumCor = zeros(1,1,3);
    lumCor(1,1,1) = luminanceCorrection;
    
    class_matrix_vec = reshape(class_matrix, rows*cols,1);
    original_mean_matrix = zeros(rows*cols,1,3);
    original_var_matrix = zeros(rows*cols,1,3);
    scribble_mean_matrix = zeros(rows*cols,1,3);
    scribble_var_matrix = zeros(rows*cols,1,3);
    
    for i=1:nColors
        positions = find(class_matrix_vec==i);
        
        if backgrounds{1,i} == 1
            scribble_mean_matrix(positions,1,:) = zeros(length(positions),1,3);
            scribble_var_matrix(positions,1,:) = zeros(length(positions),1,3);
            original_mean_matrix(positions,1,:) = ones(length(positions),1,3).*original_means(i, 1,:);
            original_var_matrix(positions,1,:) = ones(length(positions),1,3).*original_vars(i, 1,:);
        else
            if corrections==1
                scribble_mean_matrix(positions,1,2:3) = ones(length(positions),1,2).*scribble_means(i, 1,2:3);
                scri
                
                scribble_var_matrix(positions,1,:) = spillingCoefficient*ones(length(positions),1,3).*scribble_vars(i, 1,:);
                original_mean_matrix(positions,1,:) = ones(length(positions),1,3).*original_means(i, 1,:);
                original_var_matrix(positions,1,:) = ones(length(positions),1,3).*original_vars(i, 1,:);
            else
                scribble_mean_matrix(positions,1,:) = zeros(length(positions),1,3);
                scribble_var_matrix(positions,1,:) = ones(length(positions),1,3);
                original_mean_matrix(positions,1,:) = zeros(length(positions),1,3);
                original_var_matrix(positions,1,:) = ones(length(positions),1,3);
            end
        end
>>>>>>> origin/master:Pixel_expansion/UnMixing.asv
    end
    
    image_YUV2_vec = reshape(image_YUV,rows*cols,1,3);
    
    image_YUV2_vec = scribble_mean_matrix + scribble_var_matrix .* (image_YUV2_vec - original_mean_matrix) ./ original_var_matrix;
      
    image_YUV2 = reshape(image_YUV2_vec,rows,cols,3);
    
%     for x=1:cols
%        for y=1:rows
%            
%            index = class_matrix(y,x);
%             
%            %Background color should be plotted black
%            if backgrounds{1,index} == 1
%               image_YUV2(y,x,:) = [0 0 0]; %black in YUV
%               image_YUV(y,x,:) = [0 0 0]; %black in YUV
%            else
%                
%                if corrections == 1
%                     image_YUV2(y,x,:) = lumCor + scribble_means(index,1,:) + spillingCoefficient*scribble_vars(index, 1, :) .* ...
%                    ((image_YUV(y,x,:) - original_means(index, 1, :))./ original_vars(index, 1, :));
%                else
%                    image_YUV2(y,x,:) = image_YUV(y,x,:);
%            end
%        end
%     end

    image_keyed = yuv2rgb(image_YUV2);
%     image_original = yuv2rgb(image_YUV);
%     
%     figure; imshow(image_keyed);
%     figure; imshow(image_original);
    output = image_keyed;

end