% SongClassifier - build, train and evaluate a classifier.
classdef SongClassifier
    
    properties(Access=public)
        DatabaseName='.';
        Hmms=[];
        Classes={};
        ClassPaths={};
        Trained=false;
        nStates=0;
    end
    
    methods(Access=public)
        
        function sc=SongClassifier(dirName, nStates)
            sc.DatabaseName = dirName;
            sc.nStates = nStates;
            dirInfo = dir(dirName);
            if size(dirInfo,1) == 0
                error('Could not find database');
                return;
            end
            for i=1:size(dirInfo,1)
                name = dirInfo(i).name;
                if (strcmp('.', name) == false) && (strcmp('..', name) == false)
                    sc.Classes = [sc.Classes {name}];
                    sc.ClassPaths = [sc.ClassPaths {[dirName '/' name]}];
                end
            end
            
            if length(sc.Classes) ~= length(nStates)
                error('Length of input nStates must be the same as the number of classes in the directory.');
            end
        end
        
        function sc=train(sc)
            distribution = DiscreteD();
            distribution.PseudoCount = 0.5;

            for i=1:length(sc.Classes)
                display(sprintf('Training HMM %d.', i))
                [data, len] = loadData(sc.ClassPaths{i}, []);
                sc.Hmms = [sc.Hmms, MakeLeftRightHMM(sc.nStates(i), distribution, data, len)];
            end
            sc.Trained = true;
        end
        
        function lg = logprobs(sc, song, fs)
            feature = features.semitones(features.GetMusicFeatures(song, fs));
            lg = logprob(sc.Hmms, feature);
        end
        
        function [class, lprob] = classify(sc, song, fs)
            [lprob, i] = max(sc.logprobs(song, fs));
            class = sc.Classes{i};
        end
        
        function [err, classErr, errList] = validate(sc, folds)
            
            % Get the size of each class
            classSize = [];
            for i=1:length(sc.Classes)
                current = length(dir(sc.ClassPaths{i}))-3;
                classSize(i) = current;
                if current < folds
                    error('Not enough samples for the number of folds.');
                end
            end
            
            % get the partitions for each class
            partition = cell(length(sc.Classes), folds, 3);
            fprintf('\nPartitioning data (%d classes):', length(sc.Classes));
            for i=1:length(sc.Classes)
                fprintf(' %d', i);
                samples = randperm(classSize(i));
                for j=0:folds-1
                   low = floor(j*classSize(i)/folds)+1;
                   high = floor((j+1)*classSize(i)/folds);
                   songs = samples(low:high);
                   [data, len] = loadData(sc.ClassPaths{i}, songs);
                   partition{i, j+1, 1} = data;
                   partition{i, j+1, 2} = len;
                   partition{i, j+1, 3} = songs;
                end
            end
            fprintf('. Done.\n')
            
            distribution = DiscreteD(); % for HMM creation
            distribution.PseudoCount = 0.5;
            
            % get error
            err = 0;
            errList = {};
            classErr = zeros(1, length(sc.Classes));
            for i=1:folds
                sc.Hmms = [];
                fprintf('Building classifier %d: ', i);
                % train each HMM without using fold i
                for j=1:length(sc.Classes)
                    [data, len] = sc.flattenCells(partition,j,i);
                    sc.Hmms = [sc.Hmms, MakeLeftRightHMM(sc.nStates(j), distribution, data, len)];
                end
                fprintf('Done. Evaluating: ');
                
                
                % evaluate fold i
                misclassified = 0;
                totalSongs = 0;
                for j=1:length(sc.Classes)
                    songs = sc.splitData(partition, j, i);
                    for k=1:size(songs,2)
                        [~, classIndex] = max(logprob(sc.Hmms, songs{k,1}));
                        if classIndex ~= j
                            misclassified = misclassified + 1;
                            songName = sprintf('%s/%d.wav', sc.ClassPaths{j}, songs{k,2});
                            errList = [errList, {songName; sc.Classes{classIndex}}];
                            classErr(j) = classErr(j) + 1/classSize(j);
                        end
                    end
                    totalSongs = totalSongs + size(songs,2);
                end
                % add error to average
                fprintf('Error rate: %.6f\n', misclassified/totalSongs);
                err = err + misclassified/(totalSongs*folds);
            end
            fprintf('Average error: %.6f\n', err);
        end
    end
    
    methods(Access=private) % helper methods
        function [data, len] = flattenCells(sc, partition, class, fold)
            data = [];
            len = [];
            for i=1:size(partition,2)
                if i ~= fold
                    data = [data, partition{class, i, 1}];
                    len = [len, partition{class, i, 2}];
                end
            end
        end
        
        function splitted = splitData(sc, partition, class, fold)
           amount = length(partition{class, fold, 3});
           songs = partition{class, fold, 3};
           data = partition{class, fold, 1};
           len = partition{class, fold, 2};
           splitted = cell(amount, 2);
           low = 0;
           for i=1:amount
               splitted{i,1} = data(low+1:low+len(i));
               splitted{i,2} = songs(i);
               low = low + len(i);
           end
        end
    end
end
