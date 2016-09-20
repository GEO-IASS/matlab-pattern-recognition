function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------

% input check
if T < 0
    error('Sequence length can not be negative.');
elseif T == 0
    S = [];
    return;
end;

nS=mc.nStates;
% First state is chosen randmonly according to the initial state
% probability distribution.
S(1) = DiscreteD(mc.InitialProb).rand(1);
for i=2:T
    if mc.finiteDuration && (S(i-1) == nS + 1)
        break;
    end;
    % Next state is chosen using the last state's row in the
    % transition probability matrix.
    S(i) = DiscreteD(mc.TransitionProb(S(i-1),:)).rand(1);
end;