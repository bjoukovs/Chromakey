clear; close all;clc;
addpath('Pixel Expansion');

im=im2double(imread('plage.JPG')); %background
figure;imshow(im);
[im_extracted, ~, alpha] = imread('output2.png', 'png'); %JCVD modifié
figure;imshow(im_extracted);

im_extracted=im2double(im_extracted);
alpha=im2double(alpha);

[rows_back,cols_back,~]=size(im);
[rows_extracted,cols_extracted,~]=size(im_extracted);

temp = zeros(rows_back,cols_back);
temp2 = zeros(rows_back,cols_back,3);

%POS = 'middle';
POS = 'bottom';

diff=round(rows_back/2-rows_extracted/2);

if strcmp(POS,'middle')
    temp(round(rows_back/2-rows_extracted/2):round(rows_back/2+rows_extracted/2)-1,round(cols_back/2-cols_extracted/2):round(cols_back/2+cols_extracted/2)-1)=alpha(:,:);
    temp2(round(rows_back/2-rows_extracted/2):round(rows_back/2+rows_extracted/2)-1,round(cols_back/2-cols_extracted/2):round(cols_back/2+cols_extracted/2)-1,:)=im_extracted;
elseif strcmp(POS,'bottom')
    temp(diff+round(rows_back/2-rows_extracted/2):diff+round(rows_back/2+rows_extracted/2)-1,round(cols_back/2-cols_extracted/2):round(cols_back/2+cols_extracted/2)-1)=alpha(:,:);
    temp2(diff+round(rows_back/2-rows_extracted/2):diff+round(rows_back/2+rows_extracted/2)-1,round(cols_back/2-cols_extracted/2):round(cols_back/2+cols_extracted/2)-1,:)=im_extracted;
else % by default we put it to middle
    temp(round(rows_back/2-rows_extracted/2):round(rows_back/2+rows_extracted/2)-1,round(cols_back/2-cols_extracted/2):round(cols_back/2+cols_extracted/2)-1)=alpha(:,:);
    temp2(round(rows_back/2-rows_extracted/2):round(rows_back/2+rows_extracted/2)-1,round(cols_back/2-cols_extracted/2):round(cols_back/2+cols_extracted/2)-1,:)=im_extracted;
end
%temp=repmat(temp,[1 1 3]);

result=im;
% result(temp==1)=temp2;

for i=1:rows_back
    for j=1:cols_back
        if temp(i,j)==1
            result(i,j,:)=temp2(i,j,:);
        end
    end
end

figure;imshow(result)

