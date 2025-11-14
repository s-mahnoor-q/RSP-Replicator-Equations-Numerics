% we integrate trajectories with the same IC, with varying parameters
% leaving the C_1 stable region, entering the blank chaotic region

% we start near (R,S), and hopefully head towards (R,R) (C_1)
clear
x=[0 0 0];y=[0 0 0];
x(2)=exp(-6); x(3)=exp(-8); x(1)=1-x(2)-x(3);
y(1)=exp(-3); y(3)=exp(-7); y(2)=1-y(1)-y(3);

simulateRSP(10000, [x y], [0 0.81])
%% on the boundary of the stable region
simulateRSP(10000, [x y], [0 0.80])

%% 
simulateRSP(10000, [x y], [0 0.79]);

%%
simulateRSP(10000, [x y], [0 0.78]);

%%
simulateRSP(10000, [x y], [0 0.77]);