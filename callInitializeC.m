function [cExact,cDomenico,cApproximate] = callInitializeC(Domain,Parameters,Option)

%% Initiaize concentration vector
c = zeros(Domain.xSteps,Domain.ySteps,Domain.zSteps); % [mg L-1]

%% Initial condition
% c(:,:,:) = 0;

%% Source boundary condition
if Option.sourceBoundary == "Dirichlet"
    if Parameters.tp >= (Domain.tN-Domain.t1)
        xLoop = find(Domain.xStore == Parameters.Xc);
        yLoop = find(Domain.yStore >= Parameters.Yc-Parameters.Yw/2 & ...
            Domain.yStore <= Parameters.Yc+Parameters.Yw/2);
        zLoop = find(Domain.zStore >= Parameters.Zc-Parameters.Zw/2 & ...
            Domain.zStore <= Parameters.Zc+Parameters.Zw/2);
        c(xLoop,yLoop,zLoop) = Parameters.c0* ...
            exp(-Parameters.lambda*(Domain.tN-Domain.t1));
    end
end

cExact = c;
cDomenico = c;
cApproximate = c;

end
