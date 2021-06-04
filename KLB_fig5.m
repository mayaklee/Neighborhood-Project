% KLB_fig5 
% Write a new script called KLB_fig5.m that will replicate the three plots from Figure 5. 
% Plots the individual points for each run of the simulation 
% for each percentage as they do in Figure 5.

close all;

% set number of times to run simulation and how many days for each
runTimes = 10;
nDays = 14;

% make empty array to store proportion data
data1 = zeros(10,50);

% simulate 10 runs with 0 short fused individuals
for ii = 1:2:100
    for k = 1:runTimes
        neighborhood = makeNeighborhood(6,6,0,ii);
        for jj = 1:nDays
            neighborhood = evolveNeighborhood(neighborhood);
            % store proportions in data1 array
            data1(k,((ii+1)/2)) = sum(sum(neighborhood(:,:,1)));
        end
    end
end

% create x vector to match up with data
x = int16([]);
for ii = 1:2:100
    xtemp = ones(1,10)*ii;
    x = cat(2,x,xtemp);
end

% put y values into vector
y1 = (data1(:)).';

% simulate 10 runs with 9 short fused individuals

% make array to store proportions for each level
data2 = zeros(10,50);

for ii = 1:2:100
    for k = 1:runTimes
        neighborhood = makeNeighborhood(6,6,9,ii);
        for jj = 1:nDays
            neighborhood = evolveNeighborhood(neighborhood);
            % store proportions in data2 array
            data2(k,((ii+1)/2)) = sum(sum(neighborhood(:,:,1)));
        end
    end
end
     
% put y values into vector
y2 = (data2(:)).';

% simulate 10 runs with 18 short fused individuals

% make array to store proportions for each level
data3 = zeros(10,50);

for ii = 1:2:100
    for k = 1:runTimes
        neighborhood = makeNeighborhood(6,6,18,ii);
        for jj = 1:nDays
            neighborhood = evolveNeighborhood(neighborhood);
            % store proportions in data3 array
            data3(k,((ii+1)/2)) = sum(sum(neighborhood(:,:,1)));
        end
    end
end

% put y values into vector
y3 = (data3(:)).';

% plot all 3 plots in one window
figure;
subplot(3,1,1);
plot(x,y1,'k.')
title('No Low Threshold Individuals')
xlabel('Initial Proportion Aggressive (%)') 
ylabel('Final Proportion Aggressive (%)') 
subplot(3,1,2);
plot(x,y2,'k.')
title('9 Low Threshold Individuals')
xlabel('Initial Proportion Aggressive (%)') 
ylabel('Final Proportion Aggressive (%)') 
subplot(3,1,3);
plot(x,y3,'k.')
title('18 Low Threshold Individuals')
xlabel('Initial Proportion Aggressive (%)') 
ylabel('Final Proportion Aggressive (%)') 

sgtitle('DYNAMICAL EVOLUTIONARY PSYCHOLOGY');
