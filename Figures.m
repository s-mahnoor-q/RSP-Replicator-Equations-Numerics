%% Generate figures for Chapter 5: Numerical integration and Chapter 6: Searching for new stable cycles
addpath(genpath(fullfile(fileparts(mfilename('fullpath')), 'Helpers')));
p=[0.3 0.9]; %ex, ey
labelSize = 14; lw=1.25;

x(2)=exp(-6); x(3)=exp(-8); x(1)=1-(x(2)+x(3));
y(1)=exp(-2.5); y(3)=exp(-10); y(2)=1-(y(1)+y(3));
X=log(x); Y=log(y);

%% Method 1: integrating 6 equations, regular coordinates without a constraint
% %% integrate without constraints and plot
[t,u] = ode45(@(t,u) noConstraintReg(t,u,p), [0 20], [x y]);

close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); 
ax2=subplot(1,2,2); 
formatFigureChapter5_6(ax1, ax2, t, u, labelSize, lw);
savefig('Figures/noConstraints.fig')
saveas(gcf, 'Figures/noConstraints.png')

%% Method 1b: 6eq, regular coords for longer time
% problem is that it no longer satisfies constraint
[t,u] = ode45(@(t,u) noConstraintReg(t,u,p), [0 1000], [x y]);

close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); 
ax2=subplot(1,2,2); 
formatFigureChapter5_6(ax1, ax2, t, u, labelSize, lw);
savefig('Figures/noConstraintsLongTerm.fig')
saveas(gcf, 'Figures/noConstraintsLongTerm.png')

figure('Position', [0 0 900 300]); hold on;
plot(t, sum(u(:,1:3),2), 'LineWidth', lw)
plot(t, sum(u(:,4:6),2), 'LineWidth', lw)
xlabel('t', Interpreter='latex', FontSize=labelSize);
ylabel('sum of $x_i$, $y_j$', Interpreter='latex', FontSize=labelSize);
legend('$\sum x_i$','$\sum y_i$', 'Interpreter', 'latex', 'Location', 'southwest', FontSize=labelSize)
saveas(gcf, 'Figures/noConstraintsLongTermSum.png')

%% Method 2: 4eq, reg coords with constraint
IC = getIC([x y], [1 5]);
[t,u] = ode45(@(t,u) regCoordsx1x2Constraint(t,u,p), [0 20], IC);
close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); 
ax2=subplot(1,2,2); 
full_u = deriveRegVariablesFromConstraint(u, [1 5]);
formatFigureChapter5_6(ax1, ax2, t, full_u, labelSize, lw);
savefig('Figures/regCoordsConstraint_t20.fig')
saveas(gcf, 'Figures/regCoordsConstraint_t20.png')

%% Method 2b: for a longer time
% problem is that when values become close to zero, we get machine
% precision error and we are getting negative probabilities
IC = getIC([x y], [1 5]);
[t,u] = ode45(@(t,u) regCoordsx1x2Constraint(t,u,p), [0 200], IC);
close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); 
ax2=subplot(1,2,2); 
full_u = deriveRegVariablesFromConstraint(u, [1 5]);
formatFigureChapter5_6(ax1, ax2, t, full_u, labelSize, lw);
savefig('Figures/regCoordsConstraint_t200.fig')
saveas(gcf, 'Figures/regCoordsConstraint_t200.png')

%% Method 3: 4eq, log coords with constraint
% to help with machine precision errors as numbers become very small
IC = getIC([X Y], [1 5])';
[t,U] = ode45(@(t,u) replicatorEq_x1y2(t,u,p), [0 20], IC);

Full_U = deriveLogVariablesFromConstraint(U, [1 5]);
% close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); 
ax2=subplot(1,2,2); 
formatFigureChapter5_6(ax1, ax2, t, exp(Full_U), labelSize, lw);
savefig('Figures/logCoordsConstraint_t20.fig')
saveas(gcf, 'Figures/logCoordsConstraint_t20.png')

%% Method 3b: 4eq, log coords with constraint for a longer time
% to help with machine precision errors as numbers become very small
IC = getIC([X Y], [1 5])';
simulationTime=65;
[t,U] = ode45(@(t,u) replicatorEq_x1y2(t,u,p), [0 simulationTime], IC);

Full_U = deriveLogVariablesFromConstraint(U, [1 5]);
close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); xlim([0 simulationTime])
ax2=subplot(1,2,2); xlim([0 simulationTime]) 
formatFigureChapter5_6(ax1, ax2, t, exp(Full_U), labelSize, lw);
savefig('Figures/logCoordsConstraint_tLong.fig')
saveas(gcf, 'Figures/logCoordsConstraint_tLong.png')

%% Method 4: 4eq, log eq with switching constraint

[t, U] = simulateRSP(20, [x y], p)
close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); 
ax2=subplot(1,2,2); 
formatFigureChapter5_6(ax1, ax2, t, exp(U), labelSize, lw);
savefig('Figures/switchingCoordsConstraint_t20.fig')
saveas(gcf, 'Figures/switchingCoordsConstraint_t20.png')

%% Method 4b: 4eq, log eq with switching constraint for longer time

[t, U] = simulateRSP(simulationTime, [x y], p)
close all
figure('Position', [0 0 900 300]);
ax1=subplot(1,2,1); xlim([0 simulationTime])
ax2=subplot(1,2,2); xlim([0 simulationTime]) 
formatFigureChapter5_6(ax1, ax2, t, exp(U), labelSize, lw);
savefig('Figures/switchingCoordsConstraint_tLong.fig')
saveas(gcf, 'Figures/switchingCoordsConstraint_tLong.png')