clear;close all;clc;
a=zeros(2,2,3);
a(1,1,:)=[2 5 6];
a(1,2,:)=[7 8 3];
a(2,1,:)=[6 8 9];
a(2,2,:)=[8 1 2];

b=zeros(2,2,3);
b(1,1,:)=[6 1 8];
b(1,2,:)=[1 2 0];
b(2,1,:)=[8 2 7];
b(2,2,:)=[1 5 2];

c = a - b;  %it does the difference of each pair of element of the rgb vector
d = c.^2;   %makes each element of the result square
f = permute(d,[3,2,1]); %put the rgb vector as a column
g = sum(f); %sum per column
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