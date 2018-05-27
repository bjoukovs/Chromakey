function showUnmixedImage(handles)
    global main_image;
    global scribbles;
    global result_image;
    global class_matrix;
    global scribble_means;
    global scribble_vars;
    global background;
    global alpha_mask;
    global result_alpha;
    global custom_color;
    
    scribble_means_custom = cell2mat(custom_color);
    scribble_means_custom = permute(scribble_means_custom, [2 1 3]);
    scribble_means_custom = rgb2yuv(scribble_means_custom);
    
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
        result_image =  UnMixing(main_image,0,length(scribbles),class_matrix,scribble_means_custom,scribble_vars,background, 0,1,1);
        
    elseif mode==1
        %show normal
        result_image =  UnMixing(main_image,spillingCoefficient,length(scribbles),class_matrix,scribble_means_custom,scribble_vars,background, luminanceCorrection,1,0);
        
    elseif mode==2
        %show normal without corrections
        result_image =  UnMixing(main_image,1,length(scribbles),class_matrix,scribble_means_custom,scribble_vars,background, 0, 0,0);
    
    elseif mode == 3
        %show alpha mask
        figure(10)
        imshow(alpha_mask);
        return
    end
    
    
    figure(10);
    imshow(result_image);
    
        
end