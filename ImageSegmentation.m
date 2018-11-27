function varargout = ImageSegmentation(varargin)
% IMAGESEGMENTATION MATLAB code for ImageSegmentation.fig
%      IMAGESEGMENTATION, by itself, creates a new IMAGESEGMENTATION or raises the existing
%      singleton*.
%
%      H = IMAGESEGMENTATION returns the handle to a new IMAGESEGMENTATION or the handle to
%      the existing singleton*.
%
%      IMAGESEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGESEGMENTATION.M with the given input arguments.
%
%      IMAGESEGMENTATION('Property','Value',...) creates a new IMAGESEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageSegmentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageSegmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageSegmentation

% Last Modified by GUIDE v2.5 27-Oct-2018 15:08:00

% Begin initialization code - result03 NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageSegmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageSegmentation_OutputFcn, ...
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
% End initialization code - result03 NOT EDIT


% --- Executes just before ImageSegmentation is made visible.
function ImageSegmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageSegmentation (see VARARGIN)

% Choose default command line output for ImageSegmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageSegmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageSegmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open1.
function open1_Callback(hObject, eventdata, handles)
% hObject    handle to open1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg1
[filename,path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},...
    'Choose an image');
if ~isequal(filename,0)
    Info = imfinfo(fullfile(path,filename));
    if Info.BitDepth == 24
    inImg1 = imread([path,filename]);
    axes(handles.axes1)
    imshow(inImg1);
    else
        msgbox('Please choose an image color RGB !');
        return
    end
else
    return
end

set(handles.name1,'Visible','on')
set(handles.name1,'string',filename);
set(handles.popAlg,'Enable','on')
set(handles.pop1,'Enable','on')
set(handles.process1,'Enable','on')
set(handles.htg01,'Enable','on')
set(handles.detectimage,'Enable','on')


% --- Executes on button press in open2.
function open2_Callback(hObject, eventdata, handles)
% hObject    handle to open2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg2 ImgName
[filename,path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},...
    'Choose an image');
if ~isequal(filename,0)
    Info = imfinfo(fullfile(path,filename));
    if Info.BitDepth == 24
    inImg2 = imread([path,filename]);
    ImgName = filename;
    axes(handles.axes3)
    imshow(inImg2);
    else
        msgbox('Please choose an image color RGB !');
        return
    end
else
    return
end
set(handles.name2,'Visible','on')
set(handles.name2,'string',filename);
set(handles.pop2,'Enable','on')
set(handles.process2,'Enable','on')
set(handles.htg02,'Enable','on')

% --- Executes on button press in process1.
function process1_Callback(hObject, eventdata, handles)
% hObject    handle to process1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global map1
map1 =  [[0         0    0.5625];
         [0         0    0.6250];
         [0         0    0.6875];
         [0         0    0.7500];
         [0         0    0.8125];
         [0         0    0.8750];
         [0         0    0.9375];
         [0         0    1.0000];
         [0    0.0625    1.0000];
         [0    0.1250    1.0000];
         [0    0.1875    1.0000];
         [0    0.2500    1.0000];
         [0    0.3125    1.0000];
         [0    0.3750    1.0000];
         [0    0.4375    1.0000];
         [0    0.5000    1.0000];
         [0    0.5625    1.0000];
         [0    0.6250    1.0000];
         [0    0.6875    1.0000];
         [0    0.7500    1.0000];
         [0    0.8125    1.0000];
         [0    0.8750    1.0000];
         [0    0.9375    1.0000];
         [0    1.0000    1.0000];
    [0.0625    1.0000    0.9375];
    [0.1250    1.0000    0.8750];
    [0.1875    1.0000    0.8125];
    [0.2500    1.0000    0.7500];
    [0.3125    1.0000    0.6875];
    [0.3750    1.0000    0.6250];
    [0.4375    1.0000    0.5625];
    [0.5000    1.0000    0.5000];
    [0.5625    1.0000    0.4375];
    [0.6250    1.0000    0.3750];
    [0.6875    1.0000    0.3125];
    [0.7500    1.0000    0.2500];
    [0.8125    1.0000    0.1875];
    [0.8750    1.0000    0.1250];
    [0.9375    1.0000    0.0625];
    [1.0000    1.0000         0];
    [1.0000    0.9375         0];
    [1.0000    0.8750         0];
    [1.0000    0.8125         0];
    [1.0000    0.7500         0];
    [1.0000    0.6875         0];
    [1.0000    0.6250         0];
    [1.0000    0.5625         0];
    [1.0000    0.5000         0];
    [1.0000    0.4375         0];
    [1.0000    0.3750         0];
    [1.0000    0.3125         0];
    [1.0000    0.2500         0];
    [1.0000    0.1875         0];
    [1.0000    0.1250         0];
    [1.0000    0.0625         0];
    [1.0000         0         0];
    [0.9375         0         0];
    [0.8750         0         0];
    [0.8125         0         0];
    [0.7500         0         0];
    [0.6250         0         0];
    [0.5625         0         0];
    [0.6875         0         0];
    [0.5000         0         0]]; 

h = waitbar(0,'Please wait...');
pause(.5)
global inImg1 outImg1
inImg = inImg1;
nBins = 5;
winSize = 5;
pop1 = get(handles.pop1,'value');
popAlg = get(handles.popAlg,'value');
waitbar(.33,h,'Please wait...');
pause(1)
switch pop1
    case 1
        nClass = 2;
    case 2
        nClass = 3;
    case 3
        nClass = 4;
    case 4
        nClass = 5;
    case 5
        nClass = 6;
    case 6
        nClass = 7;
    case 7
        nClass = 8;
    case 8
        nClass = 9;
    case 9
        nClass = 10;
