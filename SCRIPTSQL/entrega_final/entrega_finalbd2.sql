/*funcion para validar la existencia de una chequera para una cuenta*/

CREATE OR REPLACE FUNCTION EXISTE_CHEQUERA(NO_CUENTA VARCHAR2)
RETURN NUMBER IS
V1 NUMBER;

BEGIN

SELECT COUNT(*) INTO V1 FROM CHEQUERA WHERE NO_CUENTA=CHEQUERA.ID_CUENTA AND ID_ESTATUS=1;

    IF (V1=1) THEN
    RETURN 1;
    ELSE
    RETURN 0;
    END IF;
    
END EXISTE_CHEQUERA;





/*CUENTAS */
/*PARA EL CALCULO DE INTERES,EN CUENTA DE AHORRO, SOLO SE OPERA, LUEGO
SE DEBEN LEER*/

/*CREANDO SECUNECIA Y TRIGGER PARA LA TABLA BITÁCORA LIBRETA*/

/*SECUENCIA PARA EL ID DE LA BITACORA*/
CREATE SEQUENCE SEQ_BITACORA_LIBRETA
START WITH 1
INCREMENT BY 1; 

/*TRIGGER PARA CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_BIT_LIBRETA 
BEFORE INSERT ON BITACORA_LIBRETA
FOR EACH ROW
BEGIN
SELECT SEQ_BITACORA_LIBRETA.NEXTVAL INTO :NEW.ID_BITACORA_LIBRETA FROM DUAL;
END BI_CLIENTE;
/


/*1.- PROCEDIMIENTO ALMACENADO PARA CALCULAR LOS INTERES EN CUENTAS DE AHORRO*/
CREATE OR REPLACE PROCEDURE CALCULAR_INTERES_AHORRO
(NUMEROS_CUENTAS VARCHAR2, MONTO_DISPONIBLE NUMBER)
IS
INTERES_TOTAL NUMBER(6,2);
NUMERO_LIBRETA NUMBER(15);
MONTO_DISPONIBLE_ANTERIOR NUMBER(12,2);
BEGIN
/*1.- VAMOS A TRAER EL NUMERO DE LA LIBRETA DE LA CUENTA PARA REGISTRAR LA CARGA DE INTERES*/
SELECT EXTRAER_LIBRETA(NUMEROS_CUENTAS) INTO NUMERO_LIBRETA FROM DUAL;
dbms_output.put_line(NUMERO_LIBRETA);
/*2.- GUARDAMOS EL VALOR ANTERIOR DEL SALDO PARA LUEGO REGISTRAR EL MOVIMIENTO EN LA BITACORA Y EN LA LIBRETA*/
SELECT MONTO_DISPONIBLE INTO MONTO_DISPONIBLE_ANTERIOR FROM CUENTA WHERE CUENTA.ID_CUENTA= NUMEROS_CUENTAS;
SELECT MONTO_DISPONIBLE*1.03 INTO INTERES_TOTAL FROM DUAL;
UPDATE CUENTA SET MONTO_DISPONIBLE=INTERES_TOTAL WHERE ID_CUENTA=NUMEROS_CUENTAS;


/*6.- REGISTRAMOS EL MOVIMIENTO DE CARGA DE INTERES EN LA BITACORA_LIBRETA*/
INSERT INTO BITACORA_LIBRETA (ID_LIBRETA,TIPO_TRANSACCION, FECHA, VALOR_ANTIGUO, VALOR_NUEVO)
VALUES(NUMERO_LIBRETA,1,SYSDATE,MONTO_DISPONIBLE_ANTERIOR,INTERES_TOTAL);

/*7.- REGISTRANDO EL DATO EN BITACORA_TRANSACCION*/
INSERT INTO BITACORA_TRANSACCION (ID_CUENTA,ID_LIBRETA,ID_TIPO,MONTO,SALDO_ANTERIOR,SALDO_NUEVO,FECHA,ID_ESTADO)
VALUES(NUMEROS_CUENTAS,NUMERO_LIBRETA,41,INTERES_TOTAL-MONTO_DISPONIBLE_ANTERIOR,MONTO_DISPONIBLE_ANTERIOR,
INTERES_TOTAL,SYSDATE,2);
COMMIT;
EXCEPTION
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
END;

