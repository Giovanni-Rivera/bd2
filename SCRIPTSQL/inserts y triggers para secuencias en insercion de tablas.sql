/*CREATED AND EDITED BY WALTER RIVERA*/

/*    REGLA GENERAL*/

/*PARA  EL NOMBRE DE LAS SECUENCIAS
VAMOS A COLOCAR SEQ_TBL_NOMBRE_TABLA*/

/*PARA EL NOMBRE DE TRIGGERS
(ACCCION)_NOMBRE_TABLA*
EN DONDE ACCION PUEDE TENER LAS SIGUIENTES VARIABLES
BI: BEFORE INSERT;
BU: BEFORE UPDATE;
AI: AFTER INSERT;
AU: AFTER UPDATE;
BD: BEFORE DELETE;
AD: AFTER DELETE;
INST: INSTEAD OF;


*/

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
/*Agregados a ultima hora xD*/
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('ID_TIPO_TRANSACCION_LIBRETA',7);
INSERT INTO CAMPO_BITACORA_CONFIGURACION (NOMBRE_CAMPO,ID_TABLA) VALUES('DESCRIPCION_TRANSACCION_LIBRETA',7);


/***********************************************************************************************/

/***********************************************************************************************/

/*TABLA ESTATUS_CLIENTE*/
CREATE SEQUENCE SEQ_TBL_ESTATUS_CLIENTE
START WITH 1
INCREMENT BY 1;
/*TRIGGER PARA LA SECUENCIA*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_CLIENTE
BEFORE INSERT ON ESTATUS_CLIENTE
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_ESTATUS_CLIENTE.NEXTVAL INTO :NEW.ID_ESTATUS_CLIENTE FROM DUAL;
END;  

/*INSERTANDO LOS DATOS*/
INSERT INTO ESTATUS_CLIENTE (NOMBRE) VALUES('ACTIVO');
INSERT INTO ESTATUS_CLIENTE (NOMBRE) VALUES('BLOQUEADO');
INSERT INTO ESTATUS_CLIENTE (NOMBRE) VALUES('INACTIVO');




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
INSERT INTO CAMPO_BITACORA_EMPRESA (NOMBRE_CAMPO) VALUES('ID_EMPRESA');
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
INSERT INTO CAMPO_BITACORA_USUARIO (NOMBRE_CAMPO) VALUES('ID_USUARIO');
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
/**tabla pais*/
CREATE SEQUENCE SEQ_TBL_PAIS
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA LA SECUENCIA*/
CREATE OR REPLACE TRIGGER BI_PAIS
BEFORE INSERT ON PAIS
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_PAIS.NEXTVAL INTO :NEW.ID_PAIS FROM DUAL;
END;

/*INSERTANDO DATOS*/
INSERT INTO PAIS(NOMBRE) VALUES('GUATEMALA');

/***********************************************************************************************/

/***********************************************************************************************/
/*tabla  TIPO_TRR_BITACORA_LIBRETA*/
CREATE SEQUENCE SEQ_TBL_TRR_BIT_LIB
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_TP_TRBIT_LIBRETA
BEFORE INSERT ON TIPO_TRR_BITACORA_LIBRETA
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_TRR_BIT_LIB.NEXTVAL INTO :NEW.ID_TIPO_TRANSACCION FROM DUAL;
END;

/*INSERTS DE DATOS EN  LA TABLA*/
INSERT INTO TIPO_TRR_BITACORA_LIBRETA (DESCRIPCION) VALUES('MODIFICACION');
INSERT INTO TIPO_TRR_BITACORA_LIBRETA (DESCRIPCION) VALUES('INSERCION');
INSERT INTO TIPO_TRR_BITACORA_LIBRETA (DESCRIPCION) VALUES('BAJA');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS_USUARIO*/
CREATE SEQUENCE SEQ_ESTATUS_USR
START WITH 1
INCREMENT BY 1;

/*TIGRILLO*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_USUARIO
BEFORE INSERT ON ESTATUS_USUARIO
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_USR.NEXTVAL INTO :NEW.ID_ESTATUS_USUARIO FROM DUAL;
END;

/*UN usuario puede estar activo, inactivo, bloqueado*/
INSERT INTO ESTATUS_USUARIO(NOMBRE) VALUES('ACTIVO');
INSERT INTO ESTATUS_USUARIO(NOMBRE) VALUES('INACTIVO');
INSERT INTO ESTATUS_USUARIO(NOMBRE) VALUES('BLOQUEADO');
/***********************************************************************************************/

