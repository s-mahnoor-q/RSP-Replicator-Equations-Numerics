function U = deriveVariablesFromConstraint(v, currentEquilibrium)

    constraint = sprintf('%d_%d', currentEquilibrium(1), currentEquilibrium(2));

    switch constraint
        case ''
            X1 = v(:,1); X2 = v(:,2); X3 = v(:,3);
            Y1 = v(:,4); Y2 = v(:,5); Y3 = v(:,6);
    
        case '1_4'
            X2 = v(:,1); X3 = v(:,2); X1 = log1p(-exp(X2 + X3));
            Y2 = v(:,3); Y3 = v(:,4); Y1 = log1p(-exp(Y2 + Y3));
    
        case '1_5'
            X2 = v(:,1); X3 = v(:,2); X1 = log1p(-exp(X2 + X3));
            Y1 = v(:,3); Y3 = v(:,4); Y2 = log1p(-exp(Y1 + Y3));
    
        case '1_6'
            X2 = v(:,1); X3 = v(:,2); X1 = log1p(-exp(X2 + X3));
            Y1 = v(:,3); Y2 = v(:,4); Y3 = log1p(-exp(Y1 + Y2));
    
        case '2_4'
            X1 = v(:,1); X3 = v(:,2); X2 = log1p(-exp(X1 + X3));
            Y2 = v(:,3); Y3 = v(:,4); Y1 = log1p(-exp(Y2 + Y3));
    
        case '2_5'
            X1 = v(:,1); X3 = v(:,2); X2 = log1p(-exp(X1 + X3));
            Y1 = v(:,3); Y3 = v(:,4); Y2 = log1p(-exp(Y1 + Y3));
    
        case '2_6'
            X1 = v(:,1); X3 = v(:,2); X2 = log1p(-exp(X1 + X3));
            Y1 = v(:,3); Y2 = v(:,4); Y3 = log1p(-exp(Y1 + Y2));
    
        case '3_4'
            X1 = v(:,1); X2 = v(:,2); X3 = log1p(-exp(X1 + X2));
            Y2 = v(:,3); Y3 = v(:,4); Y1 = log1p(-exp(Y2 + Y3));
    
        case '3_5'
            X1 = v(:,1); X2 = v(:,2); X3 = log1p(-exp(X1 + X2));
            Y1 = v(:,3); Y3 = v(:,4); Y2 = log1p(-exp(Y1 + Y3));
    
        case '3_6'
            X1 = v(:,1); X2 = v(:,2); X3 = log1p(-exp(X1 + X2));
            Y1 = v(:,3); Y2 = v(:,4); Y3 = log1p(-exp(Y1 + Y2));
    
        otherwise
            error("constraint %s not found!", constraint)
    end

    % Output in ode45 format: [timePoints × variables]
    U = [X1, X2, X3, Y1, Y2, Y3];

end