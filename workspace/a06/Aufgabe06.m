%% Aufgabe6 (Sedimentation)
%In dieser Aufgabe wird das System von Differentialgleichungen, das die
%Bewegung sedimentierender Partikel beschreibt, gelöst und die Bewegung
%graphisch dargestellt.

%Autor: Lena Hilpp ; Jan Frithjof Fleischhammer
%Version:26.05.2020

%% 
%Reset Workspace, Reset Konsole, alle Fenster schliessen
clear;clc;close all;

%Initialisierung der benoetigten Fenster
openfigure(2,'init'); 

%% Teilaufgabe a
t0=0; %Anfangsteit
T=100;  %Endzeit
global N;   N=16; %Anzahl Partikel

%Koordinaten der Partikel/Startwert
positions=zeros(3,N);
for k=1:1:N/2
positions(:,k)=[cos((2*k*pi)/8),sin((2*k*pi)/8),0]; %unten
positions(:,8+k)=[cos((2*k*pi)/8),sin((2*k*pi)/8),1]; %oben
end
%Startwert als Vektor 
y0=reshape(positions,[1,3*N]);

%% Teilaufgabe b/ODE45
%Loesen des Diffgleichungssystems
options=odeset('RelTol',10^(-7),'AbsTol',10^(-7));
tic;
[t,y]= ode45(@(t,y) hydroforce(t,y),[t0,T],y0,options);
Zeit=toc; %Rechenzeit
Anzahl=length(t); %Anzahl Zeitschritte
fprintf('Rechenzeit=%6.4e \n',Zeit);
fprintf('Anzahl an Zeitschritten=%d \n',Anzahl);
t1=t(2:end);
t2=t1-t(1:end-1);
mint=min(t2);
maxt=max(t2);
fprintf('minimale Schrittweite=%6.4e \n',mint);
fprintf('maxmale Schrittweite=%6.4e \n',maxt);
%% interpolieren auf Gitter mit 100 Zeitschritten
if Anzahl>100
    steps=100;
    ti=0:1:steps;
    y=interp1(t,y,ti);
end

%3D Plot der Partikel ueber alle Zeitschritte

for i=1:steps
    figure(1);
    clf;
    hold on;
    axis([-2 2 -2 2 -50 2]);
    for j=1:3:24        
        plot3(y(i,j),y(i,j+1),y(i,j+2),'ro');  %unten           
    end
    for k=25:3:48           
        plot3(y(i,k),y(i,k+1),y(i,k+2),'bo');  %oben             
    end
    view(3);
    hold off;
pause(0.002)
end
print('-f1','bild1','-dpng','-r100');

%% 2D Projektion von zweier uebereinanderliegender Partikel
figure(2);
clf;
hold on;
for i=1:steps
    axis([-1 2 -50 1]);
    plot(y(i,25),y(i,27),'bo'); %oben
    plot(y(i,1),y(i,3),'ro');   %unten    
    legend('Startpunkt oben','Startpunkt unten','location','NorthWest')
    title('Projektion zweier uebereinanderliegender Partikel');
end
hold off;
print('-f2','bild2','-dpng','-r100');



    



    
