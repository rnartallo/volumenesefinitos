function [ipoin2, iedge2, itree2] = refine(ipoin, iedge, itree, r)
%REFINE Esta funcion genera un bucle de refinamiento de la malla.
%   Detailed explanation goes here

%% Calculamos el nuevo ipoin
% Calculemos el numero de puntos y de aristas.
npoin = max(size(ipoin));
nedge = max(size(iedge));

% Inicializamos ipoin2
ipoin2 = ipoin;

% Inicializamos las coordenadas de los puntos medios de las aristas.
xyz = zeros(nedge, 3); 

% Recorremos las aristas. Calculamos las coordenadas.
for i = 1:nedge
    % Recuperamos las coordenadas de la arista i.
    [point1, point2, xyz1, xyz2] = search(i, ipoin, iedge);
    
    % Calculamos el punto medio
    midpoin = 1/2*( xyz1 + xyz2 );
    
    % Grabamos el punto sobre la esfera
    xyz(i,:) = r*midpoin./norm( midpoin );

    % Grabamos en ipoin2
    newpoin = [npoin + i, xyz(i,:), point1, point2];
    ipoin2(npoin + i, :) = newpoin;
end

%% Calculamos el nuevo itree

% Calculamos npoint2, ntree y ntree2.
npoin2 = max(size(ipoin2));
ntree = max(size(itree));
ntree2 = ntree + 2*(npoin2 - 2);

% Inicializamos itree2
itree2 = itree;

% Debemos conocer cual es el parent activo (ubicacion 4): recuperamos el id
% de cada elemento de itree. Calculamos la primera ubicacion no nula. Por
% construccion st_active debe ser 1.
elem = cell2mat(itree(:,9));
st_active = find(elem);
st_active = st_active(1);

if elem(st_active) ~= 1
    error("El primer elemento activo debe tener id 1.")
end

% Recuperamos parent activo.
pt_active = itree{st_active, 4};

% Ahora creamos el nuevo itree con un bucle for.
for i = ntree+1:ntree2
    
    % Anulamos la ubicacion 9 del elemento inicial
    elem_0 = st_active + floor( (i - ntree - 1)/4);
    itree2{elem_0, 9} = 0;
    
    % Recuperamos id de los puntos del elemento.
    point1 = itree{elem_0,1};
    point2 = itree{elem_0,2};
    point3 = itree{elem_0,3};
    
    % Buscamos id de las combinaciones.
    id_12 = parent_id(ipoin2, [point1, point2]);
    id_13 = parent_id(ipoin2, [point1, point3]);
    id_23 = parent_id(ipoin2, [point2, point3]);
    
    % Nombramos posiciones de los nuevos elementos.
    pos5 = itree{elem_0, 5};
    pos6 = itree{elem_0, 6};
    pos7 = itree{elem_0, 7};
    pos8 = itree{elem_0, 8};
    
    resto = rem(i,4);
    if resto == 1
        % Primer nuevo elemento
        itree2(i,:) = {point1, id_12, id_13, pt_active + 1,...
            4*(pos5-1)+1, 4*(pos5-1)+2, 4*(pos5-1)+3,...
            4*(pos5-1)+4, pos5};
    elseif resto == 2
        % Segundo nuevo elemento
        itree2(i,:) = {id_12, point2, id_23, pt_active + 1,...
            4*(pos6-1)+1, 4*(pos6-1)+2, 4*(pos6-1)+3,...
            4*(pos6-1)+4, pos6};
    elseif resto == 3
        % Tercer nuevo elemento
        itree2(i,:) = {id_13, id_23, point3, pt_active + 1,...
            4*(pos7-1)+1, 4*(pos7-1)+2, 4*(pos7-1)+3,...
            4*(pos7-1)+4, pos7};
    else 
        % Cuarto nuevo elemento
        itree2(i,:) = {id_12, id_13, id_23, pt_active + 1,...
            4*(pos8-1)+1, 4*(pos8-1)+2, 4*(pos8-1)+3,...
            4*(pos8-1)+4, pos8};
    end
       
    
end

%% Creamos iedge2
% ATENCION: este iedge tendra aristas repetidas.
% Añadimos las nuevas aristas a iedge. ATENCION: no seguimos el convenio de
% las caras. No se como se hace para nombrar las nuevas caras y saber cual
% esta a cada lado.
iedge2 = zeros(3*(ntree2 - ntree), 2);

for i = ntree+1:ntree2
    % Recuperamos id de los puntos que forman el triangulo nuevo.
    id_1 = itree2{i,1};
    id_2 = itree2{i,2};
    id_3 = itree2{i,3};
    
    % Calculamos un indice que nos ayude a rellenar iedge2
    iedge_ix = i - ntree - 1;
    
    % Rellenamos iedge2
    iedge2(3*iedge_ix + 1, 1:2) = [id_1, id_2];
    iedge2(3*iedge_ix + 2, 1:2) = [id_1, id_3];
    iedge2(3*iedge_ix + 3, 1:2) = [id_2, id_3];    
end

iedge2 = unique(iedge2, 'rows');

nedge2 = max(size(iedge2));

for i = 1:nedge2
    if iedge2(i,1) > iedge2(i,2)
        iedge2(i,:) = [iedge2(i,2), iedge2(i,1)];
    end
end

iedge2 = unique(iedge2, 'rows');


end


function [ipoin1, ipoin2, xyz1, xyz2] = search(i, ipoin, iedge)
%SEARCH Encuentra las coordenadas de los puntos que forman la arista
%iedge(i,:).

% Recuperamos el identificador de los puntos que forman la arista.
ipoin1 = iedge(i,1);
ipoin2 = iedge(i,2);

% Recuperamos las coordenadas usando el identificador.
xyz1 = ipoin(ipoin1,2:4);
xyz2 = ipoin(ipoin2,2:4);

end

function child_id = parent_id(ipoin, parent)
% PARENT_ID encuentra el child_id de los puntos parent = [id1, id2]

list = ipoin(:, 5:6) == parent;
list = list(:,1) & list(:,2);

% Puede ser que los indices de parent esten dados la vuelta.
if any(list) == false
    parent = [parent(2), parent(1)];
    list = ipoin(:, 5:6) == parent;
    list = list(:,1) & list(:,2);
end

child_id = find(list);

end