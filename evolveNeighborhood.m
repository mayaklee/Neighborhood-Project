function newNeighborhood = evolveNeighborhood(neighborhood)

% get the size of the neighborhood
nRows = size(neighborhood,1);
nCols = size(neighborhood,2);
% alternatively:
% [nRows, nCols] = size(neighborhood);

% make a newNeighborhood placeholder:
newNeighborhood = nan(nRows,nCols,2); % make 3D array
% the short fuse status doesn't change
newNeighborhood(:,:,2) = neighborhood(:,:,2);

% go over every person in the neighborhood:
for row = 1:nRows
    for col = 1:nCols
        person_hostile = neighborhood(row,col,1);
        
        % select local 3x3 neighborhood:
        local = neighborhood( max([1, row-1]): min([row+1, nRows]), ...
            max([1,col-1]):min([col+1,nCols]) );
        
        % compute number of hostile individuals:
        nHostile = sum(sum(local))-person_hostile;
        nNeighbors = numel(local)-1;
        nPeaceful = nNeighbors - nHostile;
        
        % update person:
        if newNeighborhood(row,col,2)==0
            if nHostile < nPeaceful
             newNeighborhood(row,col,1) = 0;
            elseif nHostile > nPeaceful
                newNeighborhood(row,col,1) = 1;
            else
                newNeighborhood(row,col,1) = person_hostile;
            end
         elseif newNeighborhood(row,col,2)==1
            if nHostile > 0
               newNeighborhood(row,col) = 1;
            else
               newNeighborhood(row,col) = 0;
            end
        end 
    end % cols
end % rows