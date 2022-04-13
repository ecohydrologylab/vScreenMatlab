function erfcComplex = callerfcComplex(x)

erfComplex = -erfi(x/(0+1i))/(0+1i);
erfcComplex = 1-erfComplex;
end