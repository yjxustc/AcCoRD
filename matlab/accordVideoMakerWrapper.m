function [hFig, hAxes] = accordVideoMakerWrapper()
%
% The AcCoRD Simulator
% (Actor-based Communication via Reaction-Diffusion)
%
% Copyright 2016 Adam Noel. All rights reserved.
% 
% For license details, read LICENSE.txt in the root AcCoRD directory
% For user documentation, read README.txt in the root AcCoRD directory
%
% accordVideoMakerWrapper.m - Wrapper function for accordVideoMaker, which
%   can generate a video file or sequence of images from AcCoRD simulation
%   output. This file prepares all of the input arguments needed for
%   accordVideoMaker.
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
% Last revised for AcCoRD v0.6 (public beta, 2016-05-30)
%
% Revision history:
%
% Revision v0.6 (public beta, 2016-05-30)
% - Created file
%
% Created 2016-05-19

%% 

% fileToLoad - simulation file generated by accordImport from raw AcCoRD
%   simulation output. The '.mat' extension should be omitted. File should
%   have 'data' and 'config' structures.
fileToLoad = 'accord_sample_out';

% bMakeVideo - if true, plot all simulation in a single figure and stich
%   images into a video file. If false, plot each observation in its own
%   figure and include an empty initial figure
bMakeVideo = true;

% videoName - filename to save the video to. File extension will be added
%   automatically.
videoName = fileToLoad;

% videoFormat - file format of the video. See MATLAB documentation for the
%   "VideoWriter" function for full list of options. 'Motion JPEG AVI' is the
%   default, but 'MPEG-4' is recommended for Windows since it creates much
%   smaller video files. 'MPEG-4' for Windows requires MATLAB 2012a or newer.
videoFormat = 'MPEG-4';

% curRepeat - index of the simulation realization to plot. It is
%   recommended that simulations that are run for video only have a
%   single realization to limit simulation output file size. Largest
%   available value is defined by 'data.numRepeat'.
curRepeat = 1;

% scale - scaling of physical dimensions of region and actor coordinates.
%   Needed to mitigate patch display problems. Recommend that smallest
%   object (non-molecule) to plot has dimension of order 1, so a system
%   defined on the order of microns should have scale equal to 1e6.
scale = 1e6;

% observationToPlot - array of indices of observations to plot. Assume that
%   all actors being displayed make the same number of observations and at
%   the same times. Actual actor start times and action intervals are
%   ignored.
%   Observation indices that are beyond the maximum number
%   of observations made will be ignored, so there is minimal harm to using
%   an "arbitrarily large" value if you want to plot the whole simulation.
observationToPlot = 1:1e6;

% customFigProp - structure of figure properties to change from AcCoRD
%   defaults. Can be passed as empty if no defaults are to be changed. See
%   accordBuildFigureStruct for structure fields and their default values.
customFigProp = [];

% customAxesProp - structure of axes properties to change from AcCoRD
%   defaults. Can be passed as empty if no defaults are to be changed. See
%   accordBuildAxesStruct for structure fields and their default values.
customAxesProp = [];

% customVideoProp - structure of video properties to change from AcCoRD
%   defaults. Can be passed as empty if no defaults are to be changed. See
%   accordInitializeVideo for structure fields and their default values.
customVideoProp = [];

% regionToPlot - array of indices of regions to be plotted. No regions need
%   to be plotted.
regionToPlot = 1;

% customRegionProp - structure of region properties to change from AcCoRD
%   defaults. Can be passed as empty if no defaults are to be changed. See
%   accordBuildDispStruct for structure fields and their default values.
customRegionProp = [];

% actorToPlot - array of indices of actors to be plotted. Indexing matches
%   the actor list in the original config file and is independent of
%   whether an actor is active or passive. Actors listed here will have
%   their shapes plotted but NOT their molecules (the latter is indicated
%   by the argument "passiveActorToPlot". Actors are drawn after regions,
%   so if an actor is defined by region(s) then it will be drawn on top of
%   its region(s). No actors need to be plotted
actorToPlot = 1;

% customActorProp - structure of actor properties to change from AcCoRD
%   defaults. Can be passed as empty if no defaults are to be changed. See
%   accordBuildDispStruct for structure fields and their default values.
customActorProp = [];

% passiveActorToPlot - array of indices of passive recording actors whose
%   molecules are to be plotted. Indexing matches the list of passive
%   actors whose observations are recorded (as stored in the data structure
%   in fileToLoad). Actors listed here will NOT have their shapes plotted
%   (use actorToPlot to plot specific actors).
passiveActorToPlot = 1;

% molToPlot - cell array of arrays of indices of molecules to display. Each
%   cell corresponds to the passive actor specified in passiveActorToPlot.
%   Its array lists the indices of the molecule types of that actor that
%   are to be drawn. The indexing of the actor's array corresponds to the
%   list of molecules that the actor is recording (as stored in the data
%   structure in fileToLoad).
molToPlot = {1};

% customMolProp - cell array of structure of molecule properties to change
%   from AcCoRD defaults. Can be passed as empty if no defaults are to be
%   changed. Indexing in this cell array matches that of the molToPlot cell
%   array. See accordBuildMarkerStruct for structure fields and their
%   default values.
customMolProp = {[]};

% cameraAnchorArray - cell array of cell arrays defining anchor points for
%   the camera display. Can be passed as an empty cell array. Each anchor
%   point is a cell array defining a complete set of camera settings, in
%   the format {'CameraPosition', 'CameraTarget', 'CameraViewAngle',
%   'CameraUpVector'}. See MATLAB camera documentation for more details.
cameraAnchorArray = {};

% frameCameraAnchor - array that specifies which frames use which camera
%   anchors. Length of array should be equal to length of
%   observationToPlot. If cameraAnchorArray is empty, then this array can
%   also be empty. Values in array must match indices of anchor points in
%   cameraAnchorArray. If a frame has associated value 0, and there are
%   camera anchors defined, then the camera settings will be interpolated
%   between anchors.
frameCameraAnchor = [];

%% Call accordVideoMaker
[hFig, hAxes] = accordVideoMaker(fileToLoad,...
    bMakeVideo, videoName, videoFormat, ...
    curRepeat, scale, observationToPlot, ...
    customFigProp, customAxesProp, customVideoProp, ...
    regionToPlot, customRegionProp, actorToPlot, customActorProp,...
    passiveActorToPlot, molToPlot, customMolProp, ...
    cameraAnchorArray, frameCameraAnchor);