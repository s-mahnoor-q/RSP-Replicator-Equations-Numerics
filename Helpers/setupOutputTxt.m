function fileID = setupOutputTxt(p,u0)
%GENERATETXTFILENAME 
    U0 = log(u0);
    txtOutName = sprintf('Simulations/ex%.2f ey%.2f__X %.3f %.3f Y %.3f %.3f.txt',p(1),p(2),u0(1),u0(2),u0(4),u0(6));
    fileID=fopen(txtOutName, 'w');
    fprintf(fileID, "Parameters: eps_x: %.2f, eps_y: %.2f\n", p(1), p(2));
    fprintf(fileID, "Initial conditions in regular coordinates: [%.3f %.3f %.3f] [%.3f %.3f %.3f]\n", u0(1), u0(2), u0(3), u0(4), u0(5), u0(6));
        fprintf(fileID, "Initial conditions in log coordinates: [%.3f %.3f %.3f] [%.3f %.3f %.3f]\n", U0(1), U0(2), U0(3), U0(4), U0(5), U0(6));
    fprintf(fileID, "=========START==========\n");
end

