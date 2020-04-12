/*antes de tener una cuenta, debe existir un CLIENTE
por lo que procedemos a crearlo por medio de plsql*/
/*1.- creamos una secuencia para llevar el control de los correlativos EN LAS DISTINTAS TABLAS QUE TENGAN
QUE VER CON CLIENTE, EN ESTA CASO ELLA MISMA Y SU BITÁCORA*/

/*SECUENCIA PARA LE ID DE CLIENTES*/
CREATE SEQUENCE SEQ_NUMERO_USUARIO
START WITH 1
INCREMENT BY 1;
COMMIT;

/*SECUENCIA PARA EL ID DE LA BITACORA*/
CREATE SEQUENCE SEQ_BITACORA_USUARIO
START WITH 1
INCREMENT BY 1; 
COMMIT;

/*2.- debemos crear el directorio donde vamos a almacenar las firmas de los clientes*/
/*2.1 definimos el nombre del directorio y la ruta*/
CREATE OR REPLACE DIRECTORY DIR_USUARIO AS 'C:\USUARIO_FOTOGRAFIA';
/*2.2 - otorgamos los permisos a los usuarios debemos crear un rol y los permisos que tendrá a ciertas tablas*/
GRANT READ, WRITE ON DIRECTORY DIR_USUARIO TO HR WITH GRANT OPTION; 
COMMIT;

/*TRIGGER PARA CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_USUARIO 
BEFORE INSERT ON USUARIO
FOR EACH ROW
BEGIN
SELECT SEQ_BITACORA_USUARIO.NEXTVAL INTO :NEW.ID_USUARIO FROM DUAL;
END BI_CLIENTE;
COMMIT;
/

/*3.- VAMOS A CREAR UN PROCEDIMIENTO ALMACENADO PARA LA INSERCIÓN DE DATOS EN LA TABLA CLIENTE,
VAMOS A MANDAR COMO PARÁMETRO UNA VARIABLE TIPO %ROWTYPE PARA HACER MAS FÁCIL EL PROCESO,
*/
CREATE OR REPLACE PROCEDURE PROC_CREAR_USUARIO(DATOS_USUARIO USUARIO%ROWTYPE)
    IS
    GENERO TIPO_GENERO.TIPO_GENERO%TYPE;
    NO_EXIST_TIPO EXCEPTION;
    NO_EXIST_USR EXCEPTION;
    ID_USR_EXISTENTE NUMBER;
    /*EL USUARIO DEBE DE ESTAR ACTIVO PARA INSERTAR SI SEGÚN SU ROL TIENE ESTE PRIVILEGIO*/
    USUARIO_ACT ESTATUS_USUARIO.NOMBRE%TYPE;
    BEGIN
        /*Evaluamos SI EL TIPO DE GENERO SELECCIONADO EXISTE DENTRO DE LOS YA
        ESTABLECIDOS EN LA BASE DE DATOS*/
        SELECT COUNT(TIPO_GENERO) INTO GENERO FROM TIPO_GENERO WHERE TIPO_GENERO=DATOS_CLIENTE.TIPO_GENERO; 
        IF(GENERO>0) THEN
            /*si todo transcurre con normalidad, insertamos datos EL ESTATUS 1 QUIERE DECIR QUE POR DEFECTO VAMOS A ACTIVAR AL CLIENTE*/
            INSERT INTO USUARIO()
            VALUES);
        /*SINO EXISTE EL TIPO LEVANTAMOS UNA EXCEPCION PROPIA*/
        ELSE
            IF(GENERO=0) THEN
                RAISE NO_EXIST_TIPO;
            ELSIF(ID_USR_EXISTENTE<=0) THEN
                RAISE NO_EXIST_USR;
            END IF;    
        END IF;
        /*Al salir todo bien, confirmamos la transacción*/
        COMMIT;
        EXCEPTION
            WHEN NO_EXIST_USR THEN
                 DBMS_OUTPUT.PUT_LINE('EL USUARIO NO EXISTE EN LA BASE DE DATOS O NO TIENE PERMISOS');
            WHEN NO_EXIST_TIPO THEN
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
CREATE OR REPLACE TRIGGER BI_BITACORA_USUARIO 
BEFORE INSERT ON BITACORA_USUARIO
FOR EACH ROW
BEGIN
SELECT SEQ_BITACORA_USUARIO.NEXTVAL INTO :NEW.ID_OPERACION FROM DUAL;
END BI_BITACORA_USUARIO;
/

/* 5.- después de insertar datos en la tabla cliente debemos registrarlos en bitacora cliente (la inserción)*/
/* 5.- después de insertar datos en la tabla cliente debemos registrarlos en bitacora cliente (la inserción)*/
CREATE OR REPLACE TRIGGER AIUD_TBL_USUARIO
AFTER INSERT OR UPDATE OR DELETE  ON USUARIO
FOR EACH ROW
DECLARE
BEGIN
            IF INSERTING THEN
                INSERT INTO BITACORA_USUARIO (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO) 
                VALUES(:NEW.ID_USUARIO_NUMERO,EXISTE_USUARIO,2,SYSDATE,NULL,NULL,NULL);
            END IF;   
            IF UPDATING ('NOMBRES') THEN
                INSERT INTO BITACORA_USUARIO (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
                VALUES(:NEW.ID_USUARIO_NUMERO,EXISTE_USUARIO,1,SYSDATE,2,:OLD.NOMBRES,:NEW.NOMBRES);
            
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
USUARIO_N CLIENTE%ROWTYPE;
BEGIN
/*
USUARIO_N.NOMBRES:='WALTER GIOVANNI';
USUARIO_N.APELLIDOS:='RIVERA LÓPEZ';
USUARIO_N.DPI:='265609010101';
USUARIO_N.NIT:='8659552-0';
USUARIO_N.MUNICIPIO:=1;
USUARIO_N.DIRECCION:='AV. EL CEMENTERIO 18-26 ZONA 3, GUATEMALA, GUATEMALA';
USUARIO_N.TELEFONO:='44533196';
USUARIO_N.CELULAR:='';
USUARIO_N.CORREO_ELECTRONICO:='walterej@hotmail.es';
USUARIO_N.TIPO_GENERO:=1;
USUARIO_N.FECHA_NACIMIENTO:=TO_DATE('20/11/1994','dd/mm/yyyy');
USUARIO_N.IMAGEN_FIRMA:=NULL;
*/
/*PROBAMOS EL PROCEDIMIENTO ALMACENADO*/
PROC_CREAR_CLIENTE(USUARIO_N);
END;
/