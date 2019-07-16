function varargout = experiment3(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @experiment3_OpeningFcn, ...
    'gui_OutputFcn',  @experiment3_OutputFcn, ...
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
function experiment3_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = experiment3_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
% --------------------------------------------------------------------
function MedFilt_Callback(hObject, eventdata, handles)
dock=rgb2gray(imread('dock.png'));
subplot(2,3,1);
imshow(dock);
title('原图','color','k');
count = 0;
for i = 3:2:11
    count = count+1;
    dock2=medfilt2(dock,[i,i]); %中值滤波
    subplot(2,3,count+1);
    imshow(dock2);
    title(['邻域块大小 ',num2str(i),'*',num2str(i)],'color','k');
end
% --------------------------------------------------------------------
function Dilate_Callback(hObject, eventdata, handles)
exp3;
for i = [1,3,5]
    dilate_exp4( i,2, dock3 )
end
% --------------------------------------------------------------------
function Erode_Callback(hObject, eventdata, handles)
exp3;
for i = [1,3,5]
    erode_exp3( i,2, dock3 )
end