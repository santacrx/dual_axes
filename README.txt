dual_axes.m: 

Syntax:
=======
  dual_axes(Axis,Title,Type,Conversion,Name,...)
  dax = dual_axes(Axis,Title,Type,Conversion,Name,...)
 
Description: 
============
  Adds a unit converted second axis to either y or x, or both. The second
  converted axis is placed opposed or on the same side as the main one. 
  Axes are linked and can be panned and returned to home. 

  *Opposed: the main x-axis is at the bottom and the added generated one
  by this funcion will be at the top of the plotting area; the second
  y-axis will be added to the right.
 
  *Same: the generated axis will be placed offset from the main one to 
  the left (if y) or below (if x).
 
  Notes:
    *Title must be fed and called by the function. If no title is desired, 
    feed a blank ([]) or empty string ('')
    *All other modifiers need to be called BEFORE this function
 
 
Inputs:
=======
 *Axis        Axis handler where to insert dual_axes
 *Title       Figure title. DO NOT CALL TITLE OUTSIDE OF THIS!
 *Type        'x','y', or 'xy' for opposed to main axes;
             'xs','ys', or 'xys' for same side as maun axes;
 *Conversion  Conversion factor from unit on plot to the one you want
 *Name        New unit label
 *[conv2]     Y-axis conversion factor when 'xy' or 'xys' is selected
 *[name2]     Y-axis label when 'xy' or 'xys' is selected
 

Outputs:
========
 *[Axis]      Axis handler(s) of dual if needed to access properties
 
 
Usage:
======
  You must call this function AFTER all figure modifiers (i.e: legends,
  limits, labels, etc.) EXCEPT title. This function calls the title, if
  no title is desired, enter a blank (i.e.: [])
  1) 'x' OR 'xs': X-axis
        dual_axes(gca,[],'x',1/.7457,'Power [hp]')
  2) 'y' OR 'ys': Y-axis
        dual_axes(gca,[],'y',0.0016,'SFC [lb/hp-hr]')
  3) 'xy' OR 'xys': Both Axes
        dual_axes(gca,[],'xy',1/.7457,'Power [hp]',0.0016,'SFC [lb/hp-hr]')
 
--------------------------------------------------------------------------
  Author: XSantacruz (santacrx@gmail.com)
  Revison: 3.1 - 20220222
--------------------------------------------------------------------------
 
 
Examples:
=========
  You can copy this code and paste it into the command window or
  select it and hit F9 on your keyboard:
 
    %both axes, opposed
    figure;
    x=0:0.1:10;
    y=rand(size(x));
    plot(x,y,'-');
    grid minor
    legend('Data');
    xlabel('X Units 1');
    ylabel('Y Units 1');
    dual_axes(gca,'Random Plot, Opposed Dual Axes',...
        'xy',20,'X Unit 2',400,'Y Unit 2');
 
    %both axes, same
    figure;
    x=0:0.1:10;
    y=rand(size(x));
    plot(x,y,'-');
    grid minor
    legend('Data');
    xlabel('X Units 1');
    ylabel('Y Units 1');
    dual_axes(gca,'Random Plot,Same Dual Axes',...
        'xys',20,'X Unit 2',400,'Y Unit 2');
 
    %x-axis, opposed
    figure;
    x=0:0.1:10;
    y=rand(size(x));
    plot(x,y,'-');
    grid minor
    legend('Data');
    xlabel('X Units 1');
    ylabel('Y Units 1');
    dual_axes(gca,'Random Plot, Opposed X-Axis Only',...
        'x',20,'X Unit 2');
 
    %x-axis, same
    figure;
    x=0:0.1:10;
    y=rand(size(x));
    plot(x,y,'-');
    grid minor
    legend('Data');
    xlabel('X Units 1');
    ylabel('Y Units 1');
    dual_axes(gca,'Random Plot, Same X-Axis Only',...
        'xs',20,'X Unit 2');
 
    %y axis, opposed
    figure;
    x=0:0.1:10;
    y=rand(size(x));
    plot(x,y,'-');
    grid minor
    legend('Data');
    xlabel('X Units 1');
    ylabel('Y Units 1');
    dual_axes(gca,'Random Plot, Opposed Y-Axis Only',...
        'y',400,'Y Unit 2');
 
    %y axis, same
    figure;
    x=0:0.1:10;
    y=rand(size(x));
    plot(x,y,'-');
    grid minor
    legend('Data');
    xlabel('X Units 1');
    ylabel('Y Units 1');
    dual_axes(gca,'Random Plot, Same Y-Axis Only',...
        'ys',400,'Y Unit 2');
	
--------------------------------------------------------------------------
 
Suggestion:
===========	
  Copy the function to your working directory, or add it to MATLAB file under your user:
	C:\Users\<user>\Documents\MATLAB

  And then add the following line to the startup.m file located there (if no file, create one with the line below.
	addpath('C:\Users\<user>\Documents\MATLAB');

  Any functions that you put into that directory from now on will always load as if they were normal to MATLAB environment.