end

switch popAlg
    case 1
        tic;
        outImg1 = ImgSeg(inImg, nBins, winSize, nClass);
        toc;
        set(handles.time1,'string',toc);
    case 2
        [m, time] = main_color(inImg, nBins, winSize, nClass);
        outImg1 = ImgSeg(m, nBins, winSize, nClass);
        set(handles.time1,'string',time);
end
try
    waitbar(.67,h,'Please wait...');
    pause(1);
catch

end
axes(handles.axes2)
ax = gca;
imshow(outImg1);
colormap(ax,map1);


index255 = 0;
index230 = 0;
index227 = 0;
index223 = 0;
index219 = 0;
index213 = 0;
index204 = 0;
index198 = 0;
index191 = 0;
index182 = 0;
index179 = 0;
index170 = 0;
index159 = 0;
index153 = 0;
index146 = 0;
index142 = 0;
index128 = 0;
index113 = 0;
index109 = 0;
index102 = 0;
index96 = 0;
index85 = 0;
index77 = 0;
index73 = 0;
index64 = 0;
index57 = 0;
index51 = 0;
index43 = 0;
index36 = 0;
index32 = 0;
index28 = 0;
index26 = 0;

for r = 1:size(outImg1,1)
    for c = 1:size(outImg1,2)
        switch outImg1(r,c)
            case 255
            index255 = index255 + 1;
            
            case 230
            index230 = index230 + 1;
            
            case 227
            index227 = index227 + 1;
            
            case 223
            index223 = index223 + 1;
             
            case 219
            index219 = index219 + 1;

            case 213
            index213 = index213 + 1;

            case 204
            index204 = index204 + 1;

            case 198
            index198 = index198 + 1;
            
            case 191
            index191 = index191 + 1;
            
            case 182
            index182 = index182 + 1;

            case 179
            index179 = index179 + 1;
            
            case 170
            index170 = index170 + 1;
            
            case 159
            index159 = index159 + 1;

            case 153
            index153 = index153 + 1;
            
            case 146
            index146 = index146 + 1;

            case 142
            index142 = index142 + 1;
            
            case 128
            index128 = index128 + 1;

            case 113
            index113 = index113 + 1;         
            
            case 109
            index109 = index109 + 1;
            
            case 102
            index102 = index102 + 1;        
            
            case 96
            index96 = index96 + 1;

            case 85
            index85 = index85 + 1;
            
            case 77
            index77 = index77 + 1;
            
            case 73
            index73 = index73 + 1;

            case 64
            index64 = index64 + 1;

            case 57
            index57 = index57 + 1;
            
            case 51
            index51 = index51 + 1;

            case 43
            index43 = index43 + 1;
            
            case 36
            index36 = index36 + 1;
            
            case 32
            index32 = index32 + 1;
            
            case 28
            index28 = index28 + 1;
            
            case 26
            index26 = index26 + 1;
        end
    end
end

sum = r*c;
axes(handles.axes5)
ax = gca;
switch pop1
    case 1
        H = pie([index255/sum index128/sum]);
        colormap(ax, [[0.5 0 0];[0.5625 1.0 0.4375]]);
    case 2
        H = pie([index255/sum index170/sum index85/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.8125 0];[0 0.875 1.0]]);
        
    case 3
        H = pie([index255/sum index191/sum index128/sum index64/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.5 0];[0.5625 1.0 0.4375];[0 0.5625 1.0]]);
        
    case 4
        H = pie([index255/sum index204/sum index153/sum index102/sum index51/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.25 0];[0.9375 1.0 0.0625];[0.125 1.0 0.8750];[0 0.3125 1.0]]);
              
    case 5     
        H = pie([index255/sum index213/sum index170/sum index128/sum index85/sum index43/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.125 0];[1.0 0.8125 0];[0.5625 1.0 0.4375];[0 0.875 1.0];[0 0.1875 1.0]]);
        
    case 6    
        H = pie([index255/sum index219/sum index182/sum index146/sum index109/sum index73/sum index36/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.0625 0];[1.0 0.625 0];[0.8125 1.0 0.1875];[0.25 1.0 0.75];[0 0.6875 1.0];[0 0.125 1.0]]);
    
    case 7
        H = pie([index255/sum index223/sum index191/sum index159/sum index128/sum index96/sum index64/sum index32/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0 0];[1.0 0.5 0];[1.0 1.0 0];[0.5625 1.0 0.4375];[0.0625 1.0 0.9375];[0 0.5625 1.0];[0 0.0625 1.0]]);
    
    case 8
        H = pie([index255/sum index227/sum index198/sum index170/sum index142/sum index113/sum index85/sum index57/sum index28/sum]);
        colormap(ax, [[0.5 0 0];[0.9375 0 0];[1.0 0.375 0];[1.0 0.8125 0];[0.75 1.0 0.25];[0.3125 1.0 0.6875];[0 0.875 1.0];[0 0.4375 1.0];[0 0 1.0]]);
    
    case 9
        H = pie([index255/sum index230/sum index204/sum index179/sum index153/sum index128/sum index102/sum index77/sum index51/sum index26/sum]);
        colormap(ax, [[0.5 0 0];[0.875 0 0];[1.0 0.25 0];[1.0 0.6875 0];[0.9375 1.0 0.0625];[0.5625 1.0 0.4375];[0.125 1.0 0.875];[0 0.75 1.0];[0 0.3125 1.0];[0 0 0.9375]]);
       
