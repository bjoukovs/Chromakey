function varargout = GUI(varargin)
    % GUI MATLAB code for GUI.fig
    %      GUI, by itself, creates a new GUI or raises the existing
    %      singleton*.
    %
    %      H = GUI returns the handle to a new GUI or the handle to
    %      the existing singleton*.
    %
    %      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in GUI.M with the given input arguments.
    %
    %      GUI('Property','Value',...) creates a new GUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before GUI_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help GUI

    % Last Modified by GUIDE v2.5 25-Apr-2018 15:39:42

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @GUI_OpeningFcn, ...
                       'gui_OutputFcn',  @GUI_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to GUI (see VARARGIN)

    % Choose default command line output for GUI
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes GUI wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    
    %remove axis ticks
    clearAxes(handles.axes1);
    clearAxes(handles.axes2);
    
    
function clearAxes(axs)
    axes(axs);
    axis off;
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
    % hObject    handle to listbox1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from listbox1


    % --- Executes during object creation, after setting all properties.
    
function listbox1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to listbox1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    disp("test");



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
    %[filename, filepath] = uigetfile({'.';'.jpg';'.tif';'.png';'.bmp'},'Search image to be displayed');
    [filename, filepath] = uigetfile({'.jpg'},'Search image to be displayed');
    filename= [filepath filename];
    imageFile = im2double(imread(filename));

    global main_image;
    global image_width;
    global image_height;
    main_image = imageFile;
    sz = size(imageFile);
    image_width = sz(2) %width
    image_height = sz(1) %height
    
    global scribbles
    global scribble_n
    scribbles = {};
    scribble_n = 1; %normally put 0
    scribbles{1} = [0 0]; %normally remove this line
    
    %display the image
    axes(handles.axes1)
    img = imshow(imageFile, 'parent', handles.axes1);
    set(img,'ButtonDownFcn',@image_ButtonDownFcn);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
    % hObject    handle to checkbox1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton6 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to axes1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: place code in OpeningFcn to populate axes1


% IMAGE MOUSE DOWN ACTION
function image_ButtonDownFcn(hObject, eventdata, handles)
    global mouseDown;
    mouseDown = 1;
    
    
    
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
    global mouseDown;
    global image_height;
    global image_width;
    global scribble_n;
    global scribbles;
    global main_image;

    if mouseDown == 1
        axes(handles.axes1);
        mousePos = get(gca, 'CurrentPoint');
        
        mx = round(mousePos(1,1));
        my = round(mousePos(1,2));
        
        if mx < 0 || my < 0 || my > image_height-1 || mx > image_width-1
            
           stopMouseMoving(handles);
           
        elseif scribble_n ~= 0
            %action when users draws scribble
            
            exists_x = find(scribbles{scribble_n}(:,1) == mx);
            exists_y = find(scribbles{scribble_n}(:,2) == my);
            
            if isempty(exists_x) && isempty(exists_y)
               
                scribbles{scribble_n} = [scribbles{scribble_n}; mx my];
                
                axes(handles.axes1);
                hold on;
                plot(mx,my,'r.','MarkerSize',6);
                hold off;
                
            end
            
        end
        
    end

function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
    global mouseDown;

    if mouseDown == 1
        stopMouseMoving(handles);
    end
    
    
function updateImageAndScribbles(handles)
    global main_image
    global scribbles
    
    clearAxes(handles.axes1);
    clearAxes(handles.axes2);
    axes(handles.axes1);
    img = imshow(main_image, 'parent', handles.axes1);
    set(img,'ButtonDownFcn',@image_ButtonDownFcn);
    hold on;
    
    for i=1:length(scribbles)
        
        for j=1:length(scribbles{i})
            plot(scribbles{i}(j,1),scribbles{i}(j,2),'r.','MarkerSize',6);
        end
        
    end
    hold off;
    
function stopMouseMoving(handles)
    global main_image;
    global scribbles;
    global scribble_n;
    global mouseDown;
    
    mouseDown = 0;

    %action when users stops drawing scribble 
   disp('test');
   RGB = getMeanColor(main_image,scribbles,scribble_n);
   updateMeanColorDisplay(handles,RGB)
   
function mn = getMeanColor(img,scribbles,scribble_n)

    pixels = []
    for i=2:length(scribbles{scribble_n})
       pos = scribbles{scribble_n}(i,:); 
       pixels = [pixels; img(pos(1),pos(2),:)]; 
    end
    
    mnR = mean(pixels(:,1));
    mnG = mean(pixels(:,2));
    mnB = mean(pixels(:,3));
    
    mn = [];
    mn(1,1,:) = [mnR mnG mnB]
    
    
function updateMeanColorDisplay(handles,RGB)
    axes(handles.axes2);
    imshow(RGB);