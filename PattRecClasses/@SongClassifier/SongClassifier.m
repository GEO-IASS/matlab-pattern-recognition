% SongClassifier - build, train and evaluate a classifier.
classdef SongClassifier
    
    properties(Access=public)
        DatabaseName='.';
        Hmms=[];
        Classes={};
        ClassPaths={};
        Trained=false;
    end
    
    methods(Access=public)
        
        function sg=SongClassifier(dirName)
            sg.DatabaseName = dirName;
            dirInfo = dir(dirName);
            if size(dirInfo,1) == 0
                error('Could not find database');
                return;
            end
            for i=1:size(dirInfo,1)
                name = dirInfo(i).name;
                if (strcmp('.', name) == false) && (strcmp('..', name) == false)
                    sg.Classes = [sg.Classes {name}];
                    sg.ClassPaths = [sg.ClassPaths {[dirName '/' name]}];
                end
            end
        end
        
        function train(sg, nStates)
            distribution = DiscreteD();
            distribution.PseudoCount = 0.5;
            if length(nStates) ~= length(sg.Classes)
                error('There must be a number of states for each class');
                return;
            end
            for i=1:length(sg.Classes)
                display(sprintf('Training HMM %d.', i))
                [data, len] = loadData(sg.ClassPaths{i});
                sg.Hmms = [sg.Hmms, MakeLeftRightHMM(nStates(i), distribution, data, len)];
            end
            sg.Trained = true;
        end
        
        function lg = logprobs(sg, song, fs)
            feature = features.semitones(features.GetMusicFeatures(song, fs));
            lg = logprob(sg.Hmms, feature);
        end
        
        function [class, lprob] = classify(sg, song, fs)
            [lprob, i] = max(sg.logprobs(song, fs));
            class = sg.Classes{i};
        end
    end
end