/*2.- PROCEDIMIENTO EN EL CUAL VAMOS A IR A EXTRAER TODAS LAS CUENTAS DE AHORRO 
POR MEDIO DE UN CURSOR PARA LUEGO RECORRELO Y OTORGAR EL INTERES*/
CREATE OR REPLACE PROCEDURE PROC_ADDINTERES_CUENTA_AHORR0
IS
CURSOR VER_CUENTAS IS 
SELECT * FROM CUENTA CU 
INNER JOIN ESTATUS_CUENTA ET
ON et.id_estatus_cuenta=cu.id_estatus
INNER JOIN TIPO_CUENTA TC
ON tc.id_tipo_cuenta=cu.id_tipo
WHERE et.nombre='HABILITADA'
AND CU.MONTO_DISPONIBLE>0 
AND tc.nombre='DE AHORRO' ORDER BY CU.ID_CUENTA ASC;
DIFERENCIA_FECHA TIMESTAMP;
BEGIN
SELECT ADD_MONTHS(TO_DATE(trunc(SYSDATE,'dd'),'DD/MM/YYYY'),0) INTO DIFERENCIA_FECHA FROM DUAL;
FOR I IN VER_CUENTAS LOOP
IF( TO_DATE(trunc(i.fecha_creacion,'dd'),'DD/MM/YYYY')<DIFERENCIA_FECHA) THEN
 CALCULAR_INTERES_AHORRO(I.ID_CUENTA,I.MONTO_DISPONIBLE);
END IF;
END LOOP;
DBMS_OUTPUT.PUT_LINE('INTERESES A CUENTAS DE AHORRO GENERADOS CON ÉXITO');
COMMIT;
EXCEPTION
/*Como para la inserción únicamente vamos a evaluar si el tipo de género existe,
            sino lo ecuentra devolverá esta excepción*/
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO EXISTEN CUENTAS DE AHORRO, O NO TIENEN MAS DE TREINTA DIAS DE VIGENCIA');
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
END;

/*viendo antes de generar intereses*/
begin
REPORTE_INTERES_AHORRO;
end;


/*probando*/
begin
PROC_ADDINTERES_CUENTA_AHORR0;
end;



/*viendo despues de generar intereses*/
begin
REPORTE_INTERES_AHORRO;
end;

SELECT * FROM BITACORA_LIBRETA;
SELECT * FROM BITACORA_TRANSACCION;

/*******************************************************************************************/
/*3.- DESPUES DE HABER UPDATIADO LAS CUENTAS, MOSTRAMOS LOS RESULTADOS, PUES
SI SE HACE DESDE EL OTRO PROCEDIMIENTO (PASO 2) CAERÍAMOS EN UNA INCOSISTENCIA DE DATOS
DEBIDO A UN ERROR DE LECTURA SUCIA.*/

CREATE OR REPLACE PROCEDURE REPORTE_INTERES_AHORRO
IS
    CURSOR VER_CUENTAS IS 
        SELECT * FROM CUENTA CU 
        INNER JOIN ESTATUS_CUENTA ET
        ON et.id_estatus_cuenta=cu.id_estatus
        INNER JOIN TIPO_CUENTA TC
        ON tc.id_tipo_cuenta=cu.id_tipo
            WHERE et.nombre='HABILITADA'
                AND CU.MONTO_DISPONIBLE>0 
                AND tc.nombre='DE AHORRO' ORDER BY CU.ID_CUENTA ASC;
    DIFERENCIA_FECHA TIMESTAMP;
