function plotipoint(ipoin, label)
%PLOTIPOINT Esta funcion representa en tres dimensiones los puntos de una
%matriz ipoint estructurada segun se explica en la funcion init_ipoint.
%   Variables de entrada:
%       - ipoint: es la matriz de puntos de la esfera.
%       - label: su valor debe ser "true" o "false". Para label = true,
%         sobre cada punto se muestrara su identificador como etiqueta.
figure()
plot3(ipoin(:,2), ipoin(:,3), ipoin(:,4), '*')
xlabel('Eje x')
ylabel('Eje y')
zlabel('Eje z')
grid on

if label == true
    labels = string(ipoin(:,1));
    text(ipoin(:,2),ipoin(:,3), ipoin(:,4),labels, ...
        'VerticalAlignment','bottom','HorizontalAlignment','right')
end

end