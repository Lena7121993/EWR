%% Datafile DG/CG
% Data for nonlinear parabolic initial boundary value problems in 1D of
% Cahn-Hilliard type.
% We solve the initial boundary value problem for [u,mu]
%    d/dt u - c1 mu'' = 0       in (0,T)x(xL,xR),
%    c2 u'' +    mu   = F'(u)   in (0,T)x(xL,xR),
%              u(0,.) = u0      in (xL,xR),
%             mu(0,.) = mu0     in (xL,xR),
%              d_n  u = 0       on (0,T)x{xN},
%              d_n mu = muN     on (0,T)x{xN},
% for xL<xR, 0<T, nonlinearity F and functions f (source), uD (Dirichlet data),
% xD (Dirichlet boundary points), uN (Neumann data mu), xN (Neumann boundary
% points), u0 (initial condition).
% Variant for c3 > 0: Viscous Cahn-Hilliard equation
%    (1-c1 c3 (.)'') d/dt u - c1 mu'' = 0       in (0,T)x(xL,xR),
%                    c2 u'' +    mu   = F'(u)   in (0,T)x(xL,xR),
%% Problems (d=1)
% Battery
%    F(z)=alpha*z*(1-z)+z*log(z)+(1-z)*log(1-z);
%%

%% Data
% Set default values
domain = dGdomain();

%% Define the problem.
% Set 'exam' to refer to the different examples outside
% Info
fprintf('Loading datafile data_ch_1d (Example Battery).\n');
% Choices
% Parameter
alpha = 4.5;
m = 1.00;
kappa = 5e-3;
% Domain
xL = 0; xR = 1;% I = [0 1]
Tini = 0;% Initial time
Tend = 0.02;% Final time
% Initial concentration
c0 = 0.01;
% Data functions
fun_F = @(z) alpha*z.*(1-z) + z.*log(z) + (1-z).*log(1-z);
fun_G = @(z) alpha*(1-2*z) + log(z) - log(1-z);% F'
fun_H = @(z) -2*alpha+1./z+1./(1-z);% G'
fun_u0  = @(x) c0*ones(size(x,1),1);% Initial state u
fun_u0p = @(x) zeros(size(x,1),1);% d/dx initial state
fun_u0pp = @(x) zeros(size(x,1),1);% d^2/dx^2 initial state
fun_mu0 = @(x) fun_G(fun_u0(x))-c2*fun_u0pp(x);% mu0 from u0
fun_xD  = @(x) zeros(size(x,1),1);% Indicator for Dirichlet nodes
fun_uD  = @(x,t) zeros(size(x,1),1);% Dirichlet boundary conditions
fun_uDp = @(x,t) zeros(size(x,1),1);% d/dt Dirichlet boundary conditions
fun_xN  = @(x) 1-fun_xD(x);% Indicator for Neumann nodes
fun_muN  = @(x,t) 1.0*x;% Neumann boundary conditions
% Exact solution if available
% Graphics (modify graphics options from dGdefaults)
gopt.fixaxis = [xL xR 0 1];% Fixed axis

%% Further settings
% Grafics options
if isempty(fun_uExt)
    gopt.ylbl = 'u_h(t,x)';
else
    gopt.ylbl  = 'u_h(t,x), u(t,x)';
    gopt2.ylbl = gopt.ylbl;
    gopt2.fixaxis = gopt.fixaxis;% Same axis for exact solution plot
end
% Domain options
geom = zeros(1,2); geom(1) = (xR+xL)/2; geom(2) = xR-xL;% To use in dGdomain
domain.tag = 'I';
domain.ncpd = nc;
domain.geom = geom;

%% END
