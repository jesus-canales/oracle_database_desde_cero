/* -----------------------------------------------------------------
 TEMA      : Gestión de Esquemas de Base de Datos desde cero
 PROFESOR  : Jesús Canales Guando
 CURSO     : Base de Datos 3 
*/ -----------------------------------------------------------------

-- <> Permitir ejecución de script
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- <> INSTANCIA DE BASE DE DATOS
-- Se refiere al motor de la base de datos Oracle.
-- Gestiona todos los recursos de la base de datos.
-- Proporciona un entorno estable para el almacenamiento y la recuperación de datos.
-- Es el responsable de la ejecución SQL y de la gestión de transacciones.
-- ## Gestión de Instancia
-- Versión de base de datos instalada
SELECT * FROM V$VERSION;

-- Ver instancia de base de datos
SELECT * FROM V$INSTANCE;

-- Listar base de datos
SELECT * FROM V$DATABASE;

-- <> TABLESPACE
-- Es una entidad definida por el administrador de la base de datos.
-- Contenedor lógico que define el almacenamiento físico de los datos.
-- Está asociado a uno o más archivos físicos del servidor.
-- ## Gestión de Tablespace
-- Ver listado de TABLESPACES
SELECT * FROM DBA_TABLESPACES;

-- Listar los archivos asociados a cada tablespace
SELECT * FROM DBA_DATA_FILES;

-- Listar los datafiles y su respectiva ubicación
SELECT tablespace_name, file_name
FROM dba_data_files;

-- Crear un Tablespace
CREATE TABLESPACE TBS_DATASOFT 
DATAFILE '/opt/oracle/oradata/xe/datasoft_01.dbf' 
SIZE 100M;

-- Modificar un Tablespace (agregar datafiles)
ALTER TABLESPACE TBS_DATASOFT
ADD DATAFILE '/opt/oracle/oradata/xe/datasoft_02.dbf'
SIZE 50M;

-- Listar Tablespaces con sus respectivos Datafiles
SELECT tablespace_name, file_name, user_bytes
FROM dba_data_files
WHERE file_name = '/opt/oracle/oradata/xe/datasoft_02.dbf';

-- ## Investigar:
-- Actualizar tamaño un Datafile de DATASOFT
-- Renombrar un Datafile de DATASOFT

-- Eliminar Tablespace
DROP TABLESPACE TBS_DATASOFT
INCLUDING CONTENTS;

-- Si bien se ha eliminado el Tablespace los Datafiles permanecen,
-- por tanto hay que eliminarlo manualmente.

-- <> CREAR TABLESPACE PARA DATASOFT
-- Crear un Tablespace
CREATE TABLESPACE TBS_DATASOFT 
DATAFILE '/opt/oracle/oradata/xe/datasoft_oficial_01.dbf' 
SIZE 100M;

-- <> USUARIO
-- Es la entidad que interactúa con la base de datos.
-- Al crear un usuario se le asigna un esquema por defecto.
-- Tienen asociado permisos que definen qué operaciones pueden realizar en la base de datos.
-- Tiene control granular sobre quién puede acceder a qué información y qué acciones puede realizar.
-- ## Gestión de Usuarios
-- Crear un nuevo usuario
-- debe contener números, letras y símbolo 
-- clave: LLmm123## (12 caracteres)
CREATE USER datasoft 
IDENTIFIED BY OraUser2024; 

-- Verificar a que tablespace esta asociado el usuario
SELECT username, default_tablespace
FROM dba_users;

-- Vamos a asociar el usuario de nuestro Tablespace DATASOFT
ALTER USER datasoft
DEFAULT TABLESPACE TBS_DATASOFT;

-- Listar los usuarios del Tablespace DATASOFT
SELECT username, default_tablespace
FROM dba_users
WHERE default_tablespace = 'TBS_DATASOFT';

-- Eliminar usuario test_##_user
DROP USER datasoft CASCADE;

-- <> CREAR USUARIO admin_##_datasoft en TABLESPACE DATASOFT
-- Crear usuario
CREATE USER datasoft
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- DATO IMPORTANTE: Un usuario recién creado no tiene asignado ningún permiso

-- <> GESTION DE PERMISOS, ROLES Y PERFILES
-- PERMISOS: Son autorizaciones individuales de un usuario para realizar acciones específicas.
-- Los tipos de permisos se pueden agrupar en: Permisos de objeto y Permisos de Sistema.
-- -- Ejemplo: asignar permiso sobre gestión de datos o creación de objetos.
-- ROLES: Es el conjunto de permisos que se pueden asignar a un usuario. Esto simplifica la gestión de permisos.
-- -- Ejemplo: Crear un rol con permisos específicos para usuarios con necesidades similares.
-- PERFIL: Establecen las restricciones a nivel de sistema, recursos y comportamiento.
-- -- Ejemplo: Número máximo de sesiones concurrentes, tiempo máximo de conexión y tamaño de transacciones.
-- RESUMEN: Los permisos son el nivel más granular, los roles agrupan permisos 
-- -------  y los perfiles establecen restricciones a nivel de sistema. 
-- -------  Esta jerarquía permite una gestión flexible y escalable de los permisos.
-- ##  EJERCICIOS
-- --- Asignar todos los permisos a DATASOFT
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

-- --- Verificar los permisos o privilegios asignados
SELECT * FROM dba_sys_privs 
WHERE grantee = 'DATASOFT';

-- -<> CREAR DOS USUARIOS DEVELOPER_01 Y DEVELOPER_02
-- --- Creamos usuario developer_01 dentro de TBS_DATASOFT
CREATE USER developer_01
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- --- Asignamos todos los permisos
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

-- --- Creamos usuario developer_02 dentro de TBS_DATASOFT
CREATE USER developer_02
IDENTIFIED BY OraUser2024
DEFAULT TABLESPACE TBS_DATASOFT;
-- --- Asignamos todos los permisos
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

-- <> ESQUEMAS DE BASE DE DATOS
-- Contenedor lógico que agrupa un conjunto de objetos relacionados.
-- Permite una mejor administración y mantenimiento.
-- Un esquema está relacionado a un usuario, pero muchos usuarios pueden estar relacionados a un solo esquema

-- <> ELIMINANDO USUARIOSY TABLESPACE
DROP USER datasoft CASCADE;
DROP USER developer_01 CASCADE;
DROP USER developer_02 CASCADE;
DROP TABLESPACE TBS_DATASOFT INCLUDING CONTENTS;
