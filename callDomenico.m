%% Function to calculate Domenico plume concentrations
function domenico = callDomenico(Parameters,Domain,Option,tau)

Parameters.vx = Parameters.vx/Parameters.R;
Parameters.k = Parameters.k/Parameters.R;

if Option.sourceBoundary == "Dirichlet"
    if isinf(Domain.tN) % Steady state
        phiX = @ (t) ...
            (2*exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)* ...
            (1.0-(1+4.0*Parameters.k*Parameters.alphaX/Parameters.vx)^0.5)));
    else % Transient
        if Parameters.k > Parameters.lambda - Parameters.vx/(4.0*Parameters.alphaX) % Omega = real
            phiX = @ (t) ...
                (exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)* ...
                (1.0-(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx)^0.5))* ...
                erfc((Domain.x-Parameters.Xc-Parameters.vx*t* ...
                abs((1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx))^0.5)/ ...
                (2.0*(Parameters.alphaX*Parameters.vx*t)^0.5))+ ...
                exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)* ...
                (1.0+(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx)^0.5))* ...
                erfc((Domain.x-Parameters.Xc+Parameters.vx*t* ...
                abs((1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx))^0.5)/ ...
                (2.0*(Parameters.alphaX*Parameters.vx*t)^0.5)));
        elseif Parameters.k < Parameters.lambda - Parameters.vx/(4.0*Parameters.alphaX) % Omega = complex
            omega = @(t) (Domain.x-Parameters.Xc+ ...
                Parameters.vx*t*(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx)^0.5)/ ...
                (2.0*(Parameters.alphaX*Parameters.vx*t)^0.5);
            w = (abs(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx))^0.5;
            phiReal = @(t) real(callerfcComplex(omega(t)));
            phiImag = @(t) imag(callerfcComplex(omega(t)));
            phiX = @ (t) ...
                2*exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX))* ...
                (phiReal(t)*cos(w*(Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX))- ...
                phiImag(t)*sin(w*(Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)));
            
        end
    end
