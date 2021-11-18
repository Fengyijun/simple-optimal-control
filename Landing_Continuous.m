%-------------------------------------------------------------------------%
%------------------- BEGIN Function Landing_Continuous.m -----------------%
%-------------------------------------------------------------------------%
% state:(x,y,Vx,Vy)
% time:(t)
% control:(ax,ay)

function phaseout = Landing_Continuous(input)

state = input.phase.state;
u = input.phase.control;

g = input.auxdata.g;    % Gravity

x = state(:,1); % position_x
y = state(:,2); % position_y
Vx = state(:,3); % velocity_x
Vy = state(:,4); % velocity_y

ax = u(:,1);  % acc_x
ay = u(:,2);  % acc_y

dx_dt = Vx;
dy_dt = Vy;
dVx_dt = ax;
dVy_dt = ay - g;

phaseout.dynamics = [dx_dt , dy_dt , dVx_dt , dVy_dt];
phaseout.integrand = 0.5*(ax.^2 + ay.^2);

%-------------------------------------------------------------------------%
%--------------------- END Function Landing_Continuous.m -----------------%
%-------------------------------------------------------------------------%

