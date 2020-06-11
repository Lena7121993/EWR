function vh = fdinterp(grd,opr,func)
%% CALL: vh = fdinterp(grd,opr,func);
% INPUT:
%    grd ... STRUCT; Gitter-Struktur.
%    opr ... STRUCT; Operatorinformation.
%    func ... FUNC; Zu interpolierende Funktion x|->func(x_1,...,x_d).
% OUTPUT:
%    vh ... DOUBLE*; vh = [func(x)]_x, x Gitterpunkte.
% DESCRIPTION:
% VH = FDINTERP(GRD,OPR,FUNC) wertet die Funktion FUNC auf dem
% Rechengitter aus und liefert die Gitterfunktion VH zurueck.

% TODO: opr kann Mittelwertop sein.

% Version: Willy Doerfler, KIT, 2013.

%% Analysiere Eingabedaten
dim = grd.dim;

%% Vektor belegen
if dim==1
   ind = grd.G>0;% Unindizierte Punkte ausfiltern
   G = grd.G(ind);
   x = grd.x(ind);
   vh = zeros(length(ind),1);
   vh(G) = func(x);
elseif dim==2
   vh = zeros(max(max(grd.G)),1);
   for i=1:length(grd.x)
      for j=1:length(grd.y)
         if grd.G(i,j)>0
            vh(grd.G(i,j)) = func(grd.x(i),grd.y(j));
         end
      end
   end
end

return
