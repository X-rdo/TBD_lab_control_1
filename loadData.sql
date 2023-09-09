ALTER SEQUENCE Modelo_id_modelo_seq RESTART WITH 1;
ALTER SEQUENCE vehiculo_id_vehiculo_seq RESTART WITH 1;
ALTER SEQUENCE comuna_id_comuna_seq RESTART WITH 1;
ALTER SEQUENCE cliente_id_cliente_seq RESTART WITH 1;
ALTER SEQUENCE Edificio_estacionamiento_id_edificio_estacionamiento_seq RESTART WITH 1;
ALTER SEQUENCE Lugar_id_lugar_seq RESTART WITH 1;
ALTER SEQUENCE Pago_id_pago_seq RESTART WITH 1;
ALTER SEQUENCE Sueldo_id_sueldo_seq RESTART WITH 1;
ALTER SEQUENCE Contrato_id_contrato_seq RESTART WITH 1;
ALTER SEQUENCE Empleado_id_empleado_seq RESTART WITH 1;

--Poblacion de tabla modelo
INSERT INTO public.modelo(marca, ModeloVe) VALUES('BMW','128i'),
('Mercedes','A200'), 
('McLaren', '570 Gt'),
('Nissan', 'Skyline R4'), 
('Honda', 'CIVIC');

--Poblacion de tabla vehiculo
INSERT INTO public.vehiculo( patente, modelo_fk) VALUES('WXYZ34',1),
('LMNO78',2), 
('EFGH56', 3),
('QRST90', 4), 
('ABHD12', 5);

--Poblacion de tabla comuna
INSERT INTO public.comuna(nombre_comuna) VALUES('LO BARNECHEA'),
('VITACURA'), 
('MAIPÚ'),
('PROVIDENCIA'), 
('LAS CONDES'),
('ESTACIÓN CENTRAL'),
('MAIPÚ'),
('SAN BERNARDO'),
('LA FLORIDA'),
('INDEPENDENCIA');

--Poblacion de tabla cliente
INSERT INTO public.cliente(nombre, comuna_fk) VALUES( 'Alejandro', 5),
(1, 1), 
(2, 2),
(3, 3), 
(4, 4);

--Poblacion de tabla edificio_estacionamiento
INSERT INTO public.Edificio_estacionamiento(cantidad_estacionamientos, comuna_fk) VALUES(5, 5),
(10, 1), 
(1, 2),
(2, 3), 
(7, 4);

--Poblacion de tabla Lugar
INSERT INTO Lugar (numero_lugar, edificios_estacion_fk) VALUES (1, 1), 
(2, 2), 
(1, 3), 
(1, 4), 
(1, 5);

--Poblacion de tabla Pago
INSERT INTO Pago (monto) VALUES (120000), 
(100000), 
(200000), 
(180000), 
(165000);

--Poblacion de tabla Sueldo
INSERT INTO Sueldo (dinero) VALUES (420000), 
(500000), 
(480000), 
(630000), 
(530000);

--Poblacion de tabla Cliente_vehiculo
INSERT INTO Cliente_vehiculo (cliente, vehiculo) VALUES ('Alejandro', 1), 
('Yerko', 2), 
('Ignacio', 3), 
('Ricardo', 4), 
('Pablo', 5);

--Poblacion de tabla Lugar_cliveh
INSERT INTO Lugar_cliveh (lugar_fk, cliente_vehiculo_fk) VALUES (1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5);


--Polacion de tabla Contrato
INSERT INTO Contrato (fecha, cliente_vehiculo_fk, edificio_estacionamiento_fk, pago_fk) VALUES ('2023-04-25', 1, 1, 1), 
('2023-04-20', 2, 1, 2),
('2023-04-19', 3, 2, 3), 
('2023-04-15', 3, 2, 3), 
('2023-04-22', 3, 2, 3);

--Poblacion de tabla empleado
INSERT INTO Empleado (nombre, cargo, sueldo_fk, comuna_fk, edificio_estacionamiento_fk) VALUES ('Juanin', 'Conserje', 1, 1, 1), 
('Josefin', 'Conserje', 2, 1, 2), 
('Pablin', 'Guardia', 1, 2,1), 
('Manuelin', 'Conserje', 1, 2,1), 
('Rodolfin', 'Administrador', 4, 3,1);

