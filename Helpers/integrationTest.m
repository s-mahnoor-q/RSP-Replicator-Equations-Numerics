u0 = [0.006737946999085   0.992350171035360   0.000911881965555   0.999619137442335   0.000045399929762   0.000335462627903];
U0 = log(u0)
p=[0.5 0.6];
[t, v] = ode45(@(t,y) replicatorEq_x2y1(t,y,p), [0 5], getIC(U0,[2 4]));
U = deriveVariablesFromConstraint(v, currentEquilibrium);
figure; hold on
plotRSPLogCoordinates(t,U)