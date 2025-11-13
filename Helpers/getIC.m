function IC = getIC(U_FULL, currentEquilibrium)
    if length(U_FULL)~=6
        error('wrong ic size')
    end
    mask = true(size(U_FULL));
    mask(currentEquilibrium) = false;

    % Return remaining elements
    IC = U_FULL(mask);
end