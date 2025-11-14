function [ax1, ax2] = formatFigureChapter5_6(ax1, ax2, t, u, labelSize, lw)
    rgb = [
    0.0000  0.4470  0.7410;  % blue
    0.8500  0.3250  0.0980;  % red
    0.9290  0.6940  0.1250;  % yellow
    0.4940  0.1840  0.5560;  % purple
    0.4660  0.6740  0.1880;  % green
    0.3010  0.7450  0.9330;  % cyan
    ];

    x1 = u(:,1); x2 = u(:,2); x3 = u(:,3);
    y1 = u(:,4); y2 = u(:,5); y3 = u(:,6);

    hold(ax1, 'on');
    xlabel(ax1, 't', Interpreter='latex', FontSize=labelSize);
    ylabel(ax1, '$x_i, y_j$', Interpreter='latex', FontSize=labelSize);
    
    size(t)
    size(x1)
    l1=plot(ax1, t,x1, 'LineWidth', lw);
    l2=plot(ax1, t,x2, 'LineWidth', lw);
    l3=plot(ax1, t,x3, 'LineWidth', lw);    
    l4=plot(ax1, t,y1, 'LineWidth', lw);
    l5=plot(ax1, t,y2, 'LineWidth', lw);
    l6=plot(ax1, t,y3, 'LineWidth', lw);

    hold(ax2, 'on');
        v=[x1,x2,x3,y1,y2,y3];
    % plotting log coordinates
    xlabel(ax2, 't', Interpreter='latex', FontSize=labelSize);
    ylabel(ax2, '$X_i, Y_j$', Interpreter='latex', FontSize=labelSize);
    [~,I] = max(imag(log(v)) ~= 0);
    I;
    for i=1:6
        if I(i) == 1
            %plot like normal because all values are real
            plot(ax2, t,log(v(:,i)), 'LineWidth', lw, 'Color', rgb(i,:));
        else
            % I(i) is when things go wrong
            tL = t(1:I(i)-1); tR = t(I(i)-1:end);
            logvL = log(v(1:I(i)-1,i));
            logvR = log(v(I(i)-1:end,i));
            plot(ax2, tL, logvL, 'LineWidth', lw, 'Color', rgb(i,:));
            % From I(i)-1 to end, make the variable dotted
            plot(ax2, tR, logvR, ':', 'LineWidth', lw, 'Color', rgb(i,:));
        end
    end
    lg = legend(ax2, [l1 l2 l3 l4 l5 l6], '$X_1$', '$X_2$', '$X_3$', '$Y_1$', '$Y_2$', '$Y_3$', 'Location', 'none', 'Interpreter', 'latex');
    set(lg, 'Units','normalized');
    set(lg, 'Position', [0.925 0.5 0.05 0.05]); 

end

