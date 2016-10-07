%logP=logprob(hmm,x) gives conditional log(probability densities)
%for an observed sequence of (possibly vector-valued) samples,
%for each HMM object in an array of HMM objects.
%This can be used to compare how well HMMs can explain data from an unknown source.
%
%Input:
%hmm=   array of HMM objects
%x=     matrix with a sequence of observed vectors, stored columnwise
%NOTE:  hmm DataSize must be same as observed vector length, i.e.
%       hmm(i).DataSize == size(x,1), for each hmm(i).
%       Otherwise, the probability is, of course, ZERO.
%
%Result:
%logP=  array with log probabilities of the complete observed sequence.
%logP(i)=   log P[x | hmm(i)]
%           size(logP)== size(hmm)
%
%The log representation is useful because the probability densities
%exp(logP) may be extremely small for random vectors with many elements
%
%Method: run the forward algorithm with each hmm on the data.
%
%Ref:   Arne Leijon (20xx): Pattern Recognition.
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------

function logP=logprob(hmm,x)
hmmSize=size(hmm);%size of hmm array
T=size(x,2);%number of vector samples in observed sequence
logP=zeros(hmmSize);%space for result
for i=1:numel(hmm)%for all HMM objects
    %Note: array elements can always be accessed as hmm(i),
    %regardless of hmmSize, even with multi-dimensional array.
    %
    %logP(i)= result for hmm(i)

    [pX, scale] = prob(hmm(i).OutputDistr, x);
    [~, c] = hmm(i).StateGen.forward(pX);
    
    if isscalar(scale)% if numel(pD)==1, i.e only 1 state.
        scale = T*scale;
    else
        scale = sum(scale);
    end
    logP(i) = sum(log(c))+scale; %(eq 5.54 or 5.55)
end;

% Note: For finite duration HMMs, it's not necessary to rescale c(T+1)