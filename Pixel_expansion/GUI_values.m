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

save('values_GUI.mat')