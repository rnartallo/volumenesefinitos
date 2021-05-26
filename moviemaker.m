%burgers with shocks example 1 - movie
F='0.5.*u^2'; T=10;a=-12;b=12;g='exp(-x.^2)';
h=1/32; k=h/2;
V1 = UpwindFixedPos(F,h,k,T,a,b,g);
V2=LF(F,h,k,T,a,b,g);
V3=Richtmyer(F,h,k,T,a,b,g);
x=[a:h:b];
S=size(V3);N=S(2);
for n=1:N
    axis([-10 10 0 1])
    plot(x,V1(:,n))
    hold on
    title("Ejemplo 3 - La ecuación de Burgers")
    axis([-10 10 0 1])
    plot(x,V2(:,n))
    axis([-10 10 0 1])
    plot(x,V3(:,n))
    axis([-10 10 0 1])
    legend('Upwind','Lax-Friedrichs','Richtmyer')
    hold off
    M(n)=getframe(gcf);
end

movie(M);
burgerstodos2 = VideoWriter('burgerstodos2.mp4','MPEG-4');
open(burgerstodos2)
writeVideo(burgerstodos2,M)
close(burgerstodos2)