% TO OBTAIN THE VALUES FROM GUI: put a breakpoint just after the call to GUI,
% make the scribbles in GUI, close GUI and then run the rest of the program

clear all;
close all;
clc;

addpath('..');

global mouseDown;
global main_image;
global image_width;
global image_height;
global scribbles;  %row cell: each entry contains a nb_scribble x 2 containing the (x,y) position of the scribbles
global scribble_n;
global background;
global custom_color; %average color from the scribbles

mouseDown = 0;
scribble_n = 0;
scribbles = {};
background = {};

gui = GUI(); %obtain scribbles from the GUI

% save('main_colors.mat',custom_color);
% save('scribble_pos.mat',scribbles);
save('values_GUI.mat');