/***********************************************************************************************/
/*TIPO_GENERO*/

CREATE SEQUENCE SEQ_TIPO_GENERO
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA LA INSERCIÓN DEL CAMPO AUTOINCRENTABLE*/
CREATE OR REPLACE TRIGGER BI_TP_GENERO
BEFORE INSERT ON TIPO_GENERO
FOR EACH ROW
BEGIN
SELECT SEQ_TIPO_GENERO.NEXTVAL INTO :NEW.TIPO_GENERO FROM DUAL;
END;

/*DE MOMENTO, SOLO SE CONSIDERA MASCULINO Y FEMENINO ÚNICAMENTE*/
INSERT INTO TIPO_GENERO(DESCRIPCION) VALUES('MASCULINO');
INSERT INTO TIPO_GENERO(DESCRIPCION) VALUES('FEMENINO');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla MÓDULOS*/
CREATE SEQUENCE SEQ_MODULO
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA COMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_MODULO
BEFORE INSERT ON MODULO
FOR EACH ROW
BEGIN
SELECT SEQ_MODULO.NEXTVAL INTO :NEW.ID_MODULO FROM DUAL;
END;

/*INSERTS, ESTOS SON LOS MODULOS POR LOS QUE ESTARÁ INTEGRADO EL SISTEMA*/
INSERT INTO MODULO(DESCRIPCION) VALUES('ACTUALIZAR_DATOS');
INSERT INTO MODULO(DESCRIPCION) VALUES('ASIGNACION_CAJAS');
INSERT INTO MODULO(DESCRIPCION) VALUES('BLOQUEOS');
INSERT INTO MODULO(DESCRIPCION) VALUES('CREACION_USUARIOS');
INSERT INTO MODULO(DESCRIPCION) VALUES('CREACION_CUENTAS');
INSERT INTO MODULO(DESCRIPCION) VALUES('DEPOSITOS Y RETIROS');
INSERT INTO MODULO(DESCRIPCION) VALUES('PAGOS DE PLANILLA');
INSERT INTO MODULO(DESCRIPCION) VALUES('REPORTES');
INSERT INTO MODULO(DESCRIPCION) VALUES('TRANSFERENCIA DE PERSONAL');
INSERT INTO MODULO(DESCRIPCION) VALUES('CONFIGURACION');
/***********************************************************************************************/

/***********************************************************************************************/
/*tablas estatus_libreta*/
/*secuencia*/
CREATE SEQUENCE SEQ_ESTATUS_LIBRETA
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA EL CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_LIBRETA
BEFORE INSERT ON ESTATUS_LIBRETA
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_LIBRETA.NEXTVAL INTO :NEW.ID_ESTATUS_LIBRETA FROM DUAL;
END;

/*INSERTS, ACÁ CONSIDERAMOS 3 ESTADOS, HABILITADA, DESHABILITADA O BLOQUEADA
DESHABILITADA QUIERE DECIR QUE SE LE DIÓ DE BAJA A LA LIBRETA)
*/
INSERT INTO ESTATUS_LIBRETA(NOMBRE) VALUES('HABILITADA');
INSERT INTO ESTATUS_LIBRETA(NOMBRE) VALUES('DESHABILITADA');
INSERT INTO ESTATUS_LIBRETA(NOMBRE) VALUES('BLOQUEADA');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla TP_TRANSACC_BITACORA_CLIENTE*/
CREATE SEQUENCE TP_TRANSACC_BITACORA_CLIENTE1
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA HACER EL CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_TP_TRANSACC_BITCLIENTE
BEFORE INSERT ON TP_TRANSACC_BITACORA_CLIENTE
FOR EACH ROW
BEGIN 
SELECT TP_TRANSACC_BITACORA_CLIENTE1.NEXTVAL INTO :NEW.ID_TIPO_TRANSACCION FROM DUAL;
END;