BEGIN
    SELECT ADD_MONTHS(TO_DATE(trunc(SYSDATE,'dd'),'DD/MM/YYYY'),0) INTO DIFERENCIA_FECHA FROM DUAL;

    DBMS_OUTPUT.PUT_LINE('D_CUENTA'||'        '||'MONTO_DISPONIBLE'||'                  '||'FECHA_CREACION'||'    '||'TIPO_CUENTA');
    FOR I IN VER_CUENTAS LOOP
    IF( TO_DATE(trunc(i.fecha_creacion,'dd'),'DD/MM/YYYY')<DIFERENCIA_FECHA) THEN
        DBMS_OUTPUT.PUT_LINE(I.ID_CUENTA||'             '||I.MONTO_DISPONIBLE||'                  '||I.FECHA_CREACION||'       AHORRO');
    END IF;
    END LOOP;
END;


/*4.0 creamos la tarea para que se ejecute cada treinta dias*/
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"PROYECTO"."INTERESES_AHORRO"',
            job_type => 'STORED_PROCEDURE',
            job_action => 'PROYECTO.PROC_ADDINTERES_CUENTA_AHORR0',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2020-05-11 22:59:00.000000000 AMERICA/REGINA','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'FREQ=MONTHLY',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => '');
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"PROYECTO"."INTERESES_AHORRO"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
    DBMS_SCHEDULER.enable(
             name => '"PROYECTO"."INTERESES_AHORRO"');
END;

SELECT * FROM CUENTA;

COMMIT;

/*4.- CONSULTAMOS EL RESULTADO DEL JOB*/
BEGIN
REPORTE_INTERES_AHORRO;
END;

SELECT * FROM BITACORA_TRANSACCION;

/*******************************************************************************************************************************************************/

/*---------------------------------CUENTAS DE AHORRO---------------------------------------------------------------------*/
/*******************************************************************************************************************************************************/

/*CUENTAS MONETARIAS*/

/*1.- PROCEDIMIENTO ALMACENADO PARA CALCULAR LOS INTERES EN CUENTAS MONETARIAS*/
CREATE OR REPLACE PROCEDURE CALCULAR_INTERES_MONETARIAS
(NUMEROS_CUENTAS VARCHAR2, MONTO_DISPONIBLE NUMBER)
IS
INTERES_TOTAL NUMBER(6,2);
MONTO_DISPONIBLE_ANTERIOR NUMBER(12,2);
BEGIN

/*1.- GUARDAMOS EL VALOR ANTERIOR DEL SALDO PARA LUEGO REGISTRAR EL MOVIMIENTO EN LA BITACORA Y EN LA LIBRETA*/
SELECT MONTO_DISPONIBLE INTO MONTO_DISPONIBLE_ANTERIOR FROM CUENTA WHERE CUENTA.ID_CUENTA= NUMEROS_CUENTAS;
SELECT MONTO_DISPONIBLE*1.015 INTO INTERES_TOTAL FROM DUAL;
UPDATE CUENTA SET MONTO_DISPONIBLE=INTERES_TOTAL WHERE ID_CUENTA=NUMEROS_CUENTAS;

/*2.- REGISTRANDO EL DATO EN BITACORA_TRANSACCION*/
INSERT INTO BITACORA_TRANSACCION (ID_CUENTA,ID_TIPO,MONTO,SALDO_ANTERIOR,SALDO_NUEVO,FECHA,ID_ESTADO)
VALUES(NUMEROS_CUENTAS,41,INTERES_TOTAL-MONTO_DISPONIBLE_ANTERIOR,MONTO_DISPONIBLE_ANTERIOR,
INTERES_TOTAL,SYSDATE,2);
COMMIT;
EXCEPTION
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
END;

/*2.- PROCEDIMIENTO EN EL CUAL VAMOS A IR A EXTRAER TODAS LAS CUENTAS MONETARIAS 
POR MEDIO DE UN CURSOR PARA LUEGO RECORRELO Y OTORGAR EL INTERES*/

