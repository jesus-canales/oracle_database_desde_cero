# GESTION DE TABLAS

[]


## Tablas

* Es una estructura fundamental dentro de una base de datos relacional.
* Tienen como objetivo almacenar los datos de manera organizada y eficiente.
* Permite a los usuarios realizar operaciones de gestión de datos: inserción, modificación, eliminación y consultas.
* Tipos de tablas: Relacionales, Temporales, Indexadas, Particionadas y Externas.
* Activar la ejecución de scripts:

````SQL
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
````

### Crear tabla **PERSONA**

* Crear la tabla PERSONA que le pertenece al usuario DEVELOPER_01
````SQL
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
````

### Crear tabla **INSCRIPCION**

* Crear la tabla INSCRIPCION que le pertenece al usuario DEVELOPER_01

````SQL
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
````

### Crear tabla **CARRERA**

* Crear la tabla CARRERA que le pertenece al usuario DATASOFT

````SQL
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
````

### Crear tabla **CICLO**

* Crear la tabla CICLO que le pertenece al usuario DATASOFT

````SQL
CREATE TABLE datasoft.ciclo
(
    identificador integer generated always as identity,
    nombre char(6) not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    CONSTRAINT pk_ciclo PRIMARY KEY (identificador)
);
````

### Crear tabla **PAGO**

* Crear la tabla PAGO que le pertenece al usuario DEVELOPER_02

````SQL
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
````

### Crear tabla **PAGO_DETALLE**

* Crear la tabla PAGO_DETALLE que le pertenece al usuario DEVELOPER_02

````SQL
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
````

## Verificar estructura de tablas

* Verificamos la estructura de tabla PERSONA

````SQL
DESC developer_01.persona;
````

* Verificamos la estructura de tabla INSCRIPCION

````SQL
DESC developer_01.inscripcion;
````

* Verificamos la estructura de tabla CARRERA

````SQL
DESC datasoft.carrera;
````

* Verificamos la estructura de tabla CICLO

````SQL
DESC datasoft.ciclo;
````

* Verificamos la estructura de tabla PAGO

````SQL
DESC developer_02.pago;
````

* Verificamos la estructura de tabla PAGO_DETALLE

````SQL
DESC developer_02.pago_detalle;
````

## Verificar las CONSTRAINTS de las tablas

* Utilizamos la sentencia cambiando el usuario y tabla de la cual deseamos ver las constraints, es conveniente conectarse desde el usuario respectivo. **Por ejemplo:** Conectarse desde el usuario datasoft y ejecutar:

````SQL
SELECT constraint_name, constraint_type 
FROM user_constraints 
WHERE table_name = 'datasoft.persona';
````

## Asignar permisos de acceso a tablas

* Developer_01 sede permisos a datasoft y developer_02 sobre la tabla persona.

````SQL
GRANT ALL ON developer_01.persona
TO datasoft, developer_02;
````

* Developer_01 sede permisos a developer_02 sobre la tabla inscripcion

````SQL
GRANT ALL ON developer_01.inscripcion
TO developer_02;
````

* Developer_02 sede permisos a datasoft sobre la tabla pago 

````SQL
GRANT ALL ON developer_02.pago
TO datasoft;
````

* Developer_02 sede permisos a datasoft sobre la tabla pago_detalle 

````SQL
GRANT ALL ON developer_02.pago_detalle
TO datasoft;
````

* Datasoft sede permisos a developer_01 y developer_02 sobre tabla carrera 

````SQL
GRANT ALL ON DATASOFT.carrera
TO developer_01, developer_02;
````

* Datasoft sede permisos a developer_01 y developer_02 sobre tabla ciclo 

````SQL
GRANT ALL ON DATASOFT.ciclo
TO developer_01, developer_02;
````

## Tablas propias de cada usuario

* Verificamos las tablas propias de cada usuario, debe conectarse desde cada usuario y ejecutar.

````SQL
SELECT 'PROPIA' AS tipo_acceso, NULL AS owner, table_name
FROM user_tables;
````

## Tablas compartidas de cada usuario

* Verificamos las tablas a las que se tiene acceso de cada usuario, debe conectarse desde cada usuario y ejecutar.

````SQL
SELECT DISTINCT 'OTRA' AS tipo_acceso, table_schema, table_name
FROM all_tab_privs
WHERE grantee = USER;
````

## Acceso a tablas propias y compartidas

* Para empezar nos conectamos con el usuario developer_01 y ejecutar:

````SQL
SELECT * FROM developer_01.persona;
SELECT * FROM datasoft.carrera; 
````

* Probamos el acceso a las tablas desde los demás usuarios.

## Gestión de estructursa de tablas compartidas

* Probamos ahora crear una nueva tabla PRUEBA en el usuario datasoft desde developer_01, para ello, nos conectamos desde developer_01:

````SQL
CREATE TABLE DATASOFT.PRUEBA
(nombre varchar2(60));
````

* Probamos ahora modificar la tabla carrera de datasoft desde developer_01, para ello, nos conectamos desde developer_01:

````SQL
ALTER TABLE DATASOFT.CARRERA
ADD COLUMN prueba_campo VARCHAR2(40);
````

* Veremos que no podremos ejecutar ninguna de las sentencias

**RETO: ¿Cómo lo solucionamos?**


## Eliminar tablas

* Desde el usuario **sys** procedemos a eliminar las tablas creadas:

````SQL
DROP TABLE DATASOFT.CARRERA CASCADE CONSTRAINTS;
DROP TABLE DATASOFT.CICLO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.PERSONA CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.INSCRIPCION CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO_DETALLE CASCADE CONSTRAINTS;
````
