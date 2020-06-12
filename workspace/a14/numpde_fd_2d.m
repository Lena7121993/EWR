%%Aufgabe14
%In dieser Aufgabe wird das Poisson-Problem mit einem sogenannten L-Gebiet
%betrachtet. Mit Hilfe der Finite-Differenzen-Methode wird eine Loesung
%berechnet und die experimentelle Konvergenzordnung der 5- und 9-Punkte-Sterm-Approximation 
%bestimmt. 

% Das allgemeine Rand-Anfangswertproblem ist
%    d/dt u - a\Delta u + b.\grad u + c u = f     in \Omega
%                                       u = dir   auf rand(\Omega)
%                                       u = u0    in {0}x\Omega
%
%% Randwertprobleme (d/dt u = 0)
%  1.  5-Pkte Stern Poissonproblem (f konstant)
%  2.  9-Pkte Stern Poissonproblem (f konstant)

% W. Doerfler: Finite Differenzen Verfahren
%              Demos fd 2d (Anfangs-)Randwertprobleme, 2020.
% Karlsruher Institut fuer Technologie, Fakultaet fuer Mathematik.

% Version: Lena Hilpp, Jan Frithjof Fleischhammer, 07.06.2020
%% Randwertprobleme
clear all; close all; clc;
openfigure(4,'init');

%% Demo 3a: 5-Pkte Stern Poissonproblem
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_2d.m (%s)\n',datestr(now));
datafile = 'dat_fd_bvp_2d_LGebiet';
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 2;% -\Delta u = 0 auf 'L'
% Run datafile
eval(datafile);
% A posteriori data
NperDim = 9;
gopt.view = [20,30];
% Run method
stationary_problem();
% Output
figure(2); title(['Numerische Loesung Demo(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%print('-f1','bild1','-dpng','-r100');
%print('-f2','bild2','-dpng','-r100');
%% Demo 3b: EOC zu 5-Punkte-Stern(erst Demo 3a ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple numpde_fd_1d.m (%s)\n',datestr(now));
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
deti = tic;% Start demo timer
N = [10;20;40;60;80;100];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe
run_eoc;
fprintf('DONE (%4.2e sec)\n',toc(deti));

%print('-f1','bild1a','-dpng','-r100');
%print('-f2','bild2a','-dpng','-r100');
%print('-f3','bild3','-dpng','-r100');
%print('-f4','bild4','-dpng','-r100');
%% Demo 3c: 9-Pkte Stern Poissonproblem
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_2d.m (%s)\n',datestr(now));
datafile = 'dat_fd_bvp_2d_LGebiet';
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 2;% -\Delta u = 0 auf 'L'
% Run datafile
eval(datafile);
% A posteriori data
NperDim = 9;
star=9;
gopt.view = [20,30];
% Run method
stationary_problem();
% Output
figure(2); title(['Numerische Loesung Demo(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%% Demo 3d: EOC zu 9-Punkte-Stern (erst Demo 3c ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple numpde_fd_1d.m (%s)\n',datestr(now));
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
deti = tic;% Start demo timer
N = [10;20;40;60;80;100];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe
run_eoc;
fprintf('DONE (%4.2e sec)\n',toc(deti));

%print('-f3','bild39stern','-dpng','-r100');
%print('-f4','bild49stern','-dpng','-r100');

%% ENDE
