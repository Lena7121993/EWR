%% Datenfile

% Das allgemeine Randwertproblem hat die Form (Prototyp)
%    -div (a grad u) + b.grad u + cu = f     in I,
%                                  u = dir   auf rand(I).
% Loesung: uex.

% Version: Willy Doerfler, KIT, Jun 2020.

%% Daten
% Gebiet
domain = 'S';% Siehe 'help numgrid'
geom = [1/2 1/2 1 1];% [0 1]^2 (Zentrum-Ausdehnung)
% Parameter
%NperDim = 5;% Punkte pro Dimension 
star = 5;% -Punkte-Stern
order1 = 'central';% Art der Differenzenapproximation fuer grad

% Datenfunktionen
fun_a = 1;% Default
fun_b = [];% Default
fun_c = [];% Default
fun_m = 1;% Default
fun_uex =[]; % Default, falls unbekannt

fun_dir=0;
    
%Grafik-Optionen
umin=-1; umax=1;


gopt.zlbl = 'u_h(x,y)';% y-Label
gopt.fixaxis = [geom(1)-geom(3)/2,geom(1)+geom(3)/2, ...
                geom(2)-geom(4)/2,geom(2)+geom(4)/2,umin,umax];

%% Info
%fprintf('\n 2D Randwertproblem: Daten aus dat_fd_bvp_2d.m (Bsp %d)\n',bsp);
