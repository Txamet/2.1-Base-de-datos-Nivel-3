-- 1. Llista el total de compres d’un client/a.
SELECT * FROM gafas JOIN ventas ON gafas.id_gafas = ventas.id_gafas WHERE ventas.id_cliente = 1; 
-- 2. Llista les diferents ulleres que ha venut un empleat durant un any.
SELECT * FROM gafas JOIN ventas ON gafas.id_gafas = ventas.id_gafas WHERE ventas.empleado_venta = "Carmen";
-- 3. Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.
SELECT DISTINCT proveedores.nombre FROM proveedores JOIN gafas ON proveedores.id_proveedor = gafas.id_proveedor JOIN ventas ON gafas.id_gafas = ventas.id_gafas;