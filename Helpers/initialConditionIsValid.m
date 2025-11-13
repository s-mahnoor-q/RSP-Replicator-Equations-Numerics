function valid = initialConditionIsValid(u0)
    constraint_err = 1e-14;
    if size(u0) ~= [1,6]
        error('Input u0 is of incorrect size. Expected size is [1,6]')
    elseif any(u0<0)
        error('Probability is negative. Please enter initial conditions in regular coordinates, not log coordinates.')
    elseif abs(1-sum(u0(1:3)))>constraint_err
         error('Sum of x probabilities is not within 1+/-%.s. Please ensure the initial condition satisfies the constraint.', constraint_err)
    elseif abs(1-sum(u0(4:6)))>constraint_err
         error('Sum of y probabilities is not within 1+/-%.s. Please ensure the initial condition satisfies the constraint.', constraint_err)
    end
    valid=true;
end

