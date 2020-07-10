%% Demofile CG
% Data for nonlinear parabolic initial boundary value problems in 1D of
% Cahn-Hilliard type.
% We solve the initial boundary value problem for [u,mu]
%    d/dt u - c1 mu'' = 0       in (0,T)x(xL,xR),
%    c2 u'' +    mu   = F'(u)   in (0,T)x(xL,xR),
%              u(0,.) = u0      in (xL,xR),
%             mu(0,.) = mu0     in (xL,xR),
%              d_n  u = 0       on (0,T)x{xN},
%              d_n mu = muN     on (0,T)x{xN},
% for xL<xR, 0<T, nonlinearity F and functions f (source), uD (Dirichlet data),
% xD (Dirichlet boundary points), uN (Neumann data mu), xN (Neumann boundary
% points), u0 (initial condition).
% Variant for c3 > 0: Viscous Cahn-Hilliard equation
%    (1-c1 c3 (.)'') d/dt u - c1 mu'' = 0       in (0,T)x(xL,xR),
%                    c2 u'' +    mu   = F'(u)   in (0,T)x(xL,xR),
%% Problems (d=1)
% Battery
%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
openfigure(4,'init');
% Organise output
fig = struct('mesh',1,'sol',2,'eng',3,'info',4);

%% Examples 4: Cahn-Hilliard equation (double well)
fprintf('\n----------------------------------------\n');
fprintf('\ndemo_ch_1d.m (%s)\n',datestr(now));
datafile = 'data_ch_1d';
allfigures('clf');% Clear figures
deti = tic;% Start demo timer
% Set default values
dGdefaults();
% A priori data
% Run datafile
eval(datafile);
% A posteriori data
pd = 2;% Polynomial degree
domain.ncpd = 50;% No of intervals
% Run method
cahn_hilliard_1d();
% Output
fprintf('Done (%4.2e sec)\n',toc(deti));

%print('-f1','Gitter2','-dpng','-r100');
%print('-f2','095','-dpng','-r100');
%print('-f3','Energie','-dpng','-r100');
%% END
