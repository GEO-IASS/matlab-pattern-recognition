% Hidden Markov Model test.
%
% This script generates 10 000 scalar random numbers from a stationary
% HMM. The mean and variance of the output should approximately equal the
% theoretical results.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------

mc = MarkovChain([0.75; 0.25], [0.99 0.01; 0.03 0.97]);
g1 = GaussD('Mean', 0, 'StDev', 1); %Distribution for state=1
g2 = GaussD('Mean', 3, 'StDev', 2); %Distribution for state=2
h = HMM(mc, [g1; g2]); %The HMM
x = rand(h, 10000); %Generate an output sequence
display(sprintf('Mean: %f\nVariance: %f', mean(x), var(x)))
