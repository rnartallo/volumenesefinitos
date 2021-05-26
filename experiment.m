%F= '7*u';T=1;a=0;b=1;g='sin(x-7*t)';sol='sin(x-7*t)'; %linear transport - Ejemplo 1
F='0.5.*u^2'; T=10;a=0;b=1;g='(2*x+1).*((2*t+1).^(-1))';sol='(2*x+1).*((2*t+1).^(-1))'; %inviscid burgers equation with linear initial condition - Ejemplo 2
error = zeros(7,4);grads=zeros(7,4);
for i=1:7
    h=1/(2^i); k=h/8; %cfl
    V1 = UpwindFixedPos(F,h,k,T,a,b,g); %si sabemos que la velocidad es positivo (e.g. Burger's)
    V2=LF(F,h,k,T,a,b,g);
    V3=Richtmyer(F,h,k,T,a,b,g);
    u = str2func(strcat('@(x,t)','0*x+',sol));
    x=[a:h:b];
    t=[0:k:T];
    [X,Y]=meshgrid(x,t);
    exacta = (u(X,Y)).';
    E1=abs(V1-exacta);
    E2=abs(V2-exacta);
    E3=abs(V3-exacta);
    error(i,1)=i;
    grad(i,1)=i;
    error(i,2)=max(max(E1));
    error(i,3)=max(max(E2));
    error(i,4)=max(max(E3));
end
tiledlayout(2,2);
nexttile
mesh(t,x,exacta)
title("Ejemplo 2 - Solución exacta")
nexttile
mesh(t,x,V1)
title("Método 'Upwind'")
nexttile
mesh(t,x,V2)
title("Método 'LF'")
nexttile
mesh(t,x,V3)
title("Método 'Richtmyer'")
steps = 2.^(-error(:,1));
figure()
loglog(steps,error(:,2),'r')
hold on
loglog(steps,error(:,3),'b')
hold on
loglog(steps,error(:,4),'g')
legend('Upwind','Lax-Friedrichs','Richtmyer')
title("Ejemplo 2 - Gráfica de error")
xlabel("Valores de h")
ylabel("Valores de E - correspondiente a h")
grad(:,2)=gradient(log(error(:,2)),log(steps)).';
grad(:,3)=gradient(log(error(:,3)),log(steps)).';
grad(:,4)=gradient(log(error(:,4)),log(steps)).';
writematrix(error,'example2error.txt','Delimiter','tab');
writematrix(grads,'example2grads.txt','Delimiter','tab');