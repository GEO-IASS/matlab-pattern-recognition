function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors:
% Alfredo Fanghella (ajfv@kth.se)
% Hirahi Galindo (hirahi@kth.se)
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;

% First we split the [0,1] interval in sections according to the  pD object
% probability mass vector. We store the upper limit of each section.
upperLimits = pD.ProbMass;
for i=2:length(upperLimits)
    upperLimits(i) = upperLimits(i) + upperLimits(i-1);
end;

for i=1:nData
    uniformValue = rand;    % value in [0,1] from a uniform distribution
    R(i) = find(uniformValue <= upperLimits, 1);  % section where the value is in  
end;
    