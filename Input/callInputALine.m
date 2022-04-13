function[Option,Parameters,Domain,Modeled,Observed] = callInputALine

Option.sourceBoundary = "Dirichlet";

Parameters.alphaX = 21.34*10; % Dispersion coeff in X-direction [m]
Parameters.alphaY = 4.2672; % Dispersion coeff in Y-direction [m]
Parameters.alphaZ = 0; % Dispersion coeff in Z-direction [m]

Parameters.Xc = 0.0; % Source location in x direction [m]
Parameters.Yc = 228.0; % Source width in y direction [m]
Parameters.Yw = 70; % Source width in y direction [m]
Parameters.Zc = 0; % Source width in z direction [m]
Parameters.Zw = 0; % Source width in z direction [m]

Parameters.vx = 0.432; % Velocity in x direction [m day-1]
Parameters.k = 0.002*0; % First order deacay constant [day-1]
Parameters.R = 1; % Retardation factor
Parameters.c0 = 40; % Initial source concentration [mg L-1 m]

Parameters.lambda = 0.001*0; % Source decay
Parameters.tp = 1826; % Start pulse time [day]

Domain.x1 = 0; % Simulation domain x start [m]
Domain.xN = 3500; % Simulation domain x end [m]
Domain.deltaX = 40;
Domain.xStore = Domain.x1:Domain.deltaX:Domain.xN;
Domain.xSteps = length(Domain.xStore);  

Domain.y1 =Parameters.Yc;  % Simulation domain y start [m]
Domain.yN = 598; % Simulation domain y end [m]
Domain.deltaY = 10;
Domain.yStore = Domain.y1:Domain.deltaY:Domain.yN;
Domain.ySteps = length(Domain.yStore);

Domain.z1 = 0;  % Simulation domain z start [m]
Domain.zN = 1;  % Simulation domain z end [m]
Domain.deltaZ = 1;
Domain.zStore = Domain.z1:Domain.deltaZ:Domain.zN;
Domain.zSteps = length(Domain.zStore);

Domain.t1 = 0; % Simulation start time [year]
Domain.tN = 1826; % Simulation end time [year]

%% Observed data
Observed = 0;
Modeled = 0;

end

