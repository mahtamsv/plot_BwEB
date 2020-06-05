# plot_BwEB
This function plots a grouped bar chart together with error bars for a
given dataset (number of groups x number of categories). 
This function has the option to add an extra group to
represent the average of the categories across the given dataset. 
The error bars in the average grouped bars (with x-axis tick label as 
'AVG') indicate the standard error of the mean. 

Here is an example plot: 

![](example_plot.png)
  
## Sample usage

Assume that your data has 3 groups (say experiments) and 4 categories:
```matlab
data = [52, 65, 98, 90; 78, 44, 80, 68; 50, 59, 55, 85];
err = [5, 4, 5, 2; 3, 3, 2, 3; 4, 3, 5, 2]; 
```

The following will create the above example plot:

```matlab
colors = {'g','r','y','b'}; 
legend = {'Spring', 'Summer', 'Fall', 'Winter'};
XTickLabel = {'Exp1', 'Exp2', 'Exp3'};
plot_BwEB(data, err, colors, 'title','Example plot','avg',1,'fontsize',15,...
        'GridOn',1, 'legends',legend, 'ylabel','Something',...
        'xlabel','Seasons', 'XTickLabel', XTickLabel)
```

Only the first three inputs (data, err and colors) are manadatory and the rest are optional. 
Please refer to `plot_BwEB.m` for more information. 