end

T = H(strcmpi(get(H,'Type'),'text'));
P = cell2mat(get(T,'Position'));
set(T,{'Position'},num2cell(P*0.6,2));
set(handles.save1,'Enable','on');
set(handles.clear1,'Enable','on');
set(handles.htg1,'Enable','on');
try
    waitbar(1,h,'Please wait...');
    pause(1);
    close(h);
catch
end
 
 
 
% --- Executes on button press in process2.
function process2_Callback(hObject, eventdata, handles)
% hObject    handle to process2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global map2
map2 =  [[0         0    0.5625];
         [0         0    0.6250];
         [0         0    0.6875];
         [0         0    0.7500];
         [0         0    0.8125];
         [0         0    0.8750];
         [0         0    0.9375];
         [0         0    1.0000];
         [0    0.0625    1.0000];
         [0    0.1250    1.0000];
         [0    0.1875    1.0000];
         [0    0.2500    1.0000];
         [0    0.3125    1.0000];
         [0    0.3750    1.0000];
         [0    0.4375    1.0000];
         [0    0.5000    1.0000];
         [0    0.5625    1.0000];
         [0    0.6250    1.0000];
         [0    0.6875    1.0000];
         [0    0.7500    1.0000];
         [0    0.8125    1.0000];
         [0    0.8750    1.0000];
         [0    0.9375    1.0000];
         [0    1.0000    1.0000];
    [0.0625    1.0000    0.9375];
    [0.1250    1.0000    0.8750];
    [0.1875    1.0000    0.8125];
    [0.2500    1.0000    0.7500];
    [0.3125    1.0000    0.6875];
    [0.3750    1.0000    0.6250];
    [0.4375    1.0000    0.5625];
    [0.5000    1.0000    0.5000];
    [0.5625    1.0000    0.4375];
    [0.6250    1.0000    0.3750];
    [0.6875    1.0000    0.3125];
    [0.7500    1.0000    0.2500];
    [0.8125    1.0000    0.1875];
    [0.8750    1.0000    0.1250];
    [0.9375    1.0000    0.0625];
    [1.0000    1.0000         0];
    [1.0000    0.9375         0];
    [1.0000    0.8750         0];
    [1.0000    0.8125         0];
    [1.0000    0.7500         0];
    [1.0000    0.6875         0];
    [1.0000    0.6250         0];
    [1.0000    0.5625         0];
    [1.0000    0.5000         0];
    [1.0000    0.4375         0];
    [1.0000    0.3750         0];
    [1.0000    0.3125         0];
    [1.0000    0.2500         0];
    [1.0000    0.1875         0];
    [1.0000    0.1250         0];
    [1.0000    0.0625         0];
    [1.0000         0         0];
    [0.9375         0         0];
    [0.8750         0         0];
    [0.8125         0         0];
    [0.7500         0         0];
    [0.6875         0         0];
    [0.6250         0         0];
    [0.5625         0         0];
    [0.5000         0         0]]; 

global inImg2 outImg2
inImg = inImg2;
nBins = 5;
winSize = 5;
pop2 = get(handles.pop2,'value');

switch pop2
    case 1
        nClass = 2;
    case 2
        nClass = 3;
    case 3
        nClass = 4;
    case 4
        nClass = 5;
    case 5
        nClass = 6;
    case 6
        nClass = 7;
    case 7
        nClass = 8;
    case 8
        nClass = 9;
    case 9
        nClass = 10;
end

% Kmeans++
global m ImgName;
[time, count, m] = K_means_Run(inImg, nClass);
fprintf(count);
name = strcat(ImgName,'_result.jpg');
imwrite(uint8(m),name);
tic;
outImg2 = ImgSeg(m, nBins, winSize, nClass);
toc;
set(handles.time2,'string',time + toc);
axes(handles.axes4)
ax = gca;
imshow(outImg2);
colormap(ax,map2);
      
      
index255 = 0;
index230 = 0;
index227 = 0;
index223 = 0;
index219 = 0;
index213 = 0;
index204 = 0;
index198 = 0;
index191 = 0;
index182 = 0;
index179 = 0;
index170 = 0;
index159 = 0;
index153 = 0;
index146 = 0;
index142 = 0;
index128 = 0;
index113 = 0;
index109 = 0;
index102 = 0;
index96 = 0;
index85 = 0;
index77 = 0;
index73 = 0;
index64 = 0;
index57 = 0;
index51 = 0;
index43 = 0;
index36 = 0;
index32 = 0;
index28 = 0;
index26 = 0;