/*INSERTS DE DATOS EN  LA TABLA*/
INSERT INTO TP_TRANSACC_BITACORA_CLIENTE (DESCRIPCION) VALUES('MODIFICACION');
INSERT INTO TP_TRANSACC_BITACORA_CLIENTE (DESCRIPCION) VALUES('INSERCION');
INSERT INTO TP_TRANSACC_BITACORA_CLIENTE (DESCRIPCION) VALUES('BAJA');
/*AGREGANDO UNOS ÚLTIMOS INSERTS*/

INSERT INTO TP_TRANSACC_BITACORA_CLIENTE (DESCRIPCION) VALUES('VINCULACION_CUENTA');
INSERT INTO TP_TRANSACC_BITACORA_CLIENTE (DESCRIPCION) VALUES('ACTUALIZACION_ASOCIACION_CUENTA');
INSERT INTO TP_TRANSACC_BITACORA_CLIENTE (DESCRIPCION) VALUES('DESVINCULACION_CUENTA');


/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA CAMPO_BITACORA_CLIENTE*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_TBL_CAMPOBIT_CLIENTE
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_TBL_CAMPOBIT_CLIENTE
BEFORE INSERT ON CAMPO_BITACORA_CLIENTE
FOR EACH ROW
BEGIN
SELECT SEQ_TBL_CAMPOBIT_CLIENTE.NEXTVAL INTO :NEW.ID_CAMPO_AFECTADO FROM DUAL;
END;

/*INSERTANDO  DATOS, */
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('ID_CLIENTE');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('NOMBRES');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('APELLIDOS');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('DPI');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('NIT');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('MUNICIPIO');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('DIRECCION');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('TELEFONO');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('CELULAR');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('CORREO_ELECTRÓNICO');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('TIPO_GENERO');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('FECHA_DE_NACIMIENTO');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('IMAGEN_FIRMA');

/*AGREGANDO ÚLTIMOS INSERTS*/

INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('ID_CLIENTE_ASOCIADO');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('ID_CUENTA_ASOCIADA');
INSERT INTO CAMPO_BITACORA_CLIENTE (NOMBRE_CAMPO) VALUES('ID_EMPRESA_ASOCIADA');


/***********************************************************************************************/

/***********************************************************************************************/
/*tabla TIPO_TRANSACCION_BOVEDA*/
/*secuencia*/
CREATE SEQUENCE SEQ_TP_TRANSACCION_BOVEDA
START WITH 1
INCREMENT BY 1;

/*Trigger para volver el campo de ID autoincrementable*/
CREATE OR REPLACE TRIGGER BI_TPTRANSACC_BOVEDA
BEFORE INSERT ON TIPO_TRANSACCION_BOVEDA
FOR EACH ROW
BEGIN
SELECT SEQ_TP_TRANSACCION_BOVEDA.NEXTVAL INTO :NEW.TIPO_TRANSACCION FROM DUAL;
END;

/*INSERTS, tipos de transacciones que se pueden dar en una boveda, actualmente
se tiene pensado únicamente retiro y depósito*/
INSERT INTO TIPO_TRANSACCION_BOVEDA (DESCRIPCION) VALUES('RETIRO');
INSERT INTO TIPO_TRANSACCION_BOVEDA (DESCRIPCION) VALUES('DEPÓSITO');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS_CHEQUERA*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_ESTATUS_CHEQUERA
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA HACER EL CAMPO AUTOINCREMENTABLE (ID_ESTATUS_CUENTA), UNA 
CHEQUERA PUEDE ESTAR HABILITADA, DESHABILITADA O BLOQUEADA*/
CREATE OR REPLACE TRIGGER BI_TBL_ESTATUS_CHEQUERA
BEFORE INSERT ON ESTATUS_CHEQUERA
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_CHEQUERA.NEXTVAL INTO :NEW.ID_ESTATUS_CHEQUERA FROM DUAL;
END;

/*INSECIÓN DE DATOS*/
INSERT INTO ESTATUS_CHEQUERA(NOMBRE) VALUES('HABILITADA');
INSERT INTO ESTATUS_CHEQUERA(NOMBRE) VALUES('DESHABILITADA');
INSERT INTO ESTATUS_CHEQUERA(NOMBRE) VALUES('BLOQUEADA');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS_Cuenta*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_ESTATUS_CUENTA
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA HACER EL CAMPO AUTOINCREMENTABLE (ID_ESTATUS_CUENTA), UNA 
CUENTA PUEDE ESTAR HABILITADA, DESHABILITADA O BLOQUEADA*/
CREATE OR REPLACE TRIGGER BI_TBL_ESTATUS_CUENTA
BEFORE INSERT ON ESTATUS_CUENTA
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_CUENTA.NEXTVAL INTO :NEW.ID_ESTATUS_CUENTA FROM DUAL;
END;

