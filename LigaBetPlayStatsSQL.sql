CREATE TABLE Hinchas (
    cedula VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    abonado BOOLEAN NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL,
    FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre)
);

CREATE TABLE Partidos(
    idPartido NUMBER PRIMARY KEY, 
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    lugar VARCHAR(20) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
    estadio VARCHAR(20) NOT NULL
    );

CREATE TABLE PartidosJugadosPorEquipos (
    idPartido NUMBER,
    nombreEquipo VARCHAR2(20),
    PRIMARY KEY (idPartido, nombreEquipo),
    FOREIGN KEY (idPartido) REFERENCES Partidos(idPartido),
    FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre)
);

CREATE TABLE Equipos (
    nombre VARCHAR(10) PRIMARY KEY,
    color VARCHAR(15)NOT NULL,
    ciudad VARCHAR(20)NOT NULL,
    estadioLocal VARCHAR(20)NOT NULL,
    posicion INT NOT NULL,
    estado BOOLEAN NOT NULL,
    presupuesto NUMBER NOT NULL
);

CREATE TABLE Jugadores (
    documento INT PRIMARY KEY,
    nombre VARCHAR(20)NOT NULL,
    posicion VARCHAR(3)NOT NULL,
    estado BOOLEAN NOT NULL,
    valorMercado NUMBER NOT NULL,
    nombreEquipo VARCHAR(20)NOT NULL,
    FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre)
);

CREATE TABLE Canteranos (
    documento INT PRIMARY KEY,
    aniosEnCantera INT NOT NULL,
    categoriaFormacion VARCHAR(10)NOT NULL,
    primerContrato DATE NOT NULL,
    FOREIGN KEY (documento) REFERENCES Jugadores(documento)
);

CREATE TABLE Extranjeros (
    documento INT PRIMARY KEY,
    paisOrigen VARCHAR(30)NOT NULL,
    permisoTrabajo BOOLEAN NOT NULL,
    fechaLlegada DATE NOT NULL,
    FOREIGN KEY (documento) REFERENCES Jugadores(documento)
);

CREATE TABLE Representantes(
    documento INT PRIMARY KEY,
    nombre VARCHAR(30)NOT NULL,
    telefono INT NOT NULL,
    experiencia INT NOT NULL,
    FOREIGN KEY (documento) REFERENCES Jugadores(documento)
);

CREATE TABLE CorreosPorRepresentantes(
    correo VARCHAR(30) UNIQUE,
    documentoRepresentante INT,
    PRIMARY KEY (correo, documentoRepresentante),
    FOREIGN KEY (documentoRepresentante) REFERENCES Representantes(documento)
);

CREATE TABLE Prestamos(
    id INT PRIMARY KEY,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    documentoJugador INT NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL,
    FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre),
    FOREIGN KEY (documentoJugador) REFERENCES Jugadores(documento)
);

CREATE TABLE Transferencias(
    numero INT PRIMARY KEY,
    valor NUMBER NOT NULL,
    detalle VARCHAR(100) NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL,
    idContrato INT NOT NULL,
    FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre),
    FOREIGN KEY (idContrato) REFERENCES Contratos(idContrato)
);

CREATE TABLE Contratos(
    idContrato NUMBER PRIMARY KEY,
    duracion VARCHAR(20) NOT NULL,
    sueldo NUMBER NOT NULL,
    rol VARCHAR(20) NOT NULL,
    bono NUMBER NOT NULL,
    detalle VARCHAR(50) NOT NULL
);

CREATE TABLE Documentaciones(
    id INT PRIMARY KEY,
    tipo VARCHAR(30) NOT NULL,
    fechaEmision DATE NOT NULL,
    fechaVencimiento DATE NOT NULL,
    autoridadEmisora VARCHAR(50) NOT NULL,
    idContrato NUMBER NOT NULL,
    FOREIGN KEY (idContrato) REFERENCES Contratos(idContrato)
);

CREATE TABLE Gerentes(
    documento INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    telefono INT,
    correo VARCHAR(30) NOT NULL,
    experiencia INT NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL,
    FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre)
);

CREATE TABLE CorreosPorGerentes(
    correo VARCHAR(30) UNIQUE,
    documentoGerente INT,
    PRIMARY KEY (correo, documentoGerente),
    FOREIGN KEY (documentoGerente) REFERENCES Gerentes(documento)
);

CREATE TABLE Financieros(
    documento INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    rendimineto INT NOT NULL,
    FOREIGN KEY (documento) REFERENCES Gerentes(documento)
);

CREATE TABLE Deportivos(
    documento INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    rendimineto INT NOT NULL,
    FOREIGN KEY (documento) REFERENCES Gerentes(documento)
);





-- Insertar en Equipos
INSERT INTO Equipos (nombre, color, ciudad, estadioLocal, posicion, estado, presupuesto)
VALUES ('Millonarios', 'Azul', 'Bogotá', 'El Campín', 1, TRUE, 5000000);

-- Insertar en Hinchas
INSERT INTO Hinchas (cedula, nombre, abonado, nombreEquipo)
VALUES ('123456789', 'Carlos Pérez', TRUE, 'Millonarios');

-- Insertar en Partidos
INSERT INTO Partidos (idPartido, fecha, hora, lugar, ciudad, estadio)
VALUES (1, TO_DATE('2025-03-22', 'YYYY-MM-DD'), TO_DATE('20:30', 'HH24:MI'), 'Bogotá', 'Bogotá', 'El Campín');

-- Insertar en PartidosJugadosPorEquipos
INSERT INTO PartidosJugadosPorEquipos (idPartido, nombreEquipo)
VALUES (1, 'Millonarios');

-- Insertar en Jugadores
INSERT INTO Jugadores (documento, nombre, posicion, estado, valorMercado, nombreEquipo)
VALUES (1000183491, 'Juan Bogotá', 'MCO', TRUE, 100000000, 'Millonarios');

-- Insertar en Canteranos
INSERT INTO Canteranos (documento, aniosEnCantera, categoriaFormacion, primerContrato)
VALUES (1000183491, 5, 'Juvenil', TO_DATE('2020-01-10', 'YYYY-MM-DD'));

-- Insertar en Extranjeros
INSERT INTO Extranjeros (documento, paisOrigen, permisoTrabajo, fechaLlegada)
VALUES (1000183492, 'Argentina', TRUE, TO_DATE('2024-02-15', 'YYYY-MM-DD'));

-- Insertar en Representantes
INSERT INTO Representantes (documento, nombre, telefono, experiencia)
VALUES (1000183491, 'Luis Gómez', 3204567890, 10);

-- Insertar en CorreosPorRepresentantes
INSERT INTO CorreosPorRepresentantes (correo, documentoRepresentante)
VALUES ('luisgomez@email.com', 1000183491);

-- Insertar en Prestamos
INSERT INTO Prestamos (id, fechaInicio, fechaFin, documentoJugador, nombreEquipo)
VALUES (1, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 1000183491, 'Millonarios');

-- Insertar en Contratos
INSERT INTO Contratos (idContrato, duracion, sueldo, rol, bono, detalle)
VALUES (1, '2 años', 30000000, 'Titular', 5000000, 'Contrato estándar');

-- Insertar en Transferencias
INSERT INTO Transferencias (numero, valor, detalle, nombreEquipo, idContrato)
VALUES (1, 200000000, 'Venta de jugador', 'Millonarios', 1);

-- Insertar en Documentaciones
INSERT INTO Documentaciones (id, tipo, fechaEmision, fechaVencimiento, autoridadEmisora, idContrato)
VALUES (1, 'Pasaporte', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2033-01-01', 'YYYY-MM-DD'), 'Migración Colombia', 1);

-- Insertar en Gerentes
INSERT INTO Gerentes (documento, nombre, telefono, correo, experiencia, nombreEquipo)
VALUES (1000456789, 'José Martínez', 3112345678, 'josemartinez@email.com', 15, 'Millonarios');

-- Insertar en CorreosPorGerentes
INSERT INTO CorreosPorGerentes (correo, documentoGerente)
VALUES ('josemartinez@email.com', 1000456789);

-- Insertar en Financieros
INSERT INTO Financieros (documento, nombre, rendimineto)
VALUES (1000456789, 'José Martínez', 90);

-- Insertar en Deportivos
INSERT INTO Deportivos (documento, nombre, rendimineto)
VALUES (1000456789, 'José Martínez', 85);







