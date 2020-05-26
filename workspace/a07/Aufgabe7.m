%% Aufgabe7 (Krankheitsausbreitung)
%In dieser Aufgabe soll das SIR-Modell(Susceptible-Infected-Recovered),ein
%Werkzeug in der mathematischen Epidemiologie, fuer die Stadt Karlsruhe
%implementiert werden.

%Autor: Lena Hilpp ; Jan Frithjof Fleischhammer
%Version: 22.05.2020

%% Preambel
% Hier wird der Workspace bereinigt und vorhandene Schaubilder geschlossen.
clear;clc;close all;

%Initialisierung der benoetigten Fenster
openfigure(7,'init'); 
%% Definitionen
% Hier werden die Verfahrensparameter vorbereitet. 
T=100;
deltat=1;
beta=0.5; gamma=0.25; %gewoehnliche Grippewelle %beta=3.75 Masern 0%Impung aber deltat auf 0.1 setzen sonst geht es nicht!(steifes Problem)
M=27;

%% Initialisierung
% Hier werden Arbeitsvariablen initialisiert. 

Stadtteile = struct([geopoint()]);  
for i=1:27
    Stadtteile(i) = struct(gpxread(sprintf('data/data%dgpx.sec',i)));
end

Namen = {'Groetzingen', 'Wolfartsweier', 'Oberreut', ...
    'Gruenwettersbach', 'Rueppur', 'Palmbach', 'Hohenwettersbach', ...
    'Waldstadt','Weststadt','Weiherfeld-Dammerstock','Innenstadt-West',...
    'Nordstadt','Daxlanden','Nordweststadt','Suedstadt','Stupferich',...
    'Muehlburg','Rintheim','Gruenwinkel','Knielingen','Durlach',...
    'Suedweststadt','Oststadt','Beiertheim-Bulach','Innenstadt-Ost',...
    'Neureut','Hagsfeld'};

N = [9138, 3156, 9554, 4082, 10630, 1936, 3023, 12484, 20489, ... 
    6029, 10283,9770,11695, 11755, 20121, 2782, 17149, 5991, 10709, ...
    10137, 30473, 20709, 22808, 6974, 6725, 18877, 7140];

%% Startwerte setzen
% Fuer das Verfahren geben wir eine Verteileung von Infizierten zum
% Zeitpunkt $0$ vor. 
I(1,:)=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 200 0 0 0 0 0 0 0 0 0 0 0];
S(1,:)=N-I(1,:);
R(1,:)=zeros(1,M);

%% Simulation der Ausbreitung
% Es ist eine explizite Rechenvorschrift in der Zeit fuer das gegebene
% Problem bekannt, die nun Schrittweise ausgewertet wird.


%Phi_ij Bevoelkerungsanteil der von i nach j pendelt
Phi = GetPhi(0.95);
%N^tot_i Wieviele Personen arbeiten im Stadtteil i
Ntot=zeros(1,27);
for i=1:27
    for m=1:27
        Ntot(1,i)=Ntot(1,i)+(Phi(m,i)*N(1,m));
    end
end

%Berechnung nach T Tage
dtS=zeros(T,M);dtI=zeros(T,M);dtR=zeros(T,M);
for t=2:T
%Ableitung S
for i=1:M
    for j=1:M
        for k=1:M
            dtS(t-1,i)=dtS(t-1,i)+(beta*Phi(i,j)*S(t-1,i)*((Phi(k,j)*I(t-1,k))/Ntot(1,j)));
            dtS(t-1,i)=-dtS(t-1,i);
        end
    end
end
%Ableitung I
for i=1:M
    for j=1:M
        for k=1:M 
            sum=beta*Phi(i,j)*S(t-1,i)*((Phi(k,j)*I(t-1,k))/Ntot(1,j));
            dtI(t-1,i)=dtI(t-1,i)+sum;
        end
    end
    dtI(t-1,i)=dtI(t-1,i)-(gamma*I(t-1,i));
end
%Ableitung R
for i=1:M
    dtR(t-1,i)=gamma*I(t-1,i);
end
%Update 
for i=1:M
    S(t,i)=S(t-1,i)+(deltat*dtS(t-1,i));
    I(t,i)=I(t-1,i)+(deltat*dtI(t-1,i));
    R(t,i)=R(t-1,i)+(deltat*dtR(t-1,i));
end
figure(1);
hold on;
DrawMapFrame(I(t,:),N,Stadtteile);
title('Verteilung Krankheitsfaelle');
hold off;
end

%% Visualisierung der Daten
% Alle Berechnungen sind abgeschlossen. Wir generieren nun Schaubilder.
%Verteilung Krankheitsfaelle t=0
figure(2);clf;
DrawMapFrame(I(1,:),N,Stadtteile);
title('Verteilung Krankheitsfaelle t=0');
%Verteilung Krankheitsfaelle t=T/2
figure(3);clf;
DrawMapFrame(I(T/2,:),N,Stadtteile);
title('Verteilung Krankheitsfaelle t=T/2');
%Verteilung Krankheitsfaelle t=T
figure(4);clf;
DrawMapFrame(I(T,:),N,Stadtteile);
title('Verteilung Krankheitsfaelle t=T');
%% Anzahl Krankenfaelle fuer verschiedene Stadtteile
figure(5);clf
t=1:1:T;
x16=N(16)*ones(T,1);
hold on;
plot(t,x16,'g-','linewidth',2);
plot(t,I(t,16),'r-','linewidth',2);
title('Stadtteil 16/Anzahl Krankenfaelle');
hold off;

figure(6);clf
x9=N(9)*ones(T,1);
hold on;
plot(t,x9,'g-','linewidth',2);
plot(t,I(t,9),'r-','linewidth',2);
title('Stadtteil 9/Anzahl Krankenfaelle');
hold off;

figure(7);clf
x25=N(25)*ones(T,1);
hold on;
plot(t,x25,'g-','linewidth',2);
plot(t,I(t,25),'r-','linewidth',2);
title('Stadtteil 25/Anzahl Krankenfaelle');
hold off;


