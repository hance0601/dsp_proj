close all; clc; clear;

% -------读取音频代码----%
[x_sum, fs] = audioread('C:\Users\86199\Desktop\24-9\数信综合实验\录音音频采集45s.mp3'); 

% 播放音频
ss = 450; % 播放时长设置为45s

%% 3.回声处理
% -------回声处理代码----%
% 将序列x(n)向右平移0.5s后给0.25的权重，得到新序列x_1(n)
delay_time = 0.5; % 滞后时间，以秒为单位
delay_samples = round(fs * delay_time); % 计算对应的样本数

% 初始序列
len = length(x_sum); % 确保合成序列长度足够

% 生成回声序列
echo_strength = 0.25; % 回声强度，范围在0到1之间
x_1 = [zeros(delay_samples, size(x_sum, 2)); x_sum] * echo_strength;
x_1 = x_1(1:len, :); % 确保长度一致

% 生成混响序列
x_echo = x_sum + x_1;
% -------end-----------%

% 播放回声音频
% -------播放回声音频代码----%
audio_echo = audioplayer(x_echo, fs); % 播放器回声信号

% 播放回声信号
play(audio_echo);
h = waitbar(0, '播放混响信号...'); % 创建进度条，初始值为0
for i = 1:ss
    pause(0.1); % 模拟任务执行的时间
    waitbar(i/ss, h, sprintf('播放混响信号：%.2fs', i*0.1)); % 更新进度条
end
stop(audio_echo);
close(h);
% -------end-----------%

% 存储音频
% -------存储音频代码----%
audiowrite('C:\Users\86199\Desktop\24-9\数信综合实验\3-echo.wav', x_echo, fs);
% -------end-----------%

% 可视化回声信号
% -------可视化代码----%
t = (0:length(x_echo)-1) / fs; % 时间轴

figure;
subplot(3, 2, 1);
plot(t, x_sum);
title('初始信号 x\_sum');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(3, 2, 3);
plot(t, x_1);
title('回声信号 x\_1');
xlabel('时间 (秒)');
ylabel('幅度');

subplot(3, 2, 5);
plot(t, x_echo);
title('回声叠加信号 x\_echo');
xlabel('时间 (秒)');
ylabel('幅度');

% 频域分析
L = length(x_sum);
Y = fft(x_sum); % FFT
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;

subplot(3, 2, 2);
plot(f, P1, 'k');
title('初始信号频谱');
xlabel('频率 (Hz)');
ylabel('幅值');

Y1 = fft(x_1); % FFT
P2 = abs(Y1/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(3, 2, 4);
plot(f, P1, 'k');
title('回声信号频谱');
xlabel('频率 (Hz)');
ylabel('幅值');

Y2 = fft(x_echo); % FFT
P2 = abs(Y2/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(3, 2, 6);
plot(f, P1, 'k');
title('回声叠加信号频谱');
xlabel('频率 (Hz)');
ylabel('幅值');

% 保存图像
saveas(gcf, 'C:\Users\86199\Desktop\24-9\数信综合实验\echo_signals.jpg');
% -------end-----------%