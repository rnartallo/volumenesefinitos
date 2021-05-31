function [iedge, nedge] = init_iedge(ipoin)
%INIT_IEDGE Esta funcion inicializa la matriz iedge con las 30 
%aristas de un icosaedro.
%   La variable de entrada es la matriz ipoin creada segun se explica
%   en init_ipoin.m
%   Las variable de salida son, nedge, el número de aristas e iedge, la 
%   matriz de aristas segun la nomenclatura de Giraldo:
%       - La columnas 1 y 2 indentifican los puntos que generan la arista.
%       - Las columnas 3 y 4 identifican los dos triangulos que comparten
%         esta arista.
%   NOTA: para rellenar esta primera matriz se ha adoptado un convenio que
%   no aparece en el Giraldo. Puede servirnos para encontrar errores en la
%   inicialización de init_iedge:
%       - En la columna 1 ponemos el identificador de punto de menor valor.
%       - Si tomamos el camino del punto de la columna 1 al punto de la 
%         columna 2, entonces, el identificador de triángulo que ponemos en
%         la columna 3 es el del triángulo a la derecha.

% El número de aristas es treinta.
nedge = 30;

% Inicializamos la matriz.
iedge = zeros(nedge, 4);

% Rellenamos la matriz a mano.
% Primero la tapa del hemisferio norte.
iedge(1,:) = [1, 2, 5, 1];
iedge(2,:) = [1, 3, 1, 2];
iedge(3,:) = [1, 4, 2, 3];
iedge(4,:) = [1, 5, 3, 4];
iedge(5,:) = [1, 6, 4, 5];

% Ahora el paralelo norte (aristas entre los puntos 2, 3, 4, 5 y 6).
iedge(6,:) = [2, 3, 6, 1];
iedge(7,:) = [3, 4, 7, 2];
iedge(8,:) = [4, 5, 8, 3];
iedge(9,:) = [5, 6, 9, 4];
iedge(10,:) = [2, 6, 5, 10];

% Ahora aristas entre el paralelo norte y el paralelo sur.
iedge(11,:) = [2, 7, 10, 11];
iedge(12,:) = [2, 8, 11, 6];
iedge(13,:) = [3, 8, 6, 12];
iedge(14,:) = [3, 9, 12, 7];
iedge(15,:) = [4, 9, 7, 13];
iedge(16,:) = [4, 10, 13, 8];
iedge(17,:) = [5, 10, 8, 14];
iedge(18,:) = [5, 11, 14, 9];
iedge(19,:) = [6, 11, 9, 15];
iedge(20,:) = [6, 7, 15, 10];

% Ahora el paralelo sur (aristas entre los puntos 7, 8, 9, 10 y 11).
iedge(21,:) = [7, 8, 16, 11];
iedge(22,:) = [8, 9, 17, 12];
iedge(23,:) = [9, 10, 18, 13];
iedge(24,:) = [10, 11, 19, 14];
iedge(25,:) = [7, 11, 15, 20];

% Finalmente la tapa del hemisferio sur.
iedge(26,:) = [7, 12, 20, 16];
iedge(27,:) = [8, 12, 16, 17];
iedge(28,:) = [9, 12, 17, 18];
iedge(29,:) = [10, 12, 18, 19];
iedge(30,:) = [11, 12, 19, 20];

end