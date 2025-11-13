function figFilename = generateFigFilename(p,u0)
%GENERATEFIGFILENAME 
    figFilename = sprintf('Simulations/ex%.2f ey%.2f__X %.3f %.3f Y %.3f %.3f.txt',p(1),p(2),u0(1),u0(2),u0(4),u0(6));
    figFilename = sprintf('%s.fig', strrep(figFilename, '.', '-'));
end

