function [U] = Richtmyer(F,h,k,T,a,b,g)
x=[a:h:b]; %malla en espacio

t=[0:k:T]; %malla en tiempo
N_x = (b-a)/h; N_t = T/k;
U = zeros(N_x+1,N_t+1);

fun_F = str2func(strcat('@(u)','0*u+',F));
fun_ini = str2func(strcat('@(x,t)','0*x+',g));
U(:,1)=fun_ini(x,0);
U(1,:)=fun_ini(a,t);
U(N_x+1,:)=fun_ini(b,t);

for n=2:N_t+1
    for i=2:N_x
        mid_upper = (0.5)*(U(i+1,n-1)+U(i,n-1))-(k/(2*h))*(fun_F(U(i+1,n-1))-fun_F(U(i,n-1)));
        mid_lower = (0.5)*(U(i,n-1)+U(i-1,n-1))-(k/(2*h))*(fun_F(U(i,n-1))-fun_F(U(i-1,n-1)));
        U(i,n)=U(i,n-1)-(k/h)*(fun_F(mid_upper)-fun_F(mid_lower));
    end
end


end

