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