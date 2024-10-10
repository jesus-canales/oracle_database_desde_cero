/* -----------------------------------------------------------------
 TEMA      : Gestión de Tablas
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

-- Verificar los permisos asignados a los usuarios
SELECT * FROM dba_sys_privs WHERE grantee IN ('DATASOFT', 'DEVELOPER_01', 'DEVELOPER_02');

-- -<> GESTIÓN DE TABLAS
-- Es una estructura fundamental dentro de una base de datos relacional.
-- Tienen como objetivo almacenar los datos de manera organizada y eficiente.
-- Permite a los usuarios realizar operaciones de gestión de datos: inserción, modificación, eliminación y consultas.
-- Tipos de tablas: Relacionales, Temporales, Indexadas, Particionadas y Externas
-- --- Desde el usuario DATASOFT crear la tabla PERSON
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';

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
    estado char(1),
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
    CONSTRAINT pk_pago_detalle PRIMARY KEY(identificador),
    CONSTRAINT chk_concepto CHECK(concepto IN ('MAT', 'ME1', 'ME2', 'ME3', 'M4', 'ME5'))
);

-- Verificar la estructura de las tablas que hemos creado
DESC developer_01.persona;
DESC developer_01.inscripcion;
DESC developer_02.pago;
DESC developer_02.pago_detalle;
DESC datasoft.carrera;
DESC datasoft.ciclo;

-- Verificar las contraints creadas en las tablas.
SELECT constraint_name, constraint_type 
FROM user_constraints 
WHERE table_name = 'datasoft.persona';

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

-- <> Verificamos las tablas propias de cada usuario 
-- y a las que tiene acceso compartido desde otros usuarios
-- (Debe conectarse desde cada usuario y ejecutar)
-- Para listar Tablas propias
SELECT 'PROPIA' AS tipo_acceso, NULL AS owner, table_name
FROM user_tables;

-- Para listar Tablas a las que se tiene acceso
SELECT DISTINCT 'OTRA' AS tipo_acceso, table_schema, table_name
FROM all_tab_privs
WHERE grantee = USER;

-- <> Probamos el acceso a las tablas desde el usuario developer_01
-- 01 Nos conectamos con el usuario developer_01 y ejecutar
SELECT * FROM developer_01.persona;
SELECT * FROM datasoft.carrera; 

-- <> Probamos el acceso a las tablas desde los demás usuarios

-- <> Probamos ahora gestionar estructura de tabla carrera de datasoft desde developer_01
-- Nos conectamos desde developer_01
-- Crear tabla en datasoft
CREATE TABLE DATASOFT.PRUEBA
(nombre varchar2(60));

-- Modificar la tabla carrera de datasoft
ALTER TABLE DATASOFT.CARRERA
ADD COLUMN prueba_campo VARCHAR2(40);

-- Veremos que no podremos ejecutar ninguna de las sentencias
-- RETO: ¿Cómo lo solucionamos?


-- <> Eliminar las tablas creadas
DROP TABLE DATASOFT.CARRERA CASCADE CONSTRAINTS;
DROP TABLE DATASOFT.CICLO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.PERSONA CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.INSCRIPCION CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO_DETALLE CASCADE CONSTRAINTS;

-- Verificar la las tablas propias por usuario
SELECT table_name
FROM all_tables
WHERE owner = 'DEVELOPER_01';
