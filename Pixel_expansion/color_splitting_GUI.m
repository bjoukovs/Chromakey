clear; close all;clc;

load('values_GUI.mat')

% WARNING first obtain 'values_GUI.mat' from the script GUI_values.m

im=im2double(imread('test.png'));
%figure;imshow(im)
[row,col,~] = size(im);

[a,b]=size(scribbles);

means=cell(1,b); %will contain the mean_scrib
vars=cell(1,b); %will contain the var_scrib

%im_lab=rgb2lab(im);
%imshow(im_lab)
% custom_color_lab=custom_color;
% for p=1:length(custom_color)
%     custom_color_lab{1,p}=rgb2lab(custom_color{1,p})
% end

for k=1:b
    pos=scribbles{k};
    [c,d]=size(pos);
    temp=zeros(c-1,2);
    temp(:,1)=pos(2:end,1);
    temp(:,2)=pos(2:end,2);
    pos=temp; %to ignore the first value which is 0,0
    [c,d]=size(pos);
    col_points=zeros(c,1,3);
    for i=1:c
        col_points(i,1,:)=im(pos(i,2),pos(i,1),:);
    end
    %mean_scrib(1,k)=mean(col_points,3); 
    mean_scrib=zeros(3,1);
    for j=1:3
        mean_scrib(j)=mean(col_points(:,:,j)); %each entry of mean_scrib contains the mean of one channel (RGB) of one color
    end
    means{1,k}=mean_scrib;
    %var_scrib(1,k)=var(col_points,0,3);
    col_point_for_var=zeros(c,3);
    col_point_for_var(:,1)=col_points(:,:,1);
    col_point_for_var(:,2)=col_points(:,:,2);
    col_point_for_var(:,3)=col_points(:,:,3);
    var_scrib=cov(col_point_for_var);
    vars{1,k}=var_scrib;
end

%% 

NBRE_REF = b; %number of elements in scribbles
im_para = zeros(row,col,3);
eps = 0.001; %to tune
temp=zeros(1,3);
dist_mahal=zeros(row,col,NBRE_REF);
for i = 1:row
    i
    for j = 1:col
        eps_perso=eps;
        for k = 1:NBRE_REF
            temp(1,1)=im(i,j,1);
            temp(1,2)=im(i,j,2);
            temp(1,3)=im(i,j,3);
            dist_mahal = (temp'-means{1,k})'*vars{1,k}*(temp'-means{1,k});
            if dist_mahal < eps
                if dist_mahal < eps_perso
                    eps_perso = dist_mahal;
                    im_para(i,j,:) = custom_color{1,k}';%ref_col(k,:);
                end
            end
            dist_mahal(i,j,k)=dist_mahal;
        end   
    end
end
figure;imshow(im_para)






