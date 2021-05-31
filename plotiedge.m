function plotiedge(ipoin, iedge, label)
%PLOTIPOINT Esta funcion representa en tres dimensiones los puntos de una
%matriz ipoint estructurada segun se explica en la funcion init_ipoint.
%   Variables de entrada:
%       - ipoint: es la matriz de puntos de la esfera.
%       - label: su valor debe ser "true" o "false". Para label = true,
%         sobre cada punto se muestrara su identificador como etiqueta.

% El numero de aristas.
nedge = max(size(iedge));

% Queremos representar cada arista en el mismo grafico. Usamos hold on
hold on

for i = 1:nedge
    % Recuperamos las coordenadas de la arista i.
    [xyz1, xyz2] = search(i, ipoin, iedge);
    xyz = [xyz1; xyz2];
    
    % Representamos la arista
    plot3(xyz(:,1), xyz(:,2), xyz(:,3), 'k-')
end
   

% if label == true
%     labels = string(ipoin(:,1));
%     text(ipoin(:,2),ipoin(:,3), ipoin(:,4),labels, ...
%         'VerticalAlignment','bottom','HorizontalAlignment','right')
% end

end

function [xyz1, xyz2] = search(i, ipoin, iedge)
%SEARCH Encuentra las coordenadas de los puntos que forman la arista
%iedge(i,:).

% Recuperamos el identificador de los puntos que forman la arista.
ipoin1 = iedge(i,1);
ipoin2 = iedge(i,2);

% Recuperamos las coordenadas usando el identificador.
xyz1 = ipoin(ipoin1,2:4);
xyz2 = ipoin(ipoin2,2:4);

end