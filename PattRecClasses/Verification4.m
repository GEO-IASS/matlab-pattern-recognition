%% Verification 4: Behaviour of the HMM output
%
% This script generates 500 samples from the HMM. You can run it 
% several times in order to get a good idea of the typical output 
% of this HMM (which is stationary).
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------
%%

% Simple infinite-duration HMM

q = [0.75; 0.25];%Initial values
A = [0.99 0.01; 0.03 0.97];% Transition matrix

mc = MarkovChain(q, A);
g1=GaussD('Mean',0,'StDev',1); %Distribution for state=1
g2=GaussD('Mean',3,'StDev',2); %Distribution for state=2
h=HMM(mc, [g1; g2]); %The HMM
[X,S] = rand(h, 500); %Generate an output sequence


% Samples and States representation
plot(X,'b'); hold on;
plot(S,'-.r');
title('HMM output')
ylabel('Samples and States')
xlabel('time(t)')
legend('Samples','States')


