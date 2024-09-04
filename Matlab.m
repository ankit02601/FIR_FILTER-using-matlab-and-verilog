% Generation of Sin wave of 1 cycle
clc;
close all; clear all;
fs=5;
Am=1;
t=0:1/fs:2*pi;
sin_wave=Am*sin(t);
figure()
plot(t,sin_wave);
xlabel('Time');
ylabel('Amplitude');
title('Sin wave');

%Add a noise
a=0.5; %upper limit of noise
b=0;  %lower limit
noise=(b-a).*rand(length(sin_wave),1)+a;
noise=noise';
sin_noise= (sin_wave + noise); % creating noisy sin signal
sin_norm = sin_noise / max(abs(sin_noise)); % these equation male value lies between 1 to -1
figure()
plot(1:length(sin_norm),sin_norm);% sin_norm on y axis
xlabel('Time');
ylabel('Amplitude');
title('sin wave + Noise');



% Convert From real to integers
total_wordlength =16;
scaling = 7;
sin_noise_integer = round(sin_norm.*(2^scaling));
figure();
plot(1:length(sin_noise_integer),sin_noise_integer);
xlabel('Time');
ylabel('Amplitude');
title('Sin wave + Noise + Scaled Signal');

%convert From integer To binary
sin_noise_in_binary_signed = dec2bin(mod((sin_noise_integer),2^total_wordlength),total_wordlength);
%sin_noise_in_binary_signed = dec2bin(sin_noise_integers, total_wordlength);
yy = cellstr(sin_noise_in_binary_signed);
fid = fopen('signal.data','wt');
fprintf(fid, '%8s\n' ,yy{:});
disp('text file for signal finished');

