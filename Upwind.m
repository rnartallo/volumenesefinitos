function [U] = Upwind(A,h,k,T,a,b,g)
x=[a:h:b]; %malla en espacio

t=[0:k:T]; %malla en tiempo
N_x = (b-a)/h; N_t = T/k;

xmid = 0.5*(x(1:N_x) + x(2:N_x+1)); %puntos medios
U = zeros(N_x+1,N_t+1);


fun_A = str2func(strcat('@(x,t)','0*x+',A));
fun_ini = str2func(strcat('@(x,t)','0*x+',g));
U(:,1)=fun_ini(x,0);
U(1,:)=fun_ini(a,t);
U(N_x+1,:)=fun_ini(b,t);

for n=2:N_t+1
    for i=2:N_x
        f1=(0.5*fun_A(t(n-1),xmid(i))*(U(i,n-1)+U(i+1,n-1)))-(0.5*abs(fun_A(t(n-1),xmid(i)))*(U(i+1,n-1)-U(i,n-1)));
        f2=(0.5*fun_A(t(n-1),xmid(i-1))*(U(i-1,n-1)+U(i,n-1)))-(0.5*abs(fun_A(t(n),xmid(i-1)))*(U(i,n-1)-U(i-1,n-1)));
        U(i,n)=U(i,n-1)-(k/h)*(f1-f2);
    end
end