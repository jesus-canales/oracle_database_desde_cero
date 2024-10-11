# GESTION DE RELACIONES

1. [Relaciones](#relaciones)
   * [Relación: Persona - Inscripción](#relación-persona---inscripcion)
   * [Relación Pago - Pago Detalle](#relación-pago-con-pago_detalle)
   * [Relación Inscripción - Pago](#relación-inscripcion---pago)
   * [Relación Carrera - Inscripción](#relación-carrera---inscripcion)
   * [Relación Ciclo - Inscripción](#relación-ciclo---inscripcion)
2. [Listar relaciones](#listar-relaciones)
3. [Eliminar relación](#eliminar-relación)
4. [Eliminar Tablas incluyendo relación](#eliminar-tablas-incluyendo-la-relación)


## Relaciones

* Permiten estructurar los datos de manera lógica y evitar la redundancia.
* Complementa al proceso de normalización contribuyendo a la integridad de datos.
* Facilitan la consulta y manipulación de datos.
* Permiten obtener información detallada y compleja a partir de diferentes tablas.
* Tipos: Uno a uno, Uno a varios y varios a varios.
* Una relación se compone de una tabla Padre (campo PK) y tabla hija (campo FK).

### RELACIÓN: Persona - Inscripcion

* Una persona puede ser inscrita en una carrera una o muchas veces
* Conectarse desde el usuario **developer_01**

````SQL
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_persona_inscripcion 
FOREIGN KEY (persona_identificador)
REFERENCES developer_01.persona(identificador);
````

### RELACIÓN: Pago con Pago_Detalle

* Una un pago realizado puede contener uno o muchos detalles
* Conectarse desde el usuario **developer_02**

````SQL
ALTER TABLE DEVELOPER_02.pago_detalle
ADD CONSTRAINT fk_pago_pago_detalle
FOREIGN KEY (pago_identificador)
REFERENCES DEVELOPER_02.pago(identificador);
````

### RELACIÓN: Inscripcion - Pago

* Una inscripción puede estar presente en uno o muchos pagos
* Conectarse desde el usuario **developer_02**

````SQL
ALTER TABLE developer_02.pago
ADD CONSTRAINT fk_inscripcion_pago
FOREIGN KEY (IDENTIFICADOR_INSCRIPCION)
REFERENCES DEVELOPER_01.inscripcion(IDENTIFICADOR);
````

### RELACIÓN: Carrera - Inscripcion

* Una carrera puede ser parte de una o muchas inscripciones
* Conectarse desde el usuario **developer_01**

````SQL
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_carrera_inscripcion
FOREIGN KEY (CARRERA_IDENTIFICADOR)
REFERENCES DATASOFT.carrera(identificador);
````

### RELACIÓN: Ciclo - Inscripcion

* Un ciclo puede ser parte de una o muchas inscripciones
* Conectarse desde el usuario **developer_01**

````SQL
ALTER TABLE developer_01.inscripcion
ADD CONSTRAINT fk_ciclo_inscripcion
FOREIGN KEY (CICLO_IDENTIFICADOR)
REFERENCES DATASOFT.ciclo(identificador);
````

## Listar relaciones

* Conectarse por cada usuario para poder visualizar las relaciones respectivas.

````SQL
SELECT 
    CONSTRAINT_NAME AS nombre_relacion,
    TABLE_NAME AS tabla_hija,
    R_OWNER AS propietario_tabla_padre,
    R_CONSTRAINT_NAME AS nombre_restriccion_padre
FROM 
    user_constraints
WHERE 
    constraint_type = 'R';
````

## Eliminar relación

* Necesitamos el nombre de la tabla y el nombre de la relación que queremos eliminar.

````SQL
ALTER TABLE developer_01.inscripcion
DROP CONSTRAINT fk_ciclo_inscripcion;
````

## Eliminar Tablas incluyendo la relación

* Eliminar las tablas creadas incluyendo las relaciones en las que participan.

````SQL
DROP TABLE DATASOFT.CARRERA CASCADE CONSTRAINTS;
DROP TABLE DATASOFT.CICLO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.PERSONA CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_01.INSCRIPCION CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO CASCADE CONSTRAINTS;
DROP TABLE DEVELOPER_02.PAGO_DETALLE CASCADE CONSTRAINTS;
````