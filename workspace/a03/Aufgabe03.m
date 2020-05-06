%% Aufgabe3
%In dieser Aufgabe wird das Raeber-Beute-Modell von Lotka betrachtet.
%Dieses soll mit Hilfe einer Matlab Routine gel�st werden. 

%Autor: Lena Hilpp ; Jan Frithjof Fleischhammer
%Version: 04.05.2020

%% Teilaufgabe a
%Reset Workspace, Reset Konsole, alle Fenster schliessen
clear;clc;close all;

%Initialisierung der benoetigten Fenster
openfigure(4,'init'); 

%% Teilaufgabe b
%Definieren der Modell Parameter
%Geburten und Sterberate f�r Rauber
gr=1; ar=2;
%Geburten und Sterberate f�r Beute
gb=1; ab=1 ;
%Anfangspopulation
r0=2; b0=2.25;
y0=[r0;b0];

%Diff.-Gleichung
dgl=@(t,x) [-ar*x(1)+gr*x(2)*x(1);ab*x(2)-gb*x(1)*x(2)];


%% Teilaufgabe c

 %Laden der Standard Optionen f�r thetaEuler
 opts=tb_thetaEuler();
 %Option fuer Verfahren einstellen 
 opts.theta=0; %opts.theta=0.5; %opts.theta=1;
 opts.ssolver='fminsearch';
 tau=0.025;
 opts.dt=tau;
    
%Switch
s=input('Gebe 1 (ODE45) oder 2 (thetaEuler)ein: ');

switch s
    %berechnen der Loesung mit ode45
    case 1
    [t,y]= ode45(dgl,[0,10],y0);
    %berechnen der Loesung mit thetaEuler
    otherwise 
    [t,y]=tb_thetaEuler(dgl,[0,10],y0,opts);
end

%% Teilaufgabe d
%Funktionsgraph
figure(1);
clf;
if s==1
    r=y(:,1);
    b=y(:,2);
    name='Loesung ueber Zeit/ODE45'
else
    r=y(1,:);
    b=y(2,:);
    name='Loesung ueber Zeit/thetaEuler'
end
%Loesung als Funktion ueber Zeit
hold on;
plot(t,r,'r-','linewidth',2);
plot(t,b,'b-','linewidth',2);
legend('raeuber','beute','location','SouthEast');
title(name);
xlabel('Zeit');
ylabel('Raeuber/Beute');
hold off;

%Ausgabe Minimum und Maximum
fprintf('minmale Anzahl Rauber=%f , maximale Anzahl Rauber= %f \n',min(r),max(r));
fprintf('minmale Anzahl Beute=%f , maximale Anzahl Beute= %f \n',min(b),max(b));

%Plot speichern
print('-f1','bild1','-dpng','-r100');

%% Teilaufgabe e
%Phasendiagramm 
figure(2);
clf;
if s==1
    name='Phasendiagramm/ODE45';
else
    name='Phasendiagramm/thetaEuler';
end
%r-b-Diagramm
plot(r,b,'r-','linewidth',2);
title(name);
xlabel('raeuber');
ylabel('beute');

print('-f2','bild2','-dpng','-r100');
%% Teilaufgabe f
%Potential-Erhaltung
figure(3);
clf;
if s==1 %ODE45
    name='Potential-Erhaltung/ODE45';
    %Integral der Gleichung
     E=@(t) ab*log(r)-gb*r+ar*log(b)-gr*b;
     %plot
     plot(t,E(t),'r-','linewidth',2);
    xlabel('Zeit');
    ylabel('Integral');
     title(name);
else %ThetaEuler
    name='Potential-Erhaltung/thetaEuler';   
    
    %Theta=0
     E=@(t) ab*log(r)-gb*r+ar*log(b)-gr*b;
     
     %Theta=0.5
    opts.theta=0.5;
    %opts.ssolver='fminsearch';
    [t1,y1]=tb_thetaEuler(dgl,[0,10],y0,opts);
    r1=y1(1,:);
    b1=y1(2,:);
    E1=@(t1) ab*log(r1)-gb*r1+ar*log(b1)-gr*b1;
    
    %Theta=1
    opts.theta=1;
    %opts.ssolver='fminsearch';
    [t2,y2]=tb_thetaEuler(dgl,[0,10],y0,opts);
    r2=y2(1,:);
    b2=y2(2,:);
    E2=@(t2) ab*log(r2)-gb*r2+ar*log(b2)-gr*b2;
    
    %plot
    hold on;
    plot(t,E(t),'r-','linewidth',2);
    plot(t1,E1(t1),'b-','linewidth',2);
    plot(t2,E2(t2),'k-','linewidth',2);
    title(name);
    xlabel('Zeit');
    ylabel('Integral');
    legend('theta=0','theta=0.5','theta=1','location','SouthEast')
    hold off;
        
    end

print('-f3','bild3','-dpng','-r100');


%% Teilaufgabe g
%Phasendiagramm mit Potential
figure(4);
clf;
if s==1
    name='Phasendiagramm mit Potential/ODE45';
else
    name='Phasendiagramm mit Potential/thetaEuler';
end
%Niveaulinien 
[R,B]=meshgrid(r,b);
fkt=exp(ab*log(R)-gb*R+ar*log(B)-gr*B);
%plotten mit Phasendiagramm
hold on;
contour(R,B,fkt);
plot(r,b,'r-','linewidth',2);
hold off;
title(name);
xlabel('raeuber');
ylabel('beute');

print('-f4','bild4','-dpng','-r100');





