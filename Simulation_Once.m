%--------------------------------------------%
%--------------- Simulation Once ------------%
%--------------------------------------------%

% InitialState:x0,y0,Vx0,Vy0

function output = Simulation_Once(InitialState,auxdata,IsPlot)

% Initial
x0 = InitialState.x0;
y0 = InitialState.y0;
Vx0 = InitialState.Vx0;
Vy0 = InitialState.Vy0;

% setting
dt = auxdata.dt;
MaxTime = auxdata.MaxTime;
acc_max = auxdata.acc_max;
acc_min = auxdata.acc_min;
g = auxdata.g;
delta_pos_min = auxdata.delta_pos_min;

% start simulation
t = 0;
x = x0;
y = y0;
Vx = Vx0;
Vy = Vy0;
delta_pos = sqrt((x^2)+(y^2));
ts = [t];
states = [x,y,Vx,Vy];
controls = [0,0];

while (t<MaxTime)&&(delta_pos>delta_pos_min)
    % calculate controls from trained model
    u = myNeuralNetworkFunction([x,y,Vx,Vy]);
    ax = u(1);
    ay = u(2);

    ax = min(ax,acc_max);
    ax = max(ax,acc_min);
    ay = min(ay,acc_max);
    ay = max(ay,acc_min);
    % dynamic
    dx_dt = Vx;
    dy_dt = Vy;
    dVx_dt = ax;
    dVy_dt = ay - g;
    % calculate the next state
    x = x + dx_dt*dt;
    y = y + dy_dt*dt;
    Vx = Vx + dVx_dt*dt;
    Vy = Vy + dVy_dt*dt;
    t = t + dt;
    % record
    states = [states;[x,y,Vx,Vy]];
    controls = [controls;[ax,ay]];
    ts = [ts;t];
    % calculate delta position
    delta_pos = sqrt((x^2)+(y^2));
end

output.result.solution.phase.time = ts;
output.result.solution.phase.state = states;
output.result.solution.phase.control = controls;

if(IsPlot)
    Plot_Optimal_Result(output);
end

end