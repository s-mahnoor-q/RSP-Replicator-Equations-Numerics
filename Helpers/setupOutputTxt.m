function fileID = setupOutputTxt(p,u0)
%GENERATETXTFILENAME 
    txtOutName = sprintf('Simulations/ex%.2f ey%.2f__X %.3f %.3f Y %.3f %.3f.txt',p(1),p(2),u0(1),u0(2),u0(4),u0(6));
    fileID=fopen(txtOutName, 'w');
    fprintf(fileID, "PARAMETERS*** eps_x: %.2f, eps_y: %.2f\n", p(1), p(2))
    fprintf(fileID, "INITIAL CONDITIONS: [%.3f %.3f %.3f] [%.3f %.3f %.3f]\n", u0(1), u0(2), u0(3), u0(4), u0(5), u0(6))
    fprintf(fileID, "=========START==========\n")
end

