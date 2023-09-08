CREATE TABLE IF NOT EXISTS Modelo(
    id_modelo serial NOT null,
    Marca text,
    ModeloVe text,
    PRIMARY KEY (id_modelo)
);

CREATE TABLE IF NOT EXISTS Vehiculo(
    id_vehiculo serial NOT null,
    patente text,
    modelo_fk bigint,
    PRIMARY KEY (id_vehiculo),
    FOREIGN KEY (modelo_fk) REFERENCES Modelo(id_modelo)
);

CREATE TABLE IF NOT EXISTS Comuna(
    id_comuna serial NOT null,
    nombre_comuna text,
    PRIMARY KEY (id_comuna)
);

CREATE TABLE IF NOT EXISTS Cliente(
    id_cliente serial NOT null,
    nombre text,
    comuna_fk bigint,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (comuna_fk) REFERENCES Comuna(id_comuna)
);

CREATE TABLE IF NOT EXISTS Cliente(
    id_cliente_vehiculo serial NOT null,
    cliente_fk bigint,
    vehiculo_fk bigint,
    PRIMARY KEY (id_cliente_vehiculo),
    FOREIGN KEY (cliente_fk) REFERENCES Lugar_cliveh(id_lugar_cliveh),
    FOREIGN KEY (vehiculo_fk) REFERENCES Vehiculo(id_vehiculo)
);

CREATE TABLE IF NOT EXISTS Edificio_estacionamiento
(
    id_edificio_estacionamiento SERIAL PRIMARY KEY,
    cantidad_estacionamientos INTEGER,
    comuna_fk BIGINT,
    FOREIGN KEY (comuna_fk) REFERENCES Comuna(id_comuna)
);

CREATE TABLE IF NOT EXISTS Lugar(
    id_lugar serial NOT null,
    numero_lugar int,
    edificios_estacion_fk bigint,
    PRIMARY KEY (id_lugar),
    FOREIGN KEY (edificios_estacion_fk) REFERENCES Edificio_estacionamiento
);
