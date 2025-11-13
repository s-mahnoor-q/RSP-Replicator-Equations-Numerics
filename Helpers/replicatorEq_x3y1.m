%% (P,R)
function dU = replicatorEq_x3y1(t, U, p)
    % integrate everything in log coords except X3, Y1

    ex=p(1); ey=p(2);
    A = [0, 1-ex, -1-ex;
        -1-ex, 0, 1-ex;
        1-ex, -1-ex, 0];
    B = [0, 1-ey, -1-ey;
        -1-ey, 0, 1-ey;
        1-ey, -1-ey, 0];

    % u is [x1;x2;y2;y3]
    X = [U(1,:); U(2,:); 1-(U(1,:)+U(2,:))];
    Y = [U(1,:); 1-(U(1,:)+U(2,:)); U(2,:)];

    x = exp(X);
    y = exp(Y);

    Ay = A * y;
    Bx = B * x;

    dX = (Ay - x' * Ay);
    dY = (Bx - y' * Bx);

    dU = [dX(1); dX(2); dY(2); dY(3)];
end