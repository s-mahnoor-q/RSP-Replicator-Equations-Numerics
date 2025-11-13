%% (S,S)
function dU = replicatorEq_x2y2(t, U, p)
    % integrate everything in log coords except X2, Y2

    ex=p(1); ey=p(2);
    A = [0, 1-ex, -1-ex;
        -1-ex, 0, 1-ex;
        1-ex, -1-ex, 0];
    B = [0, 1-ey, -1-ey;
        -1-ey, 0, 1-ey;
        1-ey, -1-ey, 0];

    % u is [x1;x3;y1;y3]
    x = [exp(U(1,:)); 1-(exp(U(1,:))+exp(U(2,:))); exp(U(2,:))];
    y = [exp(U(3,:));     1-(exp(U(3,:))+exp(U(4,:)));    exp(U(4,:))];

    Ay = A * y;
    Bx = B * x;

    dX = (Ay - x' * Ay);
    dY = (Bx - y' * Bx);

    dU = [dX(1); dX(3); dY(1); dY(3)];
end