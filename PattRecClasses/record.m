function [data, Fs] = record()
%Record Records a sound until the user presses any key

recorder = audiorecorder(22050, 16, 1);
display('Started recording. Press any key to finish.')
record(recorder);
pause
stop(recorder);
display('Done');
data = getaudiodata(recorder);
Fs = recorder.SampleRate;
end

