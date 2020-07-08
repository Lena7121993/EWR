%%Aufgabe22
%In dieser Aufgabe wird das Poisson Problem mit Finite Elemente Methode
%gelöst und die Konvergenzordnung bestimmt.
%% 
clear all; close all; clc;
openfigure(4,'init');
% Organise output
fig = struct('mesh',1,'sol',2,'res',3,'runinfo',4);

%% Teilaufgabe b
%Lösung des Poisson Problems und KonvOrdnung für verschiedene Polynomgrade
fprintf('\n----------------------------------------\n');
datafile = 'DatenkarteA22';
allfigures('clf');
dGdefaults();
eval(datafile);
%pd = 2;% Polynomial degree
%pd=4;
%pd=6;
gopt.view = [-10,50];% Specific view

N = [2;4;8;16];% Choose set of ncpd
P = [2];% Choose set of polynomial degrees (pd>1 rounding error)
ec = 'H1';% Error code, one of 'nLi','Li','L2','H1','W1i'
prog = 'stationary_cG_2d';% Programm
run_multiple;

%% Teilaufgabe c
clear all; close all; clc;
openfigure(4,'init');
% Organise output
fig = struct('mesh',1,'sol',2,'res',3,'runinfo',4);

%% Teilaufgabe c
%Adaptive Gitterverfeinerung
fprintf('\n----------------------------------------\n');
datafile = 'DatenkarteA22';
allfigures('clf');
dGdefaults();
eval(datafile);
pd = 1;% Polynomial degree
%pd=4;
%pd=6;
gopt.view = [-10,50];% Specific view

hf=@(x) sqrt(x(:,1).^2+x(:,2).^2); %Abstand zur Ecke
fun_mark=@(xmsh) refine_down_to_h(xmsh,hf); %Makiert Zellen deren Diameter größer als Abstand zur Ecke ist

ERR=zeros(1,9);
NN=zeros(1,9);
for prerefsteps=1:1:9
    stationary_cG_2d;
   
    ERR(prerefsteps)=err_h1;
    NN(prerefsteps)=length(uc);
    %NN(prerefsteps)=msh.Nvert;
    dGmeshdiagnosis(msh);
end

%% EOC
figure(4);
[eoc,cst]=eoctool(NN',ERR');
aveoc=-mean(eoc(2:end,1));avcst=mean(cst(2:end,1));
fprintf('\n Geschaetzter Fehler:E=%5.2e*h^{%5.2f}\n',avcst,-aveoc);

    