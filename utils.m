function getMeanColor(img,scribbles,scribble_n)
    
    pixels = []
    for i=1:length(scribbles{scribble_n})
       pos = scribbles{scribble_n}(i,:); 
       
       pixels = [pixels; img(pos(1),pos(2))]; 
    end
    
    pixels
    
        
end