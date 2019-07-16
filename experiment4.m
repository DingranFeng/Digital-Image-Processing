function varargout = experiment4(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experiment4_OpeningFcn, ...
                   'gui_OutputFcn',  @experiment4_OutputFcn, ...
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
function experiment4_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = experiment4_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% --------------------------------------------------------------------
function Noise_Callback(hObject, eventdata, handles)
shape=rgb2gray(imread('houghorg.bmp'));
gauss=imnoise(shape,'gaussian',0,0.2);
pepper=imnoise(shape,'salt & pepper',0.2);
% original
subplot(131);
imshow(shape);
title('Ô­Í¼','color','k');
% gaussian noised
subplot(132);
imshow(gauss);
title('¸ßË¹ÔëÉù','color','k');
% salt & pepper
subplot(133);
imshow(pepper);
title('½·ÑÎÔëÉù','color','k');
htitle=findobj('Tag','title_s');
set(htitle,'string',sprintf('ÔëÉù²úÉú'));
% --------------------------------------------------------------------
function Pepper_Callback(hObject, eventdata, handles)
% hObject    handle to Pepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
shape=rgb2gray(imread('houghorg.bmp'));
pepper=imnoise(shape,'salt & pepper',0.2);
p0=medfilt2(pepper,[9,9]);       % filtered
% binarize
p0(p0>127)=255;
p0(p0<128)=0;
flag='½·ÑÎÔëÉù';
op_exp4(p0, pepper,flag);
htitle=findobj('Tag','title_s');
set(htitle,'string',sprintf('½·ÑÎÔëÉù'));
% --------------------------------------------------------------------
function Gauss_Callback(hObject, eventdata, handles)
% hObject    handle to Gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
shape=rgb2gray(imread('houghorg.bmp'));
gauss=imnoise(shape,'gaussian',0,0.2);
gs0=medfilt2(gauss,[9,9]);       % filtered
% binarize
gs0(gs0>127)=255;
gs0(gs0<128)=0;
flag='¸ßË¹ÔëÉù';            % distinguish current noise type
op_exp4(gs0,gauss,flag);
htitle=findobj('Tag','title_s');
set(htitle,'string',sprintf('¸ßË¹ÔëÉù'));