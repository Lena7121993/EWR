function [X,Y,Z] = fdmeshgrid(grd,fh)
%% CALL: [X,Y,Z] = fdmeshgrid(grd,fh);
% INPUT:
%    grd ... STRUCT; Gitter-Struktur.
%    fh ... DOUBLE*/FUNC; Gitterfunktion [DEF 0].
% OUTPUT:
%    X,Y,Z ... DOUBLE**; Meshgrid Daten.
% DESCRIPTION:
% FDMESHGRID Bereitet die Visualisierung von Gitterfunktionen vor.
% [X,Y,Z] = FDMESHGRID(GRD,FH) gibt Matrizen X, Y und Z zurück, welche als
% Eingabeparameter für die Funktionen SURF, MESH oder CONTOUR verwendet werden
% können. Das Finite-Differenzen-Gitter ist durch die Struktur GRD mit den
% Komponenten G, X, ... definiert (siehe FDGRID). Die Werte der Gitterfunktion
% sind durch eine Funktion x|->fh(x_1,...,x_d) oder den Vektor FH definiert.
%   FH Funktionspointer: Auswertung fuer G>0,
%   FH Vektor(N):  Auswertung fuer G>0.
%   FH Vektor(NI): Auswertung nur in inneren Knoten.

% Version 0.0: Markus Richter, KIT, 2008.
% Version 1.0: Willy Doerfler, KIT, 2013.

%% Initialisierungen
[m,n] = size(grd.G);
X = nan(m,n);% Macht den Rest unsichtbar
Y = nan(m,n);
Z = nan(m,n);

%% Erzeuge die X-, Y-, und Z-Matrizen für die Funktionen surf, mesh, etc.  
if isnumeric(fh)% fh ist Vektor
   if length(fh)==grd.ni% Ggf. Rand ausblenden
      i = grd.bverts(1,:);% Randknoten
      j = grd.bverts(2,:);
      grd.G(i,j) = 0;
   end
   for i=1:m
      for j=1:n
         if grd.G(i,j)>0
            X(i,j) = grd.x(i);
            Y(i,j) = grd.y(j);
            Z(i,j) = fh(grd.G(i,j));
         end
      end
   end
else% fh ist Funktionspointer
   for i=1:m
      for j=1:n
         if grd.G(i,j)>0
            X(i,j) = grd.x(i);
            Y(i,j) = grd.y(j);
            Z(i,j) = fh(grd.x(i),grd.y(j));
         end
      end
   end
end

return