CREATE OR REPLACE PROCEDURE PROC_ADDINTERES_MONETARIA
IS
CURSOR VER_CUENTAS IS 
SELECT * FROM CUENTA CU 
INNER JOIN ESTATUS_CUENTA ET
ON et.id_estatus_cuenta=cu.id_estatus
INNER JOIN TIPO_CUENTA TC
ON tc.id_tipo_cuenta=cu.id_tipo
WHERE et.nombre='HABILITADA'
AND CU.MONTO_DISPONIBLE>0 
AND tc.nombre='MONETARIA' ORDER BY CU.ID_CUENTA ASC;
DIFERENCIA_FECHA TIMESTAMP;
BEGIN
SELECT ADD_MONTHS(TO_DATE(trunc(SYSDATE,'dd'),'DD/MM/YYYY'),0) INTO DIFERENCIA_FECHA FROM DUAL;
FOR I IN VER_CUENTAS LOOP
IF( TO_DATE(trunc(i.fecha_creacion,'dd'),'DD/MM/YYYY')<DIFERENCIA_FECHA) THEN
 CALCULAR_INTERES_MONETARIAS(I.ID_CUENTA,I.MONTO_DISPONIBLE);
END IF;
END LOOP;
DBMS_OUTPUT.PUT_LINE('INTERESES A CUENTAS DE AHORRO GENERADOS CON ÉXITO');
COMMIT;
EXCEPTION
/*Como para la inserción únicamente vamos a evaluar si el tipo de género existe,
            sino lo ecuentra devolverá esta excepción*/
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('NO EXISTEN CUENTAS DE AHORRO, O NO TIENEN MAS DE TREINTA DIAS DE VIGENCIA');
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
END;



/*viendo antes de generar intereses*/
begin
REPORTE_INTERES_MONETARIO;
end;

/*probando*/
begin
PROC_ADDINTERES_MONETARIA;
end;



/*viendo despues de generar intereses*/
begin
REPORTE_INTERES_MONETARIO;
end;

SELECT * FROM BITACORA_TRANSACCION order by no_transaccion desc;













/*******************************************************************************************/
/*3.- DESPUES DE HABER UPDATIADO LAS CUENTAS, MOSTRAMOS LOS RESULTADOS, PUES
SI SE HACE DESDE EL OTRO PROCEDIMIENTO (PASO 2) CAERÍAMOS EN UNA INCOSISTENCIA DE DATOS
DEBIDO A UN ERROR DE LECTURA SUCIA.*/
CREATE OR REPLACE PROCEDURE REPORTE_INTERES_MONETARIO
IS
    CURSOR VER_CUENTAS IS 
        SELECT * FROM CUENTA CU 
        INNER JOIN ESTATUS_CUENTA ET
        ON et.id_estatus_cuenta=cu.id_estatus
        INNER JOIN TIPO_CUENTA TC
        ON tc.id_tipo_cuenta=cu.id_tipo
            WHERE et.nombre='HABILITADA'
                AND CU.MONTO_DISPONIBLE>0 
                AND tc.nombre='MONETARIA' ORDER BY CU.ID_CUENTA ASC;
    DIFERENCIA_FECHA TIMESTAMP;
BEGIN
    SELECT ADD_MONTHS(TO_DATE(trunc(SYSDATE,'dd'),'DD/MM/YYYY'),0) INTO DIFERENCIA_FECHA FROM DUAL;

    DBMS_OUTPUT.PUT_LINE('D_CUENTA'||'        '||'MONTO_DISPONIBLE'||'                  '||'FECHA_CREACION'||'    '||'TIPO_CUENTA');
    FOR I IN VER_CUENTAS LOOP
    IF( TO_DATE(trunc(i.fecha_creacion,'dd'),'DD/MM/YYYY')<DIFERENCIA_FECHA) THEN
        DBMS_OUTPUT.PUT_LINE(I.ID_CUENTA||'             '||I.MONTO_DISPONIBLE||'                  '||I.FECHA_CREACION||'       AHORRO');
    END IF;
    END LOOP;
END;


/*4.- JOB PARA CALCULAR EL JOB A FIN DE MES CUENTAS MONETARIAS*/
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"PROYECTO"."INTERESES_MONETARIA"',
            job_type => 'STORED_PROCEDURE',
            job_action => 'PROYECTO.PROC_ADDINTERES_MONETARIA',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2020-05-22 22:59:00.000000000 AMERICA/REGINA','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'FREQ=MONTHLY',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => '');
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"PROYECTO"."INTERESES_MONETARIA"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
    DBMS_SCHEDULER.enable(
             name => '"PROYECTO"."INTERESES_MONETARIA"');
