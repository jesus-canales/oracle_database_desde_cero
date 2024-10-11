# Gestión de Usuarios, Permisos, Roles y Perfiles

1. [Usuarios](#usuarios)
   * [Gestión de Usuarios](#gestión-de-usuarios)
     * [Crear Usuario](#crear-usuario)
     * [Usuario y Tablespace](#usuario-y-tablespace)
     * [Eliminar Usuario](#eliminar-usuario)
   * [Usuarios de TBS_DATASOFT](#usuarios-de-tbs_datasoft)
     * [Usuario datasoft](#usuario-datasoft)
     * [Usuario developer_01](#usuario-developer_01)
     * [Usuario developer_02](#usaurio-developer_02)
2. [Permisos](#permisos)
3. [Roles](#roles)
4. [Perfil](#perfil)
5. [Asignando permisos a usuarios de TBS_DATASOFT](#asignando-permisos-a-usuarios-de-tbs_datasoft)
   * [Permisos de usuario datasoft](#permisos-de-usuario-datasoft)
   * [Permisos de usuario developer_01](#prmisos-de-usuario-developer_01)
   * [Permisos de usuario developer_02](#prmisos-de-usuario-developer_02)
   * [Verificar los permisos asisgnados por usuario](#verificar-los-permisos-asisgnados-por-usuario)
   * [Eliminar Usuarios](#eliminar-usuarios)


## Usuarios

* Es la entidad que interactúa con la base de datos.
* Al crear un usuario se le asigna un esquema por defecto.
* Tienen asociado permisos que definen qué operaciones pueden realizar en la base de datos.
* Tiene control granular sobre quién puede acceder a qué información y qué acciones puede realizar.

### Gestión de Usuarios

* Como buena práctica al crear un nuevo usuario el nombre de este debe contener números, letras y símbolo, **por ejemplo:** DataSoft2024##
* La contraseña de un usuario debe ser entre 8 caracteres a más, **por ejemplo:** @DataSoft#2024

#### Crear Usuario

* Crear usuario datasoft.
````SQL
CREATE USER datasoft 
IDENTIFIED BY OraUser2024; 
````

### Usuario y Tablespace

* Verificar a que tablespace esta asociado el usuario.
````SQL
SELECT username, default_tablespace
FROM dba_users; 
````

* Vamos a asociar el usuario de nuestro Tablespace DATASOFT.
````SQL
ALTER USER datasoft
DEFAULT TABLESPACE TBS_DATASOFT;
````

* Listar los usuarios del Tablespace DATASOFT.
````SQL
SELECT username, default_tablespace
FROM dba_users
WHERE default_tablespace = 'TBS_DATASOFT';
````

### Eliminar Usuario

* Vamos a eliminar a un usuario creado incluyendo a todos sus objetos.
````SQL
DROP USER datasoft CASCADE;
````

## Usuarios de TBS_DATASOFT

### Usuario datasoft

* Crear usuario datasoft
````SQL
CREATE USER datasoft
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
````

### Usuario developer_01

* Crear usuario developer_01
````SQL
CREATE USER developer_01
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
````

### Usaurio developer_02

* Crear usuario developer_02
````SQL
CREATE USER developer_02
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
````

## Permisos

* Son autorizaciones individuales de un usuario para realizar acciones específicas.
* Los tipos de permisos se pueden agrupar en: Permisos de objeto y Permisos de Sistema.
* **Ejemplo:** asignar permiso sobre gestión de datos o creación de objetos.

## Roles

* Es el conjunto de permisos que se pueden asignar a un usuario. Esto simplifica la gestión de permisos.
* **Ejemplo:** Crear un rol con permisos específicos para usuarios con necesidades similares.

## Perfil

* Establecen las restricciones a nivel de sistema, recursos y comportamiento.
* **Ejemplo:** Número máximo de sesiones concurrentes, tiempo máximo de conexión y tamaño de transacciones.

## Asignando permisos a usuarios de TBS_DATASOFT

### Permisos de usuario **datasoft**

````SQL
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
````

### Permisos de usuario **developer_01**

````SQL
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
````

### Prmisos de usuario **developer_02**

````SQL
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
````

### Verificar los permisos asisgnados por usuario

* Desde el usuario **sys** ejecutar esta sentencia con el nombre del usuario todo en mayúsculas.
````SQL
SELECT * FROM dba_sys_privs 
WHERE grantee = 'DATASOFT';
````

### Eliminar usuarios

* Eliminamos usuarios con todos los objetos que le pertenecen

````SQL
DROP USER datasoft CASCADE;
DROP USER developer_01 CASCADE;
DROP USER developer_02 CASCADE;
````

* Eliminar Tablespace TBS_DATASOFT

````SQL
DROP TABLESPACE TBS_DATASOFT INCLUDING CONTENTS;
````