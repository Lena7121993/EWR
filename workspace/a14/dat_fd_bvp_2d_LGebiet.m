%% Datenfile
% Beschreibung 2D Randwertprobleme auf L-Gebiet
% Bsp 1: Glatte Loesung 1
%    -\Delta u = 0                 in Omega,
%            u = uD                 auf dem Rand.
% Loesung: u(r,phi) =r^(2/3)cos(2/3phi-pi/6) .
%
% Das allgemeine Randwertproblem hat die Form (Prototyp)
%    -div (a grad u) + b.grad u + cu = f     in I,
%                                  u = dir   auf rand(I).
% Loesung: uex.

% Version: Lena Hilpp, Jan Frithjof Fleischhammer, 07.06.2020.

%% Daten
% Parameter
domain = 'L';% Siehe 'help numgrid'
NperDim = 9;% Punkte pro Dimension (dh, NperDim-1 Intervalle)
geom = [0 0 2 2];% (Zentrum-Ausdehnung)
star = 5;% -Punkte-Stern
order1 = 'central';% Art der Differenzenapproximation fuer grad
% Datenfunktionen
fun_a = 1;% Default
fun_b = [];% Default
fun_c = [];% Default
fun_m = 1;% Default
fun_uex =[]; % Default, falls unbekannt
% Grafik-Optionen
gopt = fdplot();% Defaults
gopt.zlbl = 'u_h(x,y)';% z-Label
gopt.meth2d='surf' %oder 'mesh' oder 'contour 
switch bsp
case 1% Glattes f, nodal exakt
   fun_f = @(x,y) 2*x.*(1-x)+2*y.*(1-y);
   fun_dir = @(x,y) x.*(1-x).*y.*(1-y);
   fun_uex = fun_dir;
   gopt.fixaxis = [0 1 0 1 0 0.1];
case 2  %Aufgabe 14
    fun_f=@(x,y) 0 ;
    fun_dir= @(x,y)fun_u_sing(x,y);
    fun_uex = fun_dir;
    gopt.fixaxis = [-1 1 -1 1 0 1.5];
    
otherwise
   error('*** Falsches bsp ***');
end

%% Info
fprintf('\n 2D Randwertproblem: Daten aus dat_fd_bvp_2d.m (Bsp %d)\n',bsp);
