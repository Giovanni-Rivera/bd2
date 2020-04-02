/*CREATED AND EDITED BY WALTER RIVERA*/

/*    REGLA GENERAL*/

/*PARA  EL NOMBRE DE LAS SECUENCIAS
VAMOS A COLOCAR SEQ_TBL_NOMBRE_TABLA*/

/*PARA EL NOMBRE DE TRIGGERS
TRIG_(BF,AF,INST)_NOMBRE_TABLA*/

/***********************************************************************************************/

/*tabla configuracion*/
/*creando la secuencia correspondiente*/
CREATE SEQUENCE SEQ_TBL_TBLCONFIG
START WITH 1
INCREMENT BY 1;
COMMIT;


CREATE OR REPLACE TRIGGER BI_TBL_TBLCONFIG
BEFORE INSERT ON TABLA_CONFIGURACION
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_TBLCONFIG.NEXTVAL INTO :NEW.ID_TABLA FROM DUAL;
END BI_TBL_TBLCONFIG;


/*INSERCIÓN DE DATOS*/
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_OPERACION_EMPRESA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('CAMPO_BITACORA_EMPRESA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_EMPRESA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('CAMPO_BITACORA_USUARIO');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_OPERACION_USUARIO');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('PAIS');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_TRR_BITACORA_LIBRETA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_USUARIO');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_GENERO');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('MODULO');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_LIBRETA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TP_TRANSACC_BITACORA_CLIENTE');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('CAMPO_BITACORA_CLIENTE');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_TRANSACCION_BOVEDA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_CHEQUERA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_CUENTA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_CUENTA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_BOLETA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_BOLETA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_CHEQUE');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_TRANSACCION');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_AGENCIA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_CAJA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_TRANSAC_BITACORA_CHEQ');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_TRANSACCION_CAJA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTATUS_BOVEDA');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('ESTADO_TRANSACCION_GEN');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('TIPO_USUARIO');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('DEPARTAMENTO');
INSERT INTO TABLA_CONFIGURACION(NOMBRE) VALUES('MUNICIPIO');

/***********************************************************************************************/

/***********************************************************************************************/
/*TABLE CAMPO_BITACORA_CONFIGURACION*/
/*creando la secuencia correspondiente*/
CREATE SEQUENCE SEQ_TBL_CMPBIT_CONF
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA INSERTAR EN LA TABLA LOS CAMPOS*/
CREATE OR REPLACE TRIGGER BI_CAMPO_BIT_OPR
BEFORE INSERT ON CAMPO_BITACORA_CONFIGURACION
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_CMPBIT_CONF.NEXTVAL INTO :NEW.ID_CAMPO_AFECTADO FROM DUAL;
END;

/*INSERCIÓN DE DATOS*/
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('TP_OPERACION_EMPRESA',1);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_EMPRESA',1);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_EMPRESA',3);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_ESTATUS',3);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('TIPO_OPERACION_USUARIO',5);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_USUARIO',5);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_PAIS',6);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_PAIS',6);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_USUARIO',8);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_TP_ESTATUS_USUARIO',8);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_TIPO_GENERO',9);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_GENERO',9);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_MODULO',10);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_MODULO',10);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_LIBRETA',11);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_ESTATUS_LIBRETA',11);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('TIPO_TRANSACCION_BOVEDA',14);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_TP_TR_BOVEDA',14);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_CHEQUERA',15);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_ESTATUS_CHEQUERA',15);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_CUENTA',16);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_CUENTA',16);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_TIPO_CUENTA',17);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMRE_CUENTA',17);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_TIPO_BOLETA',18);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_BOLETA',18);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_BOLETA',19);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_ESTATUS_BOLETA',19);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_CHEQUE',20);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_ESTATUS_CHEQUE',20);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_TIPO_TRANSACCION_BITGENERAL',21);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_TP_TRBITGENERAL',21);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_AGENCIA',22);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_ESTATUS_AGENCIA',22);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_CAJA',23);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_ESTATUS_CAJA',23);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_TPTRANSACCION_BTCHEQUE',24);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_BITCHEQUE',24);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('TP_TRANSACCION_CAJA',25);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_TP_TRANSACCACAJA',25);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESTATUS_BOVEDA',26);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_ESTATUS_BOVEDA',26);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_ESATADO_TRANSACCGEN',27);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_ESTGENERAL',27);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_TIPO_USUARIO',28);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_TP_USUARIO',28);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_MODULO_TP_USUARIO',28);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_DEPARTAMENTO',29);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_DEPARTAMENTO',29);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_PAIS_DEPARTAMENTO',29);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_MUNICIPIO',30);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('NOMBRE_MUNICIPIO',30);

/***********************************************************************************************/

/***********************************************************************************************/

/*TABLA TIPO_OPERACION_CONFIGURACION*/

CREATE SEQUENCE TBL_TP_OPR_CONFIG
START WITH 1
INCREMENT BY 1;

/*CREAMOS EL TRIGGER PARA QUE SEA AUTOINCREMENTAL*/

CREATE OR REPLACE TRIGGER BI_TIPO_OPR_CONFIG
BEFORE INSERT ON TIPO_OPERACION_CONFIGURACION
FOR EACH ROW
BEGIN
SELECT TBL_TP_OPR_CONFIG.NEXTVAL INTO :NEW.TIPO_OPERACION FROM DUAL;
END;

