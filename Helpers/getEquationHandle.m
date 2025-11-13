function f = getEquationHandle(key)
%GETEQUATIONHANDLE  Return function handle for a given equilibrium.
    % Validate input
    if ~isnumeric(key) || numel(key) ~= 2
        error('Key must be a numeric 1x2 vector, e.g. [2 4].');
    end

    % Convert key to a string for switch-case comparison
    keyStr = sprintf('%d_%d', key(1), key(2));

    switch keyStr
        case '1_4'
            f = @replicatorEq_x1y1;
        case '1_5'
            f = @replicatorEq_x1y2;
        case '1_6'
            f = @replicatorEq_x1y3;
        case '2_4'
            f = @replicatorEq_x2y1;
        case '2_5'
            f = @replicatorEq_x2y2;
        case '2_6'
            f = @replicatorEq_x2y3;
        case '3_4'
            f = @replicatorEq_x3y1;
        case '3_5'
            f = @replicatorEq_x3y2;
        case '3_6'
            f = @replicatorEq_x3y3;
        otherwise
            error('No equation found for key [%d %d].', key(1), key(2));
    end
end