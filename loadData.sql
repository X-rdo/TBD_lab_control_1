ALTER SEQUENCE Modelo_id_modelo_seq RESTART WITH 1;
ALTER SEQUENCE vehiculo_id_vehiculo_seq RESTART WITH 1;
ALTER SEQUENCE comuna_id_comuna_seq RESTART WITH 1;
ALTER SEQUENCE cliente_id_cliente_seq RESTART WITH 1;
ALTER SEQUENCE Edificio_estacionamiento_id_edificio_estacionamiento_seq RESTART WITH 1;

INSERT INTO public.modelo(marca, ModeloVe) VALUES('BMW','128i'),
('Mercedes','A200'), 
('McLaren', '570 Gt'),
('Nissan', 'Skyline R4'), 
('Honda', 'CIVIC');


INSERT INTO public.vehiculo( patente, modelo_fk) VALUES('WXYZ34',1),
('LMNO78',2), 
('EFGH56', 3),
('QRST90', 4), 
('ABHD12', 5);


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

INSERT INTO public.cliente(nombre, comuna_fk) VALUES( 'Alejandro', 5),
('Yerko', 1), 
('Ignacio', 2),
('Ricardo', 3), 
('Pablo', 4);

INSERT INTO public.Edificio_estacionamiento(cantidad_estacionamientos, comuna_fk) VALUES(5, 5),
(10, 1), 
(1, 2),
(2, 3), 
(7, 4);



