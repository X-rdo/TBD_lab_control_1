
INSERT INTO public.modelo(id_modelo, marca, ModeloVe) VALUES(1, 'BMW','128i'),
(2, 'Mercedes','A200'), 
(3, 'McLaren', '570 Gt'),
(4, 'Nissan', 'Skyline R4'), 
(5, 'Honda', 'CIVIC');

INSERT INTO public.vehiculo(id_vehiculo, patente, modelo_fk) VALUES(1, 'WXYZ34',1),
(2, 'LMNO78',2), 
(3, 'EFGH56', 3),
(4, 'QRST90', 4), 
(5, 'ABHD12', 5);


INSERT INTO public.comuna(id_comuna, nombre_comuna) VALUES(1, 'LO BARNECHEA'),
(2, 'VITACURA'), 
(3, 'MAIPÚ'),
(4, 'PROVIDENCIA'), 
(5, 'LAS CONDES'),
(6, 'ESTACIÓN CENTRAL'),
(7, 'MAIPÚ'),
(8, 'SAN BERNARDO'),
(9, 'LA FLORIDA'),
(10, 'INDEPENDENCIA');

INSERT INTO public.cliente(id_cliente, nombre, comuna_fk) VALUES(1, 'Alejandro', 5),
(2, 'Yerko', 1), 
(3, 'Ignacio', 2),
(4, 'Ricardo', 3), 
(5, 'Pablo', 4);

INSERT INTO public.Edificio_estacionamiento(id_edificio_estacionamiento, cantidad_estacionamientos, comuna_fk) VALUES(1, 5, 5),
(2, 10, 1), 
(3, 1, 2),
(4, 2, 3), 
(5, 7, 4);



