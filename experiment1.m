function varargout = experiment1(varargin)
% EXPERIMENT1 MATLAB code for experiment1.fig
%      EXPERIMENT1, by itself, creates a new EXPERIMENT1 or raises the existing
%      singleton*.
%
%      H = EXPERIMENT1 returns the handle to a new EXPERIMENT1 or the handle to
%      the existing singleton*.
%
%      EXPERIMENT1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENT1.M with the given input arguments.
%
%      EXPERIMENT1('Property','Value',...) creates a new EXPERIMENT1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before experiment1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to experiment1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help experiment1

% Last Modified by GUIDE v2.5 10-May-2019 19:29:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @experiment1_OpeningFcn, ...
    'gui_OutputFcn',  @experiment1_OutputFcn, ...
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


% --- Executes just before experiment1 is made visible.
function experiment1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to experiment1 (see VARARGIN)

% Choose default command line output for experiment1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes experiment1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = experiment1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function re_Callback(hObject, eventdata, handles)
% hObject    handle to re (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


function FT_Callback(hObject, eventdata, handles)
%% 傅里叶变换
subplot(131);
fig = imread('cameraman.bmp');
imshow(fig);
title('原始图像','fontsize',15);
subplot(132);
ft = fft2(fig);
ft_ = fftshift(ft); % 将零频移动至二维频谱的中心
s1 = size(ft,1); s2 = size(ft,2);
re = real(ft_); im = imag(ft_);
amplitude = sqrt(re.^2+im.^2); % 频谱幅值
amplitude_ = reshape(amplitude,1,s1*s2);
amplitude_ = mapminmax(amplitude_,0,255);
amplitude = reshape(amplitude_,s1,s2); % 频谱幅值范围变换至0~255
imshow(amplitude);
title('傅立叶变换频谱图','fontsize',15)
subplot(133);
zeroRate = 0.95; % 频谱置零比例
amplitudeSort = sort(amplitude_); % 频谱幅值排序
amplitudeThreshold = amplitudeSort(round(s1*s2*zeroRate)); %幅值门限
for m = 1:s1
    for n = 1:s2
        if amplitude(m,n) < amplitudeThreshold
            re(m,n) = 0; im(m,n) = 0;
        end
    end
end
ft_ = ifft2(ifftshift(re+1i*im))/255; % 傅立叶逆变换
imshow(ft_);
title('傅里叶逆变换图','fontsize',15);
PSNR = psnr(fig,255*ft_,8); %计算峰值信噪比（PSNR）
set(handles.word,'string','PSNR = ');
set(handles.val,'string',PSNR);

function DCT_Callback(hObject, eventdata, handles)
%% 离散余弦变换
% ---------------------------原始图像---------------------------
subplot(131);
fig = imread('cameraman.bmp');
imshow(fig);
title('原始图像','fontsize',15);
subplot(132);
figDCT = dct2(fig);
s1 = size(figDCT,1); s2 = size(figDCT,2);
imshow(figDCT,[0,255]);
title('离散余弦变换图','fontsize',15);
subplot(133);
zeroRate = 0.95;
Sort = sort(reshape(figDCT,1,s1*s2)); % 排序
Threshold = Sort(round(s1*s2*zeroRate)); % 门限
figDCT(figDCT<Threshold) = 0;
fig_ = idct2(figDCT);
imshow(fig_,[0 255]);
title('离散余弦逆变换图','fontsize',15);
PSNR = psnr(fig,fig_,8); %计算PSNR
set(handles.word,'string','PSNR = ');
set(handles.val,'string',PSNR);
function HT_Callback(hObject, eventdata, handles)
%% 哈达玛变换
% ---------------------------原始图像---------------------------
subplot(131);
fig = imread('cameraman.bmp');
imshow(fig);
title('原始图像','fontsize',15);
subplot(132);
H = hadamard(256);
fig = double(fig);
figHT = H*fig*H./(256^2);
s1 = size(figHT,1); s2 = size(figHT,2);
imshow(figHT*2^10,[0,255]);
title('哈达玛变换图','fontsize',15)
subplot(133);
zeroRate = 0.95;
Sort = sort(reshape(figHT,1,s1*s2)); % 排序
Threshold = Sort(round(s1*s2*zeroRate)); % 门限
figHT(figHT<Threshold) = 0;
fig_ = H*figHT*H;
imshow(fig_,[0 255]);
title('哈达玛逆变换图','fontsize',15);
PSNR = psnr(fig,fig_,8); % 计算PSNR
set(handles.word,'string','PSNR = ');
set(handles.val,'string',PSNR);

function compare_Callback(hObject, eventdata, handles)
fig = imread('cameraman.bmp');
valPSNR = 15:0.1:16;
nval = length(valPSNR);
% 置零比例数列
FTrate = zeros(1,nval);
DCTrate = zeros(1,nval);
HTrate = zeros(1,nval);
for i = 1:nval
    i
    for Rate = 0.02:0.01:1
        %% ------------------------------------------------------------
        if FTrate(i) == 0
            ft = fft2(fig);
            ft_ = fftshift(ft); % 将零频移动至二维频谱的中心
            s1 = size(ft,1); s2 = size(ft,2);
            re = real(ft_); im = imag(ft_);
            amplitude = sqrt(re.^2+im.^2); % 频谱幅值
            amplitude_ = reshape(amplitude,1,s1*s2);
            amplitude_ = mapminmax(amplitude_,0,255);
            amplitude = reshape(amplitude_,s1,s2); % 频谱幅值范围变换至0~255
            amplitudeSort = sort(amplitude_); % 频谱幅值排序
            amplitudeThreshold = amplitudeSort(round(s1*s2*Rate)); %幅值门限
            for m = 1:s1
                for n = 1:s2
                    if amplitude(m,n) < amplitudeThreshold
                        re(m,n) = 0; im(m,n) = 0;
                    end
                end
            end
            ft_ = ifft2(ifftshift(re+1i*im))/255; % 傅立叶逆变换
            PSNR = psnr(fig,255*ft_,8); %计算峰值信噪比（PSNR）
            if abs(PSNR-valPSNR(i)) < 7
                FTrate(i) = Rate;
            end
        end
%         PSNR
        %% ------------------------------------------------------------
        if DCTrate(i) == 0
            figDCT = dct2(fig);
            s1 = size(figDCT,1); s2 = size(figDCT,2);
            Sort = sort(reshape(figDCT,1,s1*s2)); % 排序
            Threshold = Sort(round(s1*s2*Rate)); % 门限
            figDCT(figDCT<Threshold) = 0;
            fig_ = idct2(figDCT);
            PSNR = psnr(fig,fig_,8); %计算PSNR
            if abs(PSNR-valPSNR(i)) < 0.5
                DCTrate(i) = Rate;
            end
        end
%         PSNR
        %% ------------------------------------------------------------
        if HTrate(i) == 0
            H = hadamard(256);
            fig = double(fig);
            figHT = H*fig*H./(256^2);
            s1 = size(figHT,1); s2 = size(figHT,2);
            Sort = sort(reshape(figHT,1,s1*s2)); % 排序
            Threshold = Sort(round(s1*s2*Rate)); % 门限
            figHT(figHT<Threshold) = 0;
            fig_ = H*figHT*H;
            PSNR = psnr(fig,fig_,8); % 计算PSNR
            if abs(PSNR-valPSNR(i)) < 0.5
                HTrate(i) = Rate;
            end
        end
%         PSNR
    end
end
figure
plot(valPSNR,256*256*(1-FTrate),valPSNR,256*256*(1-DCTrate),valPSNR,256*256*(1-HTrate),'linewidth',1.4)
legend('FT','DCT','HT')