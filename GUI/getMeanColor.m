function mn = getMeanColor(img,scribbles,scribble_n)

    pixels = [];
    sz = size(scribbles{scribble_n});
    if sz(1)>1
        for i=2:length(scribbles{scribble_n})
           pos = scribbles{scribble_n}(i,:); 
           pixels = [pixels; img(pos(2),pos(1),:)]; 
        end
    end
    
    if ~isempty(pixels)
        mnR = mean(pixels(:,1));
        mnG = mean(pixels(:,2));
        mnB = mean(pixels(:,3));

        mn = [];
        mn(1,1,:) = [mnR mnG mnB];
    else
        mn = []
        mn(1,1,:) = [1 1 1];
    end