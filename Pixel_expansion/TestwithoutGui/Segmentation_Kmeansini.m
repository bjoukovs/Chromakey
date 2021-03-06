function [segmented_images,class_matrix] = Segmentation_Kmeans(image,rows,cols,custom_color_AB,nb_classes)


    %% Conversion to LAB space
    %Transform the RGB image into a new kind of color space, the LAB one, where
    %the L component represent the luminosity (don't use it here) and A and B
    %represent the two different color information used
    im_LAB = rgb2lab(image);

    %% Applying the K-means clustering method
    %keep the a and b component of Lab space
    im_AB = im_LAB(:,:,2:3);

    %reshape the obtained matrix (rowsxcolsx2) to get a 2columns matrix
    %(rows*colsx2). Need because the function kmeans needs such a input.
    im_AB_col = reshape(im_AB,rows*cols,2);
    %reshape column wise: put each column of the matrix below the previous one,
    %and each element contains 2 components (a and b), here they are put one
    %aside each other (that is why there are 2 columns in the matrix)

    %Specify the number of cathegories that we want (number on differents
    %zones/centro�des/classes used in the algorithm
    nb_classes = nb_classes;

    %A very important thing is to avoid begining with centroid in local minima
    %(his is due to the randomness initialization...) because in this case the
    %algorith won't evolve anymore. Thus we re-iterate the whole k-means
    %process nb_rep times
    nb_rep = 3;    %Chosen arbitrarly

    %Applyng teh K-means process by using a predifine matlab function
    %Input: the AB image matrix, the criterion of evalutaion (how to compute
    %the distance, may be euclidian or other...) and number of replication to
    %avoid local minima
    %Otput: a columns matrix (rows*colsx1) and for each element we have the
    %class to which belong the pixel AND the position of the different
    %centroide (not used).
    centroid_kmeans=repmat(custom_color_AB,1,1,nb_rep);
    %the third dimension of the centroid array must match the 'replicates' parameter value.
    [class_column, class_center] = kmeans(im_AB_col,nb_classes,'distance','sqEuclidean','Replicates',nb_rep,'Start',centroid_kmeans);

    %% Reshape again to get the matrical form back
    %reput in matricial form
    class_matrix = reshape(class_column,rows,cols);
    %plot the categories as grey levels
    imshow(class_matrix,[]), title('Image segmented with a gray level for each of the classes');

    %% Attribute colors from the true image to the categories
    segmented_images = cell(1,nb_classes);
    %Reply three times the matrix (in term of deepness), 1 step of deep for
    %each RGB channel
    rgb_label = repmat(class_matrix,[1 1 3]);

    %go througth the different classes
    for k = 1:nb_classes
        color = image;
        color(rgb_label ~= k) = 0; %put the pixels of the image copy ('color') to 0 if their category label
                                   %is different from the kth label that is
                                   %tested in the loop. The test is performed
                                   %on the 3 channels (R,G,B) at the same time 
        segmented_images{k} = color; %there is only the color of the category remaining
    end

end