END;



/*viendo ver el resultado del job*/
begin
REPORTE_INTERES_MONETARIO;
end;

SELECT * FROM BITACORA_TRANSACCION order by no_transaccion desc;




/*-------------------------------------REPORTERÍA------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------------------------------*/



/*REPORTERÍA*/

/*1- REPORTE DE ESTADOS DE CUENTA CON RANGO DE FECHAS Y CUENTA*/


CREATE OR REPLACE PROCEDURE REPORTE_ESTADO_CUENTA(FECHA_INICIAL VARCHAR2, FECHA_FINAL VARCHAR2, NUMERO_CUENTA VARCHAR2)
IS
/*PARA GUARDAR SI EXISTE LA FUNCION*/
EXISTE_CUENTA_N NUMBER;

/*EXCEPCION PERSONALIZADA POR SI LA CUENTA NO EXISTE */
NO_EXISTE_CUENTA EXCEPTION;

/*CURSOR PARA EXTRAER DATOS ACORDE A LA CUENTA*/
    CURSOR VER_CUENTAS IS 
     SELECT ID_CUENTA, MONTO, SALDO_ANTERIOR, SALDO_NUEVO, FECHA,et.descripcion,ttrs.nombre  
     FROM BITACORA_TRANSACCION BT
     INNER JOIN TIPO_TRANSACCION TTRS
     ON 
     ttrs.id_tipo_transaccion=BT.ID_TIPO
     INNER JOIN ESTADO_TRANSACCION_GEN ET
     on
     et.id_estado=bt.id_estado
     WHERE BT.ID_CUENTA=NUMERO_CUENTA order by no_transaccion desc;
    
/*PARA ALMACENAR LAS FECHAS*/ 
INICIO DATE;
FIN DATE;

BEGIN

SELECT FUNCT_EXISTE_CUENTA(NUMERO_CUENTA)INTO EXISTE_CUENTA_N FROM DUAL;

IF(EXISTE_CUENTA_N<>0) THEN
/*CONVERTIR LAS FECHAS QUE ENVÍAN EN FORMATO STRING A FORMATO DATE*/
 SELECT TO_DATE(FECHA_INICIAL,'DD/MM/YYYY')INTO INICIO FROM DUAL;
 SELECT TO_DATE(FECHA_FINAL,'DD/MM/YYYY')INTO FIN FROM DUAL;      


    DBMS_OUTPUT.PUT_LINE('ID_CUENTA'||'                           '||'MONTO'||'                               '||'SALDO_ANTERIOR'||'            '||'SALDO_NUEVO'
    ||'                    '||'FECHA'||'                  '||'ESTADO_OPERACION'||'                  '||'TIPO_OPERACION');

    FOR I IN VER_CUENTAS LOOP
    IF( TO_DATE(trunc(i.FECHA,'dd'),'DD/MM/YYYY') BETWEEN INICIO AND FIN AND VER_CUENTAS%ROWCOUNT<>0) THEN
        DBMS_OUTPUT.PUT_LINE(I.ID_CUENTA||'                              '||I.MONTO||'                                        '||I.SALDO_ANTERIOR||'                      '||I.SALDO_NUEVO
    ||'                  '||TO_DATE(trunc(i.FECHA,'dd'),'DD/MM/YYYY')||'                      '||I.descripcion||'                                '||I.NOMBRE);
    ELSE
    RAISE_APPLICATION_ERROR(-20012,'NO EXISTE DATOS CON EL RANGO DE FECHA PROPORCIONADO ');
    END IF;
    END LOOP;
ELSE 
RAISE NO_EXISTE_CUENTA;
END IF;
COMMIT;
EXCEPTION 
WHEN NO_EXISTE_CUENTA THEN
DBMS_OUTPUT.PUT_LINE('NO EXISTE LA CUENTA');
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
END;


SET SERVEROUTPUT ON;


BEGIN 
REPORTE_ESTADO_CUENTA('01/04/20', '22/05/20', '2-2-221-2');
END;


/*------------------------------------------------------------------------------*/


