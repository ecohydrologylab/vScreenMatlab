function[Option,Parameters,Domain,Modeled,Observed] = callInputAPoint

Option.sourceBoundary = "Dirichlet";

Parameters.alphaX = 30.0; % Dispersion coeff in X-direction [m]
Parameters.alphaY = 5.0; % Dispersion coeff in Y-direction [m]
Parameters.alphaZ = 5.0; % Dispersion coeff in Z-direction [m]

Parameters.Xc = 0.0; % Source location in x direction [m]
Parameters.Yc = 10.0; % Source width in y direction [m]
Parameters.Yw = 0.0; % Source width in y direction [m]
Parameters.Zc = 1.0; % Source width in z direction [m]
Parameters.Zw = 0.0; % Source width in z direction [m]

Parameters.vx = 0.125; % Velocity in x direction [m day-1]
Parameters.k = 0.002*0; % First order deacay constant [day-1]
Parameters.R = 1.0; % Retardation factor
Parameters.c0 = 1.0; % Initial source concentration [mg L-1 m2]

Parameters.lambda = 0.001*0; % Source decay
Parameters.tp = 240.0; % Start pulse time [day]

Domain.x1 = 0.0; % Simulation domain x start [m]
Domain.xN = 800.0; % Simulation domain x end [m]
Domain.deltaX = 5.0;
Domain.xStore = Domain.x1:Domain.deltaX:Domain.xN;
Domain.xSteps = length(Domain.xStore);  % Simulation domain x [ft]

Domain.y1 = Parameters.Yc; % Simulation domain y start [m]
Domain.yN = 80.0;     % Simulation domain y end [m]
Domain.deltaY = 2.0;
Domain.yStore = Domain.y1:Domain.deltaY:Domain.yN;
Domain.ySteps = length(Domain.yStore);

Domain.z1 = Parameters.Zc; % Simulation domain z start [m]
Domain.zN = 51.0; % Simulation domain z end [m]
Domain.deltaZ = 2.0;
Domain.zStore = Domain.z1:Domain.deltaZ:Domain.zN;
Domain.zSteps = length(Domain.zStore);

Domain.t1 = 0.0; % Simulation start time [year]
Domain.tN = 240.0; % Simulation end time [year]
Domain.deltaT = 240.0;
Domain.tStore = Domain.t1:Domain.deltaT:Domain.tN;
Domain.tSteps = length(Domain.tStore);

%% Observed data
Observed = 0;
Modeled = 0;

end

