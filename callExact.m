%% Function to calculate Wexler plume concentrations

function exact = callExact(Parameters,Domain,Option)

Parameters.vx = Parameters.vx/Parameters.R;
Parameters.k = Parameters.k/Parameters.R;

if Option.sourceBoundary == "Dirichlet"
    fX = @(tau) ...
        ((Domain.x-Parameters.Xc)/(pi*Parameters.alphaX*Parameters.vx)^0.5 ...
        .*exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)) ...
        .*exp(-Parameters.vx.*tau/(4.0*Parameters.alphaX)-(Domain.x-Parameters.Xc)^2.0./ ...
        (4.0*Parameters.alphaX*Parameters.vx.*tau)-(Parameters.k-Parameters.lambda).*tau) ...
        .*tau.^(-3.0/2.0));
elseif Option.sourceBoundary == "Cauchy"
    fX = @(tau) ...
        (2*Parameters.vx.*tau/(pi*Parameters.alphaX*Parameters.vx).^0.5 ...
        .*exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)) ...
        .*exp(-Parameters.vx*tau/(4.0*Parameters.alphaX)-(Domain.x-Parameters.Xc)^2.0./ ...
        (4.0*Parameters.alphaX*Parameters.vx.*tau)-(Parameters.k-Parameters.lambda).*tau) ...
        .*tau.^(-3.0/2.0)...
        -Parameters.vx/(Parameters.alphaX) ...
        .*exp((Domain.x-Parameters.Xc)./Parameters.alphaX-(Parameters.k-Parameters.lambda).*tau) ...
        .*erfc((Domain.x-Parameters.Xc+Parameters.vx.*tau)./ ...
        (2*(Parameters.alphaX*Parameters.vx.*tau).^0.5)));
end

if (Parameters.alphaY == 0) % Z dimension not present
    fY = @ (tau,Yc)(2);
elseif Parameters.Yw == 0 % Point source in Z
    fY = @(tau,Yc) ...
        (1./sqrt(pi*Parameters.vx*Parameters.alphaY*tau)) ...
        .*(exp(-(Domain.y-Yc+Parameters.Yw/2)^2.0./ ...
        (4.0*Parameters.vx*Parameters.alphaY*tau)));
else % Line source in Y
    fY = @ (tau,Yc) ...
        (erf((Domain.y-Yc+Parameters.Yw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaY*tau).^0.5)) ...
        -erf((Domain.y-Yc-Parameters.Yw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaY*tau).^0.5)));
end

if (Parameters.alphaZ == 0) % Y dimension not present
    fZ = @ (tau,Zc)(2);
elseif Parameters.Zw == 0 % Point source in z
    fZ = @(tau,Zc) ...
        (1./(pi*Parameters.vx*Parameters.alphaZ*tau).^0.5) ...
        .*(exp(-(Domain.z-Zc+Parameters.Zw/2)^2.0./ ...
        (4.0*Parameters.vx*Parameters.alphaZ*tau)));
else % Line source in Z
    fZ = @ (tau,Zc) ...
        (erf((Domain.z-Zc+Parameters.Zw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaZ*tau).^0.5)) ...
        -erf((Domain.z-Zc-Parameters.Zw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaZ*tau).^0.5)));
end

%% Compute solution 
fWexler = @(tau) ...
    (Parameters.c0/8*exp(-Parameters.lambda*Domain.tN) ...
    .*fX(tau).*fY(tau,Parameters.Yc).*fZ(tau,Parameters.Zc));

if Domain.tN > Parameters.tp % Pulse boundary
    exact =integral(@(tau) fWexler(tau),Domain.tN-Parameters.tp,Domain.tN); % Note tau should be a vector in the integral function
else
    exact =integral(@(tau) fWexler(tau),0,Domain.tN); 
end

end