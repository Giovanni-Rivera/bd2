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
    BEGIN
        /*Evaluamos SI EL TIPO DE GENERO SELECCIONADO EXISTE DENTRO DE LOS YA
        ESTABLECIDOS EN LA BASE DE DATOS*/
        SELECT COUNT(TIPO_GENERO) INTO GENERO FROM TIPO_GENERO WHERE TIPO_GENERO=DATOS_CLIENTE.TIPO_GENERO; 
        /*VERIFICAMOS CON EL USUARIO QUE SE HAYAN LOGEADO EN EL SISTEMA ESTÁ, DENTRO DE NUESTRA TABLA USUARIO DEL NEGOCIO
        Y A LA  VEZ SI ESTÁ HABILITADO*/
        SELECT ID_USUARIO INTO ID_USUARIO_EXISTENTE  FROM USUARIO WHERE NOMBRE_USUARIO=(SELECT USERNAME FROM ALL_USERS WHERE USERNAME=USER);
        IF(GENERO>0 AND ID_USUARIO_EXISTENTE>0) THEN
            /*si todo transcurre con normalidad, insertamos datos*/
            INSERT INTO CLIENTE(NOMBRES,APELLIDOS,DPI,NIT,MUNICIPIO,DIRECCION,TELEFONO,CELULAR,CORREO_ELECTRONICO,TIPO_GENERO,FECHA_NACIMIENTO,IMAGEN_FIRMA)
            VALUES(DATOS_CLIENTE.NOMBRES,DATOS_CLIENTE.APELLIDOS,DATOS_CLIENTE.DPI,DATOS_CLIENTE.NIT,DATOS_CLIENTE.MUNICIPIO,DATOS_CLIENTE.DIRECCION,DATOS_CLIENTE.TELEFONO,DATOS_CLIENTE.CELULAR,
            DATOS_CLIENTE.CORREO_ELECTRONICO, DATOS_CLIENTE.TIPO_GENERO,DATOS_CLIENTE.FECHA_NACIMIENTO,DATOS_CLIENTE.IMAGEN_FIRMA);
        /*SINO EXISTE EL TIPO LEVANTAMOS UNA EXCEPCION PROPIA*/
        ELSE
            IF(GENERO=0) THEN
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
CREATE OR REPLACE TRIGGER AI_TBL_CLIENTE
AFTER INSERT OR UPDATE ON CLIENTE
FOR EACH ROW
DECLARE
EXISTE_USUARIO NUMBER:=0;
BEGIN
    SELECT ID_USUARIO INTO EXISTE_USUARIO FROM USUARIO WHERE NOMBRE_USUARIO=(SELECT USERNAME FROM ALL_USERS WHERE USERNAME=USER);
    /*SI EL USUARIO EXISTE DENTRO DEL SISTEMA*/
    
    IF EXISTE_USUARIO=1 THEN
        IF INSERTING THEN
            INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO) 
            VALUES(:NEW.ID_CLIENTE_NUMERO,EXISTE_USUARIO,2,SYSDATE,NULL,NULL,NULL);
        END IF;
        IF UPDATING ('NOMBRES') THEN
             INSERT INTO BITACORA_CLIENTE (ID_CLIENTE,ID_USUARIO,TIPO_TRANSACCION,FECHA,ID_CAMPO_AFECTADO,VALOR_ANTIGUO,VALOR_NUEVO)
             VALUES(:OLD.ID_CLIENTE_NUMERO,EXISTE_USUARIO,1,SYSDATE,2,'XXX','ZZZ');
        END IF;
    END IF;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ESTÁ INTENTANDO REGISTRAR CON UN ID YA EXISTENTE, COMUNIQUESE CON EL DBA');
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
CLIENTE_N.NOMBRES:='WALTER GIOVANNI';
CLIENTE_N.APELLIDOS:='RIVERA LÓPEZ';
CLIENTE_N.DPI:='265609010101';
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

/*para saber que triggers tiene una tabla*/
SELECT   *
  FROM   user_triggers
WHERE   table_name = 'CLIENTE' 
   AND   trigger_type LIKE '%EACH ROW'


/*hasta acá termina lo relacionado con el cliente (lógica del negocio*/







/*---------------------------------------------xxxxxxxxxxxxxxxxxxxx-------------------------------------*/

/*CAMPO_BITACORA_CLIENTE: ESTA TABLA TIENE LOS ID DE LOS CAMPOS QUE FUERON AFECTADOS*/
/*TP_TRANSACC_BITACORA_CLIENTE 
1- MODIFICACION
2- INSERCION
3.- BAJA */







Funcion asignar tipo de cuenta
    si es ahorro = 1
    si es monetaria = 2

si es menor a 10
    agregar "00"||numero
si es menor a 100 y mayor o igual a 10
    agregar "0"||numero
sie es mayor o igual a 100 y menor a 1000
    numero

else
    numero agencia superado


crear secuencia para campo autoincrementable

numero_aleatorio


/*NUMERO DE AGENCIA*/
DECLARE
X VARCHAR2(8):='00001';
Y NUMBER(8);
BEGIN
Y:=TO_NUMBER(X);

DBMS_OUTPUT.PUT_lINE(Y);
END;

/*NUMERO ALEATORIO*/
BEGIN 
DBMS_OUTPUT.PUT_LINE(ROUND(DBMS_RANDOM.VALUE(0,9)));
END;


/*vamos a crear 2 secuencias,
una para que lleve el control de los ID DE cuentas monetarias y otro 
para cuentas de ahorro*/
/*SECUENCIA PARA LLEVAR EL CONTROL DE LOS ID_DE CUENTAS MONETARIAS*/
CREATE SEQUENCE ID_CUENTA_MONETARIA
START WITH 1
INCREMENT BY 1;

/*SECUENCIA PARA LLEVAR EL CONTROL DE LOS ID DE LAS CUENTAS DE AHORRO*/
CREATE SEQUENCE ID_CUENTA_AHORRO
START WITH 1
INCREMENT BY 1;

select * from agencia;



CREATE OR REPLACE PROCEDURE CREAR_CUENTA(TIPO_CUENTA VARCHAR2,AGENCIA NUMBER)
IS
ESTADO_CUENTA NUMBER;

BEGIN




END/;





