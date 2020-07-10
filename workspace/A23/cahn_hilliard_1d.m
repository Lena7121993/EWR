%% Script to solve 1D Cahn-Hilliard type equations with cG
% Data for nonlinear parabolic initial boundary value problems in 1D of
% Cahn-Hilliard type.
% We solve the initial boundary value problem for [u,mu]
%     d/dt u   -  m mu'' = 0       in (0,T)x(xL,xR),
%    kappa u'' +    mu   = F'(u)   in (0,T)x(xL,xR),
%              u(0,.) = u0         in (xL,xR),
%             mu(0,.) = mu0        in (xL,xR),
%              d_n  u = 0          on (0,T)x{xN},
%              d_n mu = muN        on (0,T)x{xN},
% for xL<xR, 0<T, nonlinearity F and functions f (source), uD (Dirichlet data),
% xD (Dirichlet boundary points), muN (Neumann data mu), xN (Neumann boundary
% points), u0 (initial condition).
% Discretisation: (note S=-(.)'')
%    M*d/dt u + m S*mu = m muN  and  -kappa S*u + M*mu = M*F'(u)
%    ==> M*d/dt u + m kappa S*invM*S*u = m muN - m S*F'(u)
%    ==> d/dt u = -inv(M) (m kappa S*invM*S*u - m muN + m S*F'(u))
%               = -(m kappa invM*S*invM*S*u - m invM*muN
%                                        + m invM*S*F'(u))
%               = -(m kappa A*A*u + m A*F'(u) - m invM*muN)
% M mass-matrix, S stiffness-matrix, A = invM*S.
% Variant: Matlab-ODE-Solver and self-written ODE-solvers.

% By W. Doerfler, KIT, 21.08.2019, dG 2.0.
% Modified by F. Castelli, KIT, 30.06.2020.
%%

%% Set up problem
% Run a datafile before.

%% Initialisation
timer = struct('total',0,'mesh',0,'setup',0,'solv',0,'estm',0);% Stop various times
ctm = tic;% Start timer

%% Generate mesh and space

% Get coarse mesh
msh = dGdomain(domain);

% Generate dG space
spc = cGspace(msh,pd);

% Plot mesh
figure(fig.mesh); clf
dGplot(msh,spc);
drawnow;

%% Set generic data functions for linear elliptic equations of second order
pde = dGpde(fun_a,fun_b,fun_c,fun_f);
bcs = dGbcs(fun_xD,fun_uD,fun_xN,fun_muN);

%% Set up the global (cG)matrix and boundary conditions
setm = tic;
[Sc,bc,Mc] = cGassempde(msh,spc,pde);
[Ecb,uce0,gc] = cGassembcs(msh,spc,bcs,Tini);
%Lift = zeros(size(Ecb,1),2); Lift(1,1) = 1; Lift(end,2) = 1;% BC into domain

% Reduce the linear system by essential boundary conditions
% VOID

%% Solve the initial value problem.

%% Initialisation.
t  = Tini;% Init t
un = dGinterp(msh,spc,fun_u0);% Initial condition (nodal long)
u0 = (spc.Ec'*un)./diag(spc.Ec'*spc.Ec);% Transform to cG-object
un = reshape(un,[],msh.Ncell);% Initial condition (nodal block)
timer.setup = toc(setm);

%% Plot the initial condition.
figure(fig.sol); clf;
dGplot(msh,spc,un,gopt);
title(['Solution u_h at t =' sprintf('%5.2f',0)],'FontSize',11);
drawnow
figure(fig.info); clf; hold on
textline(1,sprintf('Info-Window'));
textline(2,sprintf(' Example: Battery'));
textline(3,sprintf(' Degree: %d',pd));
textline(4,sprintf(' Running NV = %d ...',msh.Nvert));
axis([0 1 0 1]); axis off;
hold off;
drawnow;

%% Time loop.
%%<<<<<<<<<< Teil (a): Definieren Sie die rechte Seite

invMc = inv(Mc); muN = gc; 

odeF=@(t,y) invMc*(-Sc*(invMc*(Mc*fun_G(y)+kappa.*Sc*y))+muN);
 
%%>>>>>>>>>>
fprintf(' Running ode15s ...\n');

%%<<<<<<<<<< Teil (b): Verwenden Sie eine Matlab-ODE Loeser
%da steifes Problem ODE15s
c=c0*ones(length(Sc),1);
options=odeset('RelTol',10^(-6),'AbsTol',10^(-8));
[ts,vs,oo] = ode15s(odeF,[Tini,Tend],c,options);

%%>>>>>>>>>>

out.dt = (ts(end)-ts(1))/oo(1);% Mean dt
out.meanit = 0;% No use
out.meanfc = oo(3)/oo(1);% No of Fevals/No of steps
% Time slice by second index
vs = real(vs)'+1i*imag(vs)'; ts = ts';

timer.total = toc(ctm);

%% Output
fprintf(' p = %2d, Unknowns: %5d, timestep: %4.2e\n',pd,size(spc.Ec,2),out.dt);
fprintf(' Mean inner itns/fcalls: %d, %d\n',round(out.meanit),round(out.meanfc));
fprintf(' Computing time: %5.2e sec\n',timer.total);
fprintf(' Setuptime:  %5.2f of total\n',timer.setup/timer.total);

%% Plot the final solution.
% Show u, compute energy
eng = zeros(1,length(ts));
figure(fig.sol); clf;
for l=1:length(ts)
    uc = vs(:,l); un = reshape(spc.Ec*uc,[],msh.Ncell);
    Fu = fun_F(uc); eins = ones(1,size(Mc,1));
    eng(l) = eins*Mc*Fu+(kappa/2)*uc'*Sc*uc;
    clf;
    if isempty(fun_uExt)% Show discrete solution
        gopt.titlestr = ['Solution u_h at t =' sprintf('%5.2f',ts(l))];
        dGplot(msh,spc,un,gopt);
    else% Show numerical and exact solution if available
        uext = @(x) fun_uExt(x,ts(l));% duext = @(x) fun_dx_uext(x,ts(l));
        gopt.titlestr = ['Solutions u,u_h at t =' sprintf('%5.2f',ts(l))];
        gopt2.titlestr = gopt.titlestr;
        dGplot(msh,spc,un,gopt);
        dGplot(msh,spc,dGinterp(msh,spc,uext),gopt2);% Show exact solution
    end
    drawnow;
end

% Show energy
% Define the Sate of Charge (SoC) under the assumption of a uniform
% insertion rate. For the considered parameters it holds SoC(t) = c0 + t.

%%<<<<<<<<<< Teil (d): Stellen Sie die freie Energiedichte graphisch dar
figure(fig.eng); clf;
soc=c0*ones(length(ts),1)+ts';
hold on;
plot(soc,fun_F(soc)); %theoretische Energiedichte
plot(soc,eng,'r-');%tatsächliche Energiedichte
legend('theoretische Energiedichte','tatsächliche Energiedichte','location','NorthEast');
%%>>>>>>>>>>


%% END
