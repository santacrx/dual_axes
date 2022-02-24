function dual_axes(pAx,pTitle,pType,conv,name,varargin)
% Syntax:
% =======
%   dual_axes(Axis,Title,Type,Conversion,Name,...)
%
% Description: 
% ============
% Adds a unit converted second axis to either y or x, or both. The second
% converted axis is placed opposed or on the same side as the main one. 
% Axes are linked and can be panned and returned to home. 
%   -Opposed: the main x-axis is at the bottom and the added generated one
%    by this funcion will be at the top of the plotting area; the second
%    y-axis will be added to the right.
%   -Same: the generated axis will be placed offset from the main one to 
%    the left (if y) or below (if x).
%
%   Notes:
%   -Title must be fed and called by the function. If no title is
%    desired, feed a blank ([]) or empty string ('')
%   -All other modifiers need to be called BEFORE this function
%
% Inputs:
% =======
%   Axis        Axis handler where to insert dual_axes
%   Title       Figure title. DO NOT CALL TITLE OUTSIDE OF THIS!
%   Type        'x','y', or 'xy' for opposed to main axes;
%               'xs','ys', or 'xys' for same side as maun axes;
%   Conversion  Conversion factor from unit on plot to the one you want
%   Name        New unit label
%   [conv2]     Y-axis conversion factor when 'xy' or 'xys' is selected
%   [name2]     Y-axis label when 'xy' or 'xys' is selected
%
% Outputs:
% ========
%   N/A
%
% Usage:
% ======
%   You must call this function AFTER all figure modifiers (i.e: legends,
%   limits, labels, etc.) EXCEPT title. This function calls the title, if
%   no title is desired, enter a blank (i.e.: [])
%   1) 'x' OR 'xs': X-axis
%       dual_axes(gca,[],'x',1/.7457,'Power [hp]')
%   2) 'y' OR 'ys': Y-axis
%       dual_axes(gca,[],'y',0.0016,'SFC [lb/hp-hr]')
%   3) 'xy' OR 'xys': Both Axes
%       dual_axes(gca,[],'xy',1/.7457,'Power [hp]',0.0016,'SFC [lb/hp-hr]')
%
%--------------------------------------------------------------------------
% Author: XSantacruz (santacrx@gmail.com)
% Revison: 3.1 - 20220222
%--------------------------------------------------------------------------
%
% Examples:
% =========
% You can copy this code and paste it into the command window or
% select it and hit F9 on your keyboard:
%
%   %both axes, opposed
%   figure;
%   x=0:0.1:10;
%   y=rand(size(x));
%   plot(x,y,'-');
%   grid minor
%   legend('Data');
%   xlabel('X Units 1');
%   ylabel('Y Units 1');
%   dual_axes(gca,'Random Plot, Opposed Dual Axes',...
%       'xy',20,'X Unit 2',400,'Y Unit 2');
%
%   %both axes, same
%   figure;
%   x=0:0.1:10;
%   y=rand(size(x));
%   plot(x,y,'-');
%   grid minor
%   legend('Data');
%   xlabel('X Units 1');
%   ylabel('Y Units 1');
%   dual_axes(gca,'Random Plot,Same Dual Axes',...
%       'xys',20,'X Unit 2',400,'Y Unit 2');
%
%   %x-axis, opposed
%   figure;
%   x=0:0.1:10;
%   y=rand(size(x));
%   plot(x,y,'-');
%   grid minor
%   legend('Data');
%   xlabel('X Units 1');
%   ylabel('Y Units 1');
%   dual_axes(gca,'Random Plot, Opposed X-Axis Only',...
%       'x',20,'X Unit 2');
%
%   %x-axis, same
%   figure;
%   x=0:0.1:10;
%   y=rand(size(x));
%   plot(x,y,'-');
%   grid minor
%   legend('Data');
%   xlabel('X Units 1');
%   ylabel('Y Units 1');
%   dual_axes(gca,'Random Plot, Same X-Axis Only',...
%       'xs',20,'X Unit 2');
%
%   %y axis, opposed
%   figure;
%   x=0:0.1:10;
%   y=rand(size(x));
%   plot(x,y,'-');
%   grid minor
%   legend('Data');
%   xlabel('X Units 1');
%   ylabel('Y Units 1');
%   dual_axes(gca,'Random Plot, Opposed Y-Axis Only',...
%       'y',400,'Y Unit 2');
%
%   %y axis, same
%   figure;
%   x=0:0.1:10;
%   y=rand(size(x));
%   plot(x,y,'-');
%   grid minor
%   legend('Data');
%   xlabel('X Units 1');
%   ylabel('Y Units 1');
%   dual_axes(gca,'Random Plot, Same Y-Axis Only',...
%       'ys',400,'Y Unit 2');

