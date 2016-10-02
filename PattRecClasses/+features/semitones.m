function S = semitones(frIsequence)
%EXTRACT extracts feature representing semitones
%
%   The functions chooses a base frequency, used as the reference value for
%   the semitone calculation. It does not pick the smallest value because
%   it can be the result from noise during silence.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------

S = frIsequence(1,:);

% correlation is mapped to range [0,1]
cor = frIsequence(3,:)/max(frIsequence(3,:));

% log(intensisty) is mapped to range [0,1]
intensity = log(frIsequence(2,:));
intensity = intensity - min(intensity);
intensity = intensity/max(intensity);

% treshold is chosen to detect pause/silence
treshold = mean(cor+intensity)/2;

% all samples under treshold are considered a pause/silence
notNoisy = [];
noisy = [];
for i=1:length(S)
   if (cor(i)+intensity(i))/2 > treshold
       notNoisy = [notNoisy S(i)];
   else
       noisy = [noisy i];
   end
end
baseFrequency = min(notNoisy);

% the pitches are transformed to semitones
S = round(12*log2(frIsequence(1,:)/baseFrequency)) + 2;

for i=noisy
   S(i) = 1;
end

treshold = mean(S) + 4*std(S);
for i=1:length(S)
   if S(i) > treshold % anything this far away is assumed to be a pause too.
       S(i) = 1;
   end
end
end
