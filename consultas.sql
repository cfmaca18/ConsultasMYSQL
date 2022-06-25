##1. Mostrar el número de pedido y el país del cliente de los pedidos de mayodel año 1995
 
use neptuno;
SELECT  P.idpedido, P.Paisdestinatario
FROM Pedidos as P
WHERE (Fechapedido) BETWEEN '1995-05-01' AND '1995-05-31'
order by P.idpedido;

#2. Mostrar el importe total de los pedidos 10501 y 10503 usando únicamente la tabla detalles.

select  D.idpedido, sum(D.preciounidad * D.cantidad) as Total
from detallesdepedidos as D
WHERE D.idpedido in (10501, 10503)
GROUP BY D.idpedido;

#3. ¿Cuánto se factura cada mes?

use neptuno;
select  SUM(D.preciounidad * D.cantidad) as Total_mes, month(P.fechapedido) as mes_pedido, year (P.fechapedido) as año_pedido
from pedidos as P, detallesdepedidos as D
WHERE P.IdPedido=D.idpedido
GROUP BY mes_pedido, año_pedido
order by año_pedido;

#4. Los pedidos que hizo la empleada NANCY.

select E.nombre, Pe.IdPedido, P.nombreProducto
from productos as P, empleados as E, pedidos as Pe, detallesdepedidos as D
where Pe.idempleado=E.idempleado AND P.idproducto=D.idproducto
GROUP BY P.nombreproducto 
HAVING E.Nombre= 'NANCY';

#5. Mostrar los pedidos de ANTON (código cliente).

SELECT C.idcliente, P.idpedido
FROM clientes as C, pedidos as P
WHERE C.idCliente=P.IdCliente
GROUP BY P.IdPedido
HAVING C.idCliente = 'ANTON';

#6. Clientes que pidieron queso en mayo de 1995

select  C.nombrecontacto, P.nombreproducto, PD.fechapedido
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN productos as P ON D.idproducto=P.idproducto
INNER JOIN clientes as C ON PD.IdCliente=C.idCliente
where (Fechapedido) BETWEEN '1995-05-01' AND '1995-05-31' AND P.nombreProducto LIKE "%Queso%";

#7. Cuántos productos hay de cada categoría y el precio medio.

select P.nombreproducto, C.nombrecategoria, avg (P.unidadesenexistencia) as Promedio
from productos as P, categorias as C
where P.idcategoria=C.idcategoria
group by P.nombreProducto;

#8. Mostrar los pedidos que tienen productos de las categorías condimentoso repostería.


select D.idpedido, P.nombreproducto, C.nombrecategoria
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN productos as P ON D.idproducto=P.idproducto
INNER JOIN categorias as C ON P.IdCategoria=C.idcategoria
where C.nombrecategoria like "%Condimentos%" 
GROUP BY C.NombreCategoria;

#9. Mostrar los nombres de las compañías que han facturado más del promedio de todas las compañías.

select C.nombreCompañia, sum(D.preciounidad * D.cantidad) as Total_facturado
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN compañiasdeenvios as C ON C.idCompañiaEnvios=PD.FormaEnvio
GROUP BY C.nombreCompañia
HAVING Total_facturado>(
SELECT AVG(Total)
FROM (select C.nombreCompañia, sum(D.preciounidad * D.cantidad) as Total
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN compañiasdeenvios as C ON C.idCompañiaEnvios=PD.FormaEnvio
GROUP BY C.nombreCompañia) AS TOTAL_COMPA);


#10. Mostar el nombre de los empleados que han facturado más que el empleado Margaret.

select E.IdEmpleado, E.nombre, Sum(D.preciounidad*D.cantidad) as Total_facturado
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN empleados as E ON E.idempleado=PD.Idempleado
GROUP BY E.Nombre
ORDER BY Total_facturado ASC;


select E.IdEmpleado, E.nombre, Sum(D.preciounidad*D.cantidad) as Total_facturado
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN empleados as E ON E.idempleado=PD.Idempleado
GROUP BY E.Nombre
HAVING Total_facturado > (
   select Sum(D.preciounidad*D.cantidad) as Total_facturado
   from detallesdepedidos as D
   INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
   INNER JOIN empleados as E ON E.idempleado=PD.Idempleado
   WHERE E.idempleado=8
   GROUP BY E.Nombre)
 
ORDER BY E.IdEmpleado ASC;





## 11 Mostrar el total de ventas de los clientes de Londres.

select C.nombrecontacto, C.ciudad, sum(P.cantidadporunidad * P.preciounidad) as Total_ventas
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN productos as P ON D.idproducto=P.idproducto
INNER JOIN clientes as C ON PD.IdCliente=C.idCliente
where C.ciudad like "%Londres%"
GROUP BY C.NombreContacto;

#12. Mostrar el total de ventas de la empresa desde que se tienen registros.

select C.NombreCompa?ia, PD.fechapedido, sum(D.preciounidad * D.cantidad) as Total_ventas
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN clientes as C ON PD.IdCliente=C.idCliente
group by C.NombreCompa?ia;

#13. Mostrar cuántos pedidos ha servido el empleado con nombre Nancy.

select E.Nombre, sum(P.unidadesenpedido) as Total_pedidos
from detallesdepedidos as D
INNER JOIN pedidos as PD ON D.idpedido=PD.IdPedido 
INNER JOIN productos as P ON D.idproducto=P.idproducto
INNER JOIN empleados as E ON PD.Idempleado=E.idempleado
WHERE E.Nombre LIKE "%Nancy%";