for r = 1:size(outImg2,1)
    for c = 1:size(outImg2,2)
        switch outImg2(r,c)
            case 255
            index255 = index255 + 1;
            
            case 230
            index230 = index230 + 1;
            
            case 227
            index227 = index227 + 1;
            
            case 223
            index223 = index223 + 1;
             
            case 219
            index219 = index219 + 1;

            case 213
            index213 = index213 + 1;

            case 204
            index204 = index204 + 1;

            case 198
            index198 = index198 + 1;
            
            case 191
            index191 = index191 + 1;
            
            case 182
            index182 = index182 + 1;

            case 179
            index179 = index179 + 1;
            
            case 170
            index170 = index170 + 1;
            
            case 159
            index159 = index159 + 1;

            case 153
            index153 = index153 + 1;
            
            case 146
            index146 = index146 + 1;

            case 142
            index142 = index142 + 1;
            
            case 128
            index128 = index128 + 1;

            case 113
            index113 = index113 + 1;         
            
            case 109
            index109 = index109 + 1;
            
            case 102
            index102 = index102 + 1;        
            
            case 96
            index96 = index96 + 1;

            case 85
            index85 = index85 + 1;
            
            case 77
            index77 = index77 + 1;
            
            case 73
            index73 = index73 + 1;

            case 64
            index64 = index64 + 1;

            case 57
            index57 = index57 + 1;
            
            case 51
            index51 = index51 + 1;

            case 43
            index43 = index43 + 1;
            
            case 36
            index36 = index36 + 1;
            
            case 32
            index32 = index32 + 1;
            
            case 28
            index28 = index28 + 1;
            
            case 26
            index26 = index26 + 1;
        end
    end
end

sum = r*c;
axes(handles.axes6)
ax = gca;
switch pop2
    case 1
        H = pie([index255/sum index128/sum]);
        colormap(ax, [[0.5 0 0];[0.5625 1.0 0.4375]]);
    case 2
        H = pie([index255/sum index170/sum index85/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.8125 0];[0 0.875 1.0]]);
        
    case 3
        H = pie([index255/sum index191/sum index128/sum index64/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.5 0];[0.5625 1.0 0.4375];[0 0.5625 1.0]]);
        
    case 4
        H = pie([index255/sum index204/sum index153/sum index102/sum index51/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.25 0];[0.9375 1.0 0.0625];[0.125 1.0 0.8750];[0 0.3125 1.0]]);
              
    case 5     
        H = pie([index255/sum index213/sum index170/sum index128/sum index85/sum index43/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.125 0];[1.0 0.8125 0];[0.5625 1.0 0.4375];[0 0.875 1.0];[0 0.1875 1.0]]);
        
    case 6    
        H = pie([index255/sum index219/sum index182/sum index146/sum index109/sum index73/sum index36/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0.0625 0];[1.0 0.625 0];[0.8125 1.0 0.1875];[0.25 1.0 0.75];[0 0.6875 1.0];[0 0.125 1.0]]);
    
    case 7
        H = pie([index255/sum index223/sum index191/sum index159/sum index128/sum index96/sum index64/sum index32/sum]);
        colormap(ax, [[0.5 0 0];[1.0 0 0];[1.0 0.5 0];[1.0 1.0 0];[0.5625 1.0 0.4375];[0.0625 1.0 0.9375];[0 0.5625 1.0];[0 0.0625 1.0]]);
    
    case 8
        H = pie([index255/sum index227/sum index198/sum index170/sum index142/sum index113/sum index85/sum index57/sum index28/sum]);
        colormap(ax, [[0.5 0 0];[0.9375 0 0];[1.0 0.375 0];[1.0 0.8125 0];[0.75 1.0 0.25];[0.3125 1.0 0.6875];[0 0.875 1.0];[0 0.4375 1.0];[0 0 1.0]]);
    
    case 9
        H = pie([index255/sum index230/sum index204/sum index179/sum index153/sum index128/sum index102/sum index77/sum index51/sum index26/sum]);
        colormap(ax, [[0.5 0 0];[0.875 0 0];[1.0 0.25 0];[1.0 0.6875 0];[0.9375 1.0 0.0625];[0.5625 1.0 0.4375];[0.125 1.0 0.875];[0 0.75 1.0];[0 0.3125 1.0];[0 0 0.9375]]);
       
end
%kmeans_pp(nClass, inImg);
T = H(strcmpi(get(H,'Type'),'text'));
P = cell2mat(get(T,'Position'));
set(T,{'Position'},num2cell(P*0.6,2));
set(handles.save2,'Enable','on')
set(handles.clear2,'Enable','on')
set(handles.htg2,'Enable','on')

% --- Executes on button press in save1.
function save1_Callback(hObject, eventdata, handles)
% hObject    handle to save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg1
global map
  [filename,pathname]=uiputfile({'*.jpg','JPEG Files(*.jpg)';... 
           '*.bmp','Bitmap Files(*.bmp)';'*.gif','GIF Files(*.gif)';... 
           '*.tif','TIFF Files(*.tif)';... 
           '*.*','all image file'},'Save as!');
  if isequal(filename,0) || isequal(pathname,0)
    disp('Cancel save')
  else
    disp(['Saved to ',fullfile(pathname,filename)])
    map = hsv(256); % Or whatever colormap you want.
    rgbImage = ind2rgb(outImg1, map); % im is a grayscale or indexed image.
    imwrite(rgbImage,[pathname,filename]);
  end


% --- Executes on button press in save2.
function save2_Callback(hObject, eventdata, handles)
% hObject    handle to save2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg2
global map
  [filename,pathname]=uiputfile({'*.jpg','JPEG Files(*.jpg)';... 
           '*.bmp','Bitmap Files(*.bmp)';'*.gif','GIF Files(*.gif)';... 
           '*.tif','TIFF Files(*.tif)';... 
           '*.*','all image file'},'Save as!'); 
  if isequal(filename,0) || isequal(pathname,0)
    disp('Cancel save')
  else
    disp(['Saved to ',fullfile(pathname,filename)])
    map = hsv(256); % Or whatever colormap you want.
    rgbImage = ind2rgb(outImg2, map); % im is a grayscale or indexed image.
    imwrite(rgbImage,[pathname,filename]);
  end

  
