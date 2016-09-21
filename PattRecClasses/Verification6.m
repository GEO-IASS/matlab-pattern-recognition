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

mc = MarkovChain([0.75; 0.25], [0.98 0.01 0.01; 0.03 0.96 0.01]);
g1 = GaussD('Mean', 0, 'StDev', 1); %Distribution for state=1
g2 = GaussD('Mean', 3, 'StDev', 2); %Distribution for state=2
h = HMM(mc, [g1; g2]); %The HMM
[x s] = rand(h, 500); %Generate an output sequence

plot(x)
title('HMM output')
xlabel('time(t)')
ylabel('Samples')
display(sprintf('Number of states: %d', length(s)));