%% Clear the workspace and the screen
sca; % 清除屏幕显示内容 
close all; % 关闭所有窗口
clearvars; % 清除运行过程中的所有变量
% trigger(0); % 将并口的电平记为低

%% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2); % 优先度比较,选择一种启动模式,内容为0,1,2，数字越大，启动项越多
Screen('Preference', 'SkipSyncTests', 1); % 跳过电子束回溯的时间
% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens'); % 返回内容为显示器列表，0=全屏，1=第一个显示器，2=第二个显示器

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens); % 择出数字标签最大的显示器进行显示

% Define black and white (white will be 1 and black 0). This is because
% in general luminace values are defined between 0 and 1 with 255 steps in
% between. All values in Psychtoolbox are defined between 0 and 1
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber); % 根据屏幕属性，得到原始黑色和原始白色

% Do a simply calculation to calculate the luminance value for grey. This
% will be half the luminace values for white
grey = white / 2; % 根据白色确定灰色

% Open an on screen window using PsychImaging and color it grey.
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey); % 设置屏幕界面
% window是窗口句柄，windowRect是窗口坐标，color是窗口的背景颜色

% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window); % 获取窗口的刷新时间,前缓冲区和后缓冲区之间的刷新，相当于显示器屏幕刷新一帧所需要的时间

% Retreive the maximum priority number
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel); % 确定窗口的优先级设置

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect); % 获取窗口的中心坐标值

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 150 150]; % 方块大小的确定

% Define black,white and red
black = [1 1 1];
white = [0 0 0];
red   = [1 0 0]; % 颜色的确定

% Numer of frames to wait when specifying good timing. Note: the use of
% wait frames is to show a generalisable coding. For example, by using
% waitframes = 2 one would flip on every other frame. See the PTB
% documentation for details. In what follows we flip every frame.

waitframes = 1;
rectColor1 = white;
rectColor2 = white;
rectColor3 = white;
rectColor4 = white; % 初值的确定

img  = imread('pause.jpg');
imgu = imread('up.jpg');
imgd = imread('down.jpg');
imgl = imread('left.jpg');
imgr = imread('right.jpg');
img1 = imread('left_sys.jpg');
img2 = imread('right_sys.jpg');
img3 = imread('up_sys.jpg');
img4 = imread('down_sys.jpg');

% Flip outside of the loop to get a time stamp
vbl = Screen('Flip', window); % 使得屏幕的界面快速呈现
time = 0;
s = 0;
m=0;
% vidobj = videoinput('winvideo',1);  
% triggerconfig(vidobj,'manual');  
% start(vidobj); 
%% Run until a key is pressed
while time < 2000 % 判断是否到达预设时间300/60=5s
%     snapshot = getsnapshot(vidobj);
%     Screen('PutImage',window,snapshot);
%     vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
%     % 设置实验引导语
%     pause(1);
    % 暂停5秒
     dx = 1;
     switch round(dx)  %获取一个随机数
         case 1    
           Screen('PutImage',window,imgu);
           vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
         case 2
           Screen('PutImage',window,imgd);
           vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
         case 3
           Screen('PutImage',window,imgl);
           vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
         otherwise
           Screen('PutImage',window,imgr);
           vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
           
     end
     pause(3);
     % Center the rectangle on the centre of the screen
     centeredRect1 = CenterRectOnPointd(baseRect, xCenter, yCenter*0.05);
     centeredRect2 = CenterRectOnPointd(baseRect, xCenter, yCenter*1.95); 
     centeredRect3 = CenterRectOnPointd(baseRect, xCenter*0.03, yCenter);
     centeredRect4 = CenterRectOnPointd(baseRect, xCenter*1.97, yCenter);% 给屏幕显示的4个方块设定屏幕上所处位置
     while time-s*2000 < 2000
         % Draw the rect to the screen
         Screen('FillRect', window, rectColor1, centeredRect1);
         Screen('FillRect', window, rectColor2, centeredRect2);
         Screen('FillRect', window, rectColor3, centeredRect3);
         Screen('FillRect', window, rectColor4, centeredRect4); % 在屏幕上特定的点位画出相应的方块,确定颜色和确定位置
         Screen('PutImage', window, img1,[xCenter*0.4,yCenter*0.95,xCenter*0.8,yCenter*1.05]);
         Screen('PutImage', window, img2,[xCenter*1.2,yCenter*0.95,xCenter*1.6,yCenter*1.05]);
         Screen('PutImage', window, img3,[xCenter*0.95,yCenter*0.5,xCenter*1.05,yCenter*0.8]);
         Screen('PutImage', window, img4,[xCenter*0.95,yCenter*1.2,xCenter*1.05,yCenter*1.5]);

         % Flip to the screen
         vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);% 切换时间同屏幕刷新时间一致
         time = time + 1;
         a = rem(time,9);% time/9取其余数，分频为6.7HZ
        if a == 5
           rectColor1 = [0 0 0];% 余数为5时，矩阵取色为红色
        elseif a == 0
           rectColor1 = [1 1 1];% 余数为0时，矩阵取色为白色
        end
        b=rem(time,6);% time/6取余数，分频为10HZ
        if b == 3
           rectColor2 = [0 0 0];% 余数为3时，矩阵取色为红色
        elseif b == 0
           rectColor2 = [1 1 1];% 余数为0时，矩阵取色为白色
        end
        c=rem(time,5);% time/5取余数，分频为12HZ
        if c == 3
           rectColor3 = [0 0 0];% 余数为3时，矩阵取色为红色
        elseif c == 0
           rectColor3 = [1 1 1];% 余数为0时，矩阵取色为白色
        end
        d=rem(time,4);% time/4取余数，分频为15HZ
        if d == 2
           rectColor4 = [0 0 0];% 余数为2时，矩阵取色为红色
        elseif d == 0
           rectColor4 = [1 1 1];% 余数为0时，矩阵取色为白色     
        end
     end 
    s = s+1;
%     trigger(0); % 并口电平记为0
end
% stop(vidobj);  
% delete(vidobj);  
% Clear the screen.
sca;