    
function updateScribbleInfo(handles)
    %updates scribble display
    global scribbles;
    global scribble_n;
    global background;
    global main_image;
    global custom_color;
    global cp;
    
    if scribble_n ~= 0
        RGB = custom_color{scribble_n};
        col = java.awt.Color(RGB(1),RGB(2),RGB(3));
        set(cp,'Value',col);
        
        set(handles.checkbox1, 'Value', background{scribble_n});
        name = cellstr(get(handles.listbox1,'String'));
        name = name{scribble_n};
        set(handles.edit1, 'String', name);
        
        
        set(handles.listbox1,'Value',scribble_n);
    else
       set(handles.edit1,'String',"");
       set(handles.checkbox1,'Value',0);
       
       set(cp,'Value',java.awt.Color(1,1,1));
    end
    