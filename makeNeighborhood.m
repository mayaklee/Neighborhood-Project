function neighborhood = makeNeighborhood(width,height,nSF,propHostile)
% create a "neighborhood" (matrix of 0s and 1s) for social simulation
%
% INPUTS:
%   width - the width of the neighborhood (# of cols) -- must be whole num
%   height - height of neighborhood (# of rows) -- whole num
%   nSF - number of short fuse individuals
%   propHostile - percent of hostile individuals -- whole num, not decimal
%
% OUTPUTS:
%   neighborhood -- 3D array with 2 layers 
%                   LAYER 1: matrix of 0s (peaceful) and 1s (hostile)
%                   LAYER 2: matrix of 0s (not short fuse) and 1s (short
%                   fuse)
%
% Example:
%  >> n = makeNeighborhood(4,3,3,50);
% first layer is a 4 x 3 matrix of 0s and 1s (hostile/peaceful) with 50%
% hostile
% second layer is a 4 x 3 matrix of 0s and 1s (not short fuse/short fuse)

% check inputs
if nargin<2
    warning('No height of neighborhood specified. Using default value of 6');
    height = 6;
end
if nargin<1 
    warning('No width of neighborhood specified. Using default value of 6');
    width = 6;
end    
if isempty(width) 
    warning('No width of neighborhood specified. Using default value of 6');
    width = 6;
end
if isempty(height)
    warning('No height of neighborhood specified. Using default value of 6');
    height = 6;
end
if isempty(nSF)
    warning('Number of short fused individuals not specified. Using default value of 6');
    nSF = 6;
end
if isempty(propHostile)
    warning('Proportion of hostile individuals not specified. Using default value of 50%');
    propHostile = 50;
end
if ~isnumeric(width) || ~isnumeric(height) || ~isnumeric(nSF) || ~isnumeric(propHostile)
    error('Inputs must be numbers');
end
if width <= 0 || height <= 0
    error('size of neighborhood must be a positive number');
end
if nSF < 0 || nSF > (width*height)
    error('Number of short fused individuals must be a number between 0 and the total amount of people')
end
if width ~= round(width) || height ~= round(height) || nSF ~= round(nSF)
    warning('Inputs must be whole numbers; rounding');
    width = round(width);
    height = round(height);
    nSF = round(nSF);
end
if propHostile > 100 || propHostile < 0 
    error('Proportion of people hostile must be between 0 and 100 percent');
end

rng('shuffle'); % seed random number generator
%rng(3);

% make a matrix:
% neighborhood = zeros(height,width);
neighborhood = zeros(height,width,2);

% count number of people in the neighborhood
nPeeps = numel(neighborhood)/2; % because 2 layers need to divide by 2
% nPeeps = height*width;

% make designated amount of people hostile as specified in propHostile
randIdx = randperm(nPeeps);
% divide whole number by 100 to get decimal and multiply by number of
% people to get number hostile, then round to whole number
hostileIdx = randIdx( 1:round((propHostile/100)*nPeeps) );
neighborhood(hostileIdx) = 1;

% make nSF people short fuse
randIdxSF = randperm(nPeeps);
SFIdx = randIdxSF(1:nSF);
% add SFIdx to number of people to push indexes in to the second layer of
% matrix
neighborhood(SFIdx + nPeeps) = 1;


% all in one line:
%neighborhood(randperm(nPeeps,nPeeps/2)) = 1;