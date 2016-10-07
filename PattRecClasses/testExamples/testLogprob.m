%% testLogprob.m Test of log(P(X|lambda))
%
%  Runs the forward algorithm for a given HMM with known results.
%  Fixes the scaling for the final result.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------

q = [1 0];
A = [0.9 0.1 0; 0 0.9 0.1];
mc = MarkovChain(q, A);
g1 = GaussD('Mean', 0, 'StDev',1);
g2 = GaussD('Mean',3 , 'StDev',2);
hmm = HMM(mc, [g1 g2]);
X = [-0.2 2.6 1.3];
logProb = hmm.logprob(X)
results = ['expected results:\n\n' ...
'logProb =\n' ...
'   -9.1877\n'];
display(sprintf(results))