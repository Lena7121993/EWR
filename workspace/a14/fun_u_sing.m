function ud = fun_u_sing(x,y)
%FUN_U_SING Diese Funktion soll fuer eine Matrix mit den Spalten fuer die
%x- und y-Koordinaten die Auswertung der Loesung ud berechnen

r=sqrt(x.^2+y.^2);
phi=atan2(x,y);

ud=r.^(2/3).*cos(((2/3).*phi)-(pi/6));
end

