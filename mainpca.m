function varargout = mainpca(varargin)
% MAINPCA MATLAB code for mainpca.fig
%      MAINPCA, by itself, creates a new MAINPCA or raises the existing
%      singleton*.
%
%      H = MAINPCA returns the handle to a new MAINPCA or the handle to
%      the existing singleton*.
%
%      MAINPCA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINPCA.M with the given input arguments.
%
%      MAINPCA('Property','Value',...) creates a new MAINPCA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainpca_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainpca_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainpca

% Last Modified by GUIDE v2.5 25-Apr-2019 22:55:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainpca_OpeningFcn, ...
                   'gui_OutputFcn',  @mainpca_OutputFcn, ...
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


% --- Executes just before mainpca is made visible.
function mainpca_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainpca (see VARARGIN)

% Choose default command line output for mainpca
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainpca wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainpca_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clear all
%close all
%clc

Training_Path = 'C:\Users\TEJAS\Desktop\PCA (2)\PCA\TrainDatabase_PCA';  %Set your directory for training data file
Testing_Path = 'C:\Users\TEJAS\Desktop\PCA (2)\PCA\TestDatabase_PCA';    %Set your directory for testing data file

disp('Pick a Testing Photo From TestDatabase please')
%TestImage=imgetfile();
[filename, pathname] = uigetfile({'*.jpg'},'Select a Testing Photo From TestDatabase');
disp('Computing......')
TestImage = [pathname, filename];
im = imread(TestImage);

Training_Data = ReadFace(Training_Path);
[m, A, Eigenfaces] = EigenfaceCore(Training_Data);
OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(Training_Path,'\',OutputName);
SelectedImage = imread(SelectedImage);

Visualize_Eigenface(Eigenfaces,128,128);

%figure('name','Recognition Result')
%subplot(1,2,1);
axes(handles.axes1);
imshow(im)
%title('Test Image');

%subplot(1,2,2);
axes(handles.axes2);
imshow(SelectedImage);
%title('Recognition Result');
disp('Done')



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(mainpca);