% --- Executes on button press in clear2.
function clear1_Callback(hObject, eventdata, handles)
% hObject    handle to clear2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes2)
cla reset;
set(handles.time1,'string',0)
set(handles.save1,'Enable','off')
set(handles.htg1,'Enable','off')
axes(handles.axes5)
cla reset;
set(handles.clear1,'Enable','off')

% --- Executes on button press in clear1.
function clear2_Callback(hObject, eventdata, handles)
% hObject    handle to clear1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes4)
cla reset;
set(handles.time2,'string',0)
set(handles.save2,'Enable','off')
set(handles.htg2,'Enable','off')
axes(handles.axes6)
cla reset;
set(handles.clear2,'Enable','off')

% --- Executes on button press in htg01.
function htg01_Callback(hObject, eventdata, handles)
% hObject    handle to htg01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg1
figure('name','Histogram01','numbertitle','off');
imhist(rgb2gray(inImg1));
title('Histogram');

% --- Executes on button press in htg02.
function htg02_Callback(hObject, eventdata, handles)
% hObject    handle to htg02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg2
figure('name','Histogram02','numbertitle','off');
imhist(rgb2gray(inImg2));
title('Histogram');

% --- Executes on button press in htg1.
function htg1_Callback(hObject, eventdata, handles)
% hObject    handle to htg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg1
figure('name','Histogram1','numbertitle','off');
imhist(outImg1);
title('Histogram');

% --- Executes on button press in htg2.
function htg2_Callback(hObject, eventdata, handles)
% hObject    handle to htg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg2
figure('name','Histogram2','numbertitle','off');
imhist(outImg2);
title('Histogram');


% --- Executes on selection change in pop1.
function pop1_Callback(hObject, eventdata, handles)
% hObject    handle to pop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop1


% --- Executes during object creation, after setting all properties.
function pop1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in pop2.
function pop2_Callback(hObject, eventdata, handles)
% hObject    handle to pop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop2

% --- Executes during object creation, after setting all properties.
function pop2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Do you want to exit !','Exit','Yes','No','No');
switch choice
    case 'Yes'
        close
    case 'No'
end


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},...
    'Choose an image');
if ~isequal(filename,0)
    Img = imread([path,filename]);
    figure('name','Open Image','numbertitle','off');
    imshow(Img);
    title(filename);
end


% --------------------------------------------------------------------
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Do you want to quit !','Exit','Yes','No','No');
switch choice
    case 'Yes'
        close
    case 'No'
end


% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate logo
hust = imread('hust.jpg');
imshow(hust);


% --- Executes on selection change in popAlg.
function popAlg_Callback(hObject, eventdata, handles)
% hObject    handle to popAlg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAlg contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAlg


% --- Executes during object creation, after setting all properties.
function popAlg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAlg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in openvideo.
function openvideo_Callback(hObject, eventdata, handles)
% hObject    handle to openvideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inVideo  Folder
[filename,path] = uigetfile({'*.mp4';'*.mov';'*.wmv';'*.vob';'*.rm';'*.asf';'*.3gp';'*.avi'},...
    'Choose an video');
if ~isequal(filename,0)
    inVideo = VideoReader([path,filename]);
    implay([path,filename]);
    
set(handles.detectvideo,'Enable','on')
Folder = strcat(path,'\image');
delete('D:\workspace\matlab\ImageSegmentation\video\image\*')
i = 1;
try
while hasFrame(inVideo)
    vidFrame = readFrame(inVideo);
    imwrite(vidFrame, fullfile(Folder, sprintf('%06d.jpg', i)));
    pause(1/inVideo.FrameRate);
    i = i + 1;
end
catch
end
end


% --- Executes on button press in detectvideo.
function detectvideo_Callback(hObject, eventdata, handles)
% hObject    handle to detectvideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg1 Folder outImg1
FileList = dir(fullfile(Folder, '*.jpg'));

axes(handles.axes2)
tic;
for iFile = 1:length(FileList)
  aFile = fullfile(Folder, FileList(iFile).name);
  inImg1 = imread(aFile);
  [re, outImg1] = fire(inImg1);
  if re == 1
      toc;
      msgbox('fire detected!');
      break;
  end
end
if re == 1
    axes(handles.axes1)
    imshow(inImg1);
else
msgbox('fire not detected!');
end
set(handles.time1,'string',toc);
set(handles.clear1,'Enable','on');



% --- Executes on button press in detectimage.
function detectimage_Callback(hObject, eventdata, handles)
% hObject    handle to detectimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg1 outImg1
  axes(handles.axes2)
  tic;
  [re, outImg1] = fire(inImg1);
  toc;
  imshow(outImg1);
  if re == 1
      msgbox('fire detected!');
  else
      msgbox('fire not detected!');
  end
set(handles.time1,'string',toc);
set(handles.clear1,'Enable','on');

  



