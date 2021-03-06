%%Aufgabe22 Singul�re L�sung
%In dieser Aufgabe wird das Poisson Problem mit Finite Elemente Methode
%gel�st und die Konvergenzordnung bestimmt.

%% 
% Parameter
domain = dGdomain();
domain.tag = 'C';% Corner Gebiet
domain.geom = [0 0 1 1];

% Grafik-Optionen

gopt.ylbl = 'y';% y-label
gopt.zlbl = 'u_h';% z-label
% Graphics (modify graphics options from dGdefaults)
uamp = 1;% A natural amplitude for the solution
bb = domain.getbb(domain.geom);% The bounding box
gopt.fixaxis = [bb(1) bb(2) bb(3) bb(4) -0.5*uamp 1.1*uamp];% incl. natural over/undershoot

fun_uD= @(x)fun(x);
fun_uEx = fun_uD;
fun_uEx_grad = @(x) fun_grad(x);
 