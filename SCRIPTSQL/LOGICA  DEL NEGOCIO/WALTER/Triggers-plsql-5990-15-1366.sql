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



/*4.- creamos un id autoincrementable para llevar el control de los jobs que vayamos creando*/
/*SECUENCIA PARA LE ID DEL JOB*/
CREATE SEQUENCE SEQ_NUMERO_JOB
START WITH 1
INCREMENT BY 1;


/*5.0 DEBEMOS METER EL STRORED PROCEDURE DENTRO DE UN PACKAGE*/
CREATE OR REPLACE PACKAGE PKG_GENERACION_INTERES_CUENTAS IS
    PROCEDURE PROC_ADDINTERES_CUENTA_AHORR0;

END PKG_GENERACION_INTERES_CUENTAS;


/*5.0 creamos la tarea para que se ejecute cada treinta dias*/
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"PROYECTO"."PRUEBA_GRAFICA"',
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
             name => '"PROYECTO"."PRUEBA_GRAFICA"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
    DBMS_SCHEDULER.enable(
             name => '"PROYECTO"."PRUEBA_GRAFICA"');
END;

SELECT * FROM CUENTA;

COMMIT;

/*4.- CONSULTAMOS EL RESULTADO DEL JOB*/
BEGIN
REPORTE_INTERES_AHORRO;
END;

SELECT * FROM BITACORA_TRANSACCION;

/*******************************************************************************************************************************************************/


/*******************************************************************************************************************************************************/




begin
select * from cuenta where 
to_date(trunc(cuenta.fecha_creacion,'dd'),'dd/mm/yyyy')
=to_date('28/04/20','DD/MM/YYYY');

end;






select trunc(sysdate, 'mm') primer_dia_del_mes,
trunc(last_day(sysdate)) ultimo_dia_del_mes
from dual; 
