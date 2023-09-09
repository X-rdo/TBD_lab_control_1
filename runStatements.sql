-- 1. Lista de clientes que gasta más por edificio.
-- COLUMNAS: id_cliente, nombre_cliente, id_edificio, monto_total_gastado.
SELECT
    E.id_cliente AS id_cliente,
    C.nombre AS nombre_cliente,
    EE.id_edificio_estacionamiento AS id_edificio,
    SUM(P.monto) AS monto_total_gastado
FROM
    Cliente C
    JOIN
        Cliente_vehiculo CV ON C.id_cliente = CV.cliente_fk                                             --Se filtra la tabla cliente vehiculo, con la id del cliente.
    JOIN
        Contrato Co ON CV.id_cliente_vehiculo = Co.cliente_vehiculo_fk                                  --Se extrae todos los contratos de ese cliente.
    JOIN
        Edificio_estacionamiento EE ON Co.edificio_estacionamiento_fk = EE.id_edificio_estacionamiento  --Se busca los edificios en donde ha generado gasto con los contratos encontrados.
    JOIN
        Pago P ON Co.pago_fk = P.id_pago                                                                --Se extrae el pago.
GROUP BY
    E.id_cliente, C.nombre, EE.id_edificio_estacionamiento                                              --Se agrupa por cliente y edificio.
ORDER BY
    EE.id_edificio_estacionamiento, monto_total_gastado DESC;                                           --Se agrupa en orden desendiente por el monto total gastado.

-- 2. Modelos de auto menos recurrente por edificio.
-- COLUMNAS:

-- 3. Empleados con mayor y menor sueldo por edificio.
-- COLUMNAS:

-- 4. Lista de comunas con la cantidad de clientes que residen en ellas.
-- COLUMNAS:

-- 5. Lista de edificio con más lugares disponibles (sin contrato).
-- COLUMNAS:

-- 6. Lista de edificio con menos lugares disponibles.
-- COLUMNAS:

-- 7. Lista de clientes con más autos por edificio.
-- COLUMNAS:

-- 8. Lugar más usado por edificio.
-- COLUMNAS:

-- 9. Edificio con más empleados, indicando el número de empleados de ese edificio.
-- COLUMNAS:

-- 10. lista de sueldos por tipo de empleado por edificio, destacar la comuna del edificio.
-- COLUMNAS:
