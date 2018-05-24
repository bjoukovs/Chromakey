function [custom_color_AB, image_YUV,image_double,scribble_means,scribble_vars] = scribblesInfo(image,scribbles,custom_color)

    %% Take centroids of the scribbles, warning: centroids are in color space not
    %in geometrical space so the centroids that we need are centroid in the lab
    %space for the kmeans clustering: we will tell the kmeans to begin with the
    %centroids of the scribbles There is te same number of scribbles than the
    %number of classes
    [a,nb_classes]=size(scribbles);
    %custom_color_AB, contains the CENTROIDS of the scribbles, computation was
    %done in the GUI
    custom_color_AB = zeros(nb_classes,2);

    for p=1:nb_classes
        custom_color_lab = rgb2lab(custom_color{1,p});
        custom_color_AB(p,:) = custom_color_lab(2:3);
    end

    %Extracting mean and variance in YUV space (to remove green spilling after K-means)
    image_double = im2double(image);
    image_YUV = rgb2yuv(image_double);

    for i=1:length(scribbles)
        sz = size(scribbles{i});
        n = sz(1)-1;   
        positions = [scribbles{i}(2:end,2) scribbles{i}(2:end,1)];
        pixels = [];    
        for j=1:n
           pixels = [pixels image_YUV(positions(j,1),positions(j,2),:)] ;
        end
        scribble_means(i,1,:) = [mean(pixels(:,:,1)) mean(pixels(:,:,2)) mean(pixels(:,:,3))];
        scribble_vars(i,1,:) = [std(pixels(:,:,1)) std(pixels(:,:,2)) std(pixels(:,:,2))];
    end
end
