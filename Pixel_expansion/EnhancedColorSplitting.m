%% Initialization
clear all; close all;clc;
im=im2double(imread('test.png'));
%figure;imshow(im)
x0=1016;y0=1138;
[row,col,~] = size(im);

% Ehancment, unify the color
imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);

H = fspecial('average',40); %simple averaging filter
imRS = conv2(imR,H,'same');
imGS = conv2(imG,H,'same');
imBS = conv2(imB,H,'same');

imS = zeros(row,col,3);
imS(:,:,1) = imRS;
imS(:,:,2) = imGS;
imS(:,:,3) = imBS;

%%
NBRE_REF=3;
ref_col=zeros(NBRE_REF,3);

ref_col(1,:) = [0.7765 0.1294 0.4235];
ref_col(2,:) = [0.6784 0.4078 0.2];
ref_col(3,:) = [1 1 1];

eps=1400; %way bigger than the epsilon of color_splitting_v1
eps_mat=eps*ones(row,col);

ref_col_lab=rgb2lab(ref_col);
im_lab=rgb2lab(imS);

%% Matrix comparison
x=cell(1,NBRE_REF); %cell from which the ith entry is a logical image containing the result of the comparison
%between the original image and the ith reference color
for i=1:NBRE_REF
    temp1=repmat(ref_col_lab(i,1),row,col); %red channel of ith ref color = r_i
    temp2=repmat(ref_col_lab(i,2),row,col); %green channel of ith ref color = g_i
    temp3=repmat(ref_col_lab(i,3),row,col); %blue channel of ith ref color = b_i
    a=cat(3,temp1,temp2,temp3); %concatenation along 3rd dimension: at each entry of the matrix there is [r_i g_i b_i]

    comp=permute(sum(permute((im_lab-a).^2,[3,1,2])),[2,3,1]); %cf. comments in test_script
    %comp=permute(comp,[2,3,1]);
    x{i}=comp<=eps_mat;
    figure;imshow(x{i})
end