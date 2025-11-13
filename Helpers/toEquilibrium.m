%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to_equilibrium
% 
% Given the current equilibrium (currentEq : cell), and the value of each of
% the variables (ye), we can predict using the heteroclinic network
% which equilibrium we are likely heading towards!
%
% This can be used to switch to a different set of equations to avoid 
% numerical errors when integrating restricted to some subspace (e.g. a
% simplex).
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function next_equilibrium = toEquilibrium(currentEquilibrium, ye)
    keys = { [1 4], [1 5], [1 6], ...
         [2 4], [2 5], [2 6], ...
         [3 4], [3 5], [3 6] };

    values = { {[3 4], [1 6]}, ... % R,R
           {[1 6], [1 4]}, ... % R,S
           {[3 6], [2 6]}, ... % R,P
           {[1 4], [3 4]}, ... % S,R
           {[1 5], [2 4]}, ... % S,S
           {[2 4], [2 5]}, ... % S,P
           {[3 6], [3 5]}, ... % P,R
           {[2 5], [1 5]}, ... % P,S
           {[2 6], [3 5]}  ... % P,P
         };
    
    heteroclinic_network = dictionary(keys, values);
    tol = 1e-5;  % tolerance for floating point equality

    % if isempty(ye)
    %     next_equilibrium = currentEq;
    %     fprintf("no crossover event detected, returning original equilibrium\n")
    %     return
    % end
    n = 6;

    
    next_equilibria = heteroclinic_network({currentEquilibrium});
    % for k = 1:numel(next_equilibria)
    %     v = next_equilibria{k};          % extract numeric vector
    %     fprintf('[%d %d]\n', v{1}, v{2});
    % end
    duplicate_indices = [];
    % disp(ye)
    ye
    for i = 1:n-1
        for j = i+1:n
            % fprintf('i: %d, j: %d, diff: %f\n',i,j,abs(ye(i) - ye(j)))
            if abs(ye(i) - ye(j)) < tol %if the values are close enough
                duplicate_indices = [i j];
            end
        end
    end

    % DEBUGGING
    % duplicate_indices
    % currentEquilibrium{1}

    duplicate_indices(ismember(duplicate_indices, currentEquilibrium)) = [];
    increasingVar = duplicate_indices;
    next_equilibria = next_equilibria{1};             % extract numeric vector
    v1 = next_equilibria{1};                          % 1st eq
    v2 = next_equilibria{2};                          % get the 2nd equilibria

    % DEBUGGING
    % increasingVar
    % v1
    % v2

    if ismember(increasingVar, v1)
        % the variable we will go to next will be smth ELSE
        next_equilibrium = v1;
    elseif ismember(increasingVar, v2)
        next_equilibrium = v2;
    else % BE CAREFUL POOPY
        warning('increasing var does not match heteroclinic network')
        next_equilibrium = v1;
    end

    % fprintf('Current eq: ')
    % fprintf('%d ', currentEquilibrium{1})
    % fprintf(', increasing var: %d, next equilibrium: ', increasingVar)
    % fprintf('%d ', next_equilibrium{1})
    % fprintf('\n')
end