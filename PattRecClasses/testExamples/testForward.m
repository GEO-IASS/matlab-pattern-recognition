%% testForward.m Forward algorithm test
%
%  Runs the forward algorithm for a Markov chain with
%  known results.
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
X = [-0.2 2.6 1.3];
[pX, ~] = prob([g1 g2], X); 
[alfaHat, c] = mc.forward(pX)
results = ['expected results:\n\n' ...
'alfaHat =\n' ...
'   1.0000 0.3847 0.4189\n' ...
'        0 0.6153 0.5811\n' ...
'c =\n' ...
'   1.0000 0.1625 0.8266 0.0581\n'];
display(sprintf(results))