/*INSECIÓN DE DATOS*/
INSERT INTO ESTATUS_CUENTA(NOMBRE) VALUES('HABILITADA');
INSERT INTO ESTATUS_CUENTA(NOMBRE) VALUES('DESHABILITADA');
INSERT INTO ESTATUS_CUENTA(NOMBRE) VALUES('BLOQUEADA');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA TIPO CUENTA*/
/*Secuencia*/
CREATE SEQUENCE SEQ_TIPO_CUENTA
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_TIPO_CUENTA
BEFORE INSERT ON TIPO_CUENTA
FOR EACH ROW
BEGIN
SELECT SEQ_TIPO_CUENTA.NEXTVAL INTO :NEW.ID_TIPO_CUENTA FROM DUAL;
END;

/*SEGÚN LO REQUERIDO EN EL PROYECTO, LOS TIPOS DE CUENTA SON MONETARIA Y DE AHORRO*/
INSERT INTO TIPO_CUENTA (NOMBRE) VALUES('DE AHORRO');
INSERT INTO TIPO_CUENTA (NOMBRE) VALUES('MONETARIA');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla TIPO_BOLETA*/
CREATE SEQUENCE SEQ_TIPO_BOLETA
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA PRIMARY KEY AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_TIPO_BOLETA
BEFORE INSERT ON TIPO_BOLETA
FOR EACH ROW
BEGIN
SELECT SEQ_TIPO_BOLETA.NEXTVAL INTO :NEW.ID_TIPO_BOLETA FROM DUAL;
END;

/*INSERTS DE DATOS*/
INSERT INTO TIPO_BOLETA (NOMBRE) VALUES('DEPOSITO CUENTA AHORRO');
INSERT INTO TIPO_BOLETA (NOMBRE) VALUES('DEPOSITO CUENTA MONETARIA');
INSERT INTO TIPO_BOLETA (NOMBRE) VALUES('RETIRO CUENTA DE AHORRO');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla ESTATUS_BOLETA*/
CREATE SEQUENCE SEQ_ESTATUS_BOLETA
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA CAMPO AUTOINCREMENTABLE*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_BOLETA
BEFORE INSERT ON ESTATUS_BOLETA
FOR EACH ROW
BEGIN 
SELECT SEQ_ESTATUS_BOLETA.NEXTVAL INTO :NEW.ID_ESTATUS_BOLETA FROM DUAL;
END;

/*UNA LIBRETA PUEDE ESTAR HABILITADA, DESHABILITADA O BLOEQUEADA*/
INSERT INTO ESTATUS_BOLETA (NOMBRE) VALUES('HABILITADA');
INSERT INTO ESTATUS_BOLETA (NOMBRE) VALUES('DESHABILITADA');
INSERT INTO ESTATUS_BOLETA (NOMBRE) VALUES('BLOQUEADA');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS_AGENCIA*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_ESTATUS_AGENCIA
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_AGENCIA
BEFORE INSERT ON ESTATUS_AGENCIA
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_AGENCIA.NEXTVAL INTO :NEW.ID_ESTATUS FROM DUAL;
END;

/*INSERCIÓN DE DATOS, UNA AGENCIA PUEDE ESTAR HABILITADA, DESHABILITADA O BLOQUEADA*/
INSERT INTO ESTATUS_AGENCIA(DESCRIPCION) VALUES('HABILITADA');
INSERT INTO ESTATUS_AGENCIA(DESCRIPCION) VALUES('DESHABILITADA');
INSERT INTO ESTATUS_AGENCIA(DESCRIPCION) VALUES('BLOQUEADA');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS_CAJA*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_ESTATUS_CAJA
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_CAJA
BEFORE INSERT ON ESTATUS_CAJA
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_CAJA.NEXTVAL INTO :NEW.ID_ESTATUS_CAJA FROM DUAL;
END;

