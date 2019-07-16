function varargout = experiment2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experiment2_OpeningFcn, ...
                   'gui_OutputFcn',  @experiment2_OutputFcn, ...
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
function experiment2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
T = 5;
a = 1;
b = 1;
fig =imread('cameraman.bmp');
subplot(251);
imshow(fig);
title('‘≠Õº');
[numRow,numColumn] = size(fig);
H = zeros(numRow,numColumn);
j=sqrt(-1); % generate the model
for u = 1:numRow
    for v = 1:numColumn
        H(u,v) = T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-pi*j*(a*u+b*v));
    end
end
figFFT = fft2(fig);
fD = figFFT.*H;
figDegraded = real(ifft2(fD));
figDegraded = uint8(255.*mat2gray(figDegraded));
valPSNR = psnr(fig,figDegraded,8);
subplot(252);
imshow(figDegraded);
title(sprintf('Ωµ÷ ÕºœÒ, PSNR=%.4f dB',valPSNR));
function varargout = experiment2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
function fanxiang_Callback(hObject, eventdata, handles)
T = 5;
a = 1;
b = 1;
fig =imread('cameraman.bmp');
subplot(251);
imshow(fig);
title('‘≠Õº');
[numRow,numColumn] = size(fig);
H = zeros(numRow,numColumn);
j=sqrt(-1); % generate the model
for u = 1:numRow
    for v = 1:numColumn
        H(u,v) = T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-pi*j*(a*u+b*v));
    end
end
figFFT = fft2(fig);
fD = figFFT.*H;
figDegraded = real(ifft2(fD));
figDegraded = uint8(255.*mat2gray(figDegraded));
valPSNR = psnr(fig,figDegraded,8);
subplot(252);
imshow(figDegraded);
title(sprintf('Ωµ÷ ÕºœÒ, PSNR=%.4f dB',valPSNR));

r=[1.0,0.9,0.8,0.7,0.6,0.5,0.4,0.3];    
for i=1:8
    inverse_filter(r(i),numRow,numColumn,i+2,H,fD,fig);
end
% --------------------------------------------------------------------
function weina_Callback(hObject, eventdata, handles)
T = 5;
a = 1;
b = 1;
fig =imread('cameraman.bmp');
subplot(241);
imshow(fig);
title('‘≠Õº');
[numRow,numColumn] = size(fig);
H = zeros(numRow,numColumn);
j=sqrt(-1); % generate the model
for u = 1:numRow
    for v = 1:numColumn
        H(u,v) = T/(pi*(a*u+b*v))*sin(pi*(a*u+b*v))*exp(-pi*j*(a*u+b*v));
    end
end
figFFT = fft2(fig);
fD = figFFT.*H;
figDegraded = real(ifft2(fD));
figDegraded = uint8(255.*mat2gray(figDegraded));
valPSNR = psnr(fig,figDegraded,8);
subplot(242);
imshow(figDegraded);
title(sprintf('Ωµ÷ ÕºœÒ, PSNR=%.4f dB',valPSNR));
HM = abs(H.*H);
global a
a=HM;
K = [0 1e-35 1e-34 1e-33 1e-32 1e-31];  
W=cell(1,8);   
for i = 1:6
    W{i}=HM./(H.*(HM+K(i)));
end
for i=1:6
    wiener_filter(i,K(i),W{i},fD,fig);
end
% --------------------------------------------------------------------
function re_Callback(hObject, eventdata, handles)
close(gcf);