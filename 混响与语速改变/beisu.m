close all; clc; clear;

% -------读取音频代码----%
[x_sum, fs] = audioread('C:\Users\86199\Desktop\24-9\数信综合实验\录音音频采集45s.mp3'); % 读取初始序列
% -------------end-----------%

% 播放音频
ss = 200; % 播放时长设置为20s

% -------1.5倍速播放代码----%
% 1.5倍速度播放序列x_sum,即x_1_5
x_1_5 = resample(x_sum, 2, 3); % 使用重采样来实现1.5倍速播放
audio_1_5 = audioplayer(x_1_5, fs * 1.5);
play(audio_1_5); % 播放语音
h_1_5 = waitbar(0, '1.5倍播放音乐...'); % 创建进度条，初始值为0
for i = 1:ss
    pause(0.1); % 模拟任务执行的时间
    waitbar(i/ss, h_1_5, sprintf('1.5倍播放音乐：%.2fs', i*0.1)); % 更新进度条
end
stop(audio_1_5);
close(h_1_5);
% -------end---%

% 存储音频
% -------存储音频代码----%
audiowrite('.\1.5-speed.wav', x_1_5, fs * 1.5);
% -------end---%

% -------0.75倍速播放代码----%
% 0.75倍速度播放序列x_sum,即x_0_75
x_0_75 = resample(x_sum, 4, 3); % 使用重采样来实现0.75倍速播放
audio_0_75 = audioplayer(x_0_75, fs * 0.75);
play(audio_0_75); % 播放语音
h_0_75 = waitbar(0, '0.75倍播放音乐...'); % 创建进度条，初始值为0
for i = 1:ss
    pause(0.1); % 模拟任务执行的时间
    waitbar(i/ss, h_0_75, sprintf('0.75倍播放音乐：%.2fs', i*0.1)); % 更新进度条
end
stop(audio_0_75);
close(h_0_75);
% -------end---%

% -------0.5速播放代码----%
% 0.5倍速度播放序列x_sum,即x_half
x_half = resample(x_sum, 2, 1); % 使用重采样来实现0.5倍速播放
audio_half = audioplayer(x_half, fs * 0.5);
play(audio_half); % 播放语音
h_half = waitbar(0, '0.5倍播放音乐...'); % 创建进度条，初始值为0
for i = 1:ss
    pause(0.1); % 模拟任务执行的时间
    waitbar(i/ss, h_half, sprintf('0.5倍播放音乐：%.2fs', i*0.1)); % 更新进度条
end
stop(audio_half);
close(h_half);
% -------end---%

% 存储音频
% -------存储音频代码----%
audiowrite('.\0.5-half.wav', x_half, fs * 0.5);
% -------end---%

h = figure;
t = (0:length(x_sum)-1) / fs;
t_1_5 = (0:length(x_1_5)-1) / (fs * 1.5);
t_0_75 = (0:length(x_0_75)-1) / (fs * 0.75);
t_half = (0:length(x_half)-1) / (fs * 0.5);



subplot(4, 1, 1);
plot(t_1_5(1:min(4*fs, length(x_1_5))), x_1_5(1:min(4*fs, length(x_1_5))));
title('1.5倍速信号 x\_1\_5');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(4, 1, 2);
plot(t(1:min(4*fs, length(x_sum))), x_sum(1:min(4*fs, length(x_sum))));
title('初始信号 x\_sum');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(4, 1, 3);
plot(t_0_75(1:min(4*fs, length(x_0_75))), x_0_75(1:min(4*fs, length(x_0_75))));
title('0.75倍速信号 x\_0\_75');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(4, 1, 4);
plot(t_half(1:min(4*fs, length(x_half))), x_half(1:min(4*fs, length(x_half))));
title('0.5倍速信号 x\_half');
xlabel('时间 (秒)');
ylabel('幅度');

% -------绘制数据代码----%
% 利用subplot分别绘制x_sum,x_double,x_half于三个子图中（只画前4s的数据）

% 存储该图片在文件夹data中并命名为half.jpg
saveas(h, 'C:\Users\86199\Desktop\24-9\数信综合实验\half.jpg');
% -------end---%