/*INSERCIÓN DE DATOS, UNA CAJA PUEDE ESTAR HABILITADA, DESHABILITADA O BLOQUEADA*/
INSERT INTO ESTATUS_CAJA(NOMBRE) VALUES('HABILITADA');
INSERT INTO ESTATUS_CAJA(NOMBRE) VALUES('DESHABILITADA');
INSERT INTO ESTATUS_CAJA(NOMBRE) VALUES('BLOQUEADA');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS_CHEQUE*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_ESTATUS_CHEQUE
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_CHEQUE
BEFORE INSERT ON ESTATUS_CHEQUE
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_CHEQUE.NEXTVAL INTO :NEW.ID_ESTATUS_CHEQUE FROM DUAL;
END;

/*INSERCIÓN DE DATOS, UNA CHEQUE PUEDE ESTAR HABILITADO, DESHABILITADO O BLOQUEADO*/
INSERT INTO ESTATUS_CHEQUE(NOMBRE) VALUES('HABILITADO');
INSERT INTO ESTATUS_CHEQUE(NOMBRE) VALUES('DESHABILITADO');
INSERT INTO ESTATUS_CHEQUE(NOMBRE) VALUES('BLOQUEADO');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla tipo_transacccion_caja*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_TP_TRANSACCION_CAJA
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_TP_TRANSACCION_CAJA
BEFORE INSERT ON TIPO_TRANSACCION_CAJA
FOR EACH ROW
BEGIN
SELECT SEQ_TP_TRANSACCION_CAJA.NEXTVAL INTO :NEW.TIPO_TRANSACCION FROM DUAL;
END;

/*EN UNA CAJA, SE DA UN CAMBIO DE TURNO, DE MOMENTO SOLO ESTE VOY A INGRESAR*/
INSERT INTO TIPO_TRANSACCION_CAJA (DESCRIPCION) VALUES('CAMBIO DE TURNO');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla TIPO_TRANSAC_BITACORA_CHEQ*/
/*secuencia*/
CREATE SEQUENCE SEQ_TPTRANSACBIT_CHEQ
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_TP_TRANSACBIT_CHEQ
BEFORE INSERT ON TIPO_TRANSAC_BITACORA_CHEQ
FOR EACH ROW
BEGIN
SELECT SEQ_TPTRANSACBIT_CHEQ.NEXTVAL INTO :NEW.ID_TIPO_TRANSACCION FROM DUAL;
END;

/*EN ESTA TABLA VAMOS A REGISTRAR 3 TIPOS DE OPERACION, MODIFICACION, INSERCION O BAJA DEL SISTEMA DE ALGUN CHEQUE*/
INSERT INTO TIPO_TRANSAC_BITACORA_CHEQ(DESCRIPCION) VALUES('MODIFICACION');
INSERT INTO TIPO_TRANSAC_BITACORA_CHEQ(DESCRIPCION) VALUES('INSERCION');
INSERT INTO TIPO_TRANSAC_BITACORA_CHEQ(DESCRIPCION) VALUES('BAJA');
/***********************************************************************************************/

/***********************************************************************************************/
/*TABLA ESTATUS_BOVEDA*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_ESTATUS_BOVEDA
START WITH 1
INCREMENT BY 1;

/*TRIGGER*/
CREATE OR REPLACE TRIGGER BI_ESTATUS_BOVEDA
BEFORE INSERT ON ESTATUS_BOVEDA
FOR EACH ROW
BEGIN
SELECT SEQ_ESTATUS_BOVEDA.NEXTVAL INTO :NEW.ID_ESTATUS_BOVEDA FROM DUAL;
END;

/*INSERCIÓN DE DATOS, UNA BOVEDA PUEDE ESTAR HABILITADA, DESHABILITADA O BLOQUEADA*/
INSERT INTO ESTATUS_BOVEDA(NOMBRE) VALUES('HABILITADA');
INSERT INTO ESTATUS_BOVEDA(NOMBRE) VALUES('DESHABILITADA');
INSERT INTO ESTATUS_BOVEDA(NOMBRE) VALUES('BLOQUEADA');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla tipo_transaccion (tipo de transacciones que se harán en la bitacora general)*/
/*SECUENCIA*/
CREATE SEQUENCE SEQ_TIPO_TRANSACCION
START WITH 1
INCREMENT BY 1;

