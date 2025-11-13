%% (S,P)
function dU = replicatorEq_x2y3(t, U, p)
    % integrate everything in log coords except X2, Y3

    ex=p(1); ey=p(2);
    A = [0, 1-ex, -1-ex;
        -1-ex, 0, 1-ex;
        1-ex, -1-ex, 0];
    B = [0, 1-ey, -1-ey;
        -1-ey, 0, 1-ey;
        1-ey, -1-ey, 0];

    % u is [x1;x3;y1;y2]
    X = [U(1,:); 1-(U(1,:)+U(2,:)); U(2,:)];
    Y = [U(3,:); U(4,:); 1-(U(3,:)+U(4,:))];

    x = exp(X);
    y = exp(Y);

    Ay = A * y;
    Bx = B * x;

    dX = (Ay - x' * Ay);
    dY = (Bx - y' * Bx);

    dU = [dX(1); dX(3); dY(1); dY(2)];
end