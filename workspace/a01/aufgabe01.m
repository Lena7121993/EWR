%%Aufgabe1
%In dieser Aufgabe sollen zwei verschiedene Modelle 
%fuer das Verhalten der Weltbevoelkerung verglichen werden. 

%Autor: Lena,Hilpp ; Jan Frithjof Fleischhammer
%Version: 28.04.2020

%%Reset Workspace, Reset Konsole, alle Fenster schliessen
clear;clc;close all;

%%Initialisierung der benoetigten Fenster
openfigure(2,'init'); 

%%Teilaufgabe b
%definiere Lambda
lambda=2*10^(-2);
t0=1960;
%berechne c1 fuer das Jahr 1960
c1=3.03;

%definiere Parameter a und d
d=2.9*10^(-2);
a=2.941*10^(-3);
%berechne c2 fuer das Jahr 1960
c2=1-d/(a*3.03);

%definiere Vektor t mit den Jahren 1800 bis 2200
t=(1800:10:2200);

%Schaetzung fuer maximale Weltbevoelkerung
fprintf('Schaetzwert Maximum (alt): %5.3e Mrd. Menschen \n', d/a);

%%Teilaufgabe c
%exponentielles Wachstum
y1=@(t) c1*exp(lambda*(t-t0));
%Modell von Verhulst
y2=@(t) (d/a)./(1-c2*exp(-d*(t-t0)));
%UN Daten von 1950 bis 2020
tdat=(1950:10:2020);
ydat=[2.54,3.03,3.70,4.46,5.33,6.14,6.96,7.79];
%UN Daten geschaetzt von 2030 bis 2100
test=(2030:10:2100);
yest=[8.55,9.20,9.79,10.15,10.46,10.67,10.81,10.88];

%%Teilaufgabe d
%plot der Daten
figure(1);
clf;
hold on;
plot(t,y1(t),'b:','linewidth',2);
plot(t, y2(t), 'k-','linewidth',2);
plot(tdat,ydat,'ro');
plot(test,yest,'rp');
axis([1800 2200 0 12]);
xlabel('Jahr');
ylabel('Mrd.Menschen');
title('Weltbevoelkerungsentwicklung 1800 bis 2100');
legend('Exp. Wachstum','Verhulst','UN Daten','UN Schaetzung','location','SouthEast');
hold off;

%Plot speichern
print('-f1','bild1','-dpng','-r100');

%%Teilaufgabe e
%Parameter des Verhulst Modell anpassen
%parametrisierte Funktion
y0=3.03;
p=[d/a,d];
y3=@(p,tt) p(1)./(1-(1-p(1)/y0)*exp(-p(2)*(tt-t0)));

%Abstandsfunktion
J=@(p) norm(y3(p,tdat)-ydat,2);
%loese Ausgleichsproblem/suche Minimum
p0=[d/a,d];
pa=fminsearch(J,p0);

fprintf('J(pa):%6.4f \n',J(pa));

%Schaetzwert maximale Weltbevoelkerung
fprintf('Schaetzwert maximale Weltbevoelkerung(neu): %6.4f Mrd. Menschen \n',pa(1));

%%Teilaufgabe f
%Plot Vergleich Verhulst-Modelle mit Daten und Schaetzungen der UN
figure(2);
clf;
hold on;
plot(t, y2(t), 'k-','linewidth',2);
plot(t, y3(pa,t), 'k:','linewidth',2);
plot(tdat,ydat,'ro');
plot(test,yest,'rp');
axis([1800 2200 0 12]);
xlabel('Jahr');
ylabel('Mrd.Menschen');
title('Weltbevoelkerungsentwicklung 1800 bis 2100');
legend('Verhulst','Verhulst angepasst','UN Daten','UN Schaetzung','location','SouthEast');
hold off;

%Plot speichern
print('-f2','bild2','-dpng','-r100');

%%Teilaufgabe g
%Wann gibt es mehr als 8 Mrd Menschen?
%Funktion fuer Nullstellenproblem
f=@(x) y3(pa,x)-8;
%Bestimmung Nullstelle
t8mrd=fzero(f,1900);

%Bestimmung Jahr und Monat
%Jahr
y8mrd=floor(t8mrd);
%Monat
m8mrd=floor((t8mrd-y8mrd)*12);

fprintf('Im %iten Monat des Jahres %i gibt es 8 Mrd. Menschen \n',m8mrd,y8mrd);;

