%---------------------- Double-Integrator Problem ------------------------%
% This example can be found in any good book on optimal control theory    %
%-------------------------------------------------------------------------%
clear all; close all; clc

%-------------------------------------------------------------------------%
%----------------- Provide All Bounds for Problem ------------------------%
%-------------------------------------------------------------------------%


tmin = 0;      tmax = 1000;
xmin = -1e4;   xmax =  +1e4;
ymin = -1e4;   ymax =  +1e4;
vxmin = -1e4;  vxmax =  +1e4;
vymin = -1e4;  vymax =  +1e4;

umin_A  = -8;   umax_A = +8;
umin_B = -100;  umax_B = +100;

t0 = 0;

x0    = 0;     xf    = 5000;
y0    = 1000;  yf    = 0;
vx0   = 250;   vxf   = 250;
vy0   = 0;     vyf   = 0;



%-------------------------------------------------------------------------%
%----------------------- Setup for Problem Bounds ------------------------%
%-------------------------------------------------------------------------%
bounds.phase.initialtime.lower = t0;
bounds.phase.initialtime.upper = t0;
bounds.phase.finaltime.lower = tmin;
bounds.phase.finaltime.upper = tmax;
bounds.phase.initialstate.lower = [x0, y0, vx0, vy0];
bounds.phase.initialstate.upper = [x0, y0, vx0, vy0];
bounds.phase.state.lower = [xmin, xmin, vxmin, vymin];
bounds.phase.state.upper = [xmax, xmax, vxmax, vymax];
bounds.phase.integral.lower = 0;
bounds.phase.integral.upper = 1e6;

% FOR CASE A
% bounds.phase.finalstate.lower = [xf, yf, vxmin, vymin];
% bounds.phase.finalstate.upper = [xf, yf, vxmax, vymax];
% bounds.phase.control.lower = [umin_A];
% bounds.phase.control.upper = [umax_A];

% FOR CASE B
bounds.phase.finalstate.lower = [xf, yf, vxmin, vyf];
bounds.phase.finalstate.upper = [xf, yf, vxmax, vyf];
bounds.phase.control.lower = [umin_B];
bounds.phase.control.upper = [umax_B];

%-------------------------------------------------------------------------%
%---------------------- Provide Guess of Solution ------------------------%
%-------------------------------------------------------------------------%
tGuess               = [0; 20];
xGuess               = [x0; xf];
yGuess               = [y0; yf];
vxGuess              = [vx0; vxf];
vyGuess              = [vy0; vyf];
uGuess               = [0; 0];
guess.phase.state    = [xGuess, yGuess, vxGuess, vyGuess];
guess.phase.control  = [uGuess];
guess.phase.time     = [tGuess];
guess.phase.integral = 0;

%-------------------------------------------------------------------------%
%----------Provide Mesh Refinement Method and Initial Mesh ---------------%
%-------------------------------------------------------------------------%
mesh.method          = 'hp-LiuRao-Legendre';
mesh.tolerance       = 1e-6;
mesh.maxiterations    = 20;
mesh.colpointsmin    = 10;
mesh.colpointsmax    = 20;
mesh.phase.colpoints = 10;

%-------------------------------------------------------------------------%
%------------- Assemble Information into Problem Structure ---------------%        
%-------------------------------------------------------------------------%
setup.mesh                        = mesh;
setup.name                        = 'Double-Integrator-Min-Time';
setup.functions.endpoint          = @doubleIntegratorEndpoint;
setup.functions.continuous        = @doubleIntegratorContinuous;
setup.displaylevel                = 2;
setup.bounds                      = bounds;
setup.guess                       = guess;
setup.nlp.solver                  = 'ipopt';
setup.derivatives.supplier        = 'sparseFD';
setup.derivatives.derivativelevel = 'second';
setup.method                      = 'RPM-Differentiation';

%-------------------------------------------------------------------------%
%----------------------- Solve Problem Using GPOPS2 ----------------------%
%-------------------------------------------------------------------------%
output = gpops2(setup);
