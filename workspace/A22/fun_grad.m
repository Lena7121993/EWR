function uEx_grad = fun_grad(x)
%FUN_GRAD Summary of this function goes here
%   Detailed explanation goes here
x1=x(:,1);
x2=x(:,2);
r=max(x1.^2+x2.^2,eps);
phi=(2/3)*atan2(x2,x1);
dx=r.^(-2/3).*cos(phi).*x1+r.^(-2/3).*sin(phi).*x2;
dy=r.^(-2/3).*cos(phi).*x2-r.^(-2/3).*sin(phi).*x1;
uEx_grad=(2/3)*[dx,dy];

end

