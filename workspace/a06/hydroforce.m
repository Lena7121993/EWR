function F = hydroforce(t,y)
%rechte Seite des Diffgleichungssystem fuer Sedimentation
%gibt Vektor der laenge 3N zurueck
global N;
N=16;
sum=zeros(3,N);
position=reshape(y,[3,N]);
id=eye(3);
K=@(z) (1/norm(z))*(id+(reshape(z,[3,1])*reshape(z,[3,1])')/norm(z)^2);
e3=[0,0,1]';
for i=1:N
    for k=1:N
        if i~=k        
            v=K(position(:,i)-position(:,k))*e3;
            sum(:,i)=sum(:,i)+v;
        end
    end
end
sum=reshape(sum,[1,3*N]);
F=(-5/(8*N)*sum)';
end



