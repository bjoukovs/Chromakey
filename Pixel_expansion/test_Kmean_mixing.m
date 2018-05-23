clear; close all;clc;


%% Image conversion to L*a*b*
he = imread('test3.jpg');
figure;
imshow(he), title('H&E image');
lab_he = rgb2lab(he);



%% Get scribble info

load('ScribbleTest.mat')

he_double = im2double(he);


for i=1:length(scribbles)
    
    sz = size(scribbles{i});
    n = sz(1)-1;
   
    positions = [scribbles{i}(2:end,2) scribbles{i}(2:end,1)];
    pixels = [];
    
    for j=1:n
       pixels = [pixels he_double(positions(j,1),positions(j,2),:)] 
    end
    
    scribble_means(i,1,:) = [mean(mean(pixels(:,:,1))) mean(mean(pixels(:,:,2))) mean(mean(pixels(:,:,3)))];
    scribble_vars(i,1,:) = [std(pixels(:,:,1)) std(pixels(:,:,2)) std(pixels(:,:,2))]
    
end



%% K-means clustering
ab = lab_he(:,:,2:3); %keep the a and b component of Lab space
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2); %transforme en un vecteur colonne à 2 colonnes: une matrice nrows*ncol x 2
%reshape column wise: put each column of the matrix below the previous one,
%and each element contains 2 components (a and b), here they are put one
%aside each other (that is why there are 2 columns in the matrix)

nColors = 3; %nbre of classes
% re-iterate the whole k-means process NBRE_REPEAT times to avoid local
% minima because the beginning of k-means is random initialization of
% centroids so due to this randomness we have to repeat the process
NBRE_REPEAT = 3;
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',NBRE_REPEAT);
% for each pixel, kmeans gives the index of the category to which it belongs
%% Reput in matricial form                                 
pixel_labels = reshape(cluster_idx,nrows,ncols); %reput in matricial form
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
    %figure;
    %imshow(segmented_images{k}); %plots the different categories
end


%% VAR AND MEAN OF THE TRUE 

load('good_regions.mat')

vec_image = reshape(he_double, [], 1, size(he_double,3));


for i=1:nColors
    
    positions = find(pixel_labels==i);
    pixels = vec_image(positions,1,:);
    
    original_means(i,1,:) = [mean(pixels(:,:,1)) mean(pixels(:,:,2)) mean(pixels(:,:,3))];
    original_vars(i,1,:) = [std(pixels(:,:,1)) std(pixels(:,:,2)) std(pixels(:,:,3))];
    
end



%% Pixel transformation

for x=1:ncols
   for y=1:nrows
      
       index = pixel_labels(y,x);
       
       %he_double(y,x,:) = original_means(index,1,:) + original_vars(index, 1, :) .* ((he_double(y,x,:) - original_means(index, 1, :) ./ original_vars(index, 1, :)));
       he_double(y,x,:) = scribble_means(index,1,:) + (he_double(y,x,2) - original_means(index, 1, 2));
       
       if index == 1
          he_double(y,x,:) = [0 0 0]; 
       end
       
   end
end

figure
imshow(he_double)

%% TO DO
% - to refine: perform a K-means on one of the "filtered" image: par ex sur
% test3.jpg les ongles et la barre en plastique sont mis dans la meme
% categorie, donc on pourrait faire k-means sur cette categories après
% - put the starting centroids of k-means by user interaction with the GUI
% - 