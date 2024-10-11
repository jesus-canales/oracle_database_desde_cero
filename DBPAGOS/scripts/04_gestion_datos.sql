/* -----------------------------------------------------------------
 TEMA      : Gestión de Datos
 PROFESOR  : Jesús Canales Guando
 CURSO     : Base de Datos 3 
*/ -----------------------------------------------------------------

-- <> Permitir ejecución de script
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- Crear un Tablespace
CREATE TABLESPACE TBS_DATASOFT
DATAFILE '/opt/oracle/oradata/xe/datasoft_oficial.dbf' 
SIZE 100M;

-- Crear un nuevo usuario
CREATE USER datasoft 
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- Asignar todos los permisos a DATASOFT
GRANT CREATE SESSION TO datasoft;
GRANT CREATE TABLE TO datasoft;
GRANT CREATE VIEW TO datasoft;
GRANT CREATE PROCEDURE TO datasoft;
GRANT CREATE TRIGGER TO datasoft;
GRANT CREATE SEQUENCE TO datasoft;
GRANT CREATE JOB TO datasoft;
GRANT UNLIMITED TABLESPACE TO datasoft;
GRANT CREATE PUBLIC SYNONYM TO datasoft;
GRANT SELECT ON ALL_SYNONYMS TO datasoft;

-- Creamos usuario developer_01 dentro de TBS_DATASOFT
CREATE USER developer_01
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- Asignamos todos los permisos
GRANT CREATE SESSION TO developer_01;
GRANT CREATE TABLE TO developer_01;
GRANT CREATE VIEW TO developer_01;
GRANT CREATE PROCEDURE TO developer_01;
GRANT CREATE TRIGGER TO developer_01;
GRANT CREATE SEQUENCE TO developer_01;
GRANT CREATE JOB TO developer_01;
GRANT UNLIMITED TABLESPACE TO developer_01;
GRANT CREATE PUBLIC SYNONYM TO developer_01;
GRANT SELECT ON ALL_SYNONYMS TO developer_01;

-- Creamos usuario developer_02 dentro de TBS_DATASOFT
CREATE USER developer_02
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- Asignamos todos los permisos
GRANT CREATE SESSION TO developer_02;
GRANT CREATE TABLE TO developer_02;
GRANT CREATE VIEW TO developer_02;
GRANT CREATE PROCEDURE TO developer_02;
GRANT CREATE TRIGGER TO developer_02;
GRANT CREATE SEQUENCE TO developer_02;
GRANT CREATE JOB TO developer_02;
GRANT UNLIMITED TABLESPACE TO developer_02;
GRANT CREATE PUBLIC SYNONYM TO developer_02;
GRANT SELECT ON ALL_SYNONYMS TO developer_02;

-- Crear tabla Person desde DEVELOPER_01
CREATE TABLE developer_01.persona
(
    identificador integer generated always as identity (start with 101 increment by 1 cache 10),
    fecha_registro timestamp default systimestamp,
    nombres varchar2(70) not null,
    apellidos varchar2(120) not null,
    fecha_nacimiento date not null,
    tipo_documento char(3) not null,
    numero_documento varchar2(20) not null,
    correo_electronico varchar2(100),
    celular char(9),
    usuario varchar2(20),
    contrasena varchar2(20),
    rol char(3),
    estado char(1) default ('A'),
    CONSTRAINT pk_persona PRIMARY KEY (identificador),
    CONSTRAINT chk_nombre_persona CHECK (REGEXP_LIKE(nombres, '^[A-Za-zÁÉÍÓÚÑáéíóúñ[:space:]-]+$')),
    CONSTRAINT chk_apellidos CHECK (REGEXP_LIKE(apellidos, '^[A-Za-zÁÉÍÓÚÑáéíóúñ[:space:]-]+$')),
    CONSTRAINT chk_tipo_documento CHECK(tipo_documento IN ('DNI', 'CNE')),
    CONSTRAINT chk_numero_documento CHECK(REGEXP_LIKE(numero_documento, '^[0-9]{8,20}$')),
    CONSTRAINT chk_correo_electronico CHECK(REGEXP_LIKE(correo_electronico, '^[A-Za-z0-9._+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
    CONSTRAINT chk_celular CHECK(REGEXP_LIKE(celular, '^9[0-9]{8}$')),
    CONSTRAINT chk_usuario CHECK(REGEXP_LIKE(usuario, '^[a-z]{8,20}$')),
    CONSTRAINT chk_contrasena CHECK(REGEXP_LIKE(contrasena, '^[A-Za-z0-9]{8,20}$')),
    CONSTRAINT chk_rol CHECK(rol IN ('EST', 'TES'))
);

-- Crear tabla Inscripción desde el usuario developer_01
CREATE TABLE developer_01.inscripcion
(
    identificador integer generated always as identity,
    fecha_inscripcion timestamp default systimestamp,
    carrera_identificador char(3) not null,
    persona_identificador integer not null, 
    ciclo_identificador integer not null,
    estado char(1) default ('A'),
    CONSTRAINT pk_inscripcion PRIMARY KEY (identificador)
);

-- Crear tabla Carrera desde el usuario datasoft
CREATE TABLE datasoft.carrera
(
    identificador char(3),
    fecha_registro timestamp default systimestamp,
    nombre varchar2(100) not null,
    descripcion varchar2(400),
    estado char(1) default ('A'),
    CONSTRAINT pk_carrera PRIMARY KEY (identificador),
    CONSTRAINT chk_identificador CHECK(REGEXP_LIKE(identificador, '^[A-Z]{3}$')),
    CONSTRAINT chk_nombre_carrera CHECK (REGEXP_LIKE(nombre, '^[A-Za-zÁÉÍÓÚÑáéíóúñ .\-]+$'))
);

-- Crear tabla Ciclo desde el usuario datasoft
CREATE TABLE datasoft.ciclo
(
    identificador integer generated always as identity,
    nombre char(6) not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    CONSTRAINT pk_ciclo PRIMARY KEY (identificador)
);

-- Crear tabla Pago desde el usuario developer_02
CREATE TABLE developer_02.pago
(
    identificador integer generated always as identity,
    identificador_inscripcion integer,
    fecha_pago timestamp  default systimestamp,
    forma_pago char(1) not null,
    estado char(1) default 'A',
    CONSTRAINT pk_pago PRIMARY KEY (identificador),
    CONSTRAINT chk_forma_pago CHECK(forma_pago IN ('E', 'T', 'Y'))
);

-- Crear tabla Detalle de Pago
CREATE TABLE developer_02.pago_detalle
(
    identificador integer generated always as identity,
    pago_identificador integer not null,
    concepto varchar2(3),
    descripcion VARCHAR2(300),
    monto number(6,2),
    CONSTRAINT pk_pago_detalle PRIMARY KEY(identificador)    
);

-- Developer_01 sede permisos a datasoft y developer_02 sobre la tabla persona
GRANT ALL ON developer_01.persona
TO datasoft, developer_02;

-- Developer_01 sede permisos a developer_02 sobre la tabla inscripcion
GRANT ALL ON developer_01.inscripcion
TO developer_02;

-- Developer_02 sede permisos a datasoft sobre la tabla pago 
GRANT ALL ON developer_02.pago
TO datasoft;

-- Developer_02 sede permisos a datasoft sobre la tabla pago 
GRANT ALL ON developer_02.pago_detalle
TO datasoft;

-- Datasoft sede permisos a developer_01 y developer_02 sobre tabla carrera
GRANT ALL ON DATASOFT.carrera
TO developer_01, developer_02;

-- Datasoft sede permisos a developer_01 y developer_02 sobre tabla ciclo
GRANT ALL ON DATASOFT.ciclo
TO developer_01, developer_02;

-- Desde Developer_01 relacionar tablas persona con inscripcion
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_persona_inscripcion 
FOREIGN KEY (persona_identificador)
REFERENCES developer_01.persona(identificador);

-- Desde Developer_02 relacionar tablas persona con inscripcion
ALTER TABLE DEVELOPER_02.pago_detalle
ADD CONSTRAINT fk_pago_pago_detalle
FOREIGN KEY (pago_identificador)
REFERENCES DEVELOPER_02.pago(identificador);

-- Desde Developer_02 relacionar tabla inscripción con pago
ALTER TABLE developer_02.pago
ADD CONSTRAINT fk_inscripcion_pago
FOREIGN KEY (IDENTIFICADOR_INSCRIPCION)
REFERENCES DEVELOPER_01.inscripcion(IDENTIFICADOR);

-- Desde Developer_01 relacionar las tablas Carrera - Inscripcion
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_carrera_inscripcion
FOREIGN KEY (CARRERA_IDENTIFICADOR)
REFERENCES DATASOFT.carrera(identificador);

-- Desde developer_01 relacionamos las tablas Ciclo - Inscripcion
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_ciclo_inscripcion
FOREIGN KEY (CICLO_IDENTIFICADOR)
REFERENCES DATASOFT.ciclo(identificador);

------------------------------------------------------------------

-- -<> GESTIÓN DE REGISTROS

-- ## Inserción de registros
-- Verificar la estructura de las tablas que hemos creado
DESC developer_01.inscripcion;
DESC developer_02.pago;
DESC developer_02.pago_detalle;


-- <> DATASOFT -> carrera
-- INSERCIÓN de registros en la tabla Carrera del usuario Datasoft
-- VERIFICAR la estructura de la tabla Carrera del usuario Datasoft
DESC datasoft.carrera;
-- --- Desde el usuario DATASOFT crear la tabla carrera
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
INSERT ALL 
    INTO datasoft.carrera(identificador, nombre, descripcion) 
    VALUES ('ASE', 'Análisis de Sistemas Empresariales', 'Profesionales innovadores en tecnología')
    INTO datasoft.carrera (identificador, nombre, descripcion)
    VALUES ('GAG', 'Gestión Agrícola', 'Profesionales para innovar la agricultura')
    INTO datasoft.carrera (identificador, nombre, descripcion)
    VALUES ('ADS', 'Análisis de Sistemas', 'Formamos programadores de software')
    INTO datasoft.carrera (identificador, nombre, descripcion)
    VALUES ('PAG', 'Producción Agraria', 'Formamos profesionales de la agricultura')
SELECT * FROM dual;
COMMIT;
-- LISTAR los registros de la tabla Carrera del usuario Datasoft
SELECT * FROM datasoft.carrera;

-- <> DATASOFT -> ciclo
-- INSERCIÓN de registros en la tabla ciclo del usuario Datasoft
-- VERIFICAR la estructura de la tabla ciclo del usuario Datasoft
DESC datasoft.ciclo;
-- --- Desde el usuario DATASOFT crear la tabla ciclo
-- La inserción debe ser individual ya que hay un campo auto incrementable
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('AS2215', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('AS2224', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('AS2313', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('AS2322', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('AS2411', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('AS2126', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('PA2126', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('PA2411', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('PA2322', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('PA2313', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('PA2215', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
INSERT INTO datasoft.ciclo (nombre, fecha_inicio, fecha_fin)
VALUES ('PA2224', TO_DATE('01/03/2024', 'DD/MM/YYYY'), TO_DATE('30/07/2024', 'DD/MM/YYYY'));
COMMIT;
-- LISTAR registros de la tabla Ciclo
SELECT * FROM DATASOFT.ciclo;

-- <> DEVELOPER_01 -> persona
-- INSERCIÓN de registros en la tabla persona del usuario developer_01
-- VERIFICAR la estructura de la tabla persona del usuario developer_01
DESC DEVELOPER_01.persona;
-- La inserción debe ser individual ya que hay un campo auto incrementable
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Marcos Abel', 'Campos Valle', TO_DATE('01/02/2007', 'DD/MM/YYYY'), 'DNI', '12523698', 'marcos_10@yahoo.com', '921527721', 'marcoscampos', '11marcVAalle23', 'EST' );
COMMIT;    
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Pedro', 'Gomez Martinez', TO_DATE('15/07/2004', 'DD/MM/YYYY'), 'DNI', '12345678', 'pedrogomez@gmail.com', '912345678', 'pedrogomez', 'Pedro12Pal', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Camila', 'Villa Oré', TO_DATE('20/05/2005', 'DD/MM/YYYY'), 'DNI', '15451236', 'camila@gmail.com', 921526621, 'camilavilla', 'CaMiAAORE20', 'EST' );
COMMIT;    
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Rodrigo', 'Reyes Vila', TO_DATE('11/08/2003', 'DD/MM/YYYY'), 'CNE', '15744512368541369741', 'rodrigroreyes@outlook.com', 952364179, 'rodrigoreyes', 'RoRe22pp', 'EST' );
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Abel', 'Vásquez Iriarte', TO_DATE('25/11/2004', 'DD/MM/YYYY'), 'CNE', '15744514136941369741', 'abelvasquez@outlook.com', 952388179, 'abelvasquez', '18Abel123', 'EST' );
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Zoila', 'Mantilla Barrios', TO_DATE('30/12/2005', 'DD/MM/YYYY'), 'DNI', '20255433', 'zoilamantilla@yahoo.com', 985143881, 'zoilamantilla', 'Zoila25Mantilla', 'EST' );
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Carolina', 'Vásquez Iriarte', TO_DATE('25/11/2004', 'DD/MM/YYYY'), 'CNE', '15744514136941369741', 'abelvasquez@outlook.com', 952388179, 'abelvasquez', 'Abel23vasQ', 'EST' );    
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Lucía', 'Martínez Álvarez', TO_DATE('12/05/2004', 'DD/MM/YYYY'), 'DNI', '20451238', 'lucia.martinez@gmail.com', 921537821, 'luciamartinez', 'Lucia123', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Juan', 'Pérez López', TO_DATE('25/09/2005', 'DD/MM/YYYY'), 'DNI', '20451239', 'juan.perez@gmail.com', 922562134, 'juanperez', 'JuanPerez12', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Ana', 'García Sánchez', TO_DATE('11/07/2003', 'DD/MM/YYYY'), 'CNE', '12345678901234567890', 'ana.garcia@outlook.com', 925478123, 'anagarcia', 'AnaG156GR', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Carlos', 'Rodríguez Fernández', TO_DATE('10/02/2004', 'DD/MM/YYYY'), 'DNI', '20451240', 'carlos.rodriguez@yahoo.com', 926583921, 'carlosrodriguez', 'Carlos12345', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('María', 'López Gómez', TO_DATE('20/12/2004', 'DD/MM/YYYY'), 'CNE', '12345678901234567891', 'maria.lopez@gmail.com', 927492134, 'marialopez', 'MarLopez12', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Sofía', 'Méndez Paredes', TO_DATE('16/08/2005', 'DD/MM/YYYY'), 'DNI', '20451241', 'sofia.mendez@gmail.com', 928593847, 'sofiamendez', 'SofiaMen12', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Diego', 'Vega Hernández', TO_DATE('04/10/2004', 'DD/MM/YYYY'), 'CNE', '12345678901234567892', 'diego.vega@outlook.com', 929637182, 'diegovega', 'Diego12VG', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Laura', 'Ruiz Martínez', TO_DATE('29/03/2003', 'DD/MM/YYYY'), 'DNI', '20451242', 'laura.ruiz@gmail.com', 930751289, 'lauraruiz', 'LauraRM123', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Pablo', 'Ramos Díaz', TO_DATE('02/06/2004', 'DD/MM/YYYY'), 'DNI', '20451243', 'pablo.ramos@gmail.com', 931863794, 'pabloramos', 'Pabl0Ramos1', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Claudia', 'Hernández Torres', TO_DATE('09/11/2005', 'DD/MM/YYYY'), 'CNE', '12345678901234567893', 'claudia.hernandez@outlook.com', 932975817, 'claudiahernandez', 'ClaudHern1', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Javier', 'Morales Cruz', TO_DATE('17/07/2003', 'DD/MM/YYYY'), 'DNI', '20451244', 'javier.morales@gmail.com', 933086921, 'javiermorales', 'JavierMC123', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Elena', 'Ortiz Gutiérrez', TO_DATE('13/03/2004', 'DD/MM/YYYY'), 'CNE', '12345678901234567894', 'elena.ortiz@outlook.com', 934291874, 'elenaortiz', 'ElenaOrtiZ9', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Mateo', 'Navarro Silva', TO_DATE('21/01/2005', 'DD/MM/YYYY'), 'DNI', '20451245', 'mateo.navarro@gmail.com', 935372189, 'mateonavarro', 'MateoN123', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Luciana', 'Cruz Romero', TO_DATE('05/09/2003', 'DD/MM/YYYY'), 'DNI', '20451246', 'luciana.cruz@gmail.com', 936418572, 'lucianacruz', 'Luci123CRUZ', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Pedro', 'Flores Ramírez', TO_DATE('14/04/2004', 'DD/MM/YYYY'), 'CNE', '12345678901234567895', 'pedro.flores@outlook.com', 937538719, 'pedroflores', 'PedroFlor79', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Julia', 'Blanco Ruiz', TO_DATE('26/05/2005', 'DD/MM/YYYY'), 'DNI', '20451247', 'julia.blanco@gmail.com', 938627483, 'juliablanco', 'JuliaBRu11z', 'EST');
COMMIT;
INSERT INTO DEVELOPER_01.persona
    (nombres, apellidos, fecha_nacimiento, tipo_documento, numero_documento, correo_electronico, celular, usuario, contrasena, rol)
VALUES 
    ('Raúl', 'Lara Jiménez', TO_DATE('11/12/2003', 'DD/MM/YYYY'), 'DNI', '20451248', 'raul.lara@gmail.com', 939762518, 'raullara', 'RaulLara12', 'EST');
COMMIT;
-- LISTAR registros de la tabla persona
SELECT * FROM developer_01.persona;

-- <> DEVELOPER_01 -> inscripcion
-- INSERCIÓN de registros en la tabla inscripcion del usuario developer_01
-- VERIFICAR la estructura de la tabla inscripcion del usuario developer_01
DESC DEVELOPER_01.inscripcion;
SELECT * FROM DATASOFT.carrera;
SELECT * FROM DATASOFT.ciclo;
SELECT * FROM DEVELOPER_01.persona;
-- La inserción debe ser individual ya que hay un campo auto incrementable
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('101', 'ASE', '1');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('102', 'ASE', '1');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('103', 'ASE', '2');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('104', 'ASE', '2');
COMMIT;  
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('105', 'ASE', '3');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('106', 'ASE', '3');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('107', 'GAG', '4');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('108', 'GAG', '4');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('109', 'GAG', '5');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('110', 'GAG', '5');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('111', 'GAG', '6');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('112', 'GAG', '6');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('113', 'ADS', '7');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('114', 'ADS', '7');
COMMIT;  
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('115', 'ADS', '8');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('116', 'ADS', '8');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('117', 'ADS', '9');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('118', 'ADS', '9');
COMMIT;  
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('119', 'PAG', '10');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('120', 'PAG', '10');
COMMIT;  
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('121', 'PAG', '11');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('122', 'PAG', '11');
COMMIT;  
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('123', 'PAG', '12');
COMMIT;
INSERT INTO DEVELOPER_01.inscripcion
    (persona_identificador, carrera_identificador, ciclo_identificador)
VALUES 
    ('124', 'PAG', '12');
COMMIT;  
-- Listar los registros de la tabla inscripcion
SELECT * FROM developer_01.inscripcion;


-- <> DEVELOPER_02 -> pago | pago_detalle
-- INSERCIÓN de registros en la tabla pago del usuario developer_02
-- VERIFICAR la estructura de la tabla pago del usuario developer_02
DESC DEVELOPER_02.pago;
DESC DEVELOPER_02.pago_detalle;
SELECT * FROM developer_01.inscripcion;
-- La inserción debe ser individual ya que hay un campo auto incrementable
-- E = Efectivo | T = Transferencia | Y = Yape
-- Trigger para asignar el valor a 'monto' basado en 'concepto'
CREATE TRIGGER developer_02.trg_set_monto
BEFORE INSERT ON developer_02.pago_detalle
FOR EACH ROW
BEGIN
    IF :NEW.concepto = 'MAT' THEN
        :NEW.monto := 150;
    ELSIF :NEW.concepto = 'ME1' OR :NEW.concepto = 'ME2' OR :NEW.concepto = 'ME3' OR :NEW.concepto = 'ME4' OR :NEW.concepto = 'ME5' THEN
        :NEW.monto := 410;
    ELSE
        :NEW.monto := 0;
    END IF;
END;
-- Inserción de Pago
--ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
INSERT INTO DEVELOPER_02.pago (identificador_inscripcion, forma_pago)
VALUES (3, 'T');
COMMIT;
-- Inserción del detalle de pago
INSERT INTO DEVELOPER_02.pago_detalle
    (pago_identificador, concepto, descripcion)
VALUES (1, 'MAT', 'Pago de Matrícula');
COMMIT;
INSERT INTO DEVELOPER_02.pago_detalle
    (pago_identificador, concepto, descripcion)
VALUES (1, 'ME1', 'Pago de Primera Mensualidad');
COMMIT;


SELECT * FROM developer_02.pago;
SELECT * FROM developer_02.pago_detalle;





/*
CREATE TABLE developer_02.pago_detalle3
(
    identificador integer generated always as identity,
    pago_identificador integer not null,
    concepto varchar2(3),
    descripcion VARCHAR2(300),
    monto number(6,2),
    CONSTRAINT pk_pago_detalle12 PRIMARY KEY(identificador)
);
*/