% --- Executes on button press in wc.
function wc_Callback(hObject, eventdata, handles)
% hObject    handle to wc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.stopwc,'Enable','on');
global closewc
global inImg1 outImg1 cam vidWriter
cam = webcam;
closewc = 0;
preview(cam)
delete('D:\workspace\matlab\ImageSegmentation\video\image\*')
Folder = 'D:\workspace\matlab\ImageSegmentation\video\image';
vidWriter = VideoWriter('D:\workspace\matlab\ImageSegmentation\video\realtime');
open(vidWriter);
re = 0;
axes(handles.axes2)
tic;
for index = 1:10000000
    if closewc == 1
        break;
    end
    frame = index
    % Acquire frame for processing
    try
    inImg1 = snapshot(cam);
    catch
    end
    % Write frame to video
    try
    writeVideo(vidWriter,inImg1);
    catch
    end
    try
    imwrite(inImg1, fullfile(Folder, sprintf('%06d.jpg', index)));
    catch
    end
    [re, outImg1] = fire(inImg1);
    if re == 1
      toc;
      msgbox('fire detected!');
      break;
    end
end
if re == 1
    axes(handles.axes1)
    imshow(inImg1);
    set(handles.time1,'string',toc);
    set(handles.clear1,'Enable','on');
    set(handles.detectimage,'Enable','on');
else
    msgbox('fire not detected!');
end
close(vidWriter);
delete (cam);  
clear cam


% --- Executes on button press in stopwc.
function stopwc_Callback(hObject, eventdata, handles)
% hObject    handle to stopwc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cam vidWriter closewc
closewc = 1;
try
closePreview(cam)
catch
end
try
close(vidWriter);
catch
end
try
delete (cam);  
catch
end
try
clear cam
catch
end
set(handles.stopwc,'Enable','off');
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [f_seg, Time1]= main_color(im, se, w_size, cluster)
%% parameters
%cluster the number of clustering centers
%se=3 the parameter of structuing element used for morphological reconstruction
%w_size the size of fitlering window
f_ori = im;
% Ground Truth, download from 'https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html'
f_ori=double(f_ori);
%% implement the proposed algorithm
tic 
[~,U1,~,~]=FCM(double(f_ori),cluster,se,w_size);
Time1=toc;
disp(strcat('running time is: ',num2str(Time1)))
f_seg=fcm_image_color(f_ori,U1);

function  [center, U, obj_fcn,iter_n]=FCM(data,cluster_n,radius,w_size,options)
% Firstly, use multivariate morphological reconstruction to reconstruct original image to suppress noise;
% Secondly, implement FCM;
% Thirdly, use a median filter to smooth the fuzzy membership U;
% Finally, normalize U;
% Input variants and parameters
  % data is a 3D data, it means that the input is a color image 
  % cluster_n denotes the number of cluster centers
  % radius denotes the parameter of structuring element used in
  % mrophological recosntruction
  % w_size is the scale of the filtering window 
 
if nargin ~= 4 && nargin ~= 5
    error('Too many or too few input arguments!');
end
% Change the following to set default options
default_options = [2;	% exponent for the partition matrix U
		100;	% max. number of iteration
		1e-5;	% min. amount of improvement
		0];	% info display during iteration 

if nargin == 4,
	options = default_options;
else
	% If "options" is not fully specified, pad it with default values.
	if length(options) < 4,
		tmp = default_options;
		tmp(1:length(options)) = options;
		options = tmp;
	end
	% If some entries of "options" are nan's, replace them with defaults.
	nan_index = find(isnan(options)==1);
	options(nan_index) = default_options(nan_index);
	if options(1) <= 1,
		error('The exponent should be greater than 1!');
	end
