clear; close all;clc;
%% Image Loading
image = imread('test3.jpg');
% figure;imshow(image), title('Original image');
[rows, cols, ~] = size(image);


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
nb_classes = 3;

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

% x1 = 1:1:cols;
% x2 = 1:1:rows;
% [x1G,x2G] = meshgrid(x1,x2);
% XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

[class_column, class_center] = kmeans(im_AB_col,nb_classes,'distance','sqEuclidean','Replicates',nb_rep);

class_centroid=[class_center(:,2)+floor(cols/2) class_center(:,1)+floor(rows/2)];
%% Reshape again to get the matrical form back
%reput in matricial form
class_matrix = reshape(class_column,rows,cols);
%plot the categories as grey levels
imshow(class_matrix,[]), title('Image segmented with a gray level for each of the classes');

%% Attribute colors from scribbles
% %Supose we 
% load('values_GUI.mat'); %gives scribbles
% [a,b]=size(scribbles);
% %In order to define to which color we assign each classes we use the mean
% %value of the scribbles
% means=cell(1,b); %will contain the mean_scrib
% 
% %We are investigate each scribbles
% for k=1:b
%     pos = scribbles{1,k};
%     [c,d] = size(pos);    
%     %%%to ignore the first value which is 0,0
%     temp = zeros(c-1,2);
%     temp(:,1) = pos(2:end,1);
%     temp(:,2) = pos(2:end,2);
%     pos = temp;
%     %%%    
%     [c,d]=size(pos);
%     col_points=zeros(c,1,3);
%     for i=1:c
%         col_points(i,1,:)=im(pos(i,1),pos(i,2),:);
%     end
%     %mean_scrib(1,k)=mean(col_points,3); 
%     mean_scrib=zeros(3,1);
%     %make the mean on each RGB channel of the k-scribble
%     for j=1:3
%         mean_scrib(j)=mean(col_points(:,:,j));
%     end
%     means{1,k}=mean_scrib;
% end
% 
% %Attribuate to each classes a color given by the mean of the scrible, to do
% %so we take the centro�d position of the class, take its rgb color and see
% %to which closestmean scriblles color is it
% %autant de class que de scribbles??
% class_color = zeros(length(class_center),2);
% class_color(:,1) = (1:nb_classes)';
% for i=1:length(class_center)
%     temp=zeros(1,3);
%     temp(1,1)=image(class_center(i),1);
%     temp(1,2)=image(class_center(i),2);
%     temp(1,3)=image(class_center(i),3);
%     for j=1:nb_classes
%         dist = norm(temp - means{1,j});
%         if dist < eps
%             class_color(i,2) = means{1,j};
%         end
%     end
% end
% 
% %Attribuate to each pixel of class i the color carresponding
% im_uniform = zeros(rows,cols,3);
% for i=1:rows
%     for j=1:cols
%         for k=1:nb_classes
%             if(class_matrix(i,j) == k)
%                 im_uniform(i,j) = class_color(k,2);
%             end            
%         end
%     end
% end
% 
% imshow(im_uniform), title('Image segmented with scribbles mean colors');

%% Attribute colors from the true image to the categories
segmented_images = cell(1,nb_classes);
rgb_label = repmat(class_matrix,[1 1 3]); %replique 3 fois en profondeur, 1 etage de profondeur par channel (R,G,B)

for k = 1:nb_classes %go on the categories
    color = image;
    color(rgb_label ~= k) = 0; %put the pixels of the image copy ('color') to 0 if their category label
                               %is different from the kth label that is
                               %tested in the loop. The test is performed
                               %on the 3 channels (R,G,B) at the same time 
    segmented_images{k} = color; %there is only the color of the category remaining
    figure;
    imshow(segmented_images{k}); %plots the different categories
end

%% Extra K_means on the obtained images
%test on the hand plus tester
% jj = segmented_images{1};
% lab_jj = rgb2lab(jj);
% ab = lab_jj(:,:,2:3);
% nrows = size(ab,1);
% ncols = size(ab,2);
% ab = reshape(ab,nrows*ncols,2);
% nColors = 2;
% [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',3);
% pixel_labels = reshape(cluster_idx,nrows,ncols);
% imshow(pixel_labels,[]), title('image labeled by cluster index');
% segmented_images = cell(1,3);
% rgb_label = repmat(pixel_labels,[1 1 3]);
% for k = 1:nColors
%     color = jj;
%     color(rgb_label ~= k) = 0;
%     segmented_images{k} = color;
%     figure;imshow(segmented_images{k}), title('objects in cluster');
% end

% en faire une fonction??

%% TO DO
% - to refine: perform a K-means on one of the "filtered" image: par ex sur
% test3.jpg les ongles et la barre en plastique sont mis dans la meme
% categorie, donc on pourrait faire k-means sur cette categories apr�s
% - put the starting centroids of k-means by user interaction with the GUI
% - 