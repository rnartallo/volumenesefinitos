function [itree, ntree] = init_itree()
%INIT_ITREE Esta funcion inicializa la matriz itree con los 20 
%elementos/triangulos del icosaedro.
%   No tiene variables de entrada.
%   Las variable de salida son, npoin, el número de puntos e 
%   ipoint, la matriz de vertices emulando la nomenclatura de 
%   Giraldo:
%       - Cada fila representa los datos de un punto, i.
%       - La primera columna es el identificador del punto, id.
%       - La segunda, tercera y cuarta son las coordenadas xi, yi, zi.

% El número de elementos o caras inicial es 20.
ntree = 20;

% Inicializamos el itree como una cell array.
itree = num2cell(zeros(ntree, 9));

% Rellenamos el id de cada uno de los 20 elementos.
itree(:,9) = num2cell((1:20)');

% Rellenamos manualmente los id de puntos que identifican dichos 
% elementos.
%Primero la tapa del hemisferio norte.
itree(1,1:3) = {1, 2, 3};
itree(2,1:3) = {1, 3, 4};
itree(3,1:3) = {1, 4, 5};
itree(4,1:3) = {1, 5, 6};
itree(5,1:3) = {1, 2, 6};

% Ahora el paralelo norte (elementos de la mitad superior).
itree(6,1:3) = {2, 3, 8};
itree(7,1:3) = {3, 4, 9};
itree(8,1:3) = {4, 5, 10};
itree(9,1:3) = {5, 6, 11};
itree(10,1:3) = {2, 6, 7};

% Ahora el paralelo sur.
itree(11,1:3) = {2, 7, 8};
itree(12,1:3) = {3, 8, 9};
itree(13,1:3) = {4, 9, 10};
itree(14,1:3) = {5, 10, 11};
itree(15,1:3) = {6, 7, 11};

% Ahora la tapa sur
itree(16,1:3) = {7, 8, 12};
itree(17,1:3) = {8, 9, 12};
itree(18,1:3) = {9, 10, 12};
itree(19,1:3) = {10, 11, 12};
itree(20,1:3) = {11, 7, 12};

% Rellenamos manualmente los futuros id de los elementos child 
% (ubicaciones 5 - 8). Tambien el parent id (ubicacion 4), en este
% caso sera 0.
% Primero la tapa del hemisferio norte.
itree(1,4:8) = {0, 1, 2, 3, 4};
itree(2,4:8) = {0, 5, 6, 7, 8};
itree(3,4:8) = {0, 9, 10, 11, 12};
itree(4,4:8) = {0, 13, 14, 15, 16};
itree(5,4:8) = {0, 17, 18, 19, 20};

% Ahora el paralelo norte (elementos de la mitad superior).
itree(6,4:8) = {0, 21, 22, 23, 24};
itree(7,4:8) = {0, 25, 26, 27, 28};
itree(8,4:8) = {0, 29, 30, 31, 32};
itree(9,4:8) = {0, 33, 34, 35, 36};
itree(10,4:8) = {0, 37, 38, 39, 40};

% Ahora el paralelo sur.
itree(11,4:8) = {0, 41, 42, 43, 44};
itree(12,4:8) = {0, 45, 46, 47, 48};
itree(13,4:8) = {0, 49, 50, 51, 52};
itree(14,4:8) = {0, 53, 54, 55, 56};
itree(15,4:8) = {0, 57, 58, 59, 60};

% Ahora la tapa sur
itree(16,4:8) = {0, 61, 62, 63, 64};
itree(17,4:8) = {0, 65, 66, 67, 68};
itree(18,4:8) = {0, 69, 70, 71, 72};
itree(19,4:8) = {0, 73, 74, 75, 76};
itree(20,4:8) = {0, 77, 78, 79, 80};

end