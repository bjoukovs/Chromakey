clear; close all;clc;

SPILLING_COEFF = 1.5; %The higher, the less the spilling is removed

%% Image conversion to L*a*b*
he = imread('test3.jpg');
figure;
imshow(he), title('H&E image');
lab_he = rgb2lab(he);

ab = lab_he(:,:,2:3); %keep the a and b component of Lab space

rows = size(ab,1);
cols = size(ab,2);

%% Get scribble info
%load('ScribbleTest.mat')
load('values_GUI.mat');

%% Take centroids of the scribbles, warning: centroids are in color space not in geometrical space
% so the centroids that we need are centroid in the lab space for the
% kmeans clustering: we will tell the kmeans to begin with the centroids of
% the scribbles
[a,b]=size(scribbles); %b=nbre class = nbre of custom colors
custom_color_AB = zeros(b,2); %contains the CENTROIDS of the scribbles, computation was done in the GUI
for p=1:b
    custom_color_lab = rgb2lab(custom_color{1,p});
    custom_color_AB(p,:) = custom_color_lab(2:3)
end

%% Extracting mean and variance in YUV space (to remove green spilling after K-means)
he_double = im2double(he);

he_YUV = rgb2yuv(he_double);

%he_YUV = rgb2ycbcr(he_double); %YUV conversion

for i=1:length(scribbles)
    
    sz = size(scribbles{i});
    n = sz(1)-1;
   
    positions = [scribbles{i}(2:end,2) scribbles{i}(2:end,1)];
    pixels = [];
    
    for j=1:n
       pixels = [pixels he_YUV(positions(j,1),positions(j,2),:)] 
    end
    
    scribble_means(i,1,:) = [mean(pixels(:,:,1)) mean(pixels(:,:,2)) mean(pixels(:,:,3))];
    scribble_vars(i,1,:) = [std(pixels(:,:,1)) std(pixels(:,:,2)) std(pixels(:,:,2))]
    
end


%% K-means clustering
ab = reshape(ab,rows*cols,2); %transforme en un vecteur colonne � 2 colonnes: une matrice nrows*ncol x 2
%reshape column wise: put each column of the matrix below the previous one,
%and each element contains 2 components (a and b), here they are put one
%aside each other (that is why there are 2 columns in the matrix)

nColors = b; %nbre of classes, b comes from the size of the scribbles cell


% re-iterate the whole k-means process NBRE_REPEAT times to avoid local
% minima because the beginning of k-means is random initialization of
% centroids so due to this randomness we have to repeat the process
NBRE_REPEAT = 3;
centroid_kmeans=repmat(custom_color_AB,1,1,NBRE_REPEAT); %the third dimension of the centroid array must match the 'replicates' parameter value.
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',NBRE_REPEAT,'Start',centroid_kmeans);
% for each pixel, kmeans gives the index of the category to which it belongs

%% Reput in matricial form                                 
pixel_labels = reshape(cluster_idx,rows,cols); %reput in matricial form
%imshow(pixel_labels,[]), title('image labeled by cluster index'); %plot the categories as grey levels

%% Attribute colors from scribbles

%% Attribute colors from the true image to the categories
segmented_images = cell(1,nColors);
rgb_label = repmat(pixel_labels,[1 1 3]); %replique 3 fois en profondeur, 1 etage de profondeur par channel (R,G,B)

for k = 1:nColors %go on the categories
    color = he;
    color(rgb_label ~= k) = 0; %put the pixels of the image copy ('color') to 0 if their category label
                               %is different from the kth label that is
                               %tested in the loop. The test is performed
                               %on the 3 channels (R,G,B) at the same time 
    segmented_images{k} = color; %there is only the color of the category remaining
    figure;
    imshow(segmented_images{k}); %plots the different categories
end


%% VAR AND MEAN OF THE TRUE 

%load('good_regions.mat')

vec_image = reshape(he_YUV, [], 1, size(he_double,3));

for i=1:nColors
    
    positions = find(pixel_labels==i);
    pixels = vec_image(positions,1,:);
    
    original_means(i,1,:) = [mean(pixels(:,:,1)) mean(pixels(:,:,2)) mean(pixels(:,:,3))];
    original_vars(i,1,:) = [std(pixels(:,:,1)) std(pixels(:,:,2)) std(pixels(:,:,3))];
    
end

%% Pixel transformation

for x=1:cols
   for y=1:rows
      
       index = pixel_labels(y,x);
       
       %he_double(y,x,:) = scribble_means(index,1,:) + scribble_vars(index, 1, :) .* ((he_double(y,x,:) - original_means(index, 1, :) ./ original_vars(index, 1, :)));
       %he_double(y,x,:) = scribble_means(index,1,:) + (he_double(y,x,2) - original_means(index, 1, 2));
       
       he_YUV2(y,x,:) = scribble_means(index,1,:) + SPILLING_COEFF*scribble_vars(index, 1, :) .* ...
           ((he_YUV(y,x,:) - original_means(index, 1, :))./ original_vars(index, 1, :));
       %he_YUV(y,x,2:3) = scribble_means(index,1,2:3) + 0.1*(he_YUV(y,x,2:3) - original_means(index, 1, 2:3));
       
       if index == 1
          he_YUV2(y,x,:) = [0 0 0]; %black in YUV
          he_YUV(y,x,:) = [0 0 0]; %black in YUV
       end
       
   end
end

he_keyed = yuv2rgb(he_YUV2);
he_original = yuv2rgb(he_YUV);

figure
imshow(he_keyed);
figure
imshow(he_original);

%% TO DO
% - to refine: perform a K-means on one of the "filtered" image: par ex sur
% test3.jpg les ongles et la barre en plastique sont mis dans la meme
% categorie, donc on pourrait faire k-means sur cette categories apr�s
% - put the starting centroids of k-means by user interaction with the GUI: DONE
% - 