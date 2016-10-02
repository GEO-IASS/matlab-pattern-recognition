%% testExamples.m
%   Extracts features from the professor's melodies and plots the results.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------
%%

import features.semitones
import features.GetMusicFeatures

[m1 fs1] = audioread('melody_1.wav');
[m2 fs2] = audioread('melody_2.wav');
[m3 fs3] = audioread('melody_3.wav');

f1 = semitones(GetMusicFeatures(m1, fs1));
f2 = semitones(GetMusicFeatures(m2, fs2));
f3 = semitones(GetMusicFeatures(m3, fs3));

subplot(3,1,1);
plot(f1);
title('Melody 1');
xlabel('Samples');
ylabel('Features');
subplot(3,1,2);
plot(f2);
title('Melody 2 (similar to melody 1)');
xlabel('Samples');
ylabel('Features');
subplot(3,1,3);
plot(f3)
title('Melody 3 (different)');
xlabel('Samples');
ylabel('Features');
