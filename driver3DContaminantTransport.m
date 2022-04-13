%% Driver to compute Analytical solution for 1D, 2D,3D contaminant plume concentrations
% Authors: Jhansi Sangani, Antriksh Srivastava, and Venkatraman Srinivasan*
% Department of Civil Engineering 
% Indian Institute of Technology Madras Chennai, India
% *corresponding author: venkatraman@iitm.ac.in
% All rights reserved

clc
clear variables
close all
tic

%% Source type and boundary
addpath('./Input/')
sourceType ="Area";

if sourceType == "Point"
    [Option,Parameters,Domain,Modeled,Observed] = callInputAPoint;
elseif sourceType == "Line"
    [Option,Parameters,Domain,Modeled,Observed] = callInputALine;
elseif sourceType == "Area"
    [Option,Parameters,Domain,Modeled,Observed] = callInputAArea;
end
if Option.sourceBoundary == "Dirichlet"
    xStart = 2;
elseif Option.sourceBoundary == "Cauchy"
    xStart = 1;
end

[cExact,cDomenico,cApproximate] = callInitializeC(Domain,Parameters,Option); % Initial and boundary condition

% Condition for pulse boundary
if Domain.tN > Parameters.tp                     
    t = Domain.tN - Parameters.tp;
else
    t = Domain.tN;
end

%% Compute concentrations for quarter plume
for xLoop = xStart:1:Domain.xSteps
    Domain.x = Domain.xStore(xLoop);
    tauDomenico(xLoop) = abs((Domain.x-Parameters.Xc)/Parameters.vx); % Tau of Domenico solution
    n = (Parameters.vx*(Domain.tN-Domain.t1)/Parameters.alphaX)^0.25;
    tauApproximate(xLoop) = abs(((Domain.x-Parameters.Xc)/Parameters.vx)/ ...  % Tau for improved solution
        (1+(Domain.x/(Parameters.vx*(t-Domain.t1)))^n)^(1/n));
    for yLoop = 1:1:Domain.ySteps
        Domain.y = Domain.yStore(yLoop);
        for zLoop = 1:1:Domain.zSteps
            Domain.z = Domain.zStore(zLoop);
            
           cExact(xLoop,yLoop,zLoop) = callExact(Parameters,Domain,Option);
%            tauExact(xLoop,yLoop,zLoop) = ...
%                callTauExact(Parameters,Domain,Option,cExact(xLoop,yLoop,zLoop));
%             
            cDomenico(xLoop,yLoop,zLoop) = ...
                callDomenico(Parameters,Domain,Option,tauDomenico(xLoop));
            
            cApproximate(xLoop,yLoop,zLoop) = ...
                callDomenico(Parameters,Domain,Option,tauApproximate(xLoop));
            
        end
    end
end

%% Copy from quarter plume to generate whole plume
[cExact] = callWholePlume(cExact);
[cApproximate] = callWholePlume(cApproximate);
[cDomenico] = callWholePlume(cDomenico);
 
Domain.yStore = cat(2,flip(2*Parameters.Yc-Domain.yStore,2),Domain.yStore(2:end));
Domain.ySteps = length(Domain.yStore); Domain.y1 = Domain.yStore(1);
Domain.zStore = cat(2,flip(2*Parameters.Zc-Domain.zStore,2),Domain.zStore(2:end));
Domain.zSteps = length(Domain.zStore); Domain.z1 = Domain.zStore(1);

%% Save results
if sourceType == "Point"
    save('../Output/APoint.mat')
elseif sourceType == "Line"
    save('../Output/ALine.mat')
elseif sourceType == "Area"
    save('../Output/AArea.mat')
end

toc

%% End of program