%grab gca data
ax(1) = pAx;

%Check inputs are correct
if rem(length(varargin),2)==0 && nargin>=5
    %load inputs
    if length(varargin)>=2
        conv2=varargin{1};
        name2=varargin(2);
    end
    %If any but x-opposed selected, do the title already
    if ~(strcmp(pType,'xy') || strcmp(pType,'x'))
        %plot title if it's not empty
        if ~isempty(pTitle), title(pTitle); end
    end
    %Find out type desired by user, load inputs appropriately. If something
    %fails, just exit and brief the user what happened
    switch pType
        case 'x'
            try
                %grab current axis position and shift down and crop up
                ax(1).Position = ax(1).Position + [0 0 0 -0.15];
                %create new axis, move x to top, hide y
                ax(2) = axes('Position',ax(1).Position,...
                    'XAxisLocation','top',...
                    'Color','none');
                ax(2).YAxis.Visible = 'off';
                %set properties and do conversions
                set(get(ax(2),'xlabel'),'string',name);
                xlim(ax(2),get(ax(1),'XLim').*conv);
            catch
                warning(' *!* dual_axes ERROR: wrong input data-type');
                return
            end
        case 'xs'
            try
                %grab current axis position and shift up and crop up
                ax(1).Position = ax(1).Position + [0 .15 0 -.15];
                %create new axis below that its just a line
                ax(2) = axes('Position',(ax(1).Position.*[1 1 1 0])+[0 -.15 0 1e-12],...
                    'XAxisLocation','bottom',...
                    'Color','none');
                ax(2).YAxis.Visible = 'off';
                %set properties and do conversions
                set(get(ax(2),'xlabel'),'string',name);
                xlim(ax(2),get(ax(1),'XLim').*conv);
            catch
                warning(' *!* dual_axes ERROR: wrong input data-type');
                return
            end
        case 'y'
            try
                %grab current axis position and crop left
                ax(1).Position = ax(1).Position + [0 0 -.05 0];
                %place new axis on top, hide x axis, put y axis to the right
                ax(2) = axes('Position',ax(1).Position,...
                    'YAxisLocation','right',...
                    'YColor',ax(1).YColor,...
                    'Color','none');
                ax(2).XAxis.Visible = 'off';
                %set properties and do conversions
                oYLim=get(ax(1),'YLim');
                set(get(ax(2),'ylabel'),'string',name);
                ylim(ax(2),get(ax(1),'YLim').*conv);
                ylim(ax(1),oYLim);
            catch
                warning(' *!* dual_axes ERROR: wrong input data-type');
                return
            end
        case 'ys'
            try
                %change original axis shape to fit new one on the side
                ax(1).Position = ax(1).Position + [.125 0 -.125 0];
                %place new axis, hide x axis, offset y-axis to the left
                ax(2) = axes('Position',(ax(1).Position.*[1 1 0 1])+[-.125 0 1e-12 0],...
                    'Color','none',...
                    'YColor',ax(1).YColor,...
                    'XTick',[],...
                    'XTickLabel',[]);
                ax(2).XAxis.Visible = 'off';
                %set properties and do conversions
                set(get(ax(2),'ylabel'),'string',name);
                ylim(ax(2),get(ax(1),'YLim').*conv);
                
            catch
                warning(' *!* dual_axes ERROR: wrong input data-type');
                return
            end
        case 'xy'
            try
                %move the axis down (to accomodate second x-axis) and add the
                %new one on top,
                ax(1).Position = ax(1).Position + [0 0 0 -0.15];
                ax(2) = axes('Position',ax(1).Position,...
                    'XAxisLocation','top',...
                    'YAxisLocation','right',...
                    'YColor',ax(1).YColor,...
                    'Color','none');
                %set properties and do conversions
                set(get(ax(2),'ylabel'),'string',name2);
                set(get(ax(2),'xlabel'),'string',name);
                axis(ax(2),[get(ax(1),'XLim').*conv, get(ax(1),'YLim').*conv2]);
            catch
                warning(' *!* dual_axes ERROR: wrong input data-type');
                return
            end
        case 'xys'
            try
                %move the axis down (to accomodate second x-axis) and right
                % (for y-axis)
                ax(1).Position = ax(1).Position + [.125 .15 -.125 -.15];
                %add the new x axis below
                ax(2) = axes('Position',(ax(1).Position.*[1 1 1 0])+[0 -.15 0 1e-12],...
                    'XAxisLocation','bottom',...
                    'Color','none');
                ax(2).YAxis.Visible = 'off';
                %set properties and do conversions
                set(get(ax(2),'xlabel'),'string',name);
                xlim(ax(2),get(ax(1),'XLim').*conv);
                %add the new y axis to the left
                ax(3) = axes('Position',(ax(1).Position.*[1 1 0 1])+[-.125 0 1e-12 0],...
                    'Color','none',...
                    'YColor',ax(1).YColor,...
                    'XTick',[],...
                    'XTickLabel',[]);
                ax(3).XAxis.Visible = 'off';
                %set properties and do conversions
                set(get(ax(3),'ylabel'),'string',name2);
                ylim(ax(3),get(ax(1),'YLim').*conv2);
            catch
                warning(' *!* dual_axes ERROR: wrong input data-type');
                return
            end
        otherwise
            %add title and do nothing else
            %plot title if it's not empty
            if ~isempty(pTitle), title(pTitle); end
            warning(' *!* dual_axes ERROR: wrong plot type call');
            return
    end
    % {
    %If it involves a top crop for x up top, now add the title
    if strcmp(pType,'xy') || strcmp(pType,'x')
        %plot title if it's not empty
        if ~isempty(pTitle), title(pTitle); end
    end
    %}
    % {
    %Link the dual axes together for panning and zooming.
    try
    for a=2:length(ax)
        %Remove interactions of other axis
        ax(a).Interactions = [];
        ax(a).Toolbar.Visible = 'off';
        % Compute scaling factor to convert ax1 scale from ax2 scale
        xyscale = [max(ax(1).XLim) \ max(ax(a).XLim); max(ax(1).YLim) \ max(ax(a).YLim)];
        % Store original axis limits for both axes
        % axBaseLim is 2x2x2 axis limits of [x;y] axes, [min,max] limits; and
        % [ax1,ax2] along the 3rd dimension
        axBaseLim = [ax(1).XLim; ax(1).YLim];           % ax1
        axBaseLim(:,:,a) = [ax(a).XLim; ax(a).YLim];    % axa
        % Assign listener
        ax(a).UserData.Listener = addlistener(ax(1),{'XLim','YLim'}, 'PostSet', ...
            @(~,~)updateLimitListener([ax(1),ax(a)], xyscale));
        % {
        % modified from source:https://www.mathworks.com/matlabcentral/answers/801186-how-to-zoom-on-a-figure-with-multiple-axes#answer_674426
        % Fix restoreview button
        axTB = axtoolbar(ax(1),'default');
        isRestoreButton = strcmpi({axTB(1).Children.Icon},'restoreview');
        if any(isRestoreButton)
            restoreButtonHandle = axTB.Children(isRestoreButton);
            originalRestoreFcn = restoreButtonHandle.ButtonPushedFcn;
            restoreButtonHandle.ButtonPushedFcn = ...
                {@myRestoreButtonCallbackFcn, ax(a), originalRestoreFcn, xyscale};
        end
        % }
    end
    catch ME
        rethrow(ME)
    end
    %}
    disp(' - Dual Axes Completed Succesfully');
else
    warning(' *!* dual_axes ERROR: wrong number of inputs');
    return
end
%focus on original axis if the user wants to explore data before continuing
axes(ax(1));
return
end

function updateLimitListener(ax,scalingFactor)
% Listener callback that responds to x/y axis limit changes to ax1 and update ax2 limits
set(ax(2),'XLim',ax(1).XLim.*scalingFactor(1),'YLim',ax(1).YLim.*scalingFactor(2));
end

%source:https://www.mathworks.com/matlabcentral/answers/801186-how-to-zoom-on-a-figure-with-multiple-axes#answer_674426
function myRestoreButtonCallbackFcn(hobj, event, ax1, originalCallback, xyscale)
% Responds to pressing the restore button in the ax2 toolbar. 
% originalCallback is a function handle to the original callback 
% function for this button. 
% xyscale and axBaseLim are defined elsewhere.
originalCallback(hobj,event) % reset ax2
updateLimitListener([event.Axes,ax1],xyscale) % update ax1
end
