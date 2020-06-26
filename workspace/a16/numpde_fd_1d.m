%% Demofile
% Das allgemeine Anfangs-Randwertproblem ist
%    d/dt u - au'' + bu' + cu = f    in [0,T] x I
%                           u = uD   auf [0,T] x rand(I)
%                           u = u0   in {0}xI
%
%% Randwertprobleme (d/dt u = 0)
%  1.  3-Pkte Stern Poissonproblem (f konstant)
%  2.  EOC dazu
%  3.  3-Pkte Stern Poissonproblem (f variabel)
%  4.  EOC dazu
%% Anfangs-Randwertprobleme (d/dt u ~= 0)
%  5.  Lineare Diffusionsgleichung, theta-Schema
%  6.  EOC dazu
%  7.  Nichtlineare Schroedinger-Gleichung, theta-Schema
%%

% W. Doerfler: Finite Differenzen Verfahren.
%              Demos fd 1d (Anfangs-)Randwertprobleme, Jun 2020.
% Karlsruher Institut fuer Technologie, Fakultaet fuer Mathematik.

%% Randwertprobleme
clear all; close all;
openfigure(4,'init');
prog = 'stationary_problem';% Programmname fuer run_eoc setzen

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

%% Demo 2: EOC zu Demo 1 (erst Demo 1 ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple numpde_fd_1d.m (%s)\n',datestr(now));
fprintf(' Running %s\n',prog);
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
deti = tic;% Start demo timer
N = [20;40;80;160;320;640];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe
run_eoc;
fprintf('DONE (%4.2e sec)\n',toc(deti));

%% Demo 3: 3-Pkte Stern Poissonproblem (f variabel)
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_1d.m (%s)\n',datestr(now));
datafile = 'dat_fd_bvp_1d';
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 2;% -u'' = f auf 'I'
% Run datafile
eval(datafile);
% A posteriori data
% Run method
stationary_problem();
% Output
figure(2); title(['Numerische Loesung Bsp(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%% Demo 4: EOC zu Demo 3 (erst Demo 3 ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple demo_fd_1d.m (%s)\n',datestr(now));
fprintf(' Running %s\n',prog);
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
deti = tic;% Start demo timer
N = [20;40;80;160;320;640];% Nodes per dimension
M = length(N);% Number of runs
run_eoc;
figure(2); title(['Numerische Loesung Bsp(' num2str(bsp) ')']);
fprintf('DONE (%4.2e sec)\n',toc(deti));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Zeitabhaengige Probleme
allfigures('clf');
prog = 'instationary_problem';% Programmname fuer run_eoc setzen

%% Demo 5: Lineare Diffusionsgleichung, theta-Schema
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_1d.m (%s)\n',datestr(now));
datafile = 'dat_fd_ivp_1d';% d/dt u - u'' = 0
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 1;
% Run datafile
eval(datafile);
% A posteriori data
theta = 0.5;% theta-Schema
dtscal = 'cfl'; dtcon = 1/2;% dt-Wahl
% Run method
instationary_problem();
% Output
figure(2); title(['Numerische Loesung Bsp(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%% Demo 6: EOC zu Bsp 1 (erst Demo 5 ausfuehren)
fprintf('\n----------------------------------------\n');
fprintf('\nMultiple demo_fd_1d.m (%s)\n',datestr(now));
fprintf(' Running %s\n',prog);
fprintf(' Bsp %d, Stern %d-pt\n',bsp,star);
fprintf(' theta %5.2e, dt scale %s, dt-constant %5.2e\n',theta,dtscal,dtcon);
deti = tic;% Start demo timer
N = [40;80;160;240;320];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe
run_eoc;
figure(2); title(['Numerische Loesung Bsp(' num2str(bsp) ')']);
fprintf('DONE (%4.2e sec)\n',toc(deti));

%% Demo 7: Nichtlineare Schroedinger-Gleichung, theta-Schema
fprintf('\n----------------------------------------\n');
fprintf('\nnumpde_fd_1d.m (%s)\n',datestr(now));
datafile = 'dat_fd_ivp_1d_nls';% d/dt u - i u'' + i |u|^2u = 0
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
fddefaults();
% A priori data
bsp = 1;
% Run datafile
eval(datafile);
% A posteriori data
theta = 0.5;% theta-Schema
dtscal = 'cfl'; dtcon = 1/8;% dt-Wahl
% Run method
instationary_nl_problem();
% Output
figure(2); title(['Numerische Loesung Bsp(' num2str(bsp) ')']);
fprintf('Done (%4.2e sec)\n',toc(deti));

%% ENDE
