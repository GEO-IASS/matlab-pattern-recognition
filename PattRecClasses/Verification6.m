%% Verification 6: Checking of rand.m with finite duration HHM
%
% This script attemps to generate 500 samples from a finite duration HMM.
% When the end state is reached, generation stops.
% The probabilities of reaching the end state are given by the last column
% of the transition probability matrix A.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------
%%

q = [0.75; 0.25];
% The transition probability matrix contains an end state whose 
% probability is enough to see the effects on the results.
% The expected number of generated samples is 10.
A = [0.86 0.04 0.1; 0.05 0.85 0.1];
mc = MarkovChain(q,A);
g1 = GaussD('Mean', 0, 'StDev', 1); %Distribution for state=1
g2 = GaussD('Mean', 3, 'StDev', 2); %Distribution for state=2
h = HMM(mc, [g1; g2]); %The HMM
[X S] = rand(h, 500); %Generate an output sequence

% Samples and States representation
plot(X,'b'); hold on;
plot(S,'-.r');
title('Finite HMM output')
ylabel('Samples and States')
xlabel('time(t)')
legend('Samples','States')
display(sprintf('Number of states: %d', length(S)));
