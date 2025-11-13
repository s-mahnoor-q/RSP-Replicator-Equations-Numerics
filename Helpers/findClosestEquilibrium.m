function equilibrium = findClosestEquilibrium(position)
    [mx, i_x] = max(position(1:3));
    [my, i_y] = max(position(4:6));

    equilibrium = [i_x, i_y+3];
end

