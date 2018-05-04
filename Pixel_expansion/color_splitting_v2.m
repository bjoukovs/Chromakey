clear all; close all;clc;
im=im2double(imread('test.png'));
%figure;imshow(im)
x0=1016;y0=1138;
[row,col,~] = size(im);
NBRE_REF=3;
ref_col=zeros(NBRE_REF,3);

ref_col(1,:) = [0.7765 0.1294 0.4235];
ref_col(2,:) = [0.6784 0.4078 0.2];
ref_col(3,:) = [1 1 1];

ref_col_lab=rgb2lab(ref_col);
im_lab=rgb2lab(im);

eps=38;
eps_mat=eps*ones(row,col);

%mat_ref_col1=ones(row,col);
%mat_ref_col1=mat_ref_col1.*[0.7765 0.1294 0.4235];

mat_ref_col1=repmat(ref_col(1,:),row,col);