/*2- REPORTE resumen de cuentas por agencia*/


CREATE OR REPLACE PROCEDURE REPORTE_RESUMEN_CUENTAS(NUMERO_AGENCIA NUMBER)
IS

CURSOR LISTADO IS 
        SELECT CUENTA.ID_CUENTA, tipo_cuenta.nombre AS TIPO_CUENTA,CLIENTE.NOMBRES||CLIENTE.APELLIDOS AS NOMBRE_CUENTA,
        estatus_cuenta.nombre AS ESTADO_CUENTA,fecha_creacion, 
        cuenta.monto_disponible,CUENTA.SALDO_EN_RESERVA FROM CUENTA 
        INNER JOIN CLIENTE_ASOCIADO_CUENTA 
        ON cuenta.id_cuenta=cliente_asociado_cuenta.id_cuenta
        INNER JOIN CLIENTE
        ON CLIENTE.ID_CLIENTE_NUMERO = CLIENTE_ASOCIADO_CUENTA.ID_CLIENTE
        INNER JOIN TIPO_CUENTA
        ON cuenta.id_tipo=TIPO_CUENTA.ID_TIPO_CUENTA
        INNER JOIN ESTATUS_CUENTA
        ON estatus_cuenta.id_estatus_cuenta=CUENTA.ID_ESTATUS
            WHERE ID_AGENCIA_APERTURA = NUMERO_AGENCIA ORDER BY FECHA_CREACION ASC;
EXISTE_AGENCIA NUMBER;
NO_EXISTE_AGENCIA EXCEPTION;
BEGIN
SELECT COUNT(*) INTO EXISTE_AGENCIA FROM AGENCIA WHERE agencia.id_agencia=NUMERO_AGENCIA;
    IF(EXISTE_AGENCIA=1) THEN
        DBMS_OUTPUT.PUT_LINE('ID_CUENTA'||'                           '||'TIPO_CUENTA'||'                               '||'NOMBRE_CUENTA'||
        '                    '||'ESTATUS_CUENTA'
    ||'                    '||'FECHA_APERTURA'||'                  '||'MONTO_DISPONIBLE'||'                  '||'SALDO_RESERVA');

        FOR I IN LISTADO
        LOOP
          DBMS_OUTPUT.PUT_LINE(I.ID_CUENTA||'                           '||I.TIPO_CUENTA||'                               '||I.NOMBRE_CUENTA||
        '                     '||I.ESTADO_CUENTA
    ||'                            '||TO_DATE(TRUNC(I.FECHA_CREACION,'DD'),'DD/MM/YYYY')||'                         '||I.MONTO_DISPONIBLE||'                  '||I.SALDO_EN_RESERVA||'         ');

        END LOOP;
    ELSE
    RAISE NO_EXISTE_AGENCIA;
    END IF;
COMMIT;
EXCEPTION 
WHEN NO_EXISTE_AGENCIA THEN
DBMS_OUTPUT.PUT_LINE('EL NUMERO DE AGENCIA QUE INGRESÓ NO EXISTE');
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE('DEBE INGRESAR UN NUMERO');
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
END;


SET SERVEROUTPUT ON;


BEGIN 
REPORTE_RESUMEN_CUENTAS(2);
END;


/**--------------------------------------------------------------------------------------------------------------------------*/

/**--------------------------------------------------------------------------------------------------------------------------*/
/*ESTADÍSTICAS POR AGENCIA*/


CREATE OR REPLACE PROCEDURE PROC_ESTADISTICA_AGENCIA(FECHA_INICIAL VARCHAR2,FECHA_FINAL VARCHAR2, ID_AGENCIA1 NUMBER)
IS
CURSOR VER_AGENCIA IS
SELECT ag.id_agencia,TP.NOMBRE AS OPERACION,
TO_DATE(TRUNC(BT.FECHA,'dd'),'DD/MM/YYYY')FECHA_OPERACION,COUNT(TP.NOMBRE)TOTAL_OPERACIONES,
SUM(BT.MONTO) AS TOTAL  FROM BITACORA_TRANSACCION BT
INNER JOIN TIPO_TRANSACCION TP
ON TP.ID_TIPO_TRANSACCION = BT.ID_TIPO
INNER JOIN CAJA CJ
ON 
BT.ID_CAJA=cj.id_caja
INNER JOIN
AGENCIA AG
ON ag.id_agencia=cj.id_agencia
where ag.id_agencia=ID_AGENCIA1
GROUP BY  ag.id_agencia,TP.NOMBRE,
TO_DATE(TRUNC(BT.FECHA,'dd'),'DD/MM/YYYY');
/*VALIDAR SI EXISTE LA AGENCIA*/
NO_EXISTE_AGENCIA EXCEPTION;

/*variable para VER SI EXISTE LA AGENCIA */
EXISTE_AGENCIA NUMBER;

/*PARA ALMACENAR LAS FECHAS*/ 
INICIO DATE;
FIN DATE;
BEGIN

/*PRIMERO VALIDAMOS SI EXSTE LA AGENCIA*/
SELECT FUNCT_EXISTE_AGENCIA(ID_AGENCIA1)INTO EXISTE_AGENCIA FROM DUAL;

IF(EXISTE_AGENCIA<>0) THEN
    /*CONVERTIR LAS FECHAS QUE ENVÍAN EN FORMATO STRING A FORMATO DATE*/
         SELECT TO_DATE(FECHA_INICIAL,'DD/MM/YYYY')INTO INICIO FROM DUAL;
         SELECT TO_DATE(FECHA_FINAL,'DD/MM/YYYY')INTO FIN FROM DUAL;  

    /*encabezado del reporte*/
     DBMS_OUTPUT.PUT_LINE('ID_AGENCIA'||'                              '||'OPERACION'||
            '                                        '||'FECHA_OPERACION'||'                      '
            ||'TOTAL_OPERACIONES'
            ||'                                             '||'TOTAL');
    FOR I IN VER_AGENCIA 
        LOOP
            IF( TO_DATE(trunc(i.FECHA_OPERACION,'dd'),'DD/MM/YYYY') BETWEEN INICIO AND FIN AND VER_AGENCIA%ROWCOUNT<>0) THEN
                DBMS_OUTPUT.PUT_LINE(I.ID_AGENCIA||'                              '||I.OPERACION||
                '                                                       '||I.FECHA_OPERACION||'                                           '
                ||I.TOTAL_OPERACIONES
                ||'                                                              '||I.TOTAL);
            ELSE
                RAISE_APPLICATION_ERROR(-20013,'NO EXISTE DATOS CON EL RANGO DE FECHA PROPORCIONADO ');
            END IF;
        END LOOP;
ELSE
 RAISE NO_EXISTE_AGENCIA;
END IF;
COMMIT;
EXCEPTION 
    WHEN INVALID_NUMBER THEN
         DBMS_OUTPUT.PUT_LINE('ESTÀ INGRESANDO UN FORMATO INCORRECTO EN EL CAMPO NUMERO DE AGENCIA');
    WHEN NO_EXISTE_AGENCIA THEN
        DBMS_OUTPUT.PUT_LINE('NO EXISTE EL NUMERO DE AGENCIA');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE||'ERROR:    '||SQLERRM||'   COMUNIQUESE CON EL DBA');
ROLLBACK;
END PROC_ESTADISTICA_AGENCIA;

commit;
set serveroutput on;



/*funcion para validar si existe una agencia*/
create or replace FUNCTION FUNCT_EXISTE_AGENCIA(NUMERO_AGENCIA NUMBER)
RETURN NUMBER
IS
CUENTA_NUMERO NUMBER;
BEGIN
    SELECT COUNT(*) INTO CUENTA_NUMERO FROM AGENCIA WHERE AGENCIA.ID_AGENCIA=NUMERO_AGENCIA;
    IF(CUENTA_NUMERO=1) THEN
        RETURN 1;

    ELSE
        RETURN 0;
    END IF; 
END;


/*BLOQUE ANÓNIMO*/
BEGIN
PROC_ESTADISTICA_AGENCIA('01/04/20','26/05/20',1);
END;















