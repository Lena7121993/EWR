%% Datenfile
% Beschreibung Transportgleichung auf dem Rechteck
% Bsp : Glatte Loesung 1
%    -epsilon\Delta u +b.grad u= f  in (0,1)^2,
%            u = 0                    auf dem Rand.
% Loesung: u(x,y) = x(1-exp(-b1/epsilon(1-x)))y(1-exp(-b2/epsilon(1-y))
%
% Das allgemeine Randwertproblem hat die Form (Prototyp)
%    -div (a grad u) + b.grad u + cu = f     in I,
%                                  u = dir   auf rand(I).
% Loesung: uex.

% Version: Lena Hilpp, Jan Frithjof Fleischhammer, 07.06.2020


%% Daten
% Parameter
domain = 'S';% Siehe 'help numgrid'
NperDim = 11;% Punkte pro Dimension (dh, NperDim-1 Intervalle)
geom = [1/2 1/2 1 1];% [0 1]^2 (Zentrum-Ausdehnung)
star = 5;% -Punkte-Stern
order1 = 'central';% Art der Differenzenapproximation fuer grad
% Datenfunktionen
fun_a = 1;% Default
fun_b = [];% Default
fun_c = [];% Default
fun_m = 1;% Default
fun_uex = [];% Default, falls unbekannt
% Grafik-Optionen
gopt = fdplot();% Defaults
gopt.zlbl = 'u_h(x,y)';% y-Label
switch bsp
case 1% Glattes f, nodal exakt
   fun_f = @(x,y) 2*x.*(1-x)+2*y.*(1-y);
   fun_dir = @(x,y) x.*(1-x).*y.*(1-y);
   fun_uex = fun_dir;
   gopt.fixaxis = [0 1 0 1 0 0.1];
   
case 3 %Aufgabe15 
    e=0.02;
    b1=1;
    b2=1/2;
    fun_a=2e-2;
    fun_b=@(x,y) [b1,b2];
     
    u1=@(x) x.*(1-exp(-(1/fun_a).*(1-x)));
    u2=@(y) y.*(1-exp(((-1/2)/fun_a).*(1-y)));
    
    expb=@(x,y) exp(-(y/e).*(1-x));
    
    fun_lu = @(x,y) (2*b1+(b1^2/e).*x).*expb(x,b1).*u2(y) + (2*b2+(b2^2/e).*x).*expb(y,b2).*u1(x);
    fun_gu = @(x,y) b1*(1-(1+(b1/e).*x).*expb(x,b1)).*u2(y) + b2*(1-(1+(b2/e).*y).*expb(y,b2)).*u1(x);
    fun_f = @(x,y) fun_lu(x,y)+fun_gu(x,y);
      
    fun_dir=@(x,y) u1(x).*u2(y);
    fun_uex=fun_dir;
    
    gopt.fixaxis = [0 1 0 1 -1 1.5];
   
otherwise
   error('*** Falsches bsp ***');
end

%% Info
fprintf('\n 2D Randwertproblem: Daten aus dat_fd_bvp_2d.m (Bsp %d)\n',bsp);
