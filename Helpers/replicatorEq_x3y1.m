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

    x = [exp(U(1,:)); exp(U(2,:)); 1-(exp(U(1,:))+exp(U(2,:)))];
    y = [1-(exp(U(3,:))+exp(U(4,:))); exp(U(3,:)); exp(U(4,:))];

    Ay = A * y;
    Bx = B * x;

    dX = (Ay - x' * Ay);
    dY = (Bx - y' * Bx);

    dU = [dX(1); dX(2); dY(2); dY(3)];
end