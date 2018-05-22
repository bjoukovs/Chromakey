load('values_GUI.mat')

im=im2double(imread('test3.jpg'));
figure;imshow(im)
[row,col,~] = size(im);

[a,b]=size(scribbles);
mean_scrib=zeros(1,b);
var_scrib=zeros(1,b);

for k=1:b
    pos=scribbles{1,k};
    mean_scrib(1,k)=mean(im(pos(1),im(2)));
    var_scrib(1,k)=var(im(pos(1),im(2)))
end






