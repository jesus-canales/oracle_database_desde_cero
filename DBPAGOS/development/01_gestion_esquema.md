# GESTIÓN DE ESQUEMAS

1. [Instancia de Base de Datos](#instancia-de-base-de-datos)
    * [Gestión de Instancia](#gestión-de-instancia)
2. [Tablespace](#tablespace)
    * [Gestión de Tablespace](#gestión-de-tablespace)
3. [Tablespace Datasoft](#tablespace-datasoft)

## <a name="instancia">Instancia de Base de Datos</a>

* Se refiere al motor de la base de datos Oracle.
* Gestiona todos los recursos de la base de datos.
* Proporciona un entorno estable para el almacenamiento y la recuperación de datos.
* Es el responsable de la ejecución SQL y de la gestión de transacciones.

### <a name="gestion-instancia">Gestión de Instancia</a>

Ver la versión de base de datos instalada, para ello debe iniciar la sesión con el usuario *sys* con el rol *sysdba*.
````SQL
SELECT * FROM V$VERSION;
````

Ver instancia de base de datos oracle.
````SQL
SELECT * FROM V$INSTANCE;
````

Listar el motor de base de datos implementado.
````SQL
SELECT * FROM V$DATABASE;
````

## <a name="tablespace">Tablespace</a>

* Es una entidad definida por el administrador de la base de datos.
* Contenedor lógico que define el almacenamiento físico de los datos.
* Está asociado a uno o más archivos físicos del servidor.

### <a name="gestion-de-tablespace">Gestión de Tablespace</a>

* Ver listado de TABLESPACES.
````SQL
SELECT * FROM DBA_TABLESPACES;
````

* Listar los archivos asociados a cada tablespace.
````SQL
SELECT * FROM DBA_DATA_FILES;
````

* Listar los datafiles y su respectiva ubicación.
````SQL
SELECT tablespace_name, file_name
FROM dba_data_files;
````

* Crear un Tablespace
````SQL
CREATE TABLESPACE TBS_DATASOFT 
DATAFILE '/opt/oracle/oradata/xe/datasoft_01.dbf' 
SIZE 100M;
````

* Modificar un Tablespace (agregar datafiles)
````SQL
ALTER TABLESPACE TBS_DATASOFT
ADD DATAFILE '/opt/oracle/oradata/xe/datasoft_02.dbf'
SIZE 50M;
````

* Listar Tablespaces con sus respectivos Datafiles.
````SQL
SELECT tablespace_name, file_name, user_bytes
FROM dba_data_files
WHERE file_name = '/opt/oracle/oradata/xe/datasoft_02.dbf';
````

* Eliminar Tablespace
````SQL
DROP TABLESPACE TBS_DATASOFT
INCLUDING CONTENTS;
````

* **Si bien se ha eliminado el Tablespace los Datafiles permanecen, por tanto hay que eliminarlo manualmente.**

## <a name="tablespace-datasoft">Tablespace Datasoft</a>

* Crear Tablespace
````SQL
CREATE TABLESPACE TBS_DATASOFT 
DATAFILE '/opt/oracle/oradata/xe/datasoft_oficial_01.dbf' 
SIZE 100M;
````


