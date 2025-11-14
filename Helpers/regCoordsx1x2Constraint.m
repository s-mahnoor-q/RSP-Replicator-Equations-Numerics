%% (R,S)
function du = regCoordsx1x2Constraint(t, u, p)
    % integrate everything in log coords except X1, Y2

    ex=p(1); ey=p(2);
    A = [0, 1-ex, -1-ex;
        -1-ex, 0, 1-ex;
        1-ex, -1-ex, 0];
    B = [0, 1-ey, -1-ey;
        -1-ey, 0, 1-ey;
        1-ey, -1-ey, 0];

    x_ = [1-(u(1,:) + u(2,:)); u(1,:); u(2,:)];
    y_ = [u(3,:); 1-(u(3,:) + u(4,:)); u(4,:)];

    Ay = A*y_;
    Bx = B*x_;

    dx = x_.*(Ay - x_' * Ay);
    dy = y_.*(Bx - y_' * Bx);
    du = [dx(2);dx(3);dy(1);dy(3)];
end