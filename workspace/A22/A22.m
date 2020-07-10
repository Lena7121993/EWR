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
P = [2,4,6,8];% Choose set of polynomial degrees (pd>1 rounding error)
ec = 'H1';% Error code, one of 'nLi','Li','L2','H1','W1i'
prog = 'stationary_cG_2d';% Programm
run_multiple;
%print('-f1','Gitter2','-dpng','-r100');
%print('-f2','Loesung','-dpng','-r100');
%print('-f3','konv','-dpng','-r100');
%print('-f4','bild1','-dpng','-r100');

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
ec = 'H1';

gopt.view = [-10,40];% Specific view

hf=@(x) sqrt(x(:,1).^2+x(:,2).^2); %Abstand zur Ecke
fun_mark=@(xmsh) refine_down_to_h(xmsh,hf); %Makiert Zellen deren Diameter größer als Abstand zur Ecke ist

ERR=zeros(9,1);
NN=zeros(9,1);
for prerefsteps=1:1:9
    stationary_cG_2d();
   
    ERR(prerefsteps)=err_h1;
    NN(prerefsteps)=length(uc);
    
    dGmeshdiagnosis(msh);
end

%print('-f1','Gitter3','-dpng','-r100');
%print('-f2','Loesung','-dpng','-r100');

%% EOC
figure(3);
[eoc,cst]=eoctool(NN,ERR);
aveoc=-mean(eoc(2:end,1));avcst=mean(cst(2:end,1));
fprintf('\n Geschaetzter Fehler:E=%5.2e*h^{%5.5f}\n',avcst,-aveoc);
%print('-f3','EOC','-dpng','-r100');

    