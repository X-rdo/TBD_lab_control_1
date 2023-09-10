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
-- COLUMNAS: id_edificios, nombre_cliente (sueldo minimo), nombre_cliente (sueldo mas alto)

SELECT 
    sueldos.edificio as edificio, 
    E1.nombre as bajo, 
    E2.nombre as altos 
FROM 
Empleado as E1 JOIN                                                                                     -- tabla anidada que entrega id de los edificios con los id del sueldo minimo y maximo
    (SELECT 
        smax.id_edificio_estacionamiento AS edificio, 
        smin.id_sueldo as minimo, 
        smax.id_sueldo as maximo 
    FROM 
 	    (SELECT                                                                                         -- consulta que obtiene el id del sueldo maximo
            ES.id_edificio_estacionamiento, 
            MAX(S.dinero) as maximo, 
            (SELECT 
                S1.id_sueldo 
            FROM 
                Sueldo AS S1 
            WHERE 
                S1.dinero = MAX(S.dinero))
        FROM
            Empleado AS E 
            JOIN 
                Sueldo as S ON E.sueldo_fk=S.id_sueldo 
            JOIN
                Edificio_estacionamiento AS ES ON E.edificio_estacionamiento_fk=ES.id_edificio_estacionamiento
        GROUP BY 
            ES.id_edificio_estacionamiento) AS smax 
    JOIN 
	    (SELECT 
            ES.id_edificio_estacionamiento,                                                             -- consulta que obtiene el id del sueldo minimo
            MIN(S.dinero) as minimo, 
            (SELECT 
                S1.id_sueldo 
            FROM 
                Sueldo AS S1 
            WHERE 
                S1.dinero = MIN(S.dinero))
        FROM
            Empleado AS E 
            JOIN 
                Sueldo as S ON E.sueldo_fk=S.id_sueldo 
            JOIN 
                Edificio_estacionamiento AS ES ON E.edificio_estacionamiento_fk=ES.id_edificio_estacionamiento
            GROUP BY ES.id_edificio_estacionamiento) AS smin
        on smin.id_edificio_estacionamiento=smax.id_edificio_estacionamiento) as sueldos on
	    E1.sueldo_fk=sueldos.minimo JOIN Empleado as E2 on sueldos.maximo=E2.sueldo_fk                  -- se realizan join para ubicar a las personas que tengan el sueldo con id minimo y maximo
	
-- 4. Lista de comunas con la cantidad de clientes que residen en ellas.
-- COLUMNAS:nombre_comuna, id_cliente

SELECT
    Co.nombre_comuna, 
    COUNT(Cli.id_cliente) AS total_cliente                                      -- cuenta la cantidad de clientes que se encuentran en esa comuna.
FROM 
   Comuna AS Co                                                                 -- se realizan join para ubicar los id de comuna que se repiten en la tabla cliente.
   JOIN Cliente AS Cli ON Co.id_comuna = Cli.comuna_fk

GROUP BY Co.nombre_comuna                                                       -- agrupa por nombre de la comuna.
ORDER BY total_cliente ASC;                                                     -- para terminar ordenando ascendentemente por la cantidad de clientes que residen en esa comuna.
                                                             
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
