%%Aufgabe2
%In dieser Aufgabe wird die experimentelle Konvergenzordnung fuer das
%expliziete Euler-Verfahren, das Crank-Nicolson-Verfahren sowie das
%impliziete Euler-Verfahren bestimmt. Als Test-Problem dient das
%Anfangswertproblem nach dem Verhulst-Modell.

%Autor: Lena,Hilpp ; Jan Frithjof Fleischhammer
%Version: 03.05.2020

%% Teilaufgabe a
%Reset Workspace, Reset Konsole, alle Fenster schliessen
clear;clc;close all;

%Initialisierung der benoetigten Fenster
openfigure(3,'init'); 

%%Teilaufgabe b
%Modellparameter definieren
d=2.9*10^(-2);
a=2.941*10^(-3);
c=1-d/(a*3.03);
y0=3.03;
t0=1960;
%was ist t1?
t1=2100;

%exakte Loesung
yex=@(t) (d/a)./(1-c*exp(-d(t-t0)));
%Diff.Gl. Verhulst Modell
verhulst=@(tt,yy) yy(d-a*yy);

%%Teilaufgabe c
%Initialisierung der Variablen fuer Konvergenzanalyse

%Anzahl an Rechnungen
n_cycles=6;
% Zeitschrittweite
dt=zeros(n_cycles,1);
% Anzahl an Intervallen der Diskretisierung
NN=zeros(n_cycles,1);
% Fehler 
err=zeros(n_cycles,1);
% benoetigte Rechenzeit
ctm=zeros(n_cycles,1);

%Laden der Standard Optionen
opts=tb_thetaEuler();
%Option fuer Verfahren einstellen 
opts.theta=0;
opts.theta=0.5;
opts.theta=1;

%%Teilaufgabe d
fprintf('Die Rechnung ist im Gang')

figure(1);
clf;
%for-Schleife fuer Anzahl der Rechnungen
for cycle=1:n_cycles,
    
    tau=10/(2^(cycle-1));
    opts.dt=tau;
    %Zeitessung
    tic;
    %Berechnung der Loesung
    [t,y]=tb_thetaEuler(verhulst,[t0,t1],y0,opts);
    %Zeitmessung beenden
    toc;
    ctm(cycle)=max(toc,1e-8);
    hold on;
    plot(t,y(t),'k-','linewidth',2);
    plot(t,yex(t),'b:','linewidth',2);
    xlabel('x');
    ylabel('y');
    legend('num.Lsg','exakte Lsg')
    hold off;
    drawnow;
    err(cycle)=norm(y-yex,inf);
    dt(cycle)=tau;
    %Anzahl unbekannte?
    NN(cycle)= ;
    pause;
end

%%Teilaufgabe e
%Konvergenzanalyse mittels eoctool
figure(2);
clf;
%eoc mit TEX Datei
[eoc,cst]=eoctool(N,ERR,2,1,{'expl. Euler','Crank-Nicolson','impli. Euler'},'eoc-vergleich.tex');

aveoc = mean(eoc(2:end,1));
avcst = mean(cst(2:end,1));
fprintf('Fehlerschaetzung: E = %5.2e * dt^{%5.2f}\n',avcst,-aveoc);


%%Teilaufgabe f
%statt Fehler Rechenzeiten uebergeben
figure(3);
[eoc,cst] = eoctool(NN,ctm);


    





