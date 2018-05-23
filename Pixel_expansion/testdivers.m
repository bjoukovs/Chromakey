%% Initialization
clear all; close all;clc;
im=im2double(imread('JCVDtest.jpg'));
figure;imshow(im)
x0=1016;y0=1138;
[row,col,~] = size(im);

%% Ehancment, unify the color
% im=rgb2lab(im);
imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);
figure;imshow(imR)
% figure;imshow(imG)
% figure;imshow(imB)

%H = fspecial('average',4); %simple averaging filter
% H = fspecial('gaussian',[5 5], 0.8); %simple averaging filter
% imRS = conv2(imR,H,'same');
% imGS = conv2(imG,H,'same');
% imBS = conv2(imB,H,'same');
result = medianfilter(imR);

figure;imshow(result)
% figure;imshow(imGS)
% figure;imshow(imBS)

% imS = zeros(row,col,3);
% imS(:,:,1) = imRS;
% imS(:,:,2) = imGS;
% imS(:,:,3) = imBS;


% %% %%%% TEST.PNG %%%%%%%%%%%%%%%%%%%%%%%%%%
% % NBRE_REF=3;
% % ref_col=zeros(NBRE_REF,3);
% % ref_col(1,:) = [0.7765 0.1294 0.4235];
% % ref_col(2,:) = [0.6784 0.4078 0.2];
% % ref_col(3,:) = [1 1 1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%% TEST2.PNG %%%%%%%%%%%%%%%%%%%%%%%%%%
% % NBRE_REF=5;
% % ref_col=zeros(NBRE_REF,3);
% % ref_col(1,:) = [0.8 0.1059 0.1333];
% % ref_col(2,:) = [0 0.302 0.5137];
% % ref_col(3,:) = [0.8588 0.7137 0.6275];
% % ref_col(4,:) = [0.5843 0.5176 0.3216];
% % ref_col(5,:) = [1 1 1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%% TEST3.jpg %%%%%%%%%%%%%%%%%%%%%
% % NBRE_REF=4;
% % ref_col=zeros(NBRE_REF,3); %3 for 3 colors
% % ref_col(1,:)=[0 1 0];
% % ref_col(2,:)=[0.7216 0.5333 0.4431];
% % ref_col(3,:)=[0.6549 0.09804 0.04314];
% % ref_col(4,:)=[0.8941 0.3333 0.502];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%% TEST4.jpg %%%%%%%%%%%%%%%%%%%%
% % NBRE_REF=6;
% % ref_col=zeros(NBRE_REF,3); %3 for 3 colors
% % ref_col(1,:)=[0 0.6549 0.149]; %green background
% % ref_col(2,:)=[0.2039 0.2902 0.3412]; %jeans
% % ref_col(3,:)=[0.09804 0.1451 0.1451]; %pull
% % ref_col(4,:)=[0.9255 0.8 0.749]; %skin
% % ref_col(5,:)=[0.251 0.1882 0.1255]; %hair
% % ref_col(6,:)=[0.2549 0.2275 0.1255]; %balai
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%% TEST5.jpg %%%%%%%%%%%%%%%%%%%%
% % NBRE_REF=5;
% % ref_col=zeros(NBRE_REF,3); %3 for 3 colors
% % ref_col(1,:)=[0.1569 0.5098 0.1647]; %green background
% % ref_col(2,:)=[0.4078 0.4275 0.4392]; %jeans
% % ref_col(3,:)=[0.9804 0.9059 0.7804]; %t-shirt
% % ref_col(4,:)=[0.9882 0.7373 0.4941]; %skin
% % ref_col(5,:)=[0.09412 0.09804 0.06667]; %hair
% % % ref_col(6,:)=[1 0.8627 0.5569]; %sable
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%% TEST5.jpg %%%%%%%%%%%%%%%%%%%%
% NBRE_REF=5;
% ref_col=zeros(NBRE_REF,3); %3 for 3 colors
% ref_col(1,:)=[0.003922 0.5529 0.1333]; %green background
% ref_col(2,:)=[0.1333 0.1255 0.1294]; %t-shirt
% ref_col(3,:)=[0.6431 0.4745 0.3098]; %skin
% % ref_col(4,:)=[0.302 0.2588 0.1882]; %hair
% ref_col(4,:)=[0.7176 0.7333 0.6784]; %sabre
% ref_col(5,:)=[0.4431 0.2039 0.02745]; %sunglasses;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% %%%% For TEST2.PNG %%%%%%%%
% % eps=1400; %way bigger than the epsilon of color_splitting_v1
% % eps_mat=eps*ones(row,col);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%% For TEST3.JPG %%%%%%%%
% % eps=400; %way bigger than the epsilon of color_splitting_v1
% % eps_mat=eps*ones(row,col);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%% For TEST4.JPG %%%%%%%%
% eps=500; %way bigger than the epsilon of color_splitting_v1
% eps_mat=eps*ones(row,col);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%% For JCVD.JPG %%%%%%%%
% eps=300; %way bigger than the epsilon of color_splitting_v1
% eps_mat=eps*ones(row,col);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% ref_col_lab=rgb2lab(ref_col);
% im_lab=rgb2lab(im);
% 
% %% Ehancment, unify the color
% imR = im_lab(:,:,1);
% imG = im_lab(:,:,2);
% imB = im_lab(:,:,3);
% 
% H = fspecial('average',6); %simple averaging filter
% %H = fspecial('gaussian',[3 3], 0.8); %simple averaging filter
% imRS = conv2(imR,H,'same');
% imGS = conv2(imG,H,'same');
% imBS = conv2(imB,H,'same');
% 
% imS = zeros(row,col,3);
% imS(:,:,1) = imRS;
% imS(:,:,2) = imGS;
% imS(:,:,3) = imBS;
% 
% im_lab = imS;
% %% Matrix comparison
% x=cell(1,NBRE_REF); %cell from which the ith entry is a logical image containing the result of the comparison
% %between the original image and the ith reference color
% for i=1:NBRE_REF
%     temp1=repmat(ref_col_lab(i,1),row,col); %red channel of ith ref color = r_i
%     temp2=repmat(ref_col_lab(i,2),row,col); %green channel of ith ref color = g_i
%     temp3=repmat(ref_col_lab(i,3),row,col); %blue channel of ith ref color = b_i
%     a=cat(3,temp1,temp2,temp3); %concatenation along 3rd dimension: at each entry of the matrix there is [r_i g_i b_i]
% 
%     comp=permute(sum(permute((im_lab-a).^2,[3,1,2])),[2,3,1]); %cf. comments in test_script
%     %comp=permute(comp,[2,3,1]);
%     x{i}=comp<=eps_mat;
%     figure;imshow(x{i})
% end
