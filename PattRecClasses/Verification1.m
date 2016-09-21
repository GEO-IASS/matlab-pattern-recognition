% Markov Chain test
% 
% This script generates 10 000 states from the given markov chain.
% Since the Markov chain is stationary, the relative frequencies of the
% states should be aporoximately equal to the values in q.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------

q = [0.75; 0.25];
A = [0.99 0.01; 0.03 0.97];
mc = MarkovChain(q, A);
states = mc.rand(10000);
tabulate(states)