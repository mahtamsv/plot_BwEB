% an example of using plot_BwEB.m 

data = [52, 65, 98, 90; 78, 44, 80, 68; 50, 59, 55, 85];
err = [5, 4, 5, 2; 3, 3, 2, 3; 4, 3, 5, 2]; 

colors = {'g','r','y','b'}; 
legend = {'Spring', 'Summer', 'Fall', 'Winter'};
XTickLabel = {'Exp1', 'Exp2', 'Exp3'};

plot_BwEB(data, err, colors, 'title','Example plot','avg',1,'fontsize',15,...
        'GridOn',1, 'legends',legend, 'ylabel','Something',...
        'xlabel','Seasons', 'XTickLabel', XTickLabel)