% Control using trained model

clear;clc;
auxdata.dt = 0.02;     % step size
auxdata.g = 9.8;
auxdata.MaxTime = 20;      % Max simulation time
auxdata.delta_pos_min = 0.5;    % terminate condition
auxdata.acc_max = 20;
auxdata.acc_min = -20;
num_of_sims = 1;   % how many times we simulate
IsPlot = true;     % weather plot each simulation or not

% initial
rng('shuffle');
pairs = [];

for i = 1:num_of_sims
    % Uniform Distribution, x0 in [-100,100], y0 in [150,250],
    % Vx0 in [-10,10], Vy0 in [-10,10]
    InitialState.x0 = -100 + 200*rand;
    InitialState.y0 = 150 + 100*rand;
    InitialState.Vx0 = -10 + 20*rand;
    InitialState.Vy0 = -10 + 20*rand;

    output = Simulation_Once(InitialState,auxdata,IsPlot);
end

