% generate state-action pairs from several optimal samples 

% setting
clear;clc;
num_of_pairs = 100;      % how many state-action pairs are generated from each sample
IsPlot = false;     % weather plot each optimal sample or not
num_of_samples = 1000;   % how many times we simulate

auxdata.GaussN = 10;
auxdata.acc_max = 20;
auxdata.acc_min = -20;
auxdata.g = 9.8;
auxdata.phi = 0.1;

% initial
rng('shuffle');
pairs = [];

for i = 1:num_of_samples
    % Uniform Distribution, x0 in [-100,100], y0 in [150,250],
    % Vx0 in [-10,10], Vy0 in [-10,10]
    InitialState.x0 = -100 + 200*rand;
    InitialState.y0 = 150 + 100*rand;
    InitialState.Vx0 = -10 + 20*rand;
    InitialState.Vy0 = -10 + 20*rand;

    % Generate an optimal sample with random initial state
    output = Generate_A_Sample(InitialState,auxdata,IsPlot);

    % generate state-action pairs from each sample 
    pairs_from_a_sample = Generate_SAPairs_From_Sample(output,num_of_pairs);

    % record ann state-action pairs
    pairs = [pairs;pairs_from_a_sample];
end

states = pairs(:,1:4);
controls = pairs(:,5:6);

save SAPairs pairs states controls