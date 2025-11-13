function [position,isterminal,direction] = switchEventFcn(t,U_integrated,currentEquilibrium)
    % size_U_int = size(U_integrated)
    U = deriveVariablesFromConstraint(U_integrated', currentEquilibrium);
    x_ = [U(:,1:3)];
    y_ = [U(:,4:6)];
    
    max_x = currentEquilibrium(1);
    max_y = currentEquilibrium(2)-3;
    
    % position should be constructed using max values
    position = [];
    isterminal = [];
    
    % will hopefully create the following comparisons:
    % x1 - x2
    % x1 - x3
    % x2 - x3
    
    % y1 - y2
    % y1 - y3
    % y2 - y3
    
    for i=1:3
        for j=1:3
            if i~=j && i < j
                % fprintf('i: %d, j: %d\n',i,j);
                position(end+1) = x_(i) - x_(j);
                isterminal(end+1) = i==max_x || j==max_x;
            else
                position(end+1) = Inf;
                isterminal(end+1) = 0;
            end
        end
    end
    for i=1:3
        for j=1:3
            if i~=j && i < j
                % fprintf('i: %d, j: %d\n',i,j);
                position(end+1) = y_(i) - y_(j);
                isterminal(end+1) = i==max_y || j==max_y;
            else
                position(end+1) = Inf;
                isterminal(end+1) = 0;
            end
        end
    end
    direction = zeros(size(position));   % The zero can be approached from either direction
end