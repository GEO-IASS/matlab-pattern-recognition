%% test1: Intensity and pitch representation
% 
% This script represents the pitch and intinsity values of each melodies
% (1, 2 and 3). The first and second melody are the same piece of music.
% The only different is the tempo (the second one is faster), so regarding 
% the tone  they should be considered equal. The third one contains
% different pitch ratios, therefore it should be considered as a different
% musical piece.
%
% We have to take into account that the intensity is an
% arbitraty unit. Sound intensity, preassure intensity and its reference
% values could change the results significantly.
%
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------
%%

% Load songs
[mel1,fs1] = audioread('songs/melody_1.wav');
[mel2,fs2] = audioread('songs/melody_2.wav');
[mel3,fs3] = audioread('songs/melody_3.wav');

%Parameters
win_len = 0.03;

% Get information of correlation and intensity
[frIseq_1] = GetMusicFeatures(mel1,fs1,win_len);
[frIseq_2] = GetMusicFeatures(mel2,fs2,win_len);
[frIseq_3] = GetMusicFeatures(mel3,fs3,win_len);

p1 = frIseq_1(1,:);
I1 = frIseq_1(3,:);   

p2 = frIseq_2(1,:);
I2 = frIseq_2(3,:);

p3 = frIseq_3(1,:);
I3 = frIseq_3(3,:);

%% Plot Intensity
%Intensity 1
t1 = 0:win_len:(length(I1)-1)*win_len;
subplot(3,1,1)
plot(t1,I1)
xlabel('Time(s)')
ylabel('Intnesity(a.u.)')
title('Intensity melody 1')


%Intensity 2
t2 = 0:win_len:(length(I2)-1)*win_len;
subplot(3,1,2)
plot(t2,I2)
xlabel('Time(s)')
ylabel('Intnesity(a.u.)')
title('Intensity melody 2')

%Intensity 3
t3 = 0:win_len:(length(I3)-1)*win_len;
subplot(3,1,3)
plot(t3,I3)
xlabel('Time(s)')
ylabel('Intnesity(a.u.)')
title('Intensity melody 3')


%% Plot Pitch
figure
t1 = 0:win_len:(length(p1)-1)*win_len;
subplot(3,1,1)
plot(t1,p1)
xlabel('Time(s)')
ylabel('Frequency(Hz)')
title('Frequency content Melody 1')


%Intensity 2
t2 = 0:win_len:(length(p2)-1)*win_len;
subplot(3,1,2)
plot(t2,p2)
xlabel('Time(s)')
ylabel('Frequency(Hz)')
title('Frequency content Melody 2')

%Intensity 3
t3 = 0:win_len:(length(p3)-1)*win_len;
subplot(3,1,3)
plot(t3,p3)
xlabel('Time(s)')
ylabel('Frequency(Hz)')
title('Frequency content Melody 3')

