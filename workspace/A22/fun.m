function ud = fun(x)
   %FUN Diese Funktion soll fuer die
   %x- und y-Koordinaten die Auswertung der Loesung ud berechnen
    
   r=sqrt(x(:,1).*x(:,1)+x(:,2).*x(:,2));
   phi=atan2(x(:,1),x(:,2));

   ud=r.^(2/3).*cos((2/3).*phi);
   
   end

