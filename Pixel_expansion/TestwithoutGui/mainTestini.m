%% main
clear; close all;clc;

%% Image Loading
image = imread('test3.jpg');
figure;imshow(image), title('Original image');
[rows, cols, ~] = size(image);

%% Scribbles information
%Get scribble
load('values_GUI.mat');
[custom_color_AB, image_YUV, image_double,scribble_means,scribble_vars] = scribblesInfo(image,scribbles,custom_color);

%% Segmention
nb_classes = length(scribbles);
[segmented_images,class_matrix] = Segmentation_Kmeans(image,rows,cols,custom_color_AB,nb_classes);

for k = 1:nb_classes
    %plots the different classes
    figure; imshow(segmented_images{k});
end

%% Remove green spilling
spillingCoefficient = 1.5;

image_keyed = UnMixing(rows,cols,image_YUV,image_double,spillingCoefficient,nb_classes,class_matrix,scribble_means,scribble_vars);
figure; imshow(image_keyed);

%% Get the image with uniform color in the classes
spillingCoefficientUniform = 0;

image_uniform = UnMixing(rows,cols,image_YUV,image_double,spillingCoefficientUniform,nb_classes,class_matrix,scribble_means,scribble_vars);
figure; imshow(image_uniform);


