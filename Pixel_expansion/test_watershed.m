%% 
clear all; close all;clc;
im=im2double(imread('test.png'));
% figure;imshow(im)

[row,col,~] = size(im);
NBRE_REF=3;
ref_col=zeros(NBRE_REF,3);

%%%%%% TEST.PNG %%%%%%%%%%%%%%%%%%%%%%%%%%
NBRE_REF=3;
ref_col(1,:) = [0.7765 0.1294 0.4235];
ref_col(2,:) = [0.6784 0.4078 0.2];
ref_col(3,:) = [1 1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = rgb2gray(im);
% figure;imshow(img)
im_level = zeros(row,col,2);
im_level(:,:,1) = img;

dep = [img(floor(row/3), floor(col/3)), floor(row/3), floor(col/3)];
% im_level(dep) = 1;
x_dep = floor(row/3);
y_dep = floor(col/3);

new_img = zeros(row,col,2);

distance = 100;
eps = 10;
next = zeros(8,3);
next(1,:) = [x_dep+1,y_dep,img(x_dep+1,y_dep)];
next(2,:) = img(x_dep+1,y_dep+1);
next(3,:) = img(x_dep+1,y_dep-1);
next(4,:) = img(x_dep,y_dep+1);
next(5,:) = img(x_dep,y_dep-1);
next(6,:) = img(x_dep-1,y_dep);
next(7,:) = img(x_dep-1,y_dep+1);
next(8,:) = img(x_dep+1,y_dep-1);
tu = length(next);

next_p = zeros(row,col);
% 
% while distance < eps
%     for i = 1:tu
%         if im_level(next(i,1),next(i,2),2) != 1
%             temp=im_lab(next(i,3));
%             distance = norm(temp - dep(1));
%             if dist < eps
%                 new_img(next(i,1),next(i,2)) = dep(3);  %attribue au pixel la valeur du K level
%                 im_level(next(i,1),next(i,2),2) = 1;    %Dis que le pixel du level K+1 appartient � un K level            
%             end
%         end
%         %Create new voisins
%         next(
% 
%     end
%     %Create new voisins
%     new
% end
    
    



ref_col_lab=rgb2lab(ref_col);
im_lab=rgb2lab(im);
figure;imshow(im_lab(:,:,2:3));
