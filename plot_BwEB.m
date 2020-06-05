%function plot_BwEB(data, err, colors,varargin)
% 
% This function plots a grouped bar chart together with error bars for a
% given dataset. This function has the option to add an extra group to
% represent the average of the categories across the given dataset. 
% The error bars in the average grouped bars (with x-axis tick label as 
% AVG') indicate the standard error of the mean. 
% 
% INPUT: 
%    data       --> number of groups x number of categories 
%    err        --> error for the given data (should be the same size as
%                   data, i.e. number of groups x number of categories)
%    colors     --> a cell list of colors, should have the same length as
%                   the number of categories 
%
%
% INPUT - optional:
%    avg        --> 0/1 whether or not to plot the average (default: 0)
%    legends    --> a cell array containing the legend for each category 
%                   (default: Ci, i is in {1,..., number of categories}) 
%    title      --> a sequence of characters indicating the title 
%    xlabel     --> a sequence of characters indicating the label of the x-axis
%    ylabel     --> a sequence of characters indicating the label of the y-axis
%    XTickLabel --> a cell array containing the x-axis tick label for each 
%                   group (default: Gi, i is in {1,..., number of groups})
%    fontsize   --> font size (default: 10)
%    ylim       --> limits of the y axis (default: [min(data(:))*0.8, 
%                   max(data(:))*1.2] )
%    GridOn     --> whether or not to plot the yaxis grid (on: 1 -- 
%                   off: 0 -- default: 0)
%
%  ------------------------------------------------
%  Example: 
%  data = [52, 65, 98; 78, 44, 80; 50, 59,55];
%  err = [5, 4, 5; 3, 3, 2; 4, 3, 5]; 
%  colors = {'r','b','g'}; 
%  plot_BwEB(data, err, colors, 'title','Example plot','avg',1,'fontsize',15,'GridOn',1)
%
%
% MIT License
% Copyright (c) 2020 Mahta Mousavi 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_BwEB(data, err, colors,varargin)

p = inputParser; 

addRequired(p,'data',@ismatrix);
addRequired(p,'err',@ismatrix);
addRequired(p,'colors',@(x)(iscell(x) && length(x)==size(data,2)));

legends_temp = cell(1,size(data,2)); 
for i = 1:length(legends_temp)
    legends_temp{i} = ['C',num2str(i)];
end
addParameter(p, 'legends', legends_temp, @(x) (length(x) == size(data,2)));
addParameter(p, 'title', [], @ischar);
addParameter(p, 'xlabel', [], @ischar);
addParameter(p, 'ylabel', [], @ischar);
addParameter(p, 'fontsize', 10, @isnumeric);
addParameter(p, 'avg', 0, @isnumeric);
addParameter(p, 'ylim', [min(data(:))*0.8, max(data(:))*1.2], @ismatrix);
addParameter(p, 'GridOn', 0, @isnumeric); 

xlabel_temp = cell(1,size(data,1)); 
for i = 1:length(xlabel_temp)
    xlabel_temp{i} = ['G', num2str(i)];
end
addParameter(p, 'XTickLabel', xlabel_temp, @iscell)

parse(p, data, err, colors, varargin{:})

legends = p.Results.legends; 
titles = p.Results.title;
xlabels = p.Results.xlabel;
ylabels = p.Results.ylabel;
fontsize = p.Results.fontsize; 
avg = p.Results.avg;
Xticklabels = p.Results.XTickLabel;
ylims = p.Results.ylim;
GridOn = p.Results.GridOn;

[numS,numC] = size(data); 

% the width of every bar is set to 0.4; find the rest of the parameters
% accordingly 
% for each subject, a length of ceil(0.4*numC) is needed 
x = ceil(0.4*(numC+1.1));
c = x:x:x*numS;

% create the figure and assign the x and y axes labels 
figure;
axes1 = axes; 
ylabel(ylabels);
xlabel(xlabels)
hold on

% plot the bars 
for i = 1:numS
    for j = 1:numC
        bar(c(i)+j*0.4,data(i,j),0.4, 'FaceColor', colors{j}); 
    end
end

% plot the error bars on the bars
for j = 1:numC
    errorbar(c+0.4*j,data(:,j),err(:,j),'.','Color','k');   
end

% plot the average if avg == 1
if avg == 1
    for j = 1:numC
        bar(x*(numS+2)+j*0.4,mean(data(:,j)),0.4, 'FaceColor', colors{j}); 
        errorbar(x*(numS+2)+0.4*j,mean(data(:,j)),std(data(:,j))/...
            sqrt(numS),'Color','k')
    end
end
    
% properly adjust the x limits depending on if the grouped average is 
% plotted or not  
% add the XTickLabel for the groups
if avg == 0
    set(axes1,'Xlim',[x-1 x*(numS+2)]);
    set(axes1,'XTick',[c+0.4*numC/2],'XTickLabel',Xticklabels);
else
    set(axes1, 'Xlim',[x-1 x*(numS+3)]);
    temp = cell(1,length(Xticklabels)+1);
    temp(1:length(Xticklabels))=Xticklabels;
    temp(length(Xticklabels)+1)={'AVG'};
    set(axes1,'XTick',[c+0.4*numC/2,x*(numS+2)+0.4*numC/2],'XTickLabel'...
        ,temp);
end

% add the legends and title for the figure 
legend(legends)
title(titles)

% set the y limits and adjust the font size 
ylim(ylims)
set(gca, 'FontSize',fontsize)

% set the y axis grid on or not 
if GridOn == 1
    ax=gca;
    ax.YGrid='on';
end

