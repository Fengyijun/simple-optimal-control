%---------------------------------------------------------------------------%
%--------------------- BEGIN Function Landing_Endpoint.m -------------------%
%---------------------------------------------------------------------------%
function output = Landing_Endpoint(input)

phi = input.auxdata.phi;
J1 = input.phase.integral;
xf = input.phase.finalstate;
J2 = 0.5*(xf(3)^2 + xf(4)^2);
output.objective = phi*J1 + (1-phi)*J2;

%---------------------------------------------------------------------------%
%--------------------- END Function Landing_Endpoint.m ---------------------%
%---------------------------------------------------------------------------%
