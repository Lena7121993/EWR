%% Aufgabe 16
%In dieser Aufgabe wird ein Eigenwertproblem betrachtet und das Problem für
%verschiedene Gitterweiten gelöst und die Konvergenzordnung bestimmt.
% Das allgemeine Anfangs-Randwertproblem ist
%    d/dt u - a\Delta u + b.\grad u + c u = f     in \Omega
%                                       u = dir   auf rand(\Omega)
%                                       u = u0    in {0}x\Omega
%

%% Randwertprobleme (d/dt u = 0)
%  1.  5-Pkte Stern Eigenwertproblem und EOC


% W. Doerfler: Finite Differenzen Verfahren
%              Demos fd 2d (Anfangs-)Randwertprobleme, Jun 2020.
% Karlsruher Institut fuer Technologie, Fakultaet fuer Mathematik.

%% Randwertprobleme
clear all; close all; clc;
openfigure(4,'init');

%% Eigenwertgleichung und EOC
fprintf('\n----------------------------------------\n');
datafile = 'dat_evp2d_1';
allfigures('clf');% Clear figures
% Set default values
fddefaults();
%apriori
nb=6;%Anzahl Eigenwerte die berechnet werden
lam_ex=2*pi^2; %Eigenwert waehlen (etwa kleinster)

N = [5;10;20;30;40;50];% Knoten pro Dimension
M = length(N);% Anzahl Durchlaeufe

err=zeros(M,1);
for i=1:M
    eval(datafile);
    NperDim=N(i);
    eigenvalue_problem();
  
    err(i)=min(abs(d-lam_ex)); %Fehlerberechnung
end


%% EOC
figure(4);
[eoc,cst]=eoctool(N,err);
aveoc=-mean(eoc(2:end,1));avcst=mean(cst(2:end,1));
fprintf('\n Geschaetzter Fehler:E=%5.2e*h^{%5.2f}\n',avcst,-aveoc);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% ENDE