/**TRIGGER*/
CREATE OR REPLACE TRIGGER BI_TIPO_TRANSACCION_GENERAL 
BEFORE INSERT ON TIPO_TRANSACCION
FOR EACH ROW
BEGIN
SELECT SEQ_TIPO_TRANSACCION.NEXTVAL INTO :NEW.ID_TIPO_TRANSACCION FROM DUAL;
END;

/*VAMOS A REGISTRAR TODOS LOS DEPOSITOS Y RETIROS DE LAS DIFERENTES CUENTAS, Y DEMÁS TRANSAACCIONES*/
INSERT INTO TIPO_TRANSACCION(NOMBRE) VALUES('DEPOSITO');
INSERT INTO TIPO_TRANSACCION(NOMBRE) VALUES('RETIRO');
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla ESTADO_TRANSACCION_GEN*/
/*OBSERVACIÓN IMPORTANTE, 
al estar utilizando la versión de oracle 11g, no podemos hacer uso directo a que la columna de id 
o llave primaria sea utoincrementable, por tal razón se realizó todo este proceso de la forma
tradicial, tal cual lo hicimos en  secciones previas y la actual:
fuente:
https://www.oracle.com/technetwork/es/articles/sql/oracle-database-columna-identidad-2775883-esa.html
*/
/*secuencia*/
CREATE SEQUENCE SEQ_ESTADO_TRANSACC_GEN
START WITH 1
INCREMENT BY 1;

/*TRIGGER PARA LOGRAR QUE EL CAMPO ID SEA UTOINCREMENTABLE CADA VEZ QUE INSERTEMOS UN DATO 
EN ESTA TABLA*/
CREATE OR REPLACE TRIGGER BI_ESTADO_TRANSACC_GEN
BEFORE INSERT ON ESTADO_TRANSACCION_GEN
FOR EACH ROW
BEGIN 
SELECT SEQ_ESTADO_TRANSACC_GEN.NEXTVAL INTO :NEW.ID_ESTADO FROM DUAL;
END;

/*UNA TRANSACCION A NIVEL GENERAL DE LA BITACORA PRINCIPAL, 
PUEDE ESTAR EN PROCESO, TERMINADA(ESTO QUIERE DECIR QUE SE APROBÓ CON ÉXITO), RECHAZADA,  PUES ALLÍ SOLO VAMOS A ESTAR REGISTRANDO LOS SALDOS ANTERIORES
Y NUEVOS DE LAS CUENTAS, SEGÚN SEA LA OPERACIÓN EN QUE SE REALIZÓ  EL FLUJO DEL CAPITAL (DINERO) */
INSERT INTO ESTADO_TRANSACCION_GEN (DESCRIPCION) VALUES('EN PROCESO');
INSERT INTO ESTADO_TRANSACCION_GEN (DESCRIPCION) VALUES('TERMINADA');
INSERT INTO ESTADO_TRANSACCION_GEN (DESCRIPCION) VALUES('RECHAZADA');
/***********************************************************************************************/
    ------------FINAL DE LOS PRINCIPALES TRIGGERS, SECUENCIAS Y DATOS NECESARIOS ----------------
    ------------PREVIO A LA IMPLEMENTACION COMPLETA DE LA LÓGICA DEL NEGOCIO---------------------
/***********************************************************************************************/








