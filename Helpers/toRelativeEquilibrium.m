function val = toRelativeEquilibrium(func)
% TORELATIVEEQUILIBRIUM  Return the relative equilibrium for a given equation name.
    key = func2str(func);
    switch string(key)
        case "replicatorEq_x1y1"
            val = "2";
        case "replicatorEq_x1y2"
            val = "1";
        case "replicatorEq_x1y3"
            val = "0";
        case "replicatorEq_x2y1"
            val = "0";
        case "replicatorEq_x2y2"
            val = "2";
        case "replicatorEq_x2y3"
            val = "1";
        case "replicatorEq_x3y1"
            val = "1";
        case "replicatorEq_x3y2"
            val = "0";
        case "replicatorEq_x3y3"
            val = "2";
        otherwise
            error('Unknown key: %s', key);
    end
end
