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
-- COLUMNAS: id_edificio_estacionamiento, Marca y modelove

SELECT Tabla2.id_edificio_estacionamiento, modelo.marca, modelo.modelove
FROM
	(SELECT Tabla.id_edificio_estacionamiento, MIN(Tabla.Cantidad_Modelo) as ModeloMin, Tabla.id_modelo
	 FROM 
		(SELECT E.id_edificio_estacionamiento, M.id_modelo, COUNT(M.id_modelo) AS Cantidad_Modelo
          FROM edificio_estacionamiento AS E 
	 		INNER JOIN contrato AS Co 
	 			ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
			 INNER JOIN cliente_vehiculo AS Cl
	 			ON Cl.id_cliente_vehiculo = Co.cliente_vehiculo_fk
			 INNER JOIN vehiculo AS V
	 			ON V.id_vehiculo = Cl.vehiculo_fk
			 INNER JOIN modelo AS M
	 			ON V.modelo_fk = M.id_modelo
			GROUP BY E.id_edificio_estacionamiento, M.id_modelo) AS Tabla                        -- Se obtienen los id de los modelos por cada edificio y su cantidad
	GROUP BY Tabla.id_edificio_estacionamiento, Tabla.id_modelo) AS Tabla2                       -- Se filtra por la cantidad minima de modelos que hay por edificio 
                                                                                                 -- (Se considera que puede haber multiples minimos)
INNER JOIN modelo on Tabla2.id_modelo = modelo.id_modelo                                         -- Se determina el modelo de los id's resultantes
                                                                                                 -- entregando los modelos menos recurrentes por edificio

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
-- COLUMNAS: id_edificio_estacionamiento, cantidad estacionamientos
SELECT *
    FROM 
    (SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos
        FROM edificio_estacionamiento AS E
            LEFT JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
            WHERE Co.edificio_estacionamiento_fk IS NULL                                                    -- se filtran los edificios que no tengan asosciados contratos

    UNION

    SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos - lugares_ocupados.cantidad_ocupada AS CantidadRestante
	    FROM edificio_estacionamiento AS E
		    JOIN (SELECT E.id_edificio_estacionamiento,  count(E.id_edificio_estacionamiento) AS cantidad_ocupada
			    FROM edificio_estacionamiento AS E
			    JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
			    GROUP BY E.id_edificio_estacionamiento) AS lugares_ocupados                                 -- Se seleccionan los edificios con contratos asociados y se le restan a los estacionamientos totales.
			    ON lugares_ocupados.id_edificio_estacionamiento = E.id_edificio_estacionamiento) AS tablas_Unidas
			    WHERE cantidad_estacionamientos = (SELECT MAX(cantidad_estacionamientos) FROM               -- En base a las tablas creadas anteriormente, se sacan los estacionamiento con más lugares disponibles.
                    (SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos
                        FROM edificio_estacionamiento AS E
                            LEFT JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
                        WHERE Co.edificio_estacionamiento_fk IS NULL

                    UNION

                    SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos - lugares_ocupados.cantidad_ocupada AS CantidadRestante
	                    FROM edificio_estacionamiento AS E
		                    JOIN (SELECT E.id_edificio_estacionamiento,  count(E.id_edificio_estacionamiento) AS cantidad_ocupada
			            FROM edificio_estacionamiento AS E
			                JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
			            GROUP BY E.id_edificio_estacionamiento) AS lugares_ocupados
			            ON lugares_ocupados.id_edificio_estacionamiento = E.id_edificio_estacionamiento) AS tablas_Unidas)
        ORDER BY id_edificio_estacionamiento;

-- 6. Lista de edificio con menos lugares disponibles.
-- COLUMNAS: id_edificio_estacionamiento, cantidad estacionamientos