/*INSERCIÓN DE DATOS*/
INSERT INTO TIPO_OPERACION_CONFIGURACION(DESCRIPCION) VALUES('MODIFICACION');
INSERT INTO TIPO_OPERACION_CONFIGURACION(DESCRIPCION) VALUES('INSERCION');
INSERT INTO TIPO_OPERACION_CONFIGURACION(DESCRIPCION) VALUES('BAJA');

/***********************************************************************************************/

/***********************************************************************************************/
/*tabla tipo_operacion_empresa*/

CREATE SEQUENCE TBL_TP_OPR_EMPR
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA LA SECUENCIA*/
CREATE OR REPLACE TRIGGER BI_TIPO_OPR_EMPRESA
BEFORE INSERT ON TIPO_OPERACION_EMPRESA
FOR EACH ROW
BEGIN
SELECT TBL_TP_OPR_EMPR.NEXTVAL INTO :NEW.TIPO_OPERACION_EMPRESA FROM DUAL;
END;

/*INSERCION DE DATOS*/
INSERT INTO TIPO_OPERACION_EMPRESA (DESCRIPCION) VALUES('MODIFICACION');
INSERT INTO TIPO_OPERACION_EMPRESA (DESCRIPCION) VALUES('INSERCION');
INSERT INTO TIPO_OPERACION_EMPRESA (DESCRIPCION) VALUES('BAJA');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla campo BITACORA empresa*/

/*creamos la secuencia*/
CREATE SEQUENCE SEQ_TBLCMP_BIT_EMPRESA
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA QUE LA SECUENCIA SEA AUTOINCREMENTAL CADA VEZ QUE SE INSERTE UN CAMPO*/
CREATE OR REPLACE TRIGGER BI_CAMPO_AFECT_EMPRESA
BEFORE INSERT ON CAMPO_BITACORA_EMPRESA
FOR EACH ROW
BEGIN
SELECT SEQ_TBLCMP_BIT_EMPRESA.NEXTVAL INTO :NEW.ID_CAMPO_AFECTADO FROM DUAL;
END;

/*INSERCION DE DATOS
NO SE COLOCAN LOS CAMPOS FECHA_CREACION Y FECHA_CANCELACION
PORQUE POR NORMAS DE SEGURIDAD NO DEBEN ESTAR HABILITADOS
PARA QUE SE LES HAGAN CAMBIOS*/
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('TODOS');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('ID_REPRESENTANTE_LEGAL');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('NOMBRE');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('DIRECCION');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('NIT');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('TELEFONO');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('CORREO');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('ID_MUNICIPIO');
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('ID_ESTATUS');

/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS EMPRESA*/
/*CREAMOS LA SESCUENCIA*/
CREATE SEQUENCE SEQ_TBL_ESTATUS_EMPRESA
START WITH 1
INCREMENT BY 1;
/*TRIGGER PARA LA SECUENCIA*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_EMPRESA
BEFORE INSERT ON ESTATUS_EMPRESA
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_ESTATUS_EMPRESA.NEXTVAL INTO :NEW.ID_ESTATUS_EMPRESA FROM DUAL;
END;   

/*INSERTANDO LOS DATOS*/
INSERT INTO ESTATUS_EMPRESA (NOMBRE) VALUES('ACTIVA');
INSERT INTO ESTATUS_EMPRESA (NOMBRE) VALUES('BLOQUEADA');
INSERT INTO ESTATUS_EMPRESA (NOMBRE) VALUES('INACTIVA');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla campo_bitacora_usuario*/

CREATE SEQUENCE SEQ_TBL_BIT_USR
START  WITH 1
INCREMENT BY 1;

/*TRIGGER PARA EL CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_BIT_USR
BEFORE INSERT ON CAMPO_BITACORA_USUARIO
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_BIT_USR.NEXTVAL INTO :NEW.ID_CAMPO_AFECTADO FROM DUAL;
END;

/*INSERTANDO DATOS*/
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('TODOS');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('NOMBRE_USUARIO');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('NOMBRES');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('APELLIDOS');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('DPI');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('DIRECCION');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('CORREO_ELECTRONICO');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('TELEFONO');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('CELULAR');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('FECHA_NACIMIENTO');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('FECHA_CREACION');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('FOTOGRAFIA');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('FECHA_DE_BAJA');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('CONTRASENA');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('ID_AGENCIA');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('ID_MUNICIPIO');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('TIPO_USUARIO');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('TIPO_GENERO');
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('ESTATUS_USUARIO');

/***********************************************************************************************/

/***********************************************************************************************/
/*tabla tipo_operacion_usuario*/
CREATE SEQUENCE SQL_TBL_TPOPR_USR
START WITH 1
INCREMENT BY 1;

/*TIRGGER PARA EL CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_TP_OPR_USR
BEFORE INSERT ON TIPO_OPERACION_USUARIO
FOR EACH ROW
BEGIN
SELECT SQL_TBL_TPOPR_USR.NEXTVAL INTO :NEW.TIPO_OPERACION FROM DUAL;
END;

/*INSERCION DE DATOS*/
INSERT INTO TIPO_OPERACION_USUARIO (DESCRIPCION) VALUES('MODIFICACION');
INSERT INTO TIPO_OPERACION_USUARIO (DESCRIPCION) VALUES('INSERCION');
INSERT INTO TIPO_OPERACION_USUARIO (DESCRIPCION) VALUES('BAJA');

/***********************************************************************************************/

/***********************************************************************************************/

