function [hFig, hAxes] = accordPlotMakerWrapper()
%
% The AcCoRD Simulator
% (Actor-based Communication via Reaction-Diffusion)
%
% Copyright 2016 Adam Noel. All rights reserved.
% 
% For license details, read LICENSE.txt in the root AcCoRD directory
% For user documentation, read README.txt in the root AcCoRD directory
%
% accordPlotMakerWrapper.m - Wrapper function for accordPlotMaker, which
%   can create a plot from AcCoRD simulation output.
%   This file prepares all of the input arguments needed for
%   accordPlotMaker.
%   RECOMMENDATION: TO USE THIS FUNCTION, YOU SHOULD MAKE A COPY AND MODIFY
%   THE COPY.
%
% INPUTS
% NONE - this file is intended to be a wrapper that is modified directly.
%   Descriptions of the input arguments for accordVideoMaker are described
%   as they are initialized below.
%
% OUTPUTS
% hFig - handle(s) to plotted figure(s). Use for making changes.
% hAxes - handle(s) to axes in plotted figure(s). Use for making changes.
%
% Last revised for AcCoRD LATEST_VERSION
%
% Revision history:
%
% Revision LATEST_VERSION
% - Created file
%
% Created 2016-06-03

%% 

% hAxes - handle to plotting axes. If 0, a new figure will be created.
%   Otherwise, curve will be added to existing axes
hAxes = 0;

% fileToLoad - simulation file generated by accordImport from raw AcCoRD
%   simulation output. The '.mat' extension can be omitted. File should
%   have 'data' and 'config' structures.
fileToLoad = 'accord_sample_out';

% customFigProp - structure of figure properties to change from AcCoRD
%   defaults. Can be passed as empty if no defaults are to be changed. See
%   accordBuildFigureStruct for structure fields and their default values.
customFigProp = [];

% customAxesProp - structure of axes properties to change from AcCoRD
%   defaults. Can be passed as empty if no defaults are to be changed. See
%   accordBuildAxesStruct for structure fields and their default values.
%   NOTE: It is highly recommended to change the default Visible and
%   Projection properties, since the default settings favor video
%   generation and not curve plotting
customAxesProp.Visible = 'on';
customAxesProp.Projection = 'orthographic';

% passiveActorToPlot - index of passive recording actors whose
%   molecules are to be plotted. Indexing matches the list of passive
%   actors whose observations are recorded (as stored in the data structure
%   in fileToLoad). Actors listed here will NOT have their shapes plotted
%   (use actorToPlot to plot specific actors).
passiveID = 1;

% molID - index of molecules to display. Indexing corresponds to the
%   list of molecules that the actor is recording (as stored in the data
%   structure in fileToLoad).
molID = 1;

% customObsProp - structure of data display properties to change
%   from AcCoRD defaults. Can be passed as empty if no defaults are to be
%   changed. See accordBuildObserverStruct for structure fields and their
%   default values.
customObsProp = [];

% customCurveProp - structure of curve display properties to change
%   from AcCoRD defaults. Can be passed as empty if no defaults are to be
%   changed. See accordBuildCurveStruct for structure fields and their
%   default values.
customCurveProp = [];

%% Call accordPlotMaker
[hFig, hAxes] = accordPlotMaker(hAxes, fileToLoad,...
    passiveID, molID, ...
    customObsProp, customCurveProp, ...
    customFigProp, customAxesProp);