end
expo = options(1);      % Exponent for U 
max_iter = options(2);      % Max. iteration 
min_impro = options(3);     % Min. improvement 
display = options(4);       % Display info or not 
obj_fcn = zeros(max_iter, 1);   % Array for objective function
%% step 1, morphological reconstruction
data_rgb=w_ColorRecons_CO(data,radius); %radius means maximal radius
data_lab=colorspace('Lab<-RGB',data_rgb); 
%% step 2, FCM on histogram
data_l=data_lab(:,:,1);data_a=data_lab(:,:,2);data_b=data_lab(:,:,3);
data=[data_l(:)';data_a(:)';data_b(:)']';
%iter_n=0; % actual number of iteration
row=size(data_a,1);col=size(data_a,2);
U = initfcm(cluster_n, row*col);			% Initial fuzzy partition
% Main loop 
for i = 1:max_iter
    %% stepfcm [U, center, obj_fcn(i)] = stepfcm(data, U, cluster_n, expo);
    mf = U.^expo;       % MF matrix after exponential modification
    center = mf*data./((ones(size(data, 2), 1)*sum(mf'))'); % new center
    %% dist = distfcm(center, data);       % fill the distance matrix
     out = zeros(size(center, 1), size(data, 1));
% fill the output matrix
if size(center, 2) > 1,
    for k = 1:size(center, 1),
	out(k, :) = sqrt(sum(((data-ones(size(data, 1), 1)*center(k, :)).^2)'));
    end
else	% 1-D data 
    for k = 1:size(center, 1),
	out(k, :) = abs(center(k)-data)';
    end
end
  dist=out+eps;
    %% distfcm end
    obj_fcn(i) = sum(sum((dist.^2).*mf));  % objective function
    tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
    U = tmp./(ones(cluster_n, 1)*sum(tmp)+eps);
    Uc{i}=U;
	if i > 1,
		%if abs(obj_fcn(i) - obj_fcn(i-1))/obj_fcn(i) < min_impro, break; end,
        if max(max(abs(Uc{i}-Uc{i-1})))< min_impro,break; end,
	end
end
iter_n = i;	% Actual number of iterations 
obj_fcn(iter_n+1:max_iter) = []; 
%% median filtering   
   for k3=1: size(center, 1) 
      U1= U (k3,:);      
      U1=reshape(U1,[row,col]); %reshape the vector U to a matrix of size row*col
      UU=medfilt2(U1,[w_size,w_size]); % Notice, we cann't use U1.^expo due to the problem of high computational complexity
      GG(k3,:)=UU(:);
  end
   U=GG./(ones(cluster_n,1)*(sum(GG))+eps);  % the normalization of 
   center_l=center(:,1);center_a=center(:,2);center_b=center(:,3);center_lab=cat(3,center_l,center_a,center_b);
   center=255*colorspace('RGB<-Lab',center_lab);

% morphological closing reconstruction
function fobrcbr=w_recons_CO(f,se)
fe=imerode(f,se);
fobr=imreconstruct(fe,f); 
fobrc=imcomplement(fobr);
fobrce=imerode(fobrc,se);
fobrcbr=imcomplement(imreconstruct(fobrce,fobrc));

% This function is only suitabe for color image
function gx=fcm_image_color(f,U) 
m=size(f,1);n=size(f,2);
U=U';
idx_f=zeros(m*n,1);
for i=1:m*n
x=U(i,:);
idx=find(x==max(x)); % Computing the classification index of matrix weighted 
idx=idx(1);
idx_f(i)=idx; %idx_f denotes the classification image based on index
end
imput_f=reshape(idx_f,[m n]); 
gx=Label_image(f,imput_f);

function [fs,center_p,Num_p,center_lab]=Label_image(f,L) 
%fs is the result of segmentation, center_p is the center pixel of each
%areas
% f is the original image 
% L is the segmented image using waterhsed transformation
f=double(f);
num_area=max(max(L)); %The number of segmented areas
Num_p=zeros(num_area,1);
if size(f,3)<2
[M,N]=size(f);
s3=L;
fs=zeros(M,N);
center_p=zeros(num_area,1); 
for i=1:num_area
f2=f(s3==i);f_med=median(f2);fx=double((s3==i))*double(f_med);
fs=fs+fx;
center_p(i,:)=uint8(f_med);
Num_p=zeros(num_area,1);
end
fs=uint8(fs);
%% Color image
else    
[M,N]=size(f(:,:,1));
s3=L;
fs=zeros(M,N,3);
fr=f(:,:,1);fg=f(:,:,2);fb=f(:,:,3);
center_p=zeros(num_area,3); 
for i=1:num_area
fr2=fr(s3==i);r_med=median(fr2);r=(s3==i)*r_med;
fg2=fg(s3==i);g_med=median(fg2);g=(s3==i)*g_med;
fb2=fb(s3==i);b_med=median(fb2);b=(s3==i)*b_med;
fs=fs+cat(3,r,g,b);
center_p(i,:)=uint8([r_med g_med b_med]);
Num_p(i)=sum(sum(s3==i));
end
fs=uint8(fs);
end
TT=cat(3,center_p(:,1),center_p(:,2),center_p(:,3));
TT2=colorspace('Lab<-RGB',TT);
TT2r=TT2(:,:,1);TT2g=TT2(:,:,2);TT2b=TT2(:,:,3);
center_lab(:,1)=TT2r(:);center_lab(:,2)=TT2g(:);center_lab(:,3)=TT2b(:);
   
function output_f=w_ColorRecons_CO(f,radius)
se=strel('disk',radius);
if length(size(f))<3
    disp('Please input a color image!');
else
%%
f=double(f);f_r=f(:,:,1);f_g=f(:,:,2);f_b=f(:,:,3);
f_pca=double(PCA_color(f));f1=f_pca(:,:,1);f2=f_pca(:,:,2);
%% step2 data transformation
data1=f1*10^3+f2+f_r*10^-3+f_g*10^-6+f_b*10^-9;Max1=max(max(data1));
data2=f1*10^3+f2+f_g*10^-3+f_r*10^-6+f_b*10^-9;Max2=max(max(data2));
data3=f1*10^3+f2+f_b*10^-3+f_r*10^-6+f_g*10^-9;Max3=max(max(data3));
%% step 3 data processing
imput_data1=imerode(data1,se);
imput_data2=imerode(data2,se);
imput_data3=imerode(data3,se);
f_rec1=imreconstruct(imput_data1,data1);
f_rec2=imreconstruct(imput_data2,data2);
f_rec3=imreconstruct(imput_data3,data3);
imput2_data1=imerode(Max1-f_rec1,se);
imput2_data2=imerode(Max2-f_rec2,se);
imput2_data3=imerode(Max3-f_rec3,se);
f_g1=Max1-imreconstruct(imput2_data1,Max1-f_rec1);
f_g2=Max2-imreconstruct(imput2_data2,Max2-f_rec2);
f_g3=Max3-imreconstruct(imput2_data3,Max3-f_rec3);
end
%% return to RGB format
tt1=f_g1-floor(f_g1);
tt2=f_g2-floor(f_g2);
tt3=f_g3-floor(f_g3);
g1_r=floor(tt1*10^3);
g1_g=floor(tt2*10^3);
g1_b=floor(tt3*10^3);
output_f=cat(3,uint8(g1_r),uint8(g1_g),uint8(g1_b));


function g=PCA_color(f)
f1=f(:,:,1);f2=f(:,:,2);f3=f(:,:,3);
data=double([f1(:)';f2(:)';f3(:)']);
[~,c]=size(data);
m=mean(data')';
d=data-repmat(m,1,c);
% Compute the covariance matrix (co) 
co=d*d';
% Compute the eigen values and eigen vectors of the covariance matrix 
[eigvector,eigvl]=eig(co);
% Sort the eigen vectors according to the eigen values 
eigvalue = diag(eigvl);
[~, index] = sort(-eigvalue);
eigvalue = eigvalue(index);
eigvector = eigvector(:, index);
% Compute the number of eigen values that greater than zero (you can select any threshold)
count1=0;
for i=1:size(eigvalue,1)
    if(eigvalue(i)>0)
        count1=count1+1;
    end
end
% We can use all the eigen vectors but this method will increase the
% computation time and complixity
%vec=eigvector(:,:);

% And also we can use the eigen vectors that the corresponding eigen values is greater than zero(Threshold) and this method will decrease the
% computation time and complixity
vec=eigvector(:,1:count1);
% Compute the feature matrix (the space that will use it to project the testing image on it)
x=vec'*d; 
x2=x+repmat(m,1,c); 
x2=uint8(x2);
x2_1=x2(1,:);x2_2=x2(2,:);x2_3=x2(3,:);
s1=size(f1,1);s2=size(f1,2);
f_1=zeros(s1, s2);f_2=f_1;f_3=f_1;
for j=1:s2
    f_1(:,j)=x2_1((j-1)*s1+1:j*s1);
    f_2(:,j)=x2_2((j-1)*s1+1:j*s1);
    f_3(:,j)=x2_3((j-1)*s1+1:j*s1);
end
g=cat(3,uint8(f_1),uint8(f_2),uint8(f_3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Kmeans
function outImg = ImgSeg(inImg, nBins, winSize, nClass)

NbParam = nBins * nBins * nBins;
divis = 256 / nBins ;

s = size(inImg);
N = winSize;

n = (N-1)/2;
r = s(1) + 2*n;
c = s(2) + 2*n;
double temp(r,c,3);
temp = zeros(r,c,3);
% out = zeros(r,c,3);
coarseImg = zeros(r,c);
TabLabel = zeros(1,NbParam);
% inrImg = rgb2gray(inImg);

temp((n+1):(end-n),(n+1):(end-n),1)=inImg(:,:,1);%R
temp((n+1):(end-n),(n+1):(end-n),2)=inImg(:,:,2);%G
temp((n+1):(end-n),(n+1):(end-n),3)=inImg(:,:,3);%B

% temp_color = temp;

for x = n+1:s(1)+ n
    for y = n+1:s(2)+ n
        e = 1;
        for k = x-n:x+n
            f = 1;
            for l = y-n:y+n
                mat(e,f,1) = temp(k,l,1);
                mat(e,f,2) = temp(k,l,2);
                mat(e,f,3) = temp(k,l,3);
                f = f+1;
            end
            e = e + 1;
        end

        sum_lab = 0;
        for i = 1 : winSize
            for j = 1 : winSize
                lab = floor(mat(i,j,1)/divis)*(nBins*nBins);
                lab = lab + floor(mat(i,j,2)/divis)*(nBins);
                lab = lab + floor(mat(i,j,3)/divis);
                lab = lab + 1;
                TabLabel(lab) = TabLabel(lab) + 1;
                sum_lab = sum_lab + lab;
            end
        end
        coarseImg(x,y) = floor(sum_lab / (winSize * winSize));

    end
end
trunCoarseImg(:,:) = coarseImg((n+1):(end-n),(n+1):(end-n));
size(coarseImg)
tempVar = trunCoarseImg(:,:);
size(tempVar(:))
inImg_1D = double(tempVar(:));%convert matrix 2D to array 1D
fusedMap = kmeans(inImg_1D,nClass, 'EmptyAction', 'singleton');
fusedMapShow = uint8(fusedMap.*(255/nClass));
outImg = reshape(fusedMapShow,s(1),s(2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Kmeans++
function [time, count,m] = K_means_Run(Img,k)
h = waitbar(0,'Please wait ...');
tic;
count = 0;
m = double(Img);
[maxRow,maxCol,rgb] = size(m); 
% initial value of centroid 
c = zeros(1,k,rgb);
for i = 1:k 
    c(1,i,:)= m(i,i,:);  
end

temp = zeros(maxRow,maxCol); % initialize as zero vector

while(1)
    waitbar(count/100);
    d=DistMatrix(m,c); % calculate objcets-centroid distances 
    [~,g]=min(d,[],3); % find group matrix g 
    if(g == temp)
        for i = 1:k
            [x,y] = find(g == i);
            num = size(x,1);
            for j = 1:num
                m(x(j),y(j),:) = c(1,i,:);
            end
        end
        break; % stop the iteration 
    else 
        count = count + 1;
        temp=g; % copy group matrix to temporary variable 
        % Recalculate the centroids
        c = zeros(1,k,rgb);
        for i = 1:k
            [x,y] = find(g == i);
            num = size(x,1);
            for j = 1:num
                c(1,i,:) = c(1,i,:) + m(x(j),y(j),:)/num;
            end
        end
    end 
end 
time = toc;
close(h); 

function d = DistMatrix(A,B) 
% A is the image
% B are the centroids
[row,col,~] = size(A);
[~,c,rgb] = size(B);
d = zeros(row,col,c);
for i = 1:c
    temp = zeros(row,col,rgb);
    for j = 1:rgb
        temp(:,:,j) = A(:,:,j) - B(1,i,j);
    end
    d(:,:,i) = sqrt(sum(temp.^2,3));
end


