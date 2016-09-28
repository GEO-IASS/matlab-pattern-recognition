%% Verification 7:
%
% This script shows that the implemented code can also work with output
% state distributions that generate arrays (not only scalar values).
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------
%%

% Gaussian vectors (if covariance parameter is used, it should be
% symmetric)
Gauss_vec(1) = GaussD('Mean',[0 3],'Covariance',[1 0;0 1]); % State 1 distribution (b1)
Gauss_vec(2) = GaussD('Mean',[1 2],'Covariance',[2 1;1 4]); % State 2 distribution (b2) (non- diagonal covariance matrix)

q = [0.75;0.25]; % Initialization
A = [0.99 0.01;0.03 0.97]; % Transition Matrix
mc = MarkovChain(q,A);
h = HMM(mc,Gauss_vec);
[X,S] = rand(h, 10000); %T = 500;

sample_mean = mean(X, 2);
display(sprintf('Sample mean: (%f, %f)', sample_mean(1), sample_mean(2)))
%should be close to 0.25, 2.75
