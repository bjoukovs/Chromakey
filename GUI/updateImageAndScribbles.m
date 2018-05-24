function updateImageAndScribbles(handles)
    global main_image
    global scribbles
    
    clearAxes(handles.axes1);
    axes(handles.axes1);
    img = imshow(main_image, 'parent', handles.axes1);
    set(img,'ButtonDownFcn',@image_ButtonDownFcn);
    hold on;
    
    for i=1:length(scribbles)
        
        sz = size(scribbles{i});
        if sz(1)>1
            for j=1:length(scribbles{i})
                plot(scribbles{i}(j,1),scribbles{i}(j,2),'r.','MarkerSize',6);
            end
        end
        
    end
    hold off;