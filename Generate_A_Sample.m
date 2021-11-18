%------------------------------------------------%
%--------------- Simple Landing Case ------------%
%------------------------------------------------%

% InitialState:x0,y0,Vx0,Vy0

function output = Generate_A_Sample(InitialState,auxdata,IsPlot)

%-------------------------------------------------------------------------%
%--------------- Provide All Physical Data for Problem -------------------%
%-------------------------------------------------------------------------%
% setting
GaussN = auxdata.GaussN;
acc_max = auxdata.acc_max;
acc_min = auxdata.acc_min;
% Initial
x0 = InitialState.x0;
y0 = InitialState.y0;
Vx0 = InitialState.Vx0;
Vy0 = InitialState.Vy0;

%-------------------------------------------------------------------------%
%---------- Provide Bounds and Guess in Each Phase of Problem ------------%
%-------------------------------------------------------------------------%
bounds.phase.initialtime.lower = [0]; 
bounds.phase.initialtime.upper = [0]; 
bounds.phase.finaltime.lower = [0]; 
bounds.phase.finaltime.upper = [Inf];
bounds.phase.initialstate.lower = [x0,y0,Vx0,Vy0];    
bounds.phase.initialstate.upper = [x0,y0,Vx0,Vy0];  
bounds.phase.state.lower = -[Inf,Inf,Inf,Inf];
bounds.phase.state.upper = [Inf,Inf,Inf,Inf];
bounds.phase.finalstate.lower = [0,0,-Inf,-Inf];
bounds.phase.finalstate.upper = [0,0,Inf,Inf];

bounds.phase.control.lower = [acc_min,acc_min];
bounds.phase.control.upper = [acc_max,acc_max];
bounds.phase.integral.lower = [0];
bounds.phase.integral.upper = Inf;

guess.phase.time = [0;10];
guess.phase.state(:,1) = [x0;0];
guess.phase.state(:,2) = [y0;0];
guess.phase.state(:,3) = [Vx0;0];
guess.phase.state(:,4) = [Vy0;0];
guess.phase.control(:,1) = [0;0];
guess.phase.control(:,2) = [0;0];
guess.phase.integral = [0];

%-------------------------------------------------------------------------%
%-------------- Provide an Initial Mesh in Each Phase --------------------%
%-------------------------------------------------------------------------%
meshphase.colpoints = 4*ones(1,GaussN);
meshphase.fraction = (1/GaussN)*ones(1,GaussN);

%-------------------------------------------------------------------------%
%----------- Assemble All Information into Setup Structure ---------------%
%-------------------------------------------------------------------------%
setup.name = 'Simple_Landing_Problem';
setup.functions.continuous = @Landing_Continuous;
setup.functions.endpoint = @Landing_Endpoint;
setup.mesh.phase = meshphase;
setup.mesh.maxiteration = 40;
setup.mesh.colpointsmin = 4;
setup.mesh.colpointsmax = 20;
setup.nlp.solver = 'snopt';
setup.bounds = bounds;
setup.guess = guess;
setup.auxdata = auxdata;
setup.derivatives.supplier = 'sparseCD';
setup.derivatives.derivativelevel = 'first';
setup.mesh.method = 'hp1';
setup.mesh.tolerance = 1e-5;
setup.method = 'RPMintegration';
setup.MaxCalculateTime = Inf;
%-------------------------------------------------------------------------%
%---------------------- Solve Problem using GPOPS2 -----------------------%
%-------------------------------------------------------------------------%
output = gpops2(setup);
if(IsPlot)
    Plot_Optimal_Result(output);
end