SELECT *                                                                    
    FROM 
    (SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos
        FROM edificio_estacionamiento AS E
            LEFT JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
            WHERE Co.edificio_estacionamiento_fk IS NULL                                                                            -- Se filtran los datos que no estan en contrato

    UNION

    SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos - lugares_ocupados.cantidad_ocupada AS CantidadRestante
	    FROM edificio_estacionamiento AS E
		    JOIN (SELECT E.id_edificio_estacionamiento,  count(E.id_edificio_estacionamiento) AS cantidad_ocupada
			    FROM edificio_estacionamiento AS E
			    JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
			    GROUP BY E.id_edificio_estacionamiento) AS lugares_ocupados
			    ON lugares_ocupados.id_edificio_estacionamiento = E.id_edificio_estacionamiento) AS tablas_Unidas                     -- Se filtran los datos que tienen contrato y se les restan a los estacionamientos totales

			    WHERE cantidad_estacionamientos = (SELECT MIN(cantidad_estacionamientos) FROM                                        -- En base a las tablas creadas anteriormente, se selecciona el edificio con menor numero de estacionamientos
                        (SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos                                           -- disponibles
                            FROM edificio_estacionamiento AS E
                            LEFT JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
                        WHERE Co.edificio_estacionamiento_fk IS NULL

                    UNION

                    SELECT E.id_edificio_estacionamiento, E.cantidad_estacionamientos - lugares_ocupados.cantidad_ocupada AS CantidadRestante
	                    FROM edificio_estacionamiento AS E
		                    JOIN (SELECT E.id_edificio_estacionamiento,  count(E.id_edificio_estacionamiento) AS cantidad_ocupada
			            FROM edificio_estacionamiento AS E
			                JOIN contrato AS Co ON E.id_edificio_estacionamiento = Co.edificio_estacionamiento_fk
			            GROUP BY E.id_edificio_estacionamiento) AS lugares_ocupados
			            ON lugares_ocupados.id_edificio_estacionamiento = E.id_edificio_estacionamiento) AS tablas_Unidas)
        ORDER BY id_edificio_estacionamiento;

-- 7. Lista de clientes con más autos por edificio.
-- COLUMNAS:

-- 8. Lugar más usado por edificio.
-- COLUMNAS: id_edificio, id_lugar, cantidad_de_usos
SELECT C.Edificio, id_lugar, cantidad_de_usos
FROM 
	(SELECT 
			ed.id_edificio_estacionamiento AS Edificio,
			id_lugar, 
			count(*) AS cantidad_de_usos,
	 		ROW_NUMBER() OVER (PARTITION BY ed.id_edificio_estacionamiento ORDER BY count(*) DESC) AS col                    --Se crea una columna que asigna un valor a la fila según la cantidad de usos que tenga el lugar
		FROM 
            Edificio_estacionamiento AS ed 
			JOIN Lugar AS L ON L.edificios_estacion_fk=ed.id_edificio_estacionamiento                   
			JOIN Lugar_cliveh AS LC ON LC.lugar_fk=L.id_lugar
		GROUP BY ed.id_edificio_estacionamiento,id_lugar) AS C                                                               --Se hace un join con las tablas edificio, lugar y cliente_vehic para, luego se agrupan por el edificio y se cuentan las instancias de cada estacionamiento en la tabla resultante
WHERE col=1;                                                                                                                 --Se seleccionan la tuplas que tengan el numero 1, es decir aquellas que tengan la mayor cantidad de usos de cada edificio


-- 9. Edificio con más empleados, indicando el número de empleados de ese edificio.
-- COLUMNAS: id_edificio, cantidad_empleados
SELECT * 
FROM
    (SELECT 
        Ed.id_edificio_estacionamiento AS edificio,  
        count(*) AS cantidad_empleados                                                                                      --Se cuenta la cantidad de tuplas que existen por edificio
    FROM
        Empleado AS E 
        JOIN Edificio_estacionamiento AS Ed ON E.edificio_estacionamiento_fk=Ed.id_edificio_estacionamiento                 --Se hace join de empleado con edificio
    GROUP BY Ed.id_edificio_estacionamiento) AS C                                                                           --Se agrupan segun el id del edificio
ORDER BY cantidad_empleados DESC  
LIMIT 1;                                                                                                                    --Se ordenan las tablas segun la cantidad de empleados de forma descendente y se limitan las tuplas a 1

-- 10. lista de sueldos por tipo de empleado por edificio, destacar la comuna del edificio.
-- COLUMNAS:
