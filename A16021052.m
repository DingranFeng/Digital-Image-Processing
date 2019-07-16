function varargout = A16021052(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A16021052_OpeningFcn, ...
                   'gui_OutputFcn',  @A16021052_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function A16021052_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = A16021052_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function fig_CreateFcn(hObject, eventdata, handles)
imshow('cameraman.bmp');
function experiment1_Callback(hObject, eventdata, handles)
experiment1();
function experiment2_Callback(hObject, eventdata, handles)
experiment2();
function experiment3_Callback(hObject, eventdata, handles)
experiment3();
function experiment4_Callback(hObject, eventdata, handles)
experiment4();
function experiment5_Callback(hObject, eventdata, handles)
function exit_Callback(hObject, eventdata, handles)
close(gcf);