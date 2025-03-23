/**
    * @file FuentesAzules.sql
    * @brief Script de creacion de base de datos para Liga BetPlay Stats
    * @version 1.0
    * @date 2025-03-22
    * @creator Nicolas Bernal y Juan Bogotá
    */

CREATE TABLE Hinchas (
    cedula VARCHAR(20)NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    abonado NUMBER(1) NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL
);

CREATE TABLE Partidos(
    idPartido NUMBER NOT NULL, 
    fecha DATE NOT NULL,
    hora VARCHAR(10) NOT NULL,
    lugar VARCHAR(20) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
    estadio VARCHAR(20) NOT NULL
);

CREATE TABLE PartidosJugadosPorEquipos (
    idPartido NUMBER,
    nombreEquipo VARCHAR2(20)
);

CREATE TABLE Equipos (
    nombre VARCHAR(50) NOT NULL,
    color VARCHAR(50)NOT NULL,
    ciudad VARCHAR(50)NOT NULL,
    estadioLocal VARCHAR(50)NOT NULL,
    posicion INT NOT NULL,
    estado NUMBER(1) NOT NULL,
    presupuesto NUMBER NOT NULL
);

CREATE TABLE Jugadores (
    documento INT NOT NULL,
    nombre VARCHAR(20)NOT NULL,
    posicion VARCHAR(3)NOT NULL,
    estado NUMBER(1) NOT NULL,
    valorMercado NUMBER NOT NULL,
    nombreEquipo VARCHAR(20)NOT NULL  
);

CREATE TABLE Canteranos (
    añosEnCantera INT NOT NULL,
    categoriaFormacion VARCHAR(10) NOT NULL,
    primerContrato DATE NOT NULL,
    documento INT NOT NULL
);

CREATE TABLE Extranjeros (
    documento INT NOT NULL,
    paisOrigen VARCHAR(30)NOT NULL,
    permisoTrabajo NUMBER(1) NOT NULL,
    fechaLlegada DATE NOT NULL
);

CREATE TABLE Representantes(
    documento INT NOT NULL,
    nombre VARCHAR(30)NOT NULL,
    telefono INT NOT NULL,
    experiencia INT NOT NULL,
    documentoJugador INT NOT NULL
);

CREATE TABLE CorreosPorRepresentantes(
    correo VARCHAR(30) NOT NULL,
    documentoRepresentante INT NOT NULL
);

CREATE TABLE Prestamos(
    id INT NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    documentoJugador INT NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL
);

CREATE TABLE Contratos(
    id NUMBER NOT NULL,
    duracion VARCHAR(20) NOT NULL,
    sueldo NUMBER NOT NULL,
    rol VARCHAR(20) NOT NULL,
    bono NUMBER NOT NULL,
    detalle VARCHAR(50) NOT NULL
);

CREATE TABLE Transferencias(
    numero INT NOT NULL,
    valor NUMBER NOT NULL,
    detalle VARCHAR(100) NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL,
    idContrato INT NOT NULL
);

CREATE TABLE Documentaciones(
    id INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    fechaEmision DATE NOT NULL,
    fechaVencimiento DATE NOT NULL,
    autoridadEmisora VARCHAR(50) NOT NULL,
    idContrato NUMBER NOT NULL
);

CREATE TABLE Gerentes(
    documento INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    telefono INT,
    correo VARCHAR(30) NOT NULL,
    experiencia INT NOT NULL,
    nombreEquipo VARCHAR(20) NOT NULL
);

CREATE TABLE CorreosPorGerentes(
    correo VARCHAR(30) NOT NULL,
    documentoGerente INT
);

CREATE TABLE Financieros(
    documento INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    rendimineto INT NOT NULL   
);

CREATE TABLE Deportivos(
    documento INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    rendimineto INT NOT NULL   
);




-- ATRIBUTOS

ALTER TABLE Hinchas 
ADD CONSTRAINT chk_cedula CHECK (LENGTH(cedula) = 10);

ALTER TABLE Partidos 
ADD CONSTRAINT chk_hora CHECK (hora BETWEEN '00:00' AND '23:59');

ALTER TABLE PartidosJugadosPorEquipos 
ADD CONSTRAINT chk_nombreEquipo CHECK (REGEXP_LIKE(nombreEquipo, '^[A-Z][a-z]*$'));

ALTER TABLE Equipos 
ADD CONSTRAINT chk_presupuesto CHECK (presupuesto > 0);

ALTER TABLE Jugadores 
ADD CONSTRAINT chk_valorMercado CHECK (valorMercado > 0);

ALTER TABLE Canteranos 
ADD CONSTRAINT chk_añosEnCantera CHECK (añosEnCantera >= 1);

ALTER TABLE Extranjeros 
ADD CONSTRAINT chk_documento CHECK (LENGTH(documento) = 10);

ALTER TABLE Representantes 
ADD CONSTRAINT chk_experiencia CHECK (experiencia >= 0);

ALTER TABLE CorreosPorRepresentantes 
ADD CONSTRAINT chk_correo CHECK (correo LIKE '%@%');

ALTER TABLE Prestamos 
ADD CONSTRAINT chk_fechaPrestamo CHECK (fechaInicio < fechaFin);

ALTER TABLE Transferencias 
ADD CONSTRAINT chk_valorTransferencia CHECK (valor > 0);

ALTER TABLE Contratos 
ADD CONSTRAINT chk_sueldo CHECK (sueldo > 0);

ALTER TABLE Documentaciones 
ADD CONSTRAINT chk_fechaDoc CHECK (fechaEmision < fechaVencimiento);

ALTER TABLE Gerentes 
ADD CONSTRAINT chk_experienciaGerente CHECK (experiencia >= 0);

ALTER TABLE CorreosPorGerentes 
ADD CONSTRAINT chk_correoGerente CHECK (correo LIKE '%@%');

ALTER TABLE Financieros 
ADD CONSTRAINT chk_rendimientoFinanciero CHECK (rendimineto BETWEEN 0 AND 100);

ALTER TABLE Deportivos 
ADD CONSTRAINT chk_rendimientoDeportivo CHECK (rendimineto BETWEEN 0 AND 100);







-- CLAVES PRIMARIAS

ALTER TABLE Hinchas 
ADD CONSTRAINT pk_Hinchas PRIMARY KEY (cedula);

ALTER TABLE Partidos 
ADD CONSTRAINT pk_Partidos PRIMARY KEY (idPartido);

ALTER TABLE PartidosJugadosPorEquipos 
ADD CONSTRAINT pk_PartidosJugadosPorEquipos PRIMARY KEY (idPartido, nombreEquipo);

ALTER TABLE Equipos 
ADD CONSTRAINT pk_Equipos PRIMARY KEY (nombre);

ALTER TABLE Jugadores 
ADD CONSTRAINT pk_Jugadores PRIMARY KEY (documento);

ALTER TABLE Canteranos 
ADD CONSTRAINT pk_Canteranos PRIMARY KEY (documento);

ALTER TABLE Extranjeros 
ADD CONSTRAINT pk_Extranjeros PRIMARY KEY (documento);

ALTER TABLE Representantes 
ADD CONSTRAINT pk_Representantes PRIMARY KEY (documento);

ALTER TABLE CorreosPorRepresentantes 
ADD CONSTRAINT pk_CorreosPorRepresentantes PRIMARY KEY (correo, documentoRepresentante);

ALTER TABLE Prestamos 
ADD CONSTRAINT pk_Prestamos PRIMARY KEY (id);

ALTER TABLE Transferencias 
ADD CONSTRAINT pk_Transferencias PRIMARY KEY (numero);

ALTER TABLE Contratos 
ADD CONSTRAINT pk_Contratos PRIMARY KEY (id);

ALTER TABLE Documentaciones 
ADD CONSTRAINT pk_Documentaciones PRIMARY KEY (id);

ALTER TABLE Gerentes 
ADD CONSTRAINT pk_Gerentes PRIMARY KEY (documento);

ALTER TABLE CorreosPorGerentes 
ADD CONSTRAINT pk_CorreosPorGerentes PRIMARY KEY (correo, documentoGerente);

ALTER TABLE Financieros 
ADD CONSTRAINT pk_Financieros PRIMARY KEY (documento);

ALTER TABLE Deportivos 
ADD CONSTRAINT pk_Deportivos PRIMARY KEY (documento);





--CLAVES UNICAS

ALTER TABLE Representantes
ADD CONSTRAINT uk_correoR UNIQUE (correo);

ALTER TABLE Gerentes
ADD CONSTRAINT uk_correoR UNIQUE (correo);





-- CLAVES FORANEAS

ALTER TABLE Hinchas 
ADD CONSTRAINT fk_Hinchas_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE PartidosJugadosPorEquipos 
ADD CONSTRAINT fk_PJPE_Partidos 
FOREIGN KEY (idPartido) REFERENCES Partidos(idPartido);

ALTER TABLE PartidosJugadosPorEquipos 
ADD CONSTRAINT fk_PJPE_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Jugadores 
ADD CONSTRAINT fk_Jugadores_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Canteranos 
ADD CONSTRAINT fk_Canteranos_Jugadores 
FOREIGN KEY (documento) REFERENCES Jugadores(documento);

ALTER TABLE Extranjeros 
ADD CONSTRAINT fk_Extranjeros_Jugadores 
FOREIGN KEY (documento) REFERENCES Jugadores(documento);

ALTER TABLE Representantes 
ADD CONSTRAINT fk_Representantes_Jugadores 
FOREIGN KEY (documentoJugador) REFERENCES Jugadores(documento);

ALTER TABLE CorreosPorRepresentantes 
ADD CONSTRAINT fk_CPR_Representantes 
FOREIGN KEY (documentoRepresentante) REFERENCES Representantes(documento);

ALTER TABLE Prestamos 
ADD CONSTRAINT fk_Prestamos_Jugadores 
FOREIGN KEY (documentoJugador) REFERENCES Jugadores(documento);

ALTER TABLE Prestamos 
ADD CONSTRAINT fk_Prestamos_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Transferencias 
ADD CONSTRAINT fk_Transferencias_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE Transferencias 
ADD CONSTRAINT fk_Transferencias_Contratos 
FOREIGN KEY (idContrato) REFERENCES Contratos(id);

ALTER TABLE Documentaciones 
ADD CONSTRAINT fk_Documentaciones_Contratos 
FOREIGN KEY (idContrato) REFERENCES Contratos(id);

ALTER TABLE Gerentes 
ADD CONSTRAINT fk_Gerentes_Equipos 
FOREIGN KEY (nombreEquipo) REFERENCES Equipos(nombre);

ALTER TABLE CorreosPorGerentes 
ADD CONSTRAINT fk_CPG_Gerentes 
FOREIGN KEY (documentoGerente) REFERENCES Gerentes(documento);

ALTER TABLE Financieros 
ADD CONSTRAINT fk_Financieros_Gerentes 
FOREIGN KEY (documento) REFERENCES Gerentes(documento);

ALTER TABLE Deportivos 
ADD CONSTRAINT fk_Deportivos_Gerentes 
FOREIGN KEY (documento) REFERENCES Gerentes(documento);





-- X tablas

DROP TABLE Hinchas;
DROP TABLE Partidos;
DROP TABLE PartidosJugadosPorEquipos;
DROP TABLE Jugadores;
DROP TABLE Equipos;
DROP TABLE Canteranos;
DROP TABLE Extranjeros;
DROP TABLE Representantes;
DROP TABLE CorreosPorRepresentantes;
DROP TABLE Prestamos;
DROP TABLE Transferencias;
DROP TABLE Contratos;
DROP TABLE Documentaciones;
DROP TABLE Gerentes;
DROP TABLE CorreosPorGerentes;
DROP TABLE Financieros;
DROP TABLE Deportivos;





--Consultas

-- Consulta contrato de jugador en temporada de fichajes de verano (junio, julio y agosto)
SELECT * 
FROM Contratos 
WHERE idContrato IN (
    SELECT idContrato 
    FROM Transferencias
) 
AND EXTRACT(MONTH FROM SYSDATE) IN (6, 7, 8);

-- Consultar cuándo juega el equipo
SELECT P.fecha, P.hora 
FROM Partidos P
JOIN PartidosJugadosPorEquipos PJPE ON P.idPartido = PJPE.idPartido
WHERE PJPE.nombreEquipo = 'NombreDelEquipo';

--Consultar el resultado del partido del equipo
SELECT P.idPartido, P.fecha, R.marcadorLocal, R.marcadorVisitante 
FROM Partidos P
JOIN Resultados R ON P.idPartido = R.idPartido
JOIN PartidosJugadosPorEquipos PJPE ON P.idPartido = PJPE.idPartido
WHERE PJPE.nombreEquipo = 'NombreDelEquipo';

--Consultar dónde juega el partido el equipo
SELECT P.fecha, P.lugar, P.estadio 
FROM Partidos P
JOIN PartidosJugadosPorEquipos PJPE ON P.idPartido = PJPE.idPartido
WHERE PJPE.nombreEquipo = 'NombreDelEquipo';

--Consultar gasto en sueldo de jugadores por Temporada (1 año)
SELECT SUM(sueldo) AS gasto_total_sueldos, EXTRACT(YEAR FROM SYSDATE) AS temporada
FROM Contratos;

--Consultar gasto en fichajes por Temporada (1 año)
SELECT SUM(valor) AS gasto_total_fichajes, EXTRACT(YEAR FROM SYSDATE) AS temporada
FROM Transferencias;

--Consulta la mison deportiva del club por Temporada (1 Año)
SELECT detalle AS mision_deportiva, EXTRACT(YEAR FROM SYSDATE) AS temporada
FROM Contratos
WHERE rol = 'Deportivo';






-- 1. PoblarOK: Insertar datos validos

--Hinchas
INSERT INTO Hinchas VALUES ('1234567890', 'Pedro Ramirez', 1, 'Millonarios');

--Partidos
INSERT INTO Partidos VALUES (1, TO_DATE('2025-03-22', 'YYYY-MM-DD'), TO_DATE('18:00', 'HH24:MI'), 'Bogota', 'Bogota', 'El Campin');

--Partido Jugados por equipo
INSERT INTO PartidosJugadosPorEquipos VALUES (1, 'Millonarios');

--Equipos
INSERT INTO Equipos VALUES ('Millonarios', 'Azul', 'Bogota', 'El Campin', 1, 1, 500000);
INSERT INTO Equipos VALUES ('Atletico Nacional', 'Verde', 'Medellin', 'Atanasio Girardot', 20, 1, 500000);
INSERT INTO Equipos VALUES ('Deportivo Cali', 'Verde', 'Cali', 'Palmaseca', 4, 1, 4500000);
INSERT INTO Equipos VALUES ('America de Cali', 'Rojo', 'Cali', 'Pascual Guerrero', 2, 1, 4300000);
INSERT INTO Equipos VALUES ('Junior', 'Rojo y Blanco', 'Barranquilla', 'Metropolitano', 5, 1, 4200000);
INSERT INTO Equipos VALUES ('Santa Fe', 'Rojo', 'Bogota', 'El Campin', 6, 1, 4100000);
INSERT INTO Equipos VALUES ('Once Caldas', 'Blanco', 'Manizales', 'Palogrande', 7, 1, 4000000);
INSERT INTO Equipos VALUES ('Ind Medellin', 'Rojo y Azul', 'Medellin', 'Atanasio Girardot', 8, 1, 3900000);
INSERT INTO Equipos VALUES ('Tolima', 'Vinotinto y Oro', 'Ibague', 'Manuel Murillo Toro', 9, 1, 3800000);
INSERT INTO Equipos VALUES ('La Equidad', 'Verde', 'Bogota', 'Metropolitano de Techo', 10, 1, 3700000);
INSERT INTO Equipos VALUES ('Pereira', 'Amarillo y Rojo', 'Pereira', 'Hernan Ramirez Villegas', 11, 1, 3600000);
INSERT INTO Equipos VALUES ('Bucaramanga', 'Amarillo', 'Bucaramanga', 'Alfonso Lopez', 12, 1, 3500000);
INSERT INTO Equipos VALUES('Pasto', 'Rojo y Azul', 'Pasto', 'Departamental Libertad', 13, 1, 3400000);
INSERT INTO Equipos VALUES('Envigado', 'Naranja', 'Envigado', 'Polideportivo Sur', 14, 1, 3300000);
INSERT INTO Equipos VALUES('Union magdalena', 'Azul y Rojo', 'Santa Marta', 'Metropolitano Roberto Melendez', 15, 1, 3200000);
INSERT INTO Equipos VALUES('Chico', 'Azul y Blanco', 'Tunja', 'La Independencia', 16, 1, 3100000);
INSERT INTO Equipos VALUES('Alianza FC', 'Celeste y Blanco', 'Valledupar', 'Maestre Pavajeu', 17, 1, 3000000);
INSERT INTO Equipos VALUES('Fortaleza', 'Azul', 'Bogota', 'Metropolitano de Techo', 18, 1, 2900000);
INSERT INTO Equipos VALUES('Llaneros', 'Negro y Blanco', 'Villavicencio', 'Bello Horizonte-Rey Pele', 19, 1, 2800000);
INSERT INTO Equipos VALUES('Aguilas Doradas', 'Dorado y Negro', 'Rio Negro','Alberto Grisales', 3, 1, 2700000);

--SELECT * FROM Equipos ORDER BY Posicion ASC;

--Jugadores
INSERT INTO Jugadores VALUES (1010000001, 'Juan Perez', 'DEL', 1, 1000000, 'Millonarios');

--Canteranos
INSERT INTO Canteranos VALUES (5, 'Juvenil', TO_DATE('2024-02-10', 'YYYY-MM-DD'), 1010000001);

--Extranjeros
INSERT INTO Extranjeros VALUES (1010000001, 'Argentina', 1, TO_DATE('2024-02-10', 'YYYY-MM-DD'));

--Representantes
INSERT INTO Representantes VALUES (4010000001, 'Luis Martinez', 1021930123, 1010000001);

--Correos Por Representantes
INSERT INTO CorreosPorRepresentantes VALUES ('luis.martinez@representantes.com', 4010000001);

--Prestamos
INSERT INTO Prestamos VALUES (501, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2026-06-01', 'YYYY-MM-DD'), 1010000001, 'Millonarios');

--Contratos
INSERT INTO Contratos VALUES (701,'2 años', 50000, 'Importante', 0.5, 'Contrato de Juan Perez');

--Tranferencias
INSERT INTO Transferencias VALUES (601, 1231, 'Comprado', 'Millonarios', 701);

--Documentaciones
INSERT INTO Documentaciones VALUES (801, 'Pasaporte', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2028-05-10', 'YYYY-MM-DD'), 'Gobierno de Colombia', 701);

--Gerentes
INSERT INTO Gerentes VALUES (901000000, 'Roberto Gomez', 1021930123, 'nicolas@bernal.com', 10, 'Millonarios');
INSERT INTO Gerentes VALUES (234424242, 'Fernando Lopez', 1021930193, 'nicolas@bernal.com', 10, 'Millonarios');

--Correos por gerente
INSERT INTO CorreosPorGerentes VALUES ('roberto.gomez@millonarios.com', 901000000);

--Financieros
INSERT INTO Financieros VALUES (901000000, 'Roberto Gomez', 10);

-- Deportivos
INSERT INTO Deportivos VALUES (234424242, 'Fernando Lopez', 10);







-- 2. PoblarNoOK: Insertar datos invalidos

-- Hinchas con cedula duplicada
INSERT INTO Hinchas VALUES ('1234567890', 'Carlos Martinez', 0, 'Santa Fe'); -- Error: cedula ya existe

-- Partidos con fecha invalida
INSERT INTO Partidos VALUES (2, '2025-02-30', TO_DATE('25:00', 'HH24:MI'), 'Medellin', 'Medellin', 'Atanasio Girardot'); -- Error: Fecha y hora invalidas

-- Partido Jugados por equipo sin partido existente
INSERT INTO PartidosJugadosPorEquipos VALUES (999, 'Millonarios'); -- Error: ID de partido no existe

-- Equipos con clave duplicada
INSERT INTO Equipos VALUES ('Millonarios', 'Rojo', 'Bogota', 'El Campin', 2, 1, 600000); -- Error: nombre ya existe

-- Jugadores sin equipo existente
INSERT INTO Jugadores VALUES (1010000002, 'Carlos Lopez', 'DEF', 1, 800000, 'EquipoInexistente'); -- Error: Equipo no existe

-- Canteranos con documento repetido
INSERT INTO Canteranos VALUES (5, 'Juvenil', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1010000002); -- Error: documento ya existe

-- Extranjeros con nacionalidad vacia
INSERT INTO Extranjeros VALUES (1010000002, '', 1, TO_DATE('2024-02-10', 'YYYY-MM-DD')); -- Error: Pais de origen no puede ser vacio

-- Representantes con ID duplicado
INSERT INTO Representantes VALUES (4010000001, 'Carlos Ramirez', 1021930456, 1010000003); -- Error: ID ya existe

-- Correos Por Representantes con ID de representante inexistente
INSERT INTO CorreosPorRepresentantes VALUES ('carlos.ramirez@representantes.com', 999999); -- Error: Representante no existe

-- Prestamos con fecha erronea
INSERT INTO Prestamos VALUES (502, TO_DATE('2026-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 1010000001, 'Millonarios'); -- Error: Fecha de inicio mayor a la de fin

-- Transferencias con valor negativo
INSERT INTO Transferencias VALUES (602, 1010000001, 'Millonarios', 'Junior', -1000000); -- Error: Valor no puede ser negativo

-- Contratos con duracion invalida
INSERT INTO Contratos VALUES (702, '5 años', -50000, 'Regular', 0.3, 'Contrato invalido'); -- Error: Salario no puede ser negativo

-- Documentaciones con fecha erronea
INSERT INTO Documentaciones VALUES (802, 'Pasaporte', TO_DATE('2028-05-10', 'YYYY-MM-DD'), TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Gobierno', 701); -- Error: Fecha de expiracion antes de expedicion

-- Gerentes con ID duplicado
INSERT INTO Gerentes VALUES (901000000, 'Luis Torres', 1021930999, 'luis.torres@club.com', 15, 'Junior'); -- Error: ID ya existe

-- Correos por gerente con ID inexistente
INSERT INTO CorreosPorGerentes VALUES ('fernando.lopez@club.com', 999999); -- Error: ID de gerente no existe

-- Financieros con ID de equipo inexistente
INSERT INTO Financieros VALUES (901000001, 'Ana Ruiz', 999); -- Error: Equipo no existe

-- Deportivos con ID de equipo inexistente
INSERT INTO Deportivos VALUES (234424243, 'Javier Mendoza', 999); -- Error: Equipo no existe






-- xPoblar

DELETE FROM Hinchas;
DELETE FROM Jugadores;
DELETE FROM Partidos;
DELETE FROM PartidosJugadosPorEquipos;
DELETE FROM Equipos;
DELETE FROM Canteranos;
DELETE FROM Extranjeros;
DELETE FROM Representantes;
DELETE FROM CorreosPorRepresentantes;
DELETE FROM Prestamos;
DELETE FROM Transferencias;
DELETE FROM Contratos;
DELETE FROM Documentaciones;
DELETE FROM Gerentes;
DELETE FROM CorreosPorGerentes;
DELETE FROM Financieros;
DELETE FROM Deportivos;