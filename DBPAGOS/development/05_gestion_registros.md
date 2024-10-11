# GESTION DE REGISTROS

1. [Registros en la tabla carrera](#registros-en-la-tabla-carrera)
2. [Registros en la tabla ciclo](#registros-en-la-tabla-ciclo)
3. [Registros en la tabla persona](#registros-en-la-tabla-persona)
4. [Registros en la tabla inscripción](#registros-en-la-tabla-inscripción)
5. [Registros en la tabla pago](#registros-en-la-tabla-pago)
6. [Registros en la tabla pago_detalle](#registros-en-la-tabla-pago_detalle)



## Registros en la tabla carrera

* Verificar estructura de la tabla: carrera

````SQL
DESC datasoft.carrera;
````

* Insertar registros en la tabla carrera

````SQL
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
````

* Listar los registros de la tabla carrera

````SQL
SELECT * FROM datasoft.carrera;
````

## Registros en la tabla ciclo

* Verificar estructura de la tabla: ciclo

````SQL
DESC datasoft.ciclo;
````

* Insertar registros en la tabla ciclo

````SQL
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
````

* Listar los registros de la tabla ciclo

````SQL
SELECT * FROM DATASOFT.ciclo;
````


## Registros en la tabla persona

* Verificar estructura de la tabla: persona

````SQL
DESC DEVELOPER_01.persona;
````

* Insertar registros en la tabla persona

````SQL
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
````

* Listar los registros de la tabla persona

````SQL
SELECT * FROM developer_01.persona;
````


## Registros en la tabla inscripción

* Verificar estructura de la tabla: inscripción

````SQL
DESC DEVELOPER_01.inscripcion;
````

* Insertar registros en la tabla inscripción

````SQL
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
````

* Listar los registros de la tabla inscripción

````SQL
SELECT * FROM developer_01.inscripcion;
````


## Registros en la tabla pago

* Verificar estructura de la tabla: pago

````SQL
DESC DEVELOPER_02.pago;
````

* Insertar el primer registro en la tabla pago

````SQL
INSERT INTO DEVELOPER_02.pago (identificador_inscripcion, forma_pago)
VALUES (3, 'T');
COMMIT;
````

* Listar los registros de la tabla pago

````SQL
SELECT * FROM developer_02.pago;
````


## Registros en la tabla pago_detalle

* Verificar estructura de la tabla: pago_detalle

````SQL
DESC DEVELOPER_02.pago_detalle;
````

* Creamos un Trigger para asignar el valor a 'monto' basado en 'concepto' al momento de realizar un insert

````SQL
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
````

* Insertar dos pago_detalle en base al primer registro de pago

````SQL
INSERT INTO DEVELOPER_02.pago_detalle
    (pago_identificador, concepto, descripcion)
VALUES (1, 'MAT', 'Pago de Matrícula');
COMMIT;
INSERT INTO DEVELOPER_02.pago_detalle
    (pago_identificador, concepto, descripcion)
VALUES (1, 'ME1', 'Pago de Primera Mensualidad');
COMMIT;
````

* Listar los registros de la tabla pago

````SQL
SELECT * FROM developer_02.pago_detalle;
````

* Verificamos que se han agregado automáticamente el monto de matrícula y mensualidad automáticamente.