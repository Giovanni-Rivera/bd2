/*---------------------------------------------xxxxxxxxxxxxxxxxxxxx-------------------------------------*/

                                                   /*USUARIO*/
/*----------------------------------------------xxxxxxxxxxxxxxxxxxx--------------------------------------*/
/*antes de tener una cuenta, debe existir un USUARIO
por lo que procedemos a crearlo por medio de plsql*/
/*1.- creamos una secuencia para llevar el control de los correlativos EN LAS DISTINTAS TABLAS QUE TENGAN
QUE VER CON USUARIO, EN ESTA CASO ELLA MISMA Y SU BITÁCORA*/

/*SECUENCIA PARA LE ID DE USUARIOS*/
    CREATE SEQUENCE SEQ_NUMERO_USUARIO
    START WITH 1
    INCREMENT BY 1;
    COMMIT;
    /*SECUENCIA PARA EL ID DE LA BITACORA*/
    CREATE SEQUENCE SEQ_BITACORA_USUARIO
    START WITH 1
    INCREMENT BY 1; 
    COMMIT;
    
/*2.- debemos crear el directorio donde vamos a almacenar las firmas de los USUARIOs*/
/*2.1 definimos el nombre del directorio y la ruta*/
CREATE OR REPLACE DIRECTORY DIR_USUARIO AS 'C:\USUARIO_FOTOGRAFIA';
/*2.2 - otorgamos los permisos a los usuarios debemos crear un rol y los permisos que tendrá a ciertas tablas*/
GRANT READ, WRITE ON DIRECTORY DIR_USUARIO TO USER WITH GRANT OPTION; 
COMMIT;

/*TRIGGER PARA CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_USUARIO 
BEFORE INSERT ON USUARIO
FOR EACH ROW
BEGIN
SELECT SEQ_BITACORA_USUARIO.NEXTVAL INTO :NEW.ID_USUARIO FROM DUAL;
END BI_USUARIO;
/


/*3.- VAMOS A CREAR UN PROCEDIMIENTO ALMACENADO PARA LA INSERCIÓN DE DATOS EN LA TABLA USUARIO,
VAMOS A MANDAR COMO PARÁMETRO UNA VARIABLE TIPO %ROWTYPE PARA HACER MAS FÁCIL EL PROCESO,
*/
CREATE OR REPLACE PROCEDURE PROC_CREAR_USUARIO(DATOS_USUARIO USUARIO%ROWTYPE)
    IS
    GENERO TIPO_GENERO.TIPO_GENERO%TYPE;
    NO_EXIST_TIPO EXCEPTION;
    /*EL USUARIO DEBE DE ESTAR ACTIVO PARA INSERTAR SI SEGÚN SU ROL TIENE ESTE PRIVILEGIO*/
    USUARIO_ACT ESTATUS_USUARIO.NOMBRE%TYPE;
    BEGIN
        /*Evaluamos SI EL TIPO DE GENERO SELECCIONADO EXISTE DENTRO DE LOS YA
        ESTABLECIDOS EN LA BASE DE DATOS*/
        SELECT COUNT(TIPO_GENERO) INTO GENERO FROM TIPO_GENERO WHERE TIPO_GENERO=DATOS_USUARIO.TIPO_GENERO; 
        /**/
        IF(GENERO>0) THEN
            /*si todo transcurre con normalidad, insertamos datos EL ESTATUS 1 QUIERE DECIR QUE POR DEFECTO VAMOS A ACTIVAR AL USUARIO*/
            INSERT INTO USUARIO(NOMBRE_USUARIO,NOMBRES,APELLIDOS,DPI,DIRECCION,CORREO_ELECTRONICO,TELEFONO,CELULAR,FECHA_NACIMIENTO,
            FECHA_CREACION, FOTOGRAFIA, CONTRASENA,ID_AGENCIA,ID_MUNICIPIO,TIPO_USUARIO,TIPO_GENERO,ESTATUS_USUARIO)

            VALUES(DATOS_USUARIO.NOMBRE_USUARIO, DATOS_USUARIO.NOMBRES, DATOS_USUARIO.APELLIDOS, DATOS_USUARIO.DPI, DATOS_USUARIO.DIRECCION,
            DATOS_USUARIO.CORREO_ELECTRONICO, DATOS_USUARIO.TELEFONO, DATOS_USUARIO.CELULAR, DATOS_USUARIO.FECHA_NACIMIENTO, SYSDATE,
            DATOS_USUARIO.FOTOGRAFIA, DATOS_USUARIO.CONTRASENA, DATOS_USUARIO.ID_AGENCIA, DATOS_USUARIO.ID_MUNICIPIO, 
            DATOS_USUARIO.TIPO_USUARIO, DATOS_USUARIO.TIPO_GENERO,1);
        /*SINO EXISTE EL TIPO LEVANTAMOS UNA EXCEPCION PROPIA*/
        ELSE
        
            RAISE NO_EXIST_TIPO;
        END IF;
        /*Al salir todo bien, confirmamos la transacción*/
        COMMIT;
        EXCEPTION
            WHEN NO_EXIST_TIPO THEN
                 DBMS_OUTPUT.PUT_LINE('SELECCCIONE UN GENERO CORRECTO');
            /*SI POR X O Y MOTIVO SE PLANEA INSERTAR UN USUARIO CON UN ID YA EXISTENTE*/
            WHEN DUP_VAL_ON_INDEX THEN
                 DBMS_OUTPUT.PUT_LINE('ESTÁ INTENTANDO INSERTAR UN NUMERO DE USUARIO YA EXISTENTE, REVISE POR FAVOR, O COMUNÍQUESE CON EL DBA');
            /*Como para la inserción únicamente vamos a evaluar si el tipo de género existe,
            sino lo ecuentra devolverá esta excepción*/
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO SE ENCONTRÓ DATO RELACIONADO A');
            /*Se agotò el tiempo de espera*/
            WHEN TIMEOUT_ON_RESOURCE THEN
                DBMS_OUTPUT.PUT_LINE('SE AGOTÓ EL TIEMPO DE ESPERA');
            /*Se intentó hacer una operación aritmética, pero no se logro realizar*/
            WHEN VALUE_ERROR THEN
                DBMS_OUTPUT.PUT_LINE('ERROR DE ÍNDOLE ARITMÉTICO');
            /*En un parámetro que es de tipo numérico se ingresa un caracter distinto a un número*/
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('FALLÓ LA CONVERSIÓN DE UN STRING O CARACTER A NÚMERO');
            /*No se permitió el acceso a la base de datos*/
            WHEN LOGIN_DENIED THEN
                DBMS_OUTPUT.PUT_LINE('ERROR AL MOMENTO DE REALIZAR EL LOGIN EN LA BASE DE DATOS');
            /*Si se presenta otro tipo de error*/
            WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('OCURRIÓ UN ERROR    '||SQLCODE||'    Mensaje:    '||SQLERRM);
        /*En dado caso la transacción presenta algún problema durante su uso, la revertimos*/
        ROLLBACK;
