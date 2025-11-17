addpath(genpath(fullfile(fileparts(mfilename('fullpath')), 'Helpers')));
%% C0 transition matrices: 0->1->0
%0->1
M_0to1 = @(ex, ey) [-(1+ex)/2 1 0;
          (1-ey)/2    0   1;
          1     0   0];
%1->0
M_1to0 = @(ex, ey) [0     1   0;
          1    (1-ex)/2 0;
          0     -(1+ey)/2   1];
P1 = [0 1 0; 1 0 0; 0 0 1];
%check order of permutation matrix here
%full transition matrices
A_C0_0 = @(ex, ey) P1 * M_1to0(ex,ey) * M_0to1(ex,ey);
A_C0_1 = @(ex, ey) M_0to1(ex,ey) * P1 * M_1to0(ex,ey);

%% C1 transition matrices: 1->2->1
%1->2
M_1to2 = @(ex, ey) [0 (1-ex)/(1+ey) 0;
          1 2/(1+ey)      0;
          0 -2/(1+ey)     1];
%2->1
M_2to1 = @(ex, ey) [1     (1+ex)/(1-ex)   0;
          0     (1+ey)/(1-ex)   0;
          0     -(1-ey)/(1-ex)  1];
P2 = [1 0 0; 0 0 1; 0 1 0];
A_C1_0 = @(ex, ey) P2 * M_2to1(ex,ey) * M_1to2(ex,ey);
A_C1_1 = @(ex, ey) M_1to2(ex,ey) * P2 * M_2to1(ex,ey);

%% C2 transition matrices: 0->2->0
%0->2
M_0to2 = @(ex, ey) [0 0 (1+ex)/(1-ey);
          1 0 (ex-1)/(1-ey);
          0 1 (1+ey)/(1-ey)];
%2->0
M_2to0 = @(ex, ey) [-2/(1+ex) 1 0;
          (1-ey)/(1+ex) 0 0;
          (2)/(1+ex) 0 1];

%full transition matrices
P1 = [0 1 0; 1 0 0; 0 0 1];
A_C2_0 = @(ex, ey) M_2to0(ex,ey) * P1 * M_0to2(ex,ey);
A_C2_1 = @(ex, ey) M_0to2(ex,ey) *P1 * M_2to0(ex,ey);

%% An example of how to check the stability regions
close all
resultC0 = PodviginasMatrix(A_C0_0, 100, false, [235, 127, 127]/256);
resultC1 = PodviginasMatrix(A_C1_0, 100, false, [255, 191, 127]/256);
resultC2 = PodviginasMatrix(A_C2_0, 100, false, [159, 248, 127]/256);

%% Chapter 6: we construct the full transition matrix for cycle 0121
P1 = [0 1 0; 1 0 0; 0 0 1];
P2 = [1 0 0; 0 0 1; 0 1 0];
A_0 = @(ex,ey) P1*M_1to0(ex,ey)*P2*M_2to1(ex,ey)*M_1to2(ex,ey)*P2*M_0to1(ex,ey);
PodviginasMatrix(A_0, 100, true, [0.7 0.2 0.9])