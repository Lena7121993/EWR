%% Aufgabe5 (Von der Erde zum Mond)
%In dieser Aufgabe wird die Reise von der Erde zum Mond modelliert und
%numerisch berechnet.

%Autor: Lena Hilpp ; Jan Frithjof Fleischhammer
%Version: 11.05.2020

%% Teilaufgabe a
%Reset Workspace, Reset Konsole, alle Fenster schliessen
clear;clc;close all;

%Initialisierung der benoetigten Fenster
openfigure(4,'init'); 

%% Teilaufgabe b
%Konstanten definieren umgerechnung mit Referenzgroessen
mE=1; %Masse Erde in kg
mM=1.23*10^-2; %Masse Mond in kg
RE=1.659*10^-2;  %Erdradius in m
RM=4.521*10^-3;  %Mondradius in m
y=86400^2*(3.844)^(-3)*5.974*6.673*10^(-11); %Gravitationskonstante un m^3/(kg s^2)

%Parameter definieren
v0=86400*1.109/(3.844*10^4);  %Abschussgeschwindigkeit in m/s
theta=0.008;      %Abschusswinkel in rad

%Entfernung Erde
dE=@(x1,x2) sqrt((x1-0).^2+(x2-0).^2);
%Entfernung Mond
dM=@(x1,x2) sqrt((x1-1).^2+(x2-0).^2);
%Gravitationspotential V
pot=@(x1,x2)-y*((mE./dE(x1,x2))+(mM./dM(x1,x2)));
%Gravitationsfeldstaerke G
frc=@(x1,x2)[-y.*(mE./((x1.^2+x2.^2).^(3/2)).*x1)-y.*(mM./(((x1-1).^2+x2.^2).^(3/2)).*x1-1);-y.*(mE./((x1.^2+x2.^2).^(3/2)).*x2)-y.*(mM./(((x1-1).^2+x2.^2).^(3/2)).*x2)];

%Plot Gravitationspotential
figure(1);
clf;
x=0:0.05:1.2;
y=-0.5:0.05:0.5;
[X,Y]=meshgrid(x,y);
mesh(X,Y,pot(X,Y));
%Plot Gravitationsfeldstaerke
figure(2);
clf;
%quiver(X,Y,frc(X,Y));

%% Teilaufgabe c
x0=[RE,0]; %Startposition
V0=v0*[cos(theta),sin(theta)]; %Abschussgeschwindigkeit