/*FIN DEL PROCEDIMIENTO ALMACENADO*/
END PROC_CREAR_USUARIO;
/
/* 4.- CAMPO AUTOINCREMENTABLE DE LA BITACORA DEL USUARIO*/
CREATE OR REPLACE TRIGGER BI_BITACORA_USUARIO 
BEFORE INSERT ON BITACORA_USUARIO
FOR EACH ROW
BEGIN
SELECT SEQ_BITACORA_USUARIO.NEXTVAL INTO :NEW.ID_OPERACION FROM DUAL;
END BI_BITACORA_USUARIO;
/

/* 5.- después de insertar datos en la tabla USUARIO debemos registrarlos en bitacora USUARIO (la inserción)*/
CREATE OR REPLACE TRIGGER AIUD_TBL_USUARIO
AFTER INSERT OR UPDATE OR DELETE  ON USUARIO
FOR EACH ROW
BEGIN

        IF INSERTING THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:NEW.ID_USUARIO,NULL,NULL,SYSDATE,'',NULL,2);
        END IF;
        IF UPDATING ('NOMBRE_USUARIO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:NEW.ID_USUARIO,:OLD.NOMBRE_USUARIO,:NEW.NOMBRE_USUARIO,SYSDATE,'',2,1); 
        END IF; 
        IF UPDATING ('NOMBRES') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:NEW.ID_USUARIO,:OLD.NOMBRES,:NEW.NOMBRES,SYSDATE,'',3,1);
        END IF;
        IF UPDATING ('APELLIDOS') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.APELLIDOS,:NEW.APELLIDOS,SYSDATE,'',4,1);
        END IF;
        IF UPDATING ('DPI') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.DPI,:NEW.DPI,SYSDATE,'',5,1);
        END IF;
        IF UPDATING ('DIRECCION') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.DIRECCION,:NEW.DIRECCION,SYSDATE,'',6,1); 
        END IF;
        IF UPDATING ('CORREO_ELECTRONICO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.CORREO_ELECTRONICO,:NEW.CORREO_ELECTRONICO,SYSDATE,'',7,1);
        END IF; 
        IF UPDATING ('TELEFONO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.TELEFONO,:NEW.TELEFONO,SYSDATE,'',8,1);  
        END IF; 
        IF UPDATING ('CELULAR') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.CELULAR,:NEW.CELULAR,SYSDATE,'',9,1); 
        END IF;
        IF UPDATING ('FECHA_NACIMIENTO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,TO_CHAR(:OLD.FECHA_NACIMIENTO),TO_CHAR(:NEW.FECHA_NACIMIENTO),SYSDATE,'',10,1);
        END IF;
        IF UPDATING ('FOTOGRAFIA') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,IMG_ANTIGUA,IMG_NUEVA) 
            VALUES(:OLD.ID_USUARIO,SYSDATE,'',12,1,:OLD.FOTOGRAFIA, :NEW.FOTOGRAFIA);
        END IF;
        IF UPDATING ('CONTRASENA') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.CONTRASENA,:NEW.CONTRASENA,SYSDATE,'',14,1); 
        END IF;
        IF UPDATING ('ID_AGENCIA') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.ID_AGENCIA,:NEW.ID_AGENCIA,SYSDATE,'',15,1); 
        END IF;
        IF UPDATING ('ID_MUNICIPIO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.ID_MUNICIPIO,:NEW.ID_MUNICIPIO,SYSDATE,'',16,1);
        END IF;
        IF UPDATING ('TIPO_USUARIO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.TIPO_USUARIO,:NEW.TIPO_USUARIO,SYSDATE,'',17,1);
        END IF;
        IF UPDATING ('TIPO_GENERO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.TIPO_GENERO,:NEW.TIPO_GENERO,SYSDATE,'',18,1);
        END IF;
        IF UPDATING ('ESTATUS_USUARIO') THEN
            INSERT INTO BITACORA_USUARIO (ID_USUARIO,VALOR_ANTERIOR,VALOR_NUEVO,FECHA_OPERACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION) 
            VALUES(:OLD.ID_USUARIO,:OLD.ESTATUS_USUARIO,:NEW.ESTATUS_USUARIO,SYSDATE,'',19,1); 
        END IF;           
    EXCEPTION
    /*si por algún motivo falla alguna conversión de un número*/
    WHEN INVALID_NUMBER THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||'  FALLÓ LA CONVERSIÓN DE:    '||SQLERRM);
    /*si el usuario quiere insertar un valor con un id de la tabla  ya  creado*/
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ESTÁ INTENTANDO REGISTRAR CON UN ID YA EXISTENTE, COMUNIQUESE CON EL DBA');
    /*si el  usuario no está registrado dentro de la base de datos*/
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('USTED NO TIENE PRIVILEGIOS O PERMISOS PARA CREAR ESTA OPERACION, CONTACTE CON EL DBA');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||'    ERROR:     '||'MENSAJE    '||SQLERRM);
END;
/
commit;
    /*6.- FORMA DE MANDAR LOS DATOS PARA EL STORED PROCEDURE*/
    /*BLOQUE ANÒNIMO NO SE BURLEN MAJES JAJAJA*/

    DECLARE
    USUARIO_N USUARIO%ROWTYPE;
    BEGIN
        USUARIO_N.NOMBRE_USUARIO:='PROYECTO';
        USUARIO_N.NOMBRES:='USUARIO 1';
        USUARIO_N.APELLIDOS:='PEREZ';
        USUARIO_N.DPI:='2433453126483';
        USUARIO_N.DIRECCION:='zona X';
        USUARIO_N.CORREO_ELECTRONICO:='Troman@hotmail.es';
        USUARIO_N.TELEFONO:='14537154';
        USUARIO_N.CELULAR:='';
        USUARIO_N.FECHA_NACIMIENTO:=TO_DATE('02/11/1995','dd/mm/yyyy');
        USUARIO_N.FOTOGRAFIA:=NULL;
        /*LOS CAMPOS COMO CONTRASEÑAS Y ESTADOS DE CUENTA AÚN NO SE HAN ENCRIPTADO
        PUES COMO ESTAMOS AÚN HACIENDO PRUEBAS DEBEMOS VALIDAR QUE ESTÉN HACIENDO BIEN LAS TRANSACCIONES
        AL FINAL, A LA ENTREGA DE L PROYECTO SE REALIZARÁ ESTE PASO*/
        USUARIO_N.CONTRASENA:='AJSDLFK';
        USUARIO_N.ID_AGENCIA:=1;
        USUARIO_N.ID_MUNICIPIO:=1;
        USUARIO_N.TIPO_USUARIO:=NULL;
        USUARIO_N.TIPO_GENERO:=2;
    /*PROBAMOS EL PROCEDIMIENTO ALMACENADO*/
    PROC_CREAR_USUARIO(USUARIO_N);
    END;
    /












/*---------------------------------------------xxxxxxxxxxxxxxxxxxxx-------------------------------------*/

                                                   /*CLIENTE*/
/*----------------------------------------------xxxxxxxxxxxxxxxxxxx--------------------------------------*/

/*antes de tener una cuenta, debe existir un CLIENTE
por lo que procedemos a crearlo por medio de plsql*/
/*1.- creamos una secuencia para llevar el control de los correlativos EN LAS DISTINTAS TABLAS QUE TENGAN
QUE VER CON CLIENTE, EN ESTA CASO ELLA MISMA Y SU BITÁCORA*/

/*SECUENCIA PARA LE ID DE CLIENTES*/
CREATE SEQUENCE SEQ_NUMERO_CLIENTES
START WITH 1
INCREMENT BY 1;

/*SECUENCIA PARA EL ID DE LA BITACORA*/
CREATE SEQUENCE SEQ_BITACORA_CLIENTE
START WITH 1
INCREMENT BY 1; 

/*2.- debemos crear el directorio donde vamos a almacenar las firmas de los clientes*/
/*2.1 definimos el nombre del directorio y la ruta*/
CREATE OR REPLACE DIRECTORY IMAGENES AS 'C:\firmas';
/*2.2 - otorgamos los permisos a los usuarios debemos crear un rol y los permisos que tendrá a ciertas tablas*/
GRANT READ, WRITE ON DIRECTORY IMAGENES TO HR WITH GRANT OPTION; 

/*TRIGGER PARA CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_CLIENTE 
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
SELECT SEQ_NUMERO_CLIENTES.NEXTVAL INTO :NEW.ID_CLIENTE_NUMERO FROM DUAL;
END BI_CLIENTE;
/

/*3.- VAMOS A CREAR UN PROCEDIMIENTO ALMACENADO PARA LA INSERCIÓN DE DATOS EN LA TABLA CLIENTE,
VAMOS A MANDAR COMO PARÁMETRO UNA VARIABLE TIPO %ROWTYPE PARA HACER MAS FÁCIL EL PROCESO,
*/
CREATE OR REPLACE PROCEDURE PROC_CREAR_CLIENTE(DATOS_CLIENTE CLIENTE%ROWTYPE)
    IS
    GENERO TIPO_GENERO.TIPO_GENERO%TYPE;
    NO_EXISTE_TIPO EXCEPTION;
    NO_EXISTE_USUARIO EXCEPTION;
    ID_USUARIO_EXISTENTE NUMBER;
    /*EL USUARIO DEBE DE ESTAR ACTIVO PARA INSERTAR SI SEGÚN SU ROL TIENE ESTE PRIVILEGIO*/
    USUARIO_ACT ESTATUS_USUARIO.NOMBRE%TYPE;
    BEGIN
        /*Evaluamos SI EL TIPO DE GENERO SELECCIONADO EXISTE DENTRO DE LOS YA
        ESTABLECIDOS EN LA BASE DE DATOS*/
        SELECT COUNT(TIPO_GENERO) INTO GENERO FROM TIPO_GENERO WHERE TIPO_GENERO=DATOS_CLIENTE.TIPO_GENERO; 
        /*VERIFICAMOS CON EL USUARIO QUE SE HAYAN LOGEADO EN EL SISTEMA ESTÁ, DENTRO DE NUESTRA TABLA USUARIO DEL NEGOCIO
        Y A LA  VEZ SI ESTÁ HABILITADO*/
        SELECT ID_USUARIO INTO ID_USUARIO_EXISTENTE  FROM USUARIO WHERE NOMBRE_USUARIO=(SELECT USERNAME FROM ALL_USERS WHERE USERNAME=USER);
          /*validamos si el usuario está activo*/
        SELECT  NOMBRE  INTO USUARIO_ACT FROM ESTATUS_USUARIO ET
            INNER JOIN USUARIO USR
            ON ET.ID_ESTATUS_USUARIO=USR.ESTATUS_USUARIO
            WHERE  USR.ID_USUARIO=ID_USUARIO_EXISTENTE;
        /*SE PUDIESE SER DE OTRA FORMA MAS LIMPIA, PERO
            POR FINES DE APRENDIZAJE SE HIZO EL INNER JOIN*/
        IF(GENERO>0 AND ID_USUARIO_EXISTENTE>0 AND USUARIO_ACT='ACTIVO') THEN
            /*si todo transcurre con normalidad, insertamos datos EL ESTATUS 1 QUIERE DECIR QUE POR DEFECTO VAMOS A ACTIVAR AL CLIENTE*/
            INSERT INTO CLIENTE(NOMBRES,APELLIDOS,DPI,NIT,MUNICIPIO,DIRECCION,TELEFONO,CELULAR,CORREO_ELECTRONICO,TIPO_GENERO,FECHA_NACIMIENTO,IMAGEN_FIRMA,ID_ESTATUS_CLIENTE)
            VALUES(DATOS_CLIENTE.NOMBRES,DATOS_CLIENTE.APELLIDOS,DATOS_CLIENTE.DPI,DATOS_CLIENTE.NIT,DATOS_CLIENTE.MUNICIPIO,DATOS_CLIENTE.DIRECCION,DATOS_CLIENTE.TELEFONO,DATOS_CLIENTE.CELULAR,
            DATOS_CLIENTE.CORREO_ELECTRONICO, DATOS_CLIENTE.TIPO_GENERO,DATOS_CLIENTE.FECHA_NACIMIENTO,DATOS_CLIENTE.IMAGEN_FIRMA,1);
        /*SINO EXISTE EL TIPO LEVANTAMOS UNA EXCEPCION PROPIA*/
        ELSE
            IF(GENERO<=0) THEN
                RAISE NO_EXISTE_TIPO;
            ELSIF(ID_USUARIO_EXISTENTE<=0) THEN
                RAISE NO_EXISTE_USUARIO;
            END IF;    
        END IF;
        /*Al salir todo bien, confirmamos la transacción*/
        COMMIT;
        EXCEPTION
            WHEN NO_EXISTE_USUARIO THEN
                 DBMS_OUTPUT.PUT_LINE('EL USUARIO NO EXISTE EN LA BASE DE DATOS O NO TIENE PERMISOS');
            WHEN NO_EXISTE_TIPO THEN
                 DBMS_OUTPUT.PUT_LINE('SELECCCIONE UN GENERO CORRECTO');
            /*SI POR X O Y MOTIVO SE PLANEA INSERTAR UN USUARIO CON UN ID YA EXISTENTE*/
            WHEN DUP_VAL_ON_INDEX THEN
                 DBMS_OUTPUT.PUT_LINE('ESTÁ INTENTANDO INSERTAR UN NUMERO DE CLIENTE YA EXISTENTE, REVISE POR FAVOR, O COMUNÍQUESE CON EL DBA');
            /*Como para la inserción únicamente vamos a evaluar si el tipo de género existe,
            sino lo ecuentra devolverá esta excepción*/
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO SE ENCONTRÓ DATO RELACIONADO A');
            /*Se agotò el tiempo de espera*/
            WHEN TIMEOUT_ON_RESOURCE THEN
                DBMS_OUTPUT.PUT_LINE('SE AGOTÓ EL TIEMPO DE ESPERA');
            /*Se intentó hacer una operación aritmética, pero no se logro realizar*/
            WHEN VALUE_ERROR THEN
                DBMS_OUTPUT.PUT_LINE('ERROR DE ÍNDOLE ARITMÉTICO');
            /*En un parámetro que es de tipo numérico se ingresa un caracter distinto a un número*/
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('FALLÓ LA CONVERSIÓN DE UN STRING O CARACTER A NÚMERO');
            /*No se permitió el acceso a la base de datos*/
            WHEN LOGIN_DENIED THEN
                DBMS_OUTPUT.PUT_LINE('ERROR AL MOMENTO DE REALIZAR EL LOGIN EN LA BASE DE DATOS');
            /*Si se presenta otro tipo de error*/
            WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('OCURRIÓ UN ERROR    '||SQLCODE||'    Mensaje:    '||SQLERRM);
        /*En dado caso la transacción presenta algún problema durante su uso, la revertimos*/
        ROLLBACK;
/*FIN DEL PROCEDIMIENTO ALMACENADO*/
END PROC_CREAR_CLIENTE;
/


/* 4.- CAMPO AUTOINCREMENTABLE DE LA BITACORA DEL CLIENTE*/
CREATE OR REPLACE TRIGGER BI_BITACORA_CLIENTE 
BEFORE INSERT ON BITACORA_CLIENTE
FOR EACH ROW
BEGIN
SELECT SEQ_BITACORA_CLIENTE.NEXTVAL INTO :NEW.ID_BITACORA_CLIENTE FROM DUAL;
END BI_BITACORA_CLIENTE;
/

/* 5.- después de insertar datos en la tabla cliente debemos registrarlos en bitacora cliente (la inserción)*/

CREATE OR REPLACE TRIGGER AIUD_TBL_CLIENTE
AFTER INSERT OR UPDATE OR DELETE  ON CLIENTE
FOR EACH ROW
DECLARE
/*VARIABLE PARA HACER UNA VALIDACIOÓN SI EL USUARIO LOEGUEADO
 EXISTE*/
EXISTE_USUARIO NUMBER:=0;
BEGIN
    /*Validamos que el usuario de la base de datos exista dentro nuestros registros en la tabla usuario*/
    SELECT ID_USUARIO INTO EXISTE_USUARIO FROM USUARIO WHERE NOMBRE_USUARIO=(USER);
    IF (EXISTE_USUARIO>0)THEN
        /*después de insertar en la tabla cliente, insertamos en nustro log (bitacora_cliente)
        en este caso solo vamos a registrar la opeacioón como tal (inserción) ya que cuando actualice
        unta tupla completa o campo, lo vamos registrar y podremos saber el valor anterior y nuevo del campo que se afectado*/
            IF INSERTING THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO) 
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,2,SYSDATE,NULL,NULL,NULL);
            END IF;   
        /*si actualiza cualquier campo del cliente (a excepción del id, pues este es autoincrentable y único)*/
            IF UPDATING ('NOMBRES') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,2,:OLD.NOMBRES,:NEW.NOMBRES);
            END IF;
            IF UPDATING ('APELLIDOS') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,3,:OLD.APELLIDOS,:NEW.APELLIDOS);
            END IF;
            IF UPDATING ('DPI') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,4,:OLD.DPI,:NEW.DPI);
            END IF;
            IF UPDATING ('NIT') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,5,:OLD.NIT,:NEW.NIT);
            END IF;
            IF UPDATING ('MUNICIPIO') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,6,:OLD.MUNICIPIO,:NEW.MUNICIPIO);
            END IF;
            IF UPDATING ('DIRECCION') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,7,:OLD.DIRECCION,:NEW.DIRECCION);
            END IF;
            IF UPDATING ('TELEFONO') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,8,:OLD.TELEFONO,:NEW.TELEFONO);
            END IF;
            IF UPDATING ('CELULAR') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,9,:OLD.CELULAR,:NEW.CELULAR);
            END IF;
            IF UPDATING ('CORREO_ELECTRONICO') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,10,:OLD.CORREO_ELECTRONICO,:NEW.CORREO_ELECTRONICO);
            END IF;
            IF UPDATING ('TIPO_GENERO') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,11,:OLD.TIPO_GENERO,:NEW.TIPO_GENERO);
            END IF;
            IF UPDATING ('FECHA_NACIMIENTO') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,12,:OLD.FECHA_NACIMIENTO,:NEW.FECHA_NACIMIENTO);
            END IF;
            IF UPDATING ('IMAGEN_FIRMA') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,IMG_ANTIGUA,IMG_NUEVA)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,13,:OLD.IMAGEN_FIRMA,:NEW.IMAGEN_FIRMA);
            END IF;
            IF UPDATING ('ID_ESTATUS_CLIENTE') THEN
                INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,14,:OLD.ID_ESTATUS_CLIENTE,:NEW.ID_ESTATUS_CLIENTE);
            END IF;
    END IF;
    EXCEPTION
    /*si por algún motivo falla alguna conversión de un número*/
    WHEN INVALID_NUMBER THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||'  FALLÓ LA CONVERSIÓN DE:    '||SQLERRM);
    /*si el usuario quiere insertar un valor con un id de la tabla  ya  creado*/
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ESTÁ INTENTANDO REGISTRAR CON UN ID YA EXISTENTE, COMUNIQUESE CON EL DBA');
    /*si el  usuario no está registrado dentro de la base de datos*/
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('USTED NO TIENE PRIVILEGIOS O PERMISOS PARA CREAR ESTA OPERACION, CONTACTE CON EL DBA');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||'    ERROR:     '||'MENSAJE    '||SQLERRM);
END;
/
COMMIT;


    /*6.- FORMA DE MANDAR LOS DATOS PARA EL STORED PROCEDURE*/
    /*BLOQUE ANÒNIMO*/

    DECLARE 
    CLIENTE_N CLIENTE%ROWTYPE;
    BEGIN
    CLIENTE_N.NOMBRES:='XXXXXXXXX';
    CLIENTE_N.APELLIDOS:='XXXXXXXXXX';
    CLIENTE_N.DPI:='789456123';
    CLIENTE_N.NIT:='8659552-0';
    CLIENTE_N.MUNICIPIO:=1;
    CLIENTE_N.DIRECCION:='AV. EL CEMENTERIO 18-26 ZONA 3, GUATEMALA, GUATEMALA';
    CLIENTE_N.TELEFONO:='44533196';
    CLIENTE_N.CELULAR:='';
    CLIENTE_N.CORREO_ELECTRONICO:='walterej@hotmail.es';
    CLIENTE_N.TIPO_GENERO:=1;
    CLIENTE_N.FECHA_NACIMIENTO:=TO_DATE('20/11/1994','dd/mm/yyyy');
    CLIENTE_N.IMAGEN_FIRMA:=NULL;
    /*PROBAMOS EL PROCEDIMIENTO ALMACENADO*/
    PROC_CREAR_CLIENTE(CLIENTE_N);
    END;
    /


/********************************************************************************************/
    /*lógica del negicio de la tabla empresa y bitácora empresa*/
/********************************************************************************************/

/*1.- SECUENCIAS */
/*SECUENCIA PARA LE ID DE EMPRESAS*/
CREATE SEQUENCE SEQ_NUMERO_EMPRESAS
START WITH 1
INCREMENT BY 1;

/*SECUENCIA PARA EL ID DE LA BITACORA*/
CREATE SEQUENCE SEQ_BITACORA_EMPRESA
START WITH 1
INCREMENT BY 1; 


/*2.-TRIGGER PAX|RA CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_EMPRESA 
BEFORE INSERT ON EMPRESA
FOR EACH ROW
BEGIN
SELECT SEQ_NUMERO_EMPRESAS.NEXTVAL INTO :NEW.ID_EMPRESA FROM DUAL;
END BI_EMPRESA;
/

/*3.- VAMOS A CREAR UN PROCEDIMIENTO ALMACENADO PARA LA INSERCIÓN DE DATOS EN LA TABLA EMPRESA,
VAMOS A MANDAR COMO PARÁMETRO UNA VARIABLE TIPO %ROWTYPE PARA HACER MAS FÁCIL EL PROCESO,
*/

CREATE OR REPLACE PROCEDURE PROC_CREAR_EMPRESA(DATOS_EMPRESA EMPRESA%ROWTYPE)
    IS
    GENERO TIPO_GENERO.TIPO_GENERO%TYPE;
    NO_EXISTE_USUARIO EXCEPTION;
    ID_USUARIO_EXISTENTE NUMBER;
    /*CON ESTA VARIABLE VAMOS A VALIDAR QUE EL CLIENTE QUE 
    ESTÉ ASOCIADO A UNA EMPRESA EXISTE EN LA TABLA CLIENTE*/
    ID_EXISTE_REPRESENTANTE NUMBER;
    /*EL USUARIO DEBE DE ESTAR ACTIVO PARA INSERTAR SI SEGÚN SU ROL TIENE ESTE PRIVILEGIO*/
    USUARIO_ACT ESTATUS_USUARIO.NOMBRE%TYPE;
    BEGIN
        /*VERIFICAMOS CON EL USUARIO QUE SE HAYAN LOGEADO EN EL SISTEMA ESTÁ, DENTRO DE NUESTRA TABLA USUARIO DEL NEGOCIO
        Y A LA  VEZ SI ESTÁ HABILITADO*/
        SELECT ID_USUARIO INTO ID_USUARIO_EXISTENTE  FROM USUARIO WHERE NOMBRE_USUARIO=(SELECT USERNAME FROM ALL_USERS WHERE USERNAME=USER);
          /*validamos si el usuario está activo*/
           /*SE PUDIESE SER DE OTRA FORMA MAS LIMPIA, PERO
            POR FINES DE APRENDIZAJE SE HIZO EL INNER JOIN*/
        SELECT  NOMBRE  INTO USUARIO_ACT FROM ESTATUS_USUARIO ET
            INNER JOIN USUARIO USR
            ON ET.ID_ESTATUS_USUARIO=USR.ESTATUS_USUARIO
            WHERE  USR.ID_USUARIO=ID_USUARIO_EXISTENTE;
       
        /*VERIFICO SI EL ID DEL CLIENTE QUE ME ESTÁN ENVIANDO COMO PARÁMETRO DE INSERCIÓN
        EXISTE EN MI TABLA CLIENTE*/
        SELECT ID_CLIENTE_NUMERO INTO ID_EXISTE_REPRESENTANTE FROM CLIENTE WHERE ID_CLIENTE_NUMERO=DATOS_EMPRESA.ID_REPRESENTANTE_LEGAL;

        /*SI EXISTE EL USUARIO QUE ESTÁ INTENTANTDO INSERTAR DATOS,
        SI ESTE ESTÁ ACTIVO Y SI HAY YA UN CLIENTE CREADO EN LA TABLA CLIENTE*/
        IF(ID_USUARIO_EXISTENTE>0 AND USUARIO_ACT='ACTIVO' AND ID_EXISTE_REPRESENTANTE>0 ) THEN
            /*si todo transcurre con normalidad, insertamos datos EL ESTATUS 1 QUIERE DECIR QUE POR DEFECTO VAMOS A ACTIVAR AL EMPRESA*/
            INSERT INTO EMPRESA(ID_REPRESENTANTE_LEGAL,NOMBRE,DIRECCION,NIT,TELEFONO,
            CORREO,ID_MUNICIPIO,FECHA_CREACION,ID_ESTATUS,NO_PATENTE)
            VALUES(DATOS_EMPRESA.ID_REPRESENTANTE_LEGAL, DATOS_EMPRESA.NOMBRE,DATOS_EMPRESA.DIRECCION,
            DATOS_EMPRESA.NIT, DATOS_EMPRESA.TELEFONO, DATOS_EMPRESA.CORREO,
            DATOS_EMPRESA.ID_MUNICIPIO,SYSDATE,1,DATOS_EMPRESA.NO_PATENTE);
        /*SINO EXISTE EL TIPO LEVANTAMOS UNA EXCEPCION PROPIA*/
        ELSE
            IF(ID_USUARIO_EXISTENTE<=0) THEN
                RAISE NO_EXISTE_USUARIO;
            END IF;    
        END IF;
        /*Al salir todo bien, confirmamos la transacción*/
        COMMIT;
        EXCEPTION
            WHEN NO_EXISTE_USUARIO THEN
                 DBMS_OUTPUT.PUT_LINE('EL USUARIO NO EXISTE EN LA BASE DE DATOS O NO TIENE PERMISOS');
            /*SI POR X O Y MOTIVO SE PLANEA INSERTAR UN USUARIO CON UN ID YA EXISTENTE*/
            WHEN DUP_VAL_ON_INDEX THEN
                 DBMS_OUTPUT.PUT_LINE('ESTÁ INTENTANDO INSERTAR UN NUMERO DE EMPRESA YA EXISTENTE, REVISE POR FAVOR, O COMUNÍQUESE CON EL DBA');
            /*Como para la inserción únicamente vamos a evaluar si el tipo de género existe,
            sino lo ecuentra devolverá esta excepción*/
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO SE ENCONTRÓ DATO RELACIONADO A');
            /*Se agotò el tiempo de espera*/
            WHEN TIMEOUT_ON_RESOURCE THEN
                DBMS_OUTPUT.PUT_LINE('SE AGOTÓ EL TIEMPO DE ESPERA');
            /*Se intentó hacer una operación aritmética, pero no se logro realizar*/
            WHEN VALUE_ERROR THEN
                DBMS_OUTPUT.PUT_LINE('ERROR DE ÍNDOLE ARITMÉTICO');
            /*En un parámetro que es de tipo numérico se ingresa un caracter distinto a un número*/
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('FALLÓ LA CONVERSIÓN DE UN STRING O CARACTER A NÚMERO');
            /*No se permitió el acceso a la base de datos*/
            WHEN LOGIN_DENIED THEN
                DBMS_OUTPUT.PUT_LINE('ERROR AL MOMENTO DE REALIZAR EL LOGIN EN LA BASE DE DATOS');
            /*Si se presenta otro tipo de error*/
            WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('OCURRIÓ UN ERROR    '||SQLCODE||'    Mensaje:    '||SQLERRM);
        /*En dado caso la transacción presenta algún problema durante su uso, la revertimos*/
        ROLLBACK;
/*FIN DEL PROCEDIMIENTO ALMACENADO*/
END PROC_CREAR_EMPRESA;
/

/* 4.- CAMPO AUTOINCREMENTABLE DE LA BITACORA DEL EMPRESA*/
CREATE OR REPLACE TRIGGER BI_BITACORA_EMPRESA 
BEFORE INSERT ON BITACORA_EMPRESA
FOR EACH ROW
BEGIN
SELECT SEQ_BITACORA_EMPRESA.NEXTVAL INTO :NEW.ID_OPERACION FROM DUAL;
END BI_BITACORA_EMPRESA;
/

/* 5.- después de insertar datos en la tabla EMPRESA debemos registrarlos en bitacora EMPRESA (la inserción)*/
CREATE OR REPLACE TRIGGER AIUD_TBL_EMPRESA
AFTER INSERT OR UPDATE OR DELETE  ON EMPRESA
FOR EACH ROW
DECLARE
/*VARIABLE PARA HACER UNA VALIDACIOÓN SI EL USUARIO LOEGUEADO
 EXISTE*/
EXISTE_USUARIO NUMBER:=0;
/*expeciones propias*/
BEGIN
    /*Validamos que el usuario de la base de datos exista dentro nuestros registros en la tabla usuario*/
    SELECT ID_USUARIO INTO EXISTE_USUARIO FROM USUARIO WHERE NOMBRE_USUARIO=(SELECT USERNAME FROM ALL_USERS WHERE USERNAME=USER);
    /*SE PUDIESE SER DE OTRA FORMA MAS LIMPIA, PERO
        POR FINES DE APRENDIZAJE SE HIZO EL INNER JOIN*/
    IF (EXISTE_USUARIO>0)THEN
        /*después de insertar en la tabla EMPRESA, insertamos en nustro log (bitacora_EMPRESA)
        en este caso solo vamos a registrar la opeacioón como tal (inserción) ya que cuando actualice
        unta tupla completa o campo, lo vamos registrar y podremos saber el valor anterior y nuevo del campo que se afectado*/
            IF INSERTING THEN
                INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,NULL,NULL,SYSDATE,'',NULL,2,EXISTE_USUARIO);
            END IF;   
        /*si actualiza cualquier campo del EMPRESA (a excepción del id, pues este es autoincrentable y único)*/
            IF UPDATING ('ID_REPRESENTANTE_LEGAL') THEN
               INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.ID_REPRESENTANTE_LEGAL,:NEW.ID_REPRESENTANTE_LEGAL,SYSDATE,'',2,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('NOMBRE') THEN
                INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.NOMBRE,:NEW.NOMBRE,SYSDATE,'',3,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('DIRECCION') THEN
                INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.DIRECCION,:NEW.DIRECCION,SYSDATE,'',4,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('NIT') THEN
                INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.NIT,:NEW.NIT,SYSDATE,'',5,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('TELEFONO') THEN
               INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.TELEFONO,:NEW.TELEFONO,SYSDATE,'',6,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('CORREO') THEN
               INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.CORREO,:NEW.CORREO,SYSDATE,'',7,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('ID_MUNICIPIO') THEN
                INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.ID_MUNICIPIO,:NEW.ID_MUNICIPIO,SYSDATE,'',8,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('ID_ESTATUS') THEN
                INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.ID_ESTATUS,:NEW.ID_ESTATUS,SYSDATE,'',9,1,EXISTE_USUARIO);
            END IF;
            IF UPDATING ('NO_PATENTE') THEN
             INSERT INTO BITACORA_EMPRESA (ID_EMPRESA, VALOR_ANTERIOR, VALOR_NUEVO,FECHA_MODIFICACION,
                DETALLES,CAMPO_AFECTADO,TIPO_OPERACION,ID_USUARIO) 
                VALUES(:NEW.ID_EMPRESA,:OLD.NO_PATENTE,:NEW.NO_PATENTE,SYSDATE,'',10,1,EXISTE_USUARIO);
            END IF;
    END IF;
    EXCEPTION
    /*si por algún motivo falla alguna conversión de un número*/
    WHEN INVALID_NUMBER THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||'  FALLÓ LA CONVERSIÓN DE:    '||SQLERRM);
    /*si el usuario quiere insertar un valor con un id de la tabla  ya  creado*/
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ESTÁ INTENTANDO REGISTRAR CON UN ID YA EXISTENTE, COMUNIQUESE CON EL DBA');
    /*si el  usuario no está registrado dentro de la base de datos*/
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('USTED NO TIENE PRIVILEGIOS O PERMISOS PARA CREAR ESTA OPERACION, CONTACTE CON EL DBA');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||'    ERROR:     '||'MENSAJE    '||SQLERRM);
END;
/
COMMIT;


/*6.- FORMA DE MANDAR LOS DATOS PARA EL STORED PROCEDURE*/
/*BLOQUE ANÒNIMO*/

DECLARE 
EMPRESA_N EMPRESA%ROWTYPE;
BEGIN
EMPRESA_N.ID_REPRESENTANTE_LEGAL:='1';
EMPRESA_N.NOMBRE:='EMPRESA 1';
EMPRESA_N.DIRECCION:='AV. EL CEMENTERIO 18-26 ZONA 3, GUATEMALA, GUATEMALA';
EMPRESA_N.NIT:='189168-0';
EMPRESA_N.TELEFONO:='1596548';
EMPRESA_N.CORREO:='empresa@google.com';
EMPRESA_N.ID_MUNICIPIO:=1;
/*PROBAMOS EL PROCEDIMIENTO ALMACENADO*/
PROC_CREAR_EMPRESA(EMPRESA_N);
END;
/












