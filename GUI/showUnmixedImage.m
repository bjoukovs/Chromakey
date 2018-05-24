function showUnmixedImage(handles)
    global main_image;
    global scribbles;
    global result_image;
    global class_matrix;
    global scribble_means;
    global scribble_vars;
    global background;
    
    mode = get(handles.popupmenu1, 'Value');
    
    spillingCoefficient = get(handles.spillingSlider, 'Max') - get(handles.spillingSlider,'Value');
    
    luminanceCorrection = get(handles.lumSlider, 'Value');
    
    if mode == 4
       %Only show regions
       figure(2);
       imshow(class_matrix,[]);
       return
    
    elseif mode==5
        %Only show regions with color
        result_image =  UnMixing(main_image,0,length(scribbles),class_matrix,scribble_means,scribble_vars,background, 0);
        
    elseif mode==1
        %show normal
        result_image =  UnMixing(main_image,spillingCoefficient,length(scribbles),class_matrix,scribble_means,scribble_vars,background, luminanceCorrection);
        
    elseif mode==2
        %show normal without corrections
        result_image =  UnMixing(main_image,1,length(scribbles),class_matrix,scribble_means,scribble_vars,background, 0);
    
    elseif mode == 3
        %show alpha mask
        %TO COMPLETE
    end
    
    
    figure(2);
    imshow(result_image);
        
end