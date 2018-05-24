    
function createScribble(handles)
    global scribbles;
    global scribble_n;
    global background;
    global custom_color;
    
    num = length(scribbles)+1;
    scribbles{num} = [0 0];
    scribble_n = num;
    
    background{scribble_n} = 0;
    custom_color{scribble_n} = [1 1 1];