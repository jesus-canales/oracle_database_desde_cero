/* -----------------------------------------------------------------
 TEMA      : Gestión de Relaciones entre Tablas
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

-- -<> GESTIÓN DE RELACIONES
-- Permiten estructurar los datos de manera lógica y evitar la redundancia.
-- Complementa al proceso de normalización contribuyendo a la integridad de datos.
-- Facilitan la consulta y manipulación de datos.
-- Permiten obtener información detallada y compleja a partir de diferentes tablas.
-- Tipos: Uno a uno, Uno a varios y varios a varios.
-- Una relación se compone de una tabla Padre (campo PK) y tabla hija (campo FK)

-- <> Relacionar Persona - Inscripcion
-- Conectarse desde developer_01
-- Una persona puede ser inscrita en una carrera una o muchas veces
-- Desde Developer_01 relacionar tablas persona con inscripcion
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_persona_inscripcion 
FOREIGN KEY (persona_identificador)
REFERENCES developer_01.persona(identificador);

-- <> Relacionar Pago con Pago_Detalle
-- Conectarse desde developer_02
-- Una un pago realizado puede contener uno o muchos detalles
-- Desde Developer_02 relacionar tablas persona con inscripcion
ALTER TABLE DEVELOPER_02.pago_detalle
ADD CONSTRAINT fk_pago_pago_detalle
FOREIGN KEY (pago_identificador)
REFERENCES DEVELOPER_02.pago(identificador);


-- <> Relacionar Inscripcion - Pago
-- Conectarse desde developer_02
-- Una inscripción puede estar presente en uno o muchos pagos
-- Desde Developer_02 relacionar tabla inscripción con pago
ALTER TABLE developer_02.pago
ADD CONSTRAINT fk_inscripcion_pago
FOREIGN KEY (IDENTIFICADOR_INSCRIPCION)
REFERENCES DEVELOPER_01.inscripcion(IDENTIFICADOR);


-- <> Relacionar Carrera - Inscripcion
-- Conectarse desde developer_01
-- Una carrera puede ser parte de una o muchas inscripciones
-- Desde Developer_01 relacionar las tablas Carrera - Inscripcion
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_carrera_inscripcion
FOREIGN KEY (CARRERA_IDENTIFICADOR)
REFERENCES DATASOFT.carrera(identificador);


-- <> Relacionar Ciclo - Inscripcion
-- Conectarse desde developer_01
-- Un ciclo puede ser parte de una o muchas inscripciones
-- Desde developer_01 relacionamos las tablas Ciclo - Inscripcion
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_ciclo_inscripcion
FOREIGN KEY (CICLO_IDENTIFICADOR)
REFERENCES DATASOFT.ciclo(identificador);

-- <> Listar relaciones
-- Conectarse por cada usuario para poder visualizar las relaciones respectivas
SELECT 
    CONSTRAINT_NAME AS nombre_relacion,
    TABLE_NAME AS tabla_hija,
    R_OWNER AS propietario_tabla_padre,
    R_CONSTRAINT_NAME AS nombre_restriccion_padre
FROM 
    user_constraints
WHERE 
    constraint_type = 'R';

-- <> Eliminar relación
-- Necesitamos el nombre de la tabla y el nombre de la relación que queremos eliminar
ALTER TABLE developer_01.inscripcion
DROP CONSTRAINT fk_ciclo_inscripcion;

-- <> Eliminar las tablas creadas incluyendo las relaciones en las que participan
DROP TABLE DATASOFT.CARRERA CASCADE CONSTRAINTS;
DROP TABLE DATASOFT.CICLO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.PERSONA CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.INSCRIPCION CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO_DETALLE CASCADE CONSTRAINTS;
