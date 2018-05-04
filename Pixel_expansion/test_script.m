clear;close all;clc;
%test script to compute the "element-wise" norm of the matrix from which
%each element is a vector containing the RGB vector difference from a and
%b --> so each entry of the final matrix contains the distance between the
%corresponding entries of a and b

a=zeros(2,2,3); %RGB 2x2x3 matrix
a(1,1,:)=[2 5 6];
a(1,2,:)=[7 8 3];
a(2,1,:)=[6 8 9];
a(2,2,:)=[8 1 2];

b=zeros(2,2,3); %RGB 2x2x3 matrix
b(1,1,:)=[6 1 8];
b(1,2,:)=[1 2 0];
b(2,1,:)=[8 2 7];
b(2,2,:)=[1 5 2];

c = a - b;  %it does the difference of each pair of element of the rgb vector
d = c.^2;   %makes each element of the result square
f = permute(d,[3,1,2]); %put the rgb vector as a column
g = sum(f); %sum per column
h=permute(g,[2,3,1]); %reput the result in the correct order (same order as a and b)

% h = sum(f)
% % c=a-b
% % 
% % d=a.^2
% % 
% % c=abs(a-b)
% 
% % c=(a-b).^2
% g=permute(a,[3,2,1])
% f=sum(g)
% %f=sum(a(1,1,:))