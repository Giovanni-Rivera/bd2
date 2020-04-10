/*antes de tener una cuenta, debe existir un CLIENTE
por lo que procedemos a crearlo por medio de plsql*/
/*1.- creamos una secuencia para llevar el control de los correlativos*/

CREATE SEQUENCE SEQ_NUMERO_CLIENTE
START WITH 1
INCREMENT BY 1;


/*1.1- PARA QUE EL ID SEA AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_CLIENTE
    BEFORE INSERT ON CLIENTE
    FOR EACH ROW
    BEGIN 
        SELECT SEQ_NUMERO_CLIENTE.NEXTVAL INTO :NEW.ID_CLIENTE_NUMERO FROM DUAL;
END;
/

/*2.- debemos crear el directorio donde vamos a almacenar las firmas de los clientes*/
/*2.1 definimos el nombre del directorio y la ruta*/
CREATE OR REPLACE DIRECTORY IMAGENES AS 'C:\firmas';
/*2.2 - otorgamos los permisos a los usuarios dependiendo su  rol en el sistema*/
GRANT READ, WRITE ON DIRECTORY IMAGENES TO HR WITH GRANT OPTION; 


/*3.- VAMOS A CREAR UN PROCEDIMIENTO ALMACENADO PARA LA INSERCIÓN DE DATOS EN LA TABLA CLIENTE,
VAMOS A MANDAR COMO PARÁMETRO UNA VARIABLE TIPO %ROWTYPE PARA HACER MAS FÁCIL EL PROCESO,
*/
CREATE OR REPLACE PROCEDURE PROC_CREAR_CLIENTE(DATOS_CLIENTE CLIENTE%ROWTYPE)
    IS
    GENERO TIPO_GENERO.TIPO_GENERO%TYPE;
    NO_EXISTE_TIPO EXCEPTION;
    BEGIN
        /*Evaluamos SI EL TIPO DE GENERO SELECCIONADO EXISTE DENTRO DE LOS YA
        ESTABLECIDOS EN LA BASE DE DATOS*/
        SELECT COUNT(TIPO_GENERO) INTO GENERO FROM TIPO_GENERO WHERE TIPO_GENERO=DATOS_CLIENTE.TIPO_GENERO; 
        IF(GENERO>0) THEN
            /*si todo transcurre con normalidad, insertamos datos*/
            INSERT INTO CLIENTE(NOMBRES,APELLIDOS,DPI,NIT,MUNICIPIO,DIRECCION,TELEFONO,CELULAR,CORREO_ELECTRONICO,TIPO_GENERO,FECHA_NACIMIENTO,IMAGEN_FIRMA)
            VALUES(DATOS_CLIENTE.NOMBRES,DATOS_CLIENTE.APELLIDOS,DATOS_CLIENTE.DPI,DATOS_CLIENTE.NIT,DATOS_CLIENTE.MUNICIPIO,DATOS_CLIENTE.DIRECCION,DATOS_CLIENTE.TELEFONO,DATOS_CLIENTE.CELULAR,
            DATOS_CLIENTE.CORREO_ELECTRONICO, DATOS_CLIENTE.TIPO_GENERO,DATOS_CLIENTE.FECHA_NACIMIENTO,DATOS_CLIENTE.IMAGEN_FIRMA);
        /*SINO EXISTE EL TIPO LEVANTAMOS UNA EXCEPCION PROPIA*/
        ELSE
          RAISE NO_EXISTE_TIPO;
        END IF;
        /*Al salir todo bien, confirmamos la transacción*/
        COMMIT;
        EXCEPTION
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

/*FORMA DE MANDAR LOS DATOS PARA EL STORED PROCEDURE*/
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






