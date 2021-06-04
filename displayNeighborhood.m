function displayNeighborhood(neighborhood,plotStyle)
% display a neighborhood array created by makeNeighborhood
%
% INPUTS:
%   neighborhood -- 3D array with 2 layers 
%                   LAYER 1: matrix of 0s (peaceful) and 1s (hostile)
%                   LAYER 2: matrix of 0s (not short fuse) and 1s (short
%                   fuse)
%   plotStyle    - 1 -- circles, 2 -- as image (squares)
%
% no outputs


if plotStyle == 1 % display as circles
    width = size(neighborhood,2);
    height = size(neighborhood,1);
%     x = [];
%     for t = 1:width
%         x = [x t*ones(1,height)];
%     end
%     y = repmat(height:-1:1,1,width);
    %hostiles = logical(neighborhood(:));
    
    % alternatively:
    [x,y] = meshgrid(1:width,height:-1:1);
    % hostiles = logical(neighborhood);
    hostiles = logical(neighborhood(:,:,1));
    shortfuse = logical(neighborhood(:,:,2));
    
    %figure; 
    p = plot(x(hostiles)-0.5,y(hostiles)-0.5,'ok','MarkerSize',12,'MarkerFaceColor','black');
    %p.MarkerSize = 20;
    %p.MarkerFaceColor = 'black';
    hold on;
    p2 = plot(x(~hostiles)-0.5,y(~hostiles)-0.5,'ok','MarkerSize',12);
    % add short fuse individuals
    p3 = plot(x(shortfuse)-0.5,y(shortfuse)-0.5,'or','MarkerSize',12);
    xlim([0 width]);
    ylim([0 height]);
    
    % add a grid
    grid on;
    set(gca,'GridColor','black');
    set(gca,'GridAlpha',1);
    
    % get rid of tick marks
    set(gca,'XTickLabel',[]);
    set(gca,'YTickLabel',[]);
    % alternatively:
    % a = gca;
    % a.XTickLabel = [];
    % a.GridColor = 'black';
    
    % title('DAY 1','FontSize',16);
    
elseif plotStyle == 2 % display as image / squares
    figure;
    imagesc(~neighborhood);
    colormap gray;
end