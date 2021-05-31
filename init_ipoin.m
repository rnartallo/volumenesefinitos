function [ipoin, npoin] = init_ipoin(r)
%INIT_IPOIN Esta funcion inicializa la matriz ipoin con los 12 puntos de un
%icosaedro.
%   La variable de entrada es el radio de la esfera, r.
%   Las variable de salida son, npoin, el número de puntos e 
%   ipoin, la matriz de vertices emulando la nomenclatura de 
%   Giraldo:
%       - Cada fila representa los datos de un punto, i.
%       - La primera columna es el identificador del punto, id.
%       - La segunda, tercera y cuarta son las coordenadas xi, yi, zi.
%       - La quinta y sexta muestran los parent de dichos puntos.

% El número de puntos es doce.
npoin = 12;

% Creamos los vectores longitud (lambda) y latitud (theta). 
lambda = zeros(1, 12);
theta = zeros(1, 12);

% Tambien el creamos el vector de identificadores.
ipoint_n = zeros(1, 12);


% Introducimos el polo norte (ipoint_n 1) y el polo sur (ipoint_n 12) 
% respectivamente
lambda(1) = 0;
theta(1) = pi/2;
ipoint_n(1) = 1;

lambda(12) = 0;
theta(12) = -pi/2;
ipoint_n(12) = 12;

% Ahora los cinco puntos del hemisferio norte.
for i = 2:6
    lambda(i) = (i - 3/2)*2*pi/5;
    theta(i) = 2*asin( 1/( 2*cos( 3*pi/10 ) ) ) - pi/2;
    ipoint_n(i) = i;
end

% igual con los puntos del hemisferio sur.
for i = 7:11
    lambda(i) = (i - 7)*2*pi/5;
    theta(i) = - 2*asin( 1/( 2*cos( 3*pi/10 ) ) ) + pi/2;
    ipoint_n(i) = i;
end

% Inicializamos y calculamos las coordendas.
xi = zeros(1, 12);
yi = zeros(1, 12);
zi = zeros(1, 12);

for i = 1:12
    xi(i) = r*cos( theta(i) )*cos( lambda(i) );
    yi(i) = r*cos( theta(i) )*sin( lambda(i) );
    zi(i) = r*sin( theta(i) );
end

% Creamos la matriz
ipoin = [ipoint_n; xi; yi,; zi; zeros(1,12); zeros(1,12)];
ipoin = ipoin';

end