clear all;
close all;

addpath('Pixel_expansion');
addpath('GUI');

global mouseDown;
global scribbles;
global scribble_n;
global background;
global availableResult;
global custom_color;

mouseDown = 0;
scribble_n = 0;
scribbles = {};
background = {};
availableResult = 0;

gui = GUI();