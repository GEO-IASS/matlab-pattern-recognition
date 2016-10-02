%% testTransposed.m
%   Extracts features from a melody and the same melody transposed.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------
%%

import features.semitones
import features.GetMusicFeatures

[m fs] = audioread('melody_1.wav');

f1 = GetMusicFeatures(m, fs);
f2 = f1;
f2(1,:) = f2(1,:)*1.5;
f1 = semitones(f1);
f2 = semitones(f2);

subplot(2,1,1);
plot(f1);
title('Original melody');
xlabel('Samples');
ylabel('Features');
subplot(2,1,2);
plot(f2);
title('Transposed melody');
xlabel('Samples');
ylabel('Features');