CREATE TABLE TIPO_OPERACION_AGENCIA (
TIPO_TRANSACCION NUMBER(3),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TIPO_OPERACION_AGENCIA ADD CONSTRAINT PK_TP_TRANAGEN PRIMARY KEY (TIPO_TRANSACCION);
/
COMMIT;


CREATE TABLE CAMPO_BITACORA_AGENCIA(
    ID_CAMPO_AFECTADO NUMBER(10),
    NOMBRE_CAMPO VARCHAR2(100)
);
ALTER TABLE CAMPO_BITACORA_AGENCIA ADD CONSTRAINT PK_CMP_BIT_AGE PRIMARY KEY (ID_CAMPO_AFECTADO);
/
COMMIT;




CREATE TABLE BITACORA_AGENCIA (
ID_OPERACION NUMBER(8),
ID_AGENCIA NUMBER(15),
VALOR_ANTERIOR VARCHAR2(200),
VALOR_NUEVO VARCHAR2(200),
FECHA_MODIFICACION TIMESTAMP,
DETALLES VARCHAR2(400),
CAMPO_AFECTADO NUMBER(10),
TIPO_OPERACION NUMBER(3)
);
ALTER TABLE BITACORA_AGENCIA ADD CONSTRAINT PK_ID_BIT_AGE PRIMARY KEY(ID_OPERACION);
ALTER TABLE BITACORA_AGENCIA ADD CONSTRAINT FK_ID_AGENC FOREIGN KEY(ID_AGENCIA) REFERENCES AGENCIA(ID_AGENCIA);
ALTER TABLE BITACORA_AGENCIA ADD CONSTRAINT FK_CP_CMP_BITAGEN FOREIGN KEY(CAMPO_AFECTADO) REFERENCES CAMPO_BITACORA_AGENCIA(ID_CAMPO_AFECTADO);
ALTER TABLE BITACORA_AGENCIA ADD CONSTRAINT FK_TP_OPR2 FOREIGN KEY(TIPO_OPERACION) REFERENCES TIPO_OPERACION_AGENCIA(TIPO_OPERACION_AGENCIA);
/
COMMIT;
/***********************************************************************************************/

/***********************************************************************************************/


/*TABLA TIPO_OPERACION_AGENCIA*/

CREATE SEQUENCE TBL_TP_OPR_AGENCIA
START WITH 1
INCREMENT BY 1;

/*CREAMOS EL TRIGGER PARA QUE SEA AUTOINCREMENTAL*/

CREATE OR REPLACE TRIGGER BI_TIPO_OPR_AGENCIA
BEFORE INSERT ON TIPO_OPERACION_AGENCIA
FOR EACH ROW
BEGIN
SELECT TBL_TP_OPR_AGENCIA.NEXTVAL INTO :NEW.TIPO_OPERACION FROM DUAL;
END;
/
/*INSERCIÓN DE DATOS*/
INSERT INTO TIPO_OPERACION_AGENCIA(DESCRIPCION) VALUES('MODIFICACION');
INSERT INTO TIPO_OPERACION_AGENCIA(DESCRIPCION) VALUES('INSERCION');
INSERT INTO TIPO_OPERACION_AGENCIA(DESCRIPCION) VALUES('BAJA');
/
/***********************************************************************************************/

/***********************************************************************************************/
/*tabla campo BITACORA AGENCIA*/

/*creamos la secuencia*/
CREATE SEQUENCE SEQ_TBLCMP_BIT_AGENCIA
START WITH 1
INCREMENT BY 1;
/
/*TRIGGER PARA QUE LA SECUENCIA SEA AUTOINCREMENTAL CADA VEZ QUE SE INSERTE UN CAMPO*/
CREATE OR REPLACE TRIGGER BI_CAMPO_AFECT_AGENCIA
BEFORE INSERT ON CAMPO_BITACORA_AGENCIA
FOR EACH ROW
BEGIN
SELECT SEQ_TBLCMP_BIT_AGENCIA.NEXTVAL INTO :NEW.ID_CAMPO_AFECTADO FROM DUAL;
END;
/
/*INSERCION DE DATOS
NO SE COLOCAN LOS CAMPOS FECHA_CREACION Y FECHA_CANCELACION
PORQUE POR NORMAS DE SEGURIDAD NO DEBEN ESTAR HABILITADOS
PARA QUE SE LES HAGAN CAMBIOS*/
INSERT INTO CAMPO_BITACORA_AGENCIA (NOMBRE_CAMPO) VALUES('ID_AGENCIA');
INSERT INTO CAMPO_BITACORA_AGENCIA (NOMBRE_CAMPO) VALUES('NOMBRE');
INSERT INTO CAMPO_BITACORA_AGENCIA (NOMBRE_CAMPO) VALUES('DIRECCION');
INSERT INTO CAMPO_BITACORA_AGENCIA (NOMBRE_CAMPO) VALUES('FECHA_APERTURA');
INSERT INTO CAMPO_BITACORA_AGENCIA (NOMBRE_CAMPO) VALUES('FECHA_CIERRE');
INSERT INTO CAMPO_BITACORA_AGENCIA (NOMBRE_CAMPO) VALUES('MUNICIPIO');
INSERT INTO CAMPO_BITACORA_AGENCIA (NOMBRE_CAMPO) VALUES('TIPO_ESTATUS');
/