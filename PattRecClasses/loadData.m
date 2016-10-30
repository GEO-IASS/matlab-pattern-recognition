function [data, len] = loadData(dirName, selection)
%loadData loads the songs from a directory and extracts features
%   This function takes a directory name as an input and extracts features
%   from all the songs there. It assumes the directory holds songs named
%   1.wav, 2.wav ... N.wav, original.wav, and nothing else.
%
% Input:
%   dirName: name of directory.
%   selection: vector with song numbers to load. 
%   If selection is empty, load all songs in directory
% 
% Output:
%   data: feature sequence for each song, stored columnwise
%   len: vector with the length of each sequence
% 


data = [];
len = [];

directory = dir(dirName);
if size(directory, 1)== 0
    display('Could not find directory.');
    return;
end

if length(selection) == 0
    selection = 1:(length(directory)-3);
    % we don't wan't to count ., .. or original.wav
end

for i = selection
    name = sprintf('%s/%d.wav', dirName, i);
    [song, fs] = audioread(name);
    vect = features.semitones(features.GetMusicFeatures(song, fs));
    len = [len, length(vect)];
    data = [data, vect];
end
end

    