function[Option,Parameters,Domain,Modeled,Observed] = callInputAArea

Option.sourceBoundary = "Dirichlet";

Parameters.alphaX = 42.58; % Dispersion coeff in X-direction [m]
Parameters.alphaY = 8.43; % Dispersion coeff in Y-direction [m]
Parameters.alphaZ = 0.00642; % Dispersion coeff in Z-direction [m]

Parameters.Xc = 0.0; % Source location in x direction [m]
Parameters.Yc = 0.0; % Source width in y direction [m]
Parameters.Yw = 240.0; % Source width in y direction [m]
Parameters.Zc = 0.0; % Source width in z direction [m]
Parameters.Zw = 5.0; % Source width in z direction [m]

Parameters.vx = 0.2151; % Velocity in x direction [m day-1]
Parameters.k = 0.001*0; % First order deacay constant [day-1]
Parameters.R = 1.0; % Retardation factor
Parameters.c0 = 850.0; % Initial source concentration [mg L-1]
Parameters.lambda = 0.008*0; % Source decay
Parameters.tp = 5110.0; % Start pulse time [day]

Domain.x1 = 0.0; % Simulation domain x start [m]
Domain.xN = 2500.0; % Simulation domain x end [m]
Domain.deltaX = 100.0;
Domain.xStore = Domain.x1:Domain.deltaX:Domain.xN;
Domain.xSteps = length(Domain.xStore);

Domain.y1 = Parameters.Yc; % Simulation domain y start [m]
Domain.yN = 1000.0; % Simulation domain y end [m]
Domain.deltaY = 50.0;
Domain.yStore = Domain.y1:Domain.deltaY:Domain.yN;
Domain.ySteps = length(Domain.yStore);

Domain.z1 = Parameters.Zc; % Simulation domain z start [m]
Domain.zN = 1;  % Simulation domain z end [m]
Domain.deltaZ = 1;
Domain.zStore = Domain.z1:Domain.deltaZ:Domain.zN;
Domain.zSteps = length(Domain.zStore);

Domain.t1 = 0.0; % Simulation start time [year]
Domain.tN = 5110.0; % Simulation end time [year]
Domain.deltaT = 5110.0;
Domain.tStore = Domain.t1:Domain.deltaT:Domain.tN;
Domain.tSteps = length(Domain.tStore);

%% Observed data
Observed = 0;
Modeled = 0;

end

