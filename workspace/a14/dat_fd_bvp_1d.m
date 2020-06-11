%% Datenfile
% Beschreibung von 1D Randwertproblemen zur Loesung mit 'stationary_problem':
% Bsp 1: Glatte Loesung 1
%    -u'' = 2   in (0,1),
%       u = 0   auf dem Rand.
% Loesung: u(x) = x (1-x).
%
% Notation:
% Das allgemeine Randwertproblem hat die Form (Prototyp)
%    -(au')' + bu' + cu = f     in I,
%                     u = dir   auf rand(I).
% Loesung: fun_uex.

% Version: Willy Doerfler, KIT, 2020.

%% Daten
% Defaultwerte ausserhalb besetzen
% Gebiet
domain = 'I';% Intervall
geom = [1/2 1];% Zentrum-Ausdehnung ([x0,L] -> [x0-L/2,x0+L/2])
NperDim = 65;% Punkte pro Dimension (dh, NperDim-1 Intervalle)
% Operator
star = 3;% <star>-Punkte-Stern
order1 = 'central';% Art der Differenzenapproximation fuer grad
% Grafik-Optionen
% Auswahl der Beispiele durch Setzung des Parameters 'bsp' (ausserhalb)
switch bsp% Beispielauswahl
case 1% Glattes f, nodal exakt
   fun_f = 2;
   fun_dir = 0;
   fun_uex = @(x) x.*(1-x);
   gopt.fixaxis = [0 1 0 0.3];
otherwise
   error('*** Beispiel nicht implementiert ***');
end

%% Info
fprintf('\n 1D Randwertproblem: Daten aus dat_fd_bvp_1d.dat, Bsp %d.\n',bsp);