elseif Option.sourceBoundary == "Cauchy"
    if isinf(Domain.tN) % Steady state
        phiX = @ (t) ...
            (4/(1+(1+(4*(Parameters.k-Parameters.lambda)*Parameters.alphaX)/v)^0.5)) ...
            *exp((Domain.x-Parameters.Xc/(2*Parameters.alphaX))* ...
            (1-(1+(4*(Parameters.k-Parameters.lambda)*Parameters.alphaX)/Parameters.vx)^0.5));
    else % Transient
        if Parameters.k == Parameters.lambda*Parameters.R % Real
            phiX = @ (t) ...
                2*(1-exp(-(Parameters.k-Parameters.lambda)*t) ...
                *(1.0-0.5*erfc((Domain.x-Parameters.Xc-Parameters.vx*t)/ ...
                (2*(Parameters.alphaX*Parameters.vx*t)^0.5)) ...
                -(Parameters.vx*t/(pi*Parameters.alphaX))^0.5 ...
                *(exp(-(Domain.x-Parameters.Xc-Parameters.vx*t)^2/ ...
                (4*Parameters.alphaX*Parameters.vx*t))) ...
                +0.5*(1.0+(Domain.x-Parameters.Xc)/Parameters.alphaX+Parameters.vx*t/Parameters.alphaX) ...
                *exp((Domain.x-Parameters.Xc)/Parameters.alphaX) ...
                *erfc((Domain.x-Parameters.Xc+Parameters.vx*t)/ ...
                (2*(Parameters.alphaX*Parameters.vx*t)^0.5))));
        elseif Parameters.k > Parameters.lambda - Parameters.vx/(4.0*Parameters.alphaX) % Omega = real
            w = abs((1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx)^0.5);
            phiX = @ (t) ...
                2*((1/(1+w))*exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)* ...
                (1.0-(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx)^0.5))* ...
                erfc((Domain.x-Parameters.Xc-Parameters.vx*t* ...
                abs((1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx))^0.5)/ ...
                (2.0*(Parameters.alphaX*Parameters.vx*t)^0.5))+...
                (1/(1-w))*exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)* ...
                (1.0+(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx)^0.5))* ...
                erfc((Domain.x-Parameters.Xc+Parameters.vx*t* ...
                abs((1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx))^0.5)/ ...
                (2.0*(Parameters.alphaX*Parameters.vx*t)^0.5))...
                +Parameters.vx/(2.0*Parameters.alphaX*(Parameters.k-Parameters.lambda)) ...
                *exp((Domain.x-Parameters.Xc)./Parameters.alphaX-(Parameters.k-Parameters.lambda).*t) ...
                *erfc((Domain.x-Parameters.Xc+Parameters.vx*t)./ ...
                (2*(Parameters.alphaX*Parameters.vx.*t).^0.5)));
        elseif Parameters.k < Parameters.lambda - Parameters.vx/(4.0*Parameters.alphaX)  % Omega = complex
            omega = @(t) (Domain.x-Parameters.Xc+ ...
                Parameters.vx*t*(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx)^0.5)/ ...
                (2.0*(Parameters.alphaX*Parameters.vx*t)^0.5);
            w = (abs(1.0+4.0*(Parameters.k-Parameters.lambda)*Parameters.alphaX/Parameters.vx))^0.5;
            phiReal = @(t) real(callerfcComplex(omega(t)));
            phiImag = @(t) imag(callerfcComplex(omega(t)));
            phiX = @ (t) ...
                2*(1/(1+w^2)*(exp((Domain.x-Parameters.Xc)/(2.0*Parameters.alphaX)) ...
                *((phiReal(t)-phiImag(t)*w) ...
                *cos((Domain.x-Parameters.Xc)*w/(2.0*Parameters.alphaX)) ...
                -(phiReal(t)*w+phiImag(t)) ...
                *sin((Domain.x-Parameters.Xc)*w/(2.0*Parameters.alphaX)))) ...
                +Parameters.vx/(4.0*Parameters.alphaX*(Parameters.k-Parameters.lambda)) ...
                *exp((Domain.x-Parameters.Xc)/Parameters.alphaX-Parameters.k*t) ...
                *erfc((Domain.x-Parameters.Xc+Parameters.vx*t)/ ...
                (2.0*(Parameters.alphaX*Parameters.vx*t)^0.5)));
        end
    end
end

if (Parameters.alphaY == 0) % Y dimension not present
    fY = @ (Yc)(2);
elseif (Parameters.Yw == 0) % Point source in Y
    fY = @(Yc) ...
        (1./(pi*Parameters.vx*Parameters.alphaY*tau).^0.5) ...
        .*(exp(-(Domain.y-Parameters.Yc)^2.0./ ...
        (4.0*Parameters.vx*Parameters.alphaY*tau)));
else % Line source in Y
    fY = @ (Yc) ...
        (erf((Domain.y-Yc+Parameters.Yw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaY*tau).^0.5)) ...
        -erf((Domain.y-Yc-Parameters.Yw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaY*tau).^0.5)));
end

if (Parameters.alphaZ == 0) % Z dimension not present
    fZ = @ (Zc)(2);
elseif (Parameters.Zw == 0) % Point source in Z
    fZ = @ (Zc) ...
        (1./(pi*Parameters.vx*Parameters.alphaZ*tau).^0.5) ...
        .*(exp(-(Domain.z-Parameters.Zc)^2.0./ ...
        (4.0*Parameters.vx*Parameters.alphaZ*tau)));
else % Line source in Z
    fZ = @ (Zc) ...
        (erf((Domain.z-Zc+Parameters.Zw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaZ*tau).^0.5)) ...
        -erf((Domain.z-Zc-Parameters.Zw/2)./ ...
        (2.0.*(Parameters.vx*Parameters.alphaZ*tau).^0.5)));
end

%% Compute solution
fDomenico = @(t) ...
    (Parameters.c0/8*exp(-Parameters.lambda*Domain.tN) ...
    *phiX(t)*fY(Parameters.Yc)*fZ(Parameters.Zc));

if Domain.tN > Parameters.tp % Pulse boundary
    domenico = fDomenico(Domain.tN)-fDomenico(Domain.tN-Parameters.tp);
else
    domenico = fDomenico(Domain.tN);    
end

end
