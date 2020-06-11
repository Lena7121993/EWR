%% Demofile
% Das allgemeine Rand-Anfangswertproblem ist
%    d/dt u - au'' + bu' + cu = f    in [0,T] x I
%                           u = uD   auf [0,T] x rand(I)
%                           u = u0   in {0}xI
%
%% Randwertprobleme (d/dt u = 0)
%  1.  3-Pkte Stern Poissonproblem (f konstant)
%% Anfangsrandwertprobleme
%%

% W. Doerfler: Finite Differenzen Verfahren.
%              Demos fd 1d (Anfangs-)Randwertprobleme, 2020.
% Karlsruher Institut fuer Technologie, Fakultaet fuer Mathematik.

%% Randwertprobleme
clear all; close all;
openfigure(4,'init');

%% Demo 1: 3-Pkte Stern Poissonproblem (f konstant)
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_1d.m (%s)\n',datestr(now));
datafile = 'dat_fd_bvp_1d';
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 1;% -u'' = 2 auf 'I'
% Run datafile
eval(datafile);
% A posteriori data
% Run method
stationary_problem();
% Output
figure(2); title(['Numerische Loesung Bsp(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%% Demo 1: EOC zu Bsp 1 (erst Demo 1 ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple numpde_fd_1d.m (%s)\n',datestr(now));
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
deti = tic;% Start demo timer
N = [20;40;80;160;320;640];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe
run_eoc;
fprintf('DONE (%4.2e sec)\n',toc(deti));

%% ENDE
