function du = noConstraintReg(t, u, p)
    ex=p(1); ey=p(2);
    A = [0, 1-ex, -1-ex;
        -1-ex, 0, 1-ex;
        1-ex, -1-ex, 0];
    B = [0, 1-ey, -1-ey;
        -1-ey, 0, 1-ey;
        1-ey, -1-ey, 0];

    x_ = u(1:3,:); y_ = u(4:6,:);

    du=zeros(6,1);
    Ay = A*y_; Bx = B*x_;

    dx = x_.*(Ay - x_' * Ay);
    dy = y_.*(Bx - y_' * Bx);
    du = [dx;dy];
end