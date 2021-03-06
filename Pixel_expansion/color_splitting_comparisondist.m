%% 
clear all; close all;clc;
im=im2double(imread('test.png'));
figure;imshow(im)
[row,col,~] = size(im);

NBRE_REF=3;
ref_col=zeros(NBRE_REF,3);

%%%%%% TEST.PNG %%%%%%%%%%%%%%%%%%%%%%%%%%
NBRE_REF=3;
ref_col(1,:) = [0.7765 0.1294 0.4235];
ref_col(2,:) = [0.6784 0.4078 0.2];
ref_col(3,:) = [1 1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST2.PNG %%%%%%%%%%%%%%%%%%%%%%%%%%
% NBRE_REF=5;
% ref_col(1,:) = [0.8 0.1059 0.1333];
% ref_col(2,:) = [0 0.302 0.5137];
% ref_col(3,:) = [0.8588 0.7137 0.6275];
% ref_col(4,:) = [0.5843 0.5176 0.3216];
% ref_col(5,:) = [1 1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ref_col_lab=rgb2lab(ref_col);
im_lab=rgb2lab(im);

im_dist = zeros(row,col,4);
imR = im_lab(:,:,1);
imG = im_lab(:,:,2);
imB = im_lab(:,:,3);
im_dist(:,:,1) = imR;
im_dist(:,:,2) = imG;
im_dist(:,:,3) = imB;
im_dist(:,:,4) = 1000;
%% 
im_para = zeros(row,col,3);
eps = 500; %to tune
temp=zeros(1,3);
for i = 1:row
    i
    for j = 1:col
        for k = 1:NBRE_REF
            temp(1,1)=im_dist(i,j,1);
            temp(1,2)=im_dist(i,j,2);
            temp(1,3)=im_dist(i,j,3);
            dist = norm(temp - ref_col_lab(k,:));
            if dist < eps
                if dist < im_dist(i,j,4);
                    im_dist(i,j,4) = dist;
                    im_para(i,j,:) = ref_col(k,:);
                end
            end
        end   
    end
end
figure;imshow(im_para)