u0 = [0.997185785195431   0.002478752176666   0.000335462627903   0.082084998623899   0.917869601446339   0.000045399929762];
U0 = log(u0);
p=[0.3 0.9];
currentEquilibrium=findClosestEquilibrium(U0)
U_IC = getIC(U0,currentEquilibrium)
[t, v] = ode45(@(t,y) replicatorEq_x1y2(t,y,p), [0 5], U_IC);
close all
U = deriveVariablesFromConstraint(v, currentEquilibrium);
figure; hold on
plotRSPLogCoordinates(t,U)
