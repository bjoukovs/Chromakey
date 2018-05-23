clear; close all;clc;
%% Image conversion to L*a*b*
he = imread('test3.jpg');
figure;
imshow(he), title('H&E image');
lab_he = rgb2lab(he);

%% K-means clustering
ab = lab_he(:,:,2:3); %keep the a and b component of Lab space
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2); %transforme en un vecteur colonne à 2 colonnes: une matrice nrows*ncol x 2
%reshape column wise: put each column of the matrix below the previous one,
%and each element contains 2 components (a and b), here they are put one
%aside each other (that is why there are 2 columns in the matrix)

nColors = 4; %nbre of classes
% re-iterate the whole k-means process NBRE_REPEAT times to avoid local
% minima because the beginning of k-means is random initialization of
% centroids so due to this randomness we have to repeat the process
NBRE_REPEAT = 3;
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',NBRE_REPEAT);
% for each pixel, kmeans gives the index of the category to which it belongs
%% Reput in matricial form                                 
pixel_labels = reshape(cluster_idx,nrows,ncols); %reput in matricial form
imshow(pixel_labels,[]), title('image labeled by cluster index'); %plot the categories as grey levels

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

%% TO DO
% - to refine: perform a K-means on one of the "filtered" image: par ex sur
% test3.jpg les ongles et la barre en plastique sont mis dans la meme
% categorie, donc on pourrait faire k-means sur cette categories après
% - put the starting centroids of k-means by user interaction with the GUI
% - 