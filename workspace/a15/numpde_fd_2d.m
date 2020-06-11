%% Aufgabe15
%In dieser Aufgabe wird ein konvektionsdominiertes Modellproblem
%(Transportgleichung) betrachtet. Mit der Finite-Differenzen-Methode wird
%die numerische Loesung berechnet und die experimentelle Konvergenzordnung
%der 5-Punkte-Stern-Approximation mit dem zentralen Differenzenquotienten bestimmt.

% Das allgemeine Rand-Anfangswertproblem ist
%    d/dt u - a\Delta u + b.\grad u + c u = f     in \Omega
%                                       u = dir   auf rand(\Omega)
%                                       u = u0    in {0}x\Omega
%
%% Randwertprobleme (d/dt u = 0)
%  1.  5-Pkte Stern Transportgleichung
%  2.  5-Pkte Stern mit upwind

% W. Doerfler: Finite Differenzen Verfahren
%              Demos fd 2d (Anfangs-)Randwertprobleme, 2020.
% Karlsruher Institut fuer Technologie, Fakultaet fuer Mathematik.

% Version: Lena Hilpp, Jan Frithjof Fleischhammer, 07.06.2020
%% Randwertprobleme
clear all; close all;clf;
openfigure(4,'init');

%% Demo 4a: 5-Pkte Stern Transportgleichung
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_2d.m (%s)\n',datestr(now));
datafile = 'dat_fd_bvp_2d';
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 3;% -epsilon\Delta u +b*gradient u= f auf 'S'
% Run datafile
eval(datafile);
% A posteriori data
NperDim = 11;
gopt.view = [20,60];
% Run method
stationary_problem();
% Output
figure(2); title(['Numerische Loesung Demo(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%print('-f1','bild1gros','-dpng','-r100');
%print('-f2','bild2gros','-dpng','-r100');
%% Demo 4b: EOC zu Bsp 3 (erst Demo 4a ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple numpde_fd_1d.m (%s)\n',datestr(now));
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
deti = tic;% Start demo timer
N = [10;20;40;60;80;100];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe
run_eoc;
fprintf('DONE (%4.2e sec)\n',toc(deti));

%print('-f1','bild1agros','-dpng','-r100');
%print('-f2','bild2agros','-dpng','-r100');
%print('-f3','bild3gros','-dpng','-r100');
%print('-f4','bild4gros','-dpng','-r100');
%% Demo 4c: upwind
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_2d.m (%s)\n',datestr(now));
datafile = 'dat_fd_bvp_2d';
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 3;% -epsilon\Delta u +b*gradient u= f auf 'S'
% Run datafile
eval(datafile);
% A posteriori data
NperDim = 11;
gopt.view = [20,60];
order1='upwind';
% Run method
stationary_problem();
% Output
figure(2); title(['Numerische Loesung Demo(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%print('-f1','bild1upwind','-dpng','-r100');
%print('-f2','bild2upwind','-dpng','-r100');
%% Demo 4d: EOC zu Bsp 3 upwind (erst Demo 4c ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple numpde_fd_1d.m (%s)\n',datestr(now));
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
deti = tic;% Start demo timer
N = [10;20;40;60;80;100];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe
run_eoc;
fprintf('DONE (%4.2e sec)\n',toc(deti));

%print('-f1','bild1aupwind','-dpng','-r100');
%print('-f2','bild2aupwind','-dpng','-r100');
%print('-f3','bild3upwind','-dpng','-r100');
%print('-f4','bild4upwind','-dpng','-r100');
%% ENDE
