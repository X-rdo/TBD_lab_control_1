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

CREATE TABLE IF NOT EXISTS Cliente_vehiculo(
    id_cliente_vehiculo serial NOT null,
    cliente_fk bigint,
    vehiculo_fk bigint,
    PRIMARY KEY (id_cliente_vehiculo),
    FOREIGN KEY (cliente_fk) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (vehiculo_fk) REFERENCES Vehiculo(id_vehiculo)
);

CREATE TABLE if NOT EXISTS Lugar_cliveh(
    id_lugar_cliveh serial NOT null,
    lugar_fk bigint,
    cliente_vehiculo_fk bigint,
    PRIMARY KEY (id_lugar_cliveh),
    FOREIGN KEY (lugar_fk) REFERENCES Lugar(id_lugar),
    FOREIGN KEY (cliente_vehiculo_fk) REFERENCES Cliente_vehiculo(id_cliente_vehiculo)
);

CREATE TABLE Pago
(
    id_pago SERIAL PRIMARY KEY,
    monto MONEY
);

CREATE TABLE Sueldo
(
    id_sueldo SERIAL PRIMARY KEY,
    dinero MONEY
);

CREATE TABLE IF NOT EXISTS Contrato
(
    id_contrato SERIAL PRIMARY KEY,
    fecha TIMESTAMP,
    cliente_vehiculo_fk BIGINT,
    edificio_estacionamiento_fk BIGINT,
    pago_fk SERIAL,
    FOREIGN KEY (cliente_vehiculo_fk) REFERENCES Cliente_vehiculo(id_cliente_vehiculo) ,
    FOREIGN KEY (edificio_estacionamiento_fk) REFERENCES Edificio_estacionamiento(id_edificio_estacionamiento),
    FOREIGN KEY (pago_fk) REFERENCES Pago(id_pago)
);

CREATE TABLE Empleado
(
    id_empleado SERIAL PRIMARY KEY,
    nombre TEXT,
    cargo TEXT,
    sueldo_fk BIGINT,
    comuna_fk BIGINT,
    edificio_estacionamiento_fk BIGINT,
    FOREIGN KEY (sueldo_fk) REFERENCES Sueldo(id_sueldo),
    FOREIGN KEY (comuna_fk) REFERENCES Comuna(id_comuna),
    FOREIGN KEY (edificio_estacionamiento_fk) REFERENCES Edificio_estacionamiento(id_edificio_estacionamiento)
);
