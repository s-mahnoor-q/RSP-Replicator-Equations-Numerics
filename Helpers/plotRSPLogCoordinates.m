function [] = plotRSPLogCoordinates(t, U)
    % we plot the variables
    % TODO: add dotted line feature which

    % default MATLAB colours
    colors = [
    0.0000  0.4470  0.7410;  % blue
    0.8500  0.3250  0.0980;  % red
    0.9290  0.6940  0.1250;  % yellow
    0.4940  0.1840  0.5560;  % purple
    0.4660  0.6740  0.1880;  % green
    0.3010  0.7450  0.9330;  % cyan
    ];

    % plotting all variables on 1 plot, in the log coordinates
    for i=1:6
        plot(t,U(:,i),'Color',colors(i,:),'LineWidth', 1.25);
    end
end