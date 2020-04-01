CREATE TABLE CAMPO_BITACORA_CONFIGURACION(
    ID_CAMPO_AFECTADO NUMBER(10),
    NOMBRE_CAMPO VARCHAR2(100)
);
ALTER TABLE CAMPO_BITACORA_CONFIGURACION ADD CONSTRAINT PK_CONFIG PRIMARY KEY (ID_CAMPO_AFECTADO);

CREATE TABLE TIPO_OPERACION_CONFIGURACION
(
    TIPO_OPERACION number(3),
    DESCRIPCION varchar2(100)
);
ALTER TABLE TIPO_OPERACION_CONFIGURACION ADD CONSTRAINT PK_TP_CONGIG PRIMARY KEY(TIPO_OPERACION);


CREATE TABLE TIPO_OPERACION_EMPRESA
(
    TIPO_OPERACION_EMPRESA NUMBER(3),
    DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TIPO_OPERACION_EMPRESA ADD CONSTRAINT PK_OP_EMPR PRIMARY KEY(TIPO_OPERACION_EMPRESA);

CREATE TABLE CAMPO_BITACORA_EMPRESA(
    ID_CAMPO_AFECTADO NUMBER(10),
    NOMBRE_CAMPO VARCHAR2(100)
);
ALTER TABLE CAMPO_BITACORA_EMPRESA ADD CONSTRAINT PK_BIT_EMPR PRIMARY KEY(ID_CAMPO_AFECTADO);


CREATE TABLE ESTATUS_EMPRESA(
    ID_ESTATUS_EMPRESA NUMBER(3),
    NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_EMPRESA ADD CONSTRAINT PK_ST_EMPR PRIMARY KEY(ID_ESTATUS_EMPRESA);


CREATE TABLE CAMPO_BITACORA_USUARIO(
    ID_CAMPO_AFECTADO NUMBER(10),
    NOMBRE_CAMPO VARCHAR2(100)
);
ALTER TABLE CAMPO_BITACORA_USUARIO ADD CONSTRAINT PK_CMP_BIT_USR PRIMARY KEY (ID_CAMPO_AFECTADO);


CREATE TABLE TIPO_OPERACION_USUARIO(
    TIPO_OPERACION NUMBER(3),
    DESCRIPCION VARCHAR2(100)
);      
ALTER TABLE TIPO_OPERACION_USUARIO ADD CONSTRAINT  PK_TP_OPERACION PRIMARY KEY(TIPO_OPERACION);

CREATE TABLE PAIS
(
ID_PAIS NUMBER(4),
NOMBRE VARCHAR2(200)
);
ALTER TABLE PAIS ADD CONSTRAINT PK_PAIS PRIMARY KEY (ID_PAIS);

CREATE TABLE TIPO_TRR_BITACORA_LIBRETA(
ID_TIPO_TRANSACCION NUMBER(15),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TIPO_TRR_BITACORA_LIBRETA ADD CONSTRAINT ID_TP_TRANSACC PRIMARY KEY (ID_TIPO_TRANSACCION);


CREATE TABLE ESTATUS_USUARIO(
ID_ESTATUS_USUARIO NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_USUARIO ADD CONSTRAINT PK_ID_STAT PRIMARY KEY(ID_ESTATUS_USUARIO);

CREATE TABLE TIPO_GENERO(
TIPO_GENERO NUMBER(1),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TIPO_GENERO ADD CONSTRAINT PK_TP_GENERO PRIMARY KEY(TIPO_GENERO);

CREATE TABLE MODULO(
ID_MODULO NUMBER(3),
DESCRIPCION VARCHAR2(200)
);
ALTER TABLE MODULO ADD CONSTRAINT PK_MOD PRIMARY KEY(ID_MODULO);

CREATE TABLE ESTATUS_LIBRETA(
ID_ESTATUS_LIBRETA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_LIBRETA ADD CONSTRAINT PK_ST_LIBR PRIMARY KEY(ID_ESTATUS_LIBRETA);

CREATE TABLE TP_TRANSACC_BITACORA_CLIENTE(
ID_TIPO_TRANSACCION NUMBER(3),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TP_TRANSACC_BITACORA_CLIENTE ADD CONSTRAINT PK_BT_CL PRIMARY KEY(ID_TIPO_TRANSACCION);


CREATE TABLE CAMPO_BITACORA_CLIENTE(
ID_CAMPO_AFECTADO NUMBER(3),
NOMBRE_CAMPO VARCHAR2(100)
);
ALTER TABLE CAMPO_BITACORA_CLIENTE ADD CONSTRAINT PK_CMP_BIT_CLIENTE PRIMARY KEY (ID_CAMPO_AFECTADO);

CREATE TABLE TIPO_TRANSACCION_BOVEDA(
TIPO_TRANSACCION NUMBER(3),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TIPO_TRANSACCION_BOVEDA ADD CONSTRAINT PK_TP_TRANSBOV PRIMARY KEY (TIPO_TRANSACCION);

CREATE TABLE ESTATUS_CHEQUERA(
ID_ESTATUS_CHEQUERA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_CHEQUERA ADD CONSTRAINT PK_ESTATUS_CHEUQERA PRIMARY KEY(ID_ESTATUS_CHEQUERA);

CREATE TABLE ESTATUS_CUENTA(
ID_ESTATUS_CUENTA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_CUENTA ADD CONSTRAINT PK_ESTATUS_CUENTA PRIMARY KEY(ID_ESTATUS_CUENTA);

CREATE TABLE TIPO_CUENTA(
ID_TIPO_CUENTA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE TIPO_CUENTA ADD CONSTRAINT PK_ID_TIPO_CUENTA PRIMARY KEY(ID_TIPO_CUENTA);

CREATE TABLE TIPO_BOLETA(
ID_TIPO_BOLETA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE TIPO_BOLETA ADD CONSTRAINT PK_ID_TP_BOLETA PRIMARY KEY(ID_TIPO_BOLETA);

CREATE TABLE ESTATUS_BOLETA(
ID_ESTATUS_BOLETA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_BOLETA ADD CONSTRAINT PK_ID_ST_BOL PRIMARY KEY(ID_ESTATUS_BOLETA);

CREATE TABLE ESTATUS_CHEQUE(
ID_ESTATUS_CHEQUE NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_CHEQUE ADD CONSTRAINT PK_ID_ST_CHEQ PRIMARY KEY(ID_ESTATUS_CHEQUE);




CREATE TABLE TIPO_TRANSACCION
(
ID_TIPO_TRANSACCION NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE TIPO_TRANSACCION ADD CONSTRAINT PK_TP_TRANS PRIMARY KEY(ID_TIPO_TRANSACCION);




CREATE TABLE ESTATUS_AGENCIA(
ID_ESTATUS NUMBER(2),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE ESTATUS_AGENCIA ADD CONSTRAINT PK_ST_AGEN PRIMARY KEY(ID_ESTATUS);



CREATE TABLE ESTATUS_CAJA(
ID_ESTATUS_CAJA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_CAJA ADD CONSTRAINT PK_ST_CAJA PRIMARY KEY(ID_ESTATUS_CAJA);


CREATE TABLE TIPO_TRANSAC_BITACORA_CHEQ
(
ID_TIPO_TRANSACCION NUMBER(3),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TIPO_TRANSAC_BITACORA_CHEQ ADD CONSTRAINT PK_TR_BIT_CHEQ PRIMARY KEY(ID_TIPO_TRANSACCION);

CREATE TABLE TIPO_TRANSACCION_CAJA(
TIPO_TRANSACCION NUMBER(3),
DESCRIPCION VARCHAR2(100)
);
ALTER TABLE TIPO_TRANSACCION_CAJA ADD CONSTRAINT PK_TP_TRS_CAJA PRIMARY KEY(TIPO_TRANSACCION);

CREATE TABLE ESTATUS_BOVEDA(
ID_ESTATUS_BOVEDA NUMBER(3),
NOMBRE VARCHAR2(100)
);
ALTER TABLE ESTATUS_BOVEDA ADD CONSTRAINT PK_ST_BOV PRIMARY KEY(ID_ESTATUS_BOVEDA);


CREATE TABLE ESTADO_TRANSACCION_GEN(
ID_ESTADO NUMBER(3),
DESCRIPCION VARCHAR2(200)
);
ALTER TABLE ESTADO_TRANSACCION_GEN ADD CONSTRAINT PK_ST_TRANSACC_GENERAL PRIMARY KEY(ID_ESTADO);


CREATE TABLE TIPO_USUARIO(
ID_TIPO_USUARIO NUMBER(3),
DESCRIPCION VARCHAR2(100),
ID_MODULO NUMBER(3)
);
ALTER TABLE TIPO_USUARIO ADD CONSTRAINT PK_TP_USR PRIMARY KEY(ID_TIPO_USUARIO);
ALTER TABLE TIPO_USUARIO ADD CONSTRAINT FK_MOOD FOREIGN KEY(ID_MODULO) REFERENCES MODULO(ID_MODULO);

CREATE TABLE DEPARTAMENTO(
ID_DEPARTAMENTO NUMBER(6),
NOMBRE VARCHAR2(200),
ID_PAIS NUMBER(4)
);
ALTER TABLE DEPARTAMENTO ADD CONSTRAINT PK_DPTO PRIMARY KEY (ID_DEPARTAMENTO);
ALTER TABLE DEPARTAMENTO ADD CONSTRAINT FK_PAIS FOREIGN KEY(ID_PAIS) REFERENCES PAIS (ID_PAIS);


CREATE TABLE MUNICIPIO(
ID_MUNICIPIO NUMBER(8),
NOMBRE VARCHAR2(200),
ID_DEPARTAMENTO NUMBER(6)
);
ALTER TABLE MUNICIPIO ADD CONSTRAINT PK_ID_MUN PRIMARY KEY(ID_MUNICIPIO);
ALTER TABLE MUNICIPIO ADD CONSTRAINT FK_ID_DEP FOREIGN KEY(ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO(ID_DEPARTAMENTO);


CREATE TABLE AGENCIA(
ID_AGENCIA NUMBER(8),
NOMBRE VARCHAR2(200),
DIRECCION VARCHAR2(300),
FECHA_APERTURA TIMESTAMP,
FECHA_CIERRE TIMESTAMP,
MUNICIPIO NUMBER(8),
TIPO_ESTATUS NUMBER(2)
);
ALTER TABLE AGENCIA ADD CONSTRAINT PK_ID_AG PRIMARY KEY(ID_AGENCIA);
ALTER TABLE AGENCIA ADD CONSTRAINT FK_MUN FOREIGN KEY(MUNICIPIO) REFERENCES MUNICIPIO(ID_MUNICIPIO);
ALTER TABLE AGENCIA ADD CONSTRAINT FK_TP_ST FOREIGN KEY(TIPO_ESTATUS) REFERENCES ESTATUS_AGENCIA (ID_ESTATUS);



CREATE TABLE CAJA(
ID_CAJA NUMBER(8),
NOMBRE VARCHAR2(100),
SALDO NUMBER(12,2),
ID_AGENCIA NUMBER(8),
TIPO_ESTADO NUMBER(3)
);
ALTER TABLE CAJA ADD CONSTRAINT PK_ID_CAJA PRIMARY KEY(ID_CAJA);
ALTER TABLE CAJA ADD CONSTRAINT FK_ID_CAJA FOREIGN KEY(ID_AGENCIA) REFERENCES AGENCIA(ID_AGENCIA);
ALTER TABLE CAJA ADD CONSTRAINT FK_ID_STA FOREIGN KEY(TIPO_ESTADO) REFERENCES ESTATUS_CAJA(ID_ESTATUS_CAJA);













CREATE TABLE CLIENTE (
ID_CLIENTE_NUMERO NUMBER(15),
NOMBRES VARCHAR2(100),
APELLIDOS VARCHAR2(100),
DPI VARCHAR2(13),
NIT VARCHAR2(15),
MUNICIPIO NUMBER(8),
DIRECCION VARCHAR2(200),
TELEFONO VARCHAR2(20),
CELULAR VARCHAR2(20),
CORREO_ELECTRONICO VARCHAR2(150),
TIPO_GENERO NUMBER(1),
FECHA_NACIMIENTO TIMESTAMP,
IMAGEN_FIRMA BLOB
);
ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLI PRIMARY KEY(ID_CLIENTE_NUMERO);
ALTER TABLE CLIENTE ADD CONSTRAINT FK_CL_MUN FOREIGN KEY(MUNICIPIO) REFERENCES MUNICIPIO(ID_MUNICIPIO);
ALTER TABLE CLIENTE ADD CONSTRAINT FK_TG_CL FOREIGN KEY(TIPO_GENERO) REFERENCES TIPO_GENERO (TIPO_GENERO);



CREATE TABLE EMPRESA (
ID_EMPRESA NUMBER(15),
ID_REPRESENTANTE_LEGAL NUMBER(15),
NOMBRE VARCHAR2(200),
DIRECCION VARCHAR2(400),
NIT VARCHAR2(15),
TELEFONO VARCHAR2(20),
CORREO VARCHAR2(150),
ID_MUNICIPIO NUMBER(8),
FECHA_CREACION TIMESTAMP,
ID_ESTATUS NUMBER(3)
);
ALTER TABLE EMPRESA ADD CONSTRAINT PK_ID_EMPR PRIMARY KEY(ID_EMPRESA);
ALTER TABLE EMPRESA ADD CONSTRAINT FK_ID_REP_LEG FOREIGN KEY(ID_REPRESENTANTE_LEGAL) REFERENCES CLIENTE (ID_CLIENTE_NUMERO);
ALTER TABLE EMPRESA ADD CONSTRAINT FK_TP_STATUS FOREIGN KEY(ID_ESTATUS) REFERENCES ESTATUS_EMPRESA(ID_ESTATUS_EMPRESA);
ALTER TABLE EMPRESA ADD CONSTRAINT FK_EMP_ID_MUN FOREIGN KEY(ID_MUNICIPIO) REFERENCES MUNICIPIO(ID_MUNICIPIO);




CREATE TABLE BITACORA_EMPRESA (
ID_OPERACION NUMBER(8),
ID_EMPRESA NUMBER(15),
VALOR_ANTERIOR VARCHAR2(200),
VALOR_NUEVO VARCHAR2(200),
FECHA_MODIFICACION TIMESTAMP,
DETALLES VARCHAR2(400),
CAMPO_AFECTADO NUMBER(10),
TIPO_OPERACION NUMBER(3)
);
ALTER TABLE BITACORA_EMPRESA ADD CONSTRAINT PK_ID_OPR PRIMARY KEY(ID_OPERACION);
ALTER TABLE BITACORA_EMPRESA ADD CONSTRAINT FK_ID_EMPR FOREIGN KEY(ID_EMPRESA) REFERENCES EMPRESA(ID_EMPRESA);
ALTER TABLE BITACORA_EMPRESA ADD CONSTRAINT FK_CP_AFECT FOREIGN KEY(CAMPO_AFECTADO) REFERENCES CAMPO_BITACORA_EMPRESA(ID_CAMPO_AFECTADO);
ALTER TABLE BITACORA_EMPRESA ADD CONSTRAINT FK_TP_OPR1 FOREIGN KEY(TIPO_OPERACION) REFERENCES TIPO_OPERACION_EMPRESA(TIPO_OPERACION_EMPRESA);




CREATE TABLE USUARIO(
ID_USUARIO NUMBER(15),
NOMBRE_USUARIO VARCHAR2(20),
NOMBRES VARCHAR2(100),
APELLIDOS VARCHAR2(100),
DPI VARCHAR2(13),
DIRECCION VARCHAR2(300),
CORREO_ELECTRONICO VARCHAR2(150),
TELEFONO VARCHAR2(20),
CELULAR VARCHAR2(20),
FECHA_NACIMENTO TIMESTAMP,
FECHA_CREACION TIMESTAMP,
FOTOGRAFIA BLOB,
FECHA_DE_BAJA TIMESTAMP,
CONTRASENA VARCHAR2(200),
ID_AGENCIA NUMBER(15),
ID_MUNICIPIO NUMBER(4),
TIPO_USUARIO NUMBER(3),
TIPO_GENERO NUMBER(1),
ESTATUS_USUARIO NUMBER(3)
);
ALTER TABLE USUARIO ADD CONSTRAINT PK_USR PRIMARY KEY(ID_USUARIO);
ALTER TABLE USUARIO ADD CONSTRAINT FK_ID_AG FOREIGN KEY(ID_AGENCIA) REFERENCES AGENCIA(ID_AGENCIA);
ALTER TABLE USUARIO ADD CONSTRAINT FK_ID_TP_USR FOREIGN KEY(TIPO_USUARIO) REFERENCES TIPO_USUARIO(ID_TIPO_USUARIO);
ALTER TABLE USUARIO ADD CONSTRAINT FK_ID_MUN_USR FOREIGN KEY(ID_MUNICIPIO) REFERENCES MUNICIPIO(ID_MUNICIPIO);
ALTER TABLE USUARIO ADD CONSTRAINT FK_ID_TP_GEN FOREIGN KEY(TIPO_GENERO) REFERENCES TIPO_GENERO(TIPO_GENERO);
ALTER TABLE USUARIO ADD CONSTRAINT FK_ID_ST_USR FOREIGN KEY(ESTATUS_USUARIO) REFERENCES ESTATUS_USUARIO(ID_ESTATUS_USUARIO);



CREATE TABLE BITACORA_CONFIGURACION(
ID_OPERACION NUMBER(8),
ID_USUARIO NUMBER(15),
VALOR_ANTERIOR VARCHAR2(200),
VALOR_NUEVO VARCHAR2(200),
FECHA_OPERACION TIMESTAMP,
CAMPO_AFECTADO NUMBER(10),
TIPO_OPERACION NUMBER(3)
);

ALTER TABLE BITACORA_CONFIGURACION ADD CONSTRAINT PK_BIT_CONF PRIMARY KEY(ID_OPERACION);
ALTER TABLE BITACORA_CONFIGURACION ADD CONSTRAINT FK_ID_USR_CONF FOREIGN KEY(ID_USUARIO)REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_CONFIGURACION ADD CONSTRAINT FK_CMP_AFECT FOREIGN KEY(CAMPO_AFECTADO) REFERENCES CAMPO_BITACORA_CONFIGURACION(ID_CAMPO_AFECTADO);
ALTER TABLE BITACORA_CONFIGURACION ADD CONSTRAINT FK_TP_OPR FOREIGN KEY(TIPO_OPERACION) REFERENCES TIPO_OPERACION_CONFIGURACION(TIPO_OPERACION);




CREATE TABLE BITACORA_USUARIO(
ID_OPERACION NUMBER(8),
ID_USUARIO NUMBER(15),
VALOR_ANTERIOR VARCHAR2(200),
VALOR_NUEVO VARCHAR2(200),
FECHA_OPERACION TIMESTAMP,
DETALLES VARCHAR2(400),
CAMPO_AFECTADO NUMBER(10),
TIPO_OPERACION NUMBER(3)
);
ALTER TABLE BITACORA_USUARIO ADD CONSTRAINT PK_ID_BT_USR PRIMARY KEY(ID_OPERACION);
ALTER TABLE BITACORA_USUARIO ADD CONSTRAINT FK_BTUSR_USR FOREIGN KEY(ID_USUARIO) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_USUARIO ADD CONSTRAINT FK_CMP_AFEC FOREIGN KEY(CAMPO_AFECTADO) REFERENCES CAMPO_BITACORA_USUARIO(ID_CAMPO_AFECTADO);
ALTER TABLE BITACORA_USUARIO ADD CONSTRAINT FK_TP_OPRUSR FOREIGN KEY(TIPO_OPERACION) REFERENCES TIPO_OPERACION_USUARIO(TIPO_OPERACION);






CREATE TABLE BOVEDA(
ID_BOVEDA NUMBER(8),
ID_AGENCIA NUMBER(8),
MONTO NUMBER(12,2),
TIPO_ESTADO NUMBER(3)
);
ALTER TABLE BOVEDA ADD CONSTRAINT PK_ID_BOV PRIMARY KEY(ID_BOVEDA);
ALTER TABLE BOVEDA ADD CONSTRAINT FK_ID_AG_BOV FOREIGN KEY(ID_AGENCIA) REFERENCES AGENCIA(ID_AGENCIA);
ALTER TABLE BOVEDA ADD CONSTRAINT FK_BOV_ST FOREIGN KEY(TIPO_ESTADO) REFERENCES ESTATUS_BOVEDA(ID_ESTATUS_BOVEDA);



CREATE TABLE BITACORA_BOVEDA_CAJA(
ID_TRANSACCION NUMBER(12),
MONTO_ANTERIOR NUMBER(12,2),
MONTO_NUEVO NUMBER(12,2),
FECHA_TRANSACCION TIMESTAMP,
ID_GERENTE NUMBER(15),
ID_USUARIO_RESPONSABLE NUMBER(15),
ID_BOVEDA NUMBER(8),
TIPO_TRANSACCION NUMBER(3),
ID_CAJA NUMBER(8)
);
ALTER TABLE BITACORA_BOVEDA_CAJA ADD CONSTRAINT PK_BIT_BOV_CAJA PRIMARY KEY(ID_TRANSACCION);
ALTER TABLE BITACORA_BOVEDA_CAJA ADD CONSTRAINT FK_ID_GER FOREIGN KEY(ID_GERENTE) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_BOVEDA_CAJA ADD CONSTRAINT FK_ID_USR_RESP FOREIGN KEY(ID_USUARIO_RESPONSABLE) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_BOVEDA_CAJA ADD CONSTRAINT FK_ID_BOV FOREIGN KEY(ID_BOVEDA) REFERENCES BOVEDA(ID_BOVEDA);
ALTER TABLE BITACORA_BOVEDA_CAJA ADD CONSTRAINT FK_ID_TP_TR FOREIGN KEY(TIPO_TRANSACCION) REFERENCES TIPO_TRANSACCION_BOVEDA(TIPO_TRANSACCION);
ALTER TABLE BITACORA_BOVEDA_CAJA ADD CONSTRAINT FK_ID_CAJA_BOV FOREIGN KEY(ID_CAJA) REFERENCES CAJA(ID_CAJA);



CREATE TABLE BITACORA_CAJA(
ID_TRANSACCION NUMBER(12),
MONTO_ANTERIOR NUMBER(12,2),
MONTO_NUEVO NUMBER(12,2),
FECHA_TRANSACCION TIMESTAMP,
ID_USUARIO_RESPONSABLE NUMBER(15),
TIPO_TRANSACCION NUMBER(3),
ID_CAJA NUMBER(8)
);
ALTER TABLE BITACORA_CAJA ADD CONSTRAINT PK_ID_TR PRIMARY KEY(ID_TRANSACCION);
ALTER TABLE BITACORA_CAJA ADD CONSTRAINT FK_CJ_RESP FOREIGN KEY(ID_USUARIO_RESPONSABLE) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_CAJA ADD CONSTRAINT FK_TP_TRS_CAJA FOREIGN KEY(TIPO_TRANSACCION) REFERENCES TIPO_TRANSACCION_CAJA(TIPO_TRANSACCION);
ALTER TABLE BITACORA_CAJA ADD CONSTRAINT FK_BTI_CAJA FOREIGN KEY(ID_CAJA) REFERENCES CAJA(ID_CAJA);


CREATE TABLE CUENTA(
ID_CUENTA VARCHAR2(30),
SALDO_EN_RESERVA NUMBER(12,2),
MONTO_DISPONIBLE NUMBER(12,2),
FECHA_CREACION TIMESTAMP,
FECHA_CANCELACION TIMESTAMP,
ID_ESTATUS NUMBER(3),
ID_TIPO NUMBER(3),
ID_AGENCIA_APERTURA NUMBER(8)
);
ALTER TABLE CUENTA ADD CONSTRAINT PK_ID_CUENTA PRIMARY KEY(ID_CUENTA);
ALTER TABLE CUENTA ADD CONSTRAINT FK_ID_ST_CUENTA FOREIGN KEY(ID_ESTATUS) REFERENCES ESTATUS_CUENTA(ID_ESTATUS_CUENTA);
ALTER TABLE CUENTA ADD CONSTRAINT FK_TP_CUENTA FOREIGN KEY(ID_TIPO) REFERENCES TIPO_CUENTA(ID_TIPO_CUENTA);
ALTER TABLE CUENTA ADD CONSTRAINT FK_ID_AGE_APERTURA FOREIGN KEY(ID_AGENCIA_APERTURA) REFERENCES AGENCIA(ID_AGENCIA);




CREATE TABLE CLIENTE_ASOCIADO_CUENTA(
ID_CLIENTE NUMBER(15),
ID_CUENTA VARCHAR2(20),
ID_EMPRESA NUMBER(15)
);
ALTER TABLE CLIENTE_ASOCIADO_CUENTA ADD CONSTRAINT PK_CLIENTE_CUENTA PRIMARY KEY(ID_CLIENTE,ID_CUENTA);
ALTER TABLE CLIENTE_ASOCIADO_CUENTA ADD CONSTRAINT FK_EMPR_CLIENTE FOREIGN KEY(ID_EMPRESA) REFERENCES EMPRESA(ID_EMPRESA);
ALTER TABLE CLIENTE_ASOCIADO_CUENTA ADD CONSTRAINT FK_ID_CL_ASOCIADO FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE_NUMERO);
ALTER TABLE CLIENTE_ASOCIADO_CUENTA ADD CONSTRAINT FK_ID_CUENTA_ASOC FOREIGN KEY(ID_CUENTA) REFERENCES CUENTA(ID_CUENTA);













CREATE TABLE BOLETA(
ID_BOLETA NUMBER(20),
MONTO NUMBER(12,2),
ID_CUENTA VARCHAR2(30),
TIPO_BOLETA NUMBER(3),
ID_ESTATUS NUMBER(3)
);
ALTER TABLE BOLETA ADD CONSTRAINT PK_ID_BOL PRIMARY KEY(ID_BOLETA);
ALTER TABLE BOLETA ADD CONSTRAINT FK_ID_CUENTA_BOL FOREIGN KEY(ID_CUENTA) REFERENCES CUENTA(ID_CUENTA);
ALTER TABLE BOLETA ADD CONSTRAINT FK_ID_BOL_TP FOREIGN KEY(TIPO_BOLETA) REFERENCES TIPO_BOLETA(ID_TIPO_BOLETA);
ALTER TABLE BOLETA ADD CONSTRAINT FK_ST_BOL FOREIGN KEY(ID_ESTATUS) REFERENCES ESTATUS_BOLETA(ID_ESTATUS_BOLETA);


CREATE TABLE LIBRETA(
ID_LIBRETA NUMBER(15),
ID_CUENTA VARCHAR2(30),
ID_ESTATUS NUMBER(3)
);
ALTER TABLE LIBRETA ADD CONSTRAINT PK_ID_LIB PRIMARY KEY(ID_LIBRETA);
ALTER TABLE LIBRETA ADD CONSTRAINT FK_id_cuen_lib FOREIGN KEY(ID_CUENTA) REFERENCES CUENTA(ID_CUENTA);
ALTER TABLE LIBRETA ADD CONSTRAINT FK_ID_ST FOREIGN KEY(ID_ESTATUS) REFERENCES ESTATUS_LIBRETA(ID_ESTATUS_LIBRETA);


CREATE TABLE DETALLE_LIBRETA(
ID_DETALLE_LIBRETA NUMBER(15),
ID_LIBRETA NUMBER(15),
FECHA TIMESTAMP,
SALDO NUMBER(12,2),
ID_BOLETA NUMBER(20)
);
ALTER TABLE DETALLE_LIBRETA ADD CONSTRAINT PK_DET_LIBRETA PRIMARY KEY(ID_DETALLE_LIBRETA);
ALTER TABLE DETALLE_LIBRETA ADD CONSTRAINT FK_ID_LIB_DET FOREIGN KEY(ID_LIBRETA) REFERENCES LIBRETA(ID_LIBRETA);
ALTER TABLE DETALLE_LIBRETA ADD CONSTRAINT FK_ID_BOLETA FOREIGN KEY(ID_BOLETA) REFERENCES BOLETA(ID_BOLETA);



CREATE TABLE CHEQUERA(
ID_CHEQUERA NUMBER(20),
ID_CUENTA VARCHAR2(30),
ID_ESTATUS NUMBER(3)
);
ALTER TABLE CHEQUERA ADD CONSTRAINT PK_ID_CHEQUER PRIMARY KEY(ID_CHEQUERA);
ALTER TABLE CHEQUERA ADD CONSTRAINT FK_CHEQ_CUENTA FOREIGN KEY(ID_CUENTA) REFERENCES CUENTA(ID_CUENTA);
ALTER TABLE CHEQUERA ADD CONSTRAINT FK_ID_EST_CHEQUERA FOREIGN KEY(ID_ESTATUS)REFERENCES ESTATUS_CHEQUERA(ID_ESTATUS_CHEQUERA);



CREATE TABLE CHEQUE(
ID_CHEQUE NUMBER(25),
NO_CHEQUE NUMBER(25),
ID_CHEQUERA NUMBER(20),
ID_ESTATUS_CHEQUE NUMBER(3)
);
ALTER TABLE CHEQUE ADD CONSTRAINT PK_CHEQUE PRIMARY KEY(ID_CHEQUE);
ALTER TABLE CHEQUE ADD CONSTRAINT FK_ID_CHEQUERA FOREIGN KEY(ID_CHEQUERA) REFERENCES CHEQUERA(ID_CHEQUERA);
ALTER TABLE CHEQUE ADD CONSTRAINT FK_ID_ST_CHEQUE FOREIGN KEY(ID_ESTATUS_CHEQUE) REFERENCES ESTATUS_CHEQUE(ID_ESTATUS_CHEQUE);




<<<<<<< HEAD








=======
>>>>>>> produccion-walter
CREATE TABLE BITACORA_LIBRETA(
ID_BITACORA_LIBRETA NUMBER(20),
ID_LIBRETA NUMBER(15),
ID_USUARIO NUMBER(15),
TIPO_TRANSACCION NUMBER(3),
FECHA TIMESTAMP,
VALOR_ANTIGUO NUMBER(12,2),
VALOR_NUEVO NUMBER(12,2)
);
ALTER TABLE BITACORA_LIBRETA ADD CONSTRAINT PK_ID_BIT_LIB PRIMARY KEY(ID_BITACORA_LIBRETA);
ALTER TABLE BITACORA_LIBRETA ADD CONSTRAINT FK_ID_LIB_BIT FOREIGN KEY(ID_LIBRETA) REFERENCES LIBRETA(ID_LIBRETA);
ALTER TABLE BITACORA_LIBRETA ADD CONSTRAINT FK_USR_BIT_LIB FOREIGN KEY(ID_USUARIO) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_LIBRETA ADD CONSTRAINT FK_TPTRS_BIT_LIB FOREIGN KEY(TIPO_TRANSACCION) REFERENCES TIPO_TRR_BITACORA_LIBRETA(ID_TIPO_TRANSACCION);



CREATE TABLE BITACORA_CLIENTE(
ID_BITACORA_CLIENTE NUMBER(20),
ID_CLIENTE NUMBER(15),
ID_USUARIO NUMBER(15),
TIPO_TRANSACCION NUMBER(3),
FECHA TIMESTAMP,
ID_CAMPO_AFECTADO NUMBER(3),
VALOR_ANTIGUO NUMBER(12,2),
VALOR_NUEVO NUMBER(12,2)
);
ALTER TABLE BITACORA_CLIENTE ADD CONSTRAINT PK_BIT_CL PRIMARY KEY(ID_BITACORA_CLIENTE);
ALTER TABLE BITACORA_CLIENTE ADD CONSTRAINT FK_BIT_CL_ID FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE_NUMERO);
ALTER TABLE BITACORA_CLIENTE ADD CONSTRAINT FK_BIT_CL_USR FOREIGN KEY(ID_USUARIO) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_CLIENTE ADD CONSTRAINT FK_BIT_CL_TPR FOREIGN KEY(TIPO_TRANSACCION) REFERENCES TP_TRANSACC_BITACORA_CLIENTE(ID_TIPO_TRANSACCION);
ALTER TABLE BITACORA_CLIENTE ADD CONSTRAINT FK_BIT_CL_CMA FOREIGN KEY(ID_CAMPO_AFECTADO) REFERENCES CAMPO_BITACORA_CLIENTE(ID_CAMPO_AFECTADO);



CREATE TABLE BITACORA_CHEQUE(
ID_BITACORA_CHEQUE NUMBER(20),
ID_CHEQUE NUMBER(25),
ID_USUARIO NUMBER(15),
TIPO_TRANSACCION NUMBER(3),
FECHA TIMESTAMP,
VALOR_ANTIGUO NUMBER(12,2),
VALOR_NUEVO NUMBER(12,2)
);
ALTER TABLE BITACORA_CHEQUE ADD CONSTRAINT PK_ID_BIT_CHEQ PRIMARY KEY(ID_BITACORA_CHEQUE);
ALTER TABLE BITACORA_CHEQUE ADD CONSTRAINT FK_BIT_CHEQUE FOREIGN KEY(ID_CHEQUE) REFERENCES CHEQUE(ID_CHEQUE);
ALTER TABLE BITACORA_CHEQUE ADD CONSTRAINT FK_BIT_ID_USR FOREIGN KEY(ID_USUARIO) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_CHEQUE ADD CONSTRAINT FK_BIT_TRANSACC FOREIGN KEY(TIPO_TRANSACCION) REFERENCES TIPO_TRANSAC_BITACORA_CHEQ(ID_TIPO_TRANSACCION);



CREATE TABLE PLANILLA(
ID_PLANILLA NUMBER(15),
DESCRIPCION VARCHAR2(400),
CUENTA_ORIGEN VARCHAR2(20),
MONTO_TOTAL NUMBER(12,6),
MONTO_OPERADO_EXITOSAMENTE NUMBER(12,6));
ALTER TABLE PLANILLA ADD CONSTRAINT PK_ID_PANILLA PRIMARY KEY(ID_PLANILLA);
ALTER TABLE PLANILLA ADD CONSTRAINT FK_CUENTA_ORIGEN FOREIGN KEY(CUENTA_ORIGEN) REFERENCES CUENTA(ID_CUENTA);


DROP TABLE BITACORA_SALDO;
ALTER TABLE CHEQUERA ADD FECHA_CREACION TIMESTAMP;
ALTER TABLE CHEQUERA ADD FECHA_ENTREGA TIMESTAMP;
DROP TABLE BITACORA_TRANSACCION;

CREATE TABLE BITACORA_TRANSACCION(
NO_TRANSACCION NUMBER(15),
ID_CAJA NUMBER(8),
ID_USUARIO NUMBER(15),
ID_CUENTA VARCHAR2(30),
ID_BOLETA NUMBER(20),
ID_CHEQUE NUMBER(25),
ID_CLIENTE_FIRMANTE NUMBER(15),
ID_LIBRETA NUMBER(15),
ID_TIPO NUMBER(3),
MONTO NUMBER(12,2),
SALDO_ANTERIOR NUMBER(12,2),
SALDO_NUEVO NUMBER (12,2),
FECHA TIMESTAMP,
ID_ESTADO NUMBER(3),
ID_PLANILLA NUMBER(15)
);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT PK_TRANSCCION_GEN PRIMARY KEY(NO_TRANSACCION);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_ID_CAJA_GEN FOREIGN KEY(ID_CAJA) REFERENCES CAJA(ID_CAJA);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_USR FOREIGN KEY(ID_USUARIO) REFERENCES USUARIO(ID_USUARIO);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_CUENTA FOREIGN KEY(ID_CUENTA) REFERENCES CUENTA(ID_CUENTA);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_BOL FOREIGN KEY(ID_BOLETA) REFERENCES BOLETA(ID_BOLETA);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT fK_TR_GEN_CHEQUE FOREIGN KEY(ID_CHEQUE) REFERENCES CHEQUE(ID_CHEQUE);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_FIRMANTE FOREIGN KEY(ID_CLIENTE_FIRMANTE) REFERENCES CLIENTE(ID_CLIENTE_NUMERO);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_LIB FOREIGN KEY(ID_LIBRETA) REFERENCES LIBRETA(ID_LIBRETA);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_TRAN FOREIGN KEY(ID_TIPO) REFERENCES TIPO_TRANSACCION(ID_TIPO_TRANSACCION);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_STA FOREIGN KEY(ID_ESTADO) REFERENCES ESTADO_TRANSACCION_GEN(ID_ESTADO);
ALTER TABLE BITACORA_TRANSACCION ADD CONSTRAINT FK_TR_GEN_PLAN FOREIGN KEY(ID_PLANILLA) REFERENCES PLANILLA(ID_PLANILLA);


/*SE AGREGA ESTA TABLA PORQUE PARA LA CONFIURACION DEBEMOS LLEVAR EL CONTROL DE QUE CAMPOS DE TABLAS EN ESPECÍFICO EL
SUPERUSUARIO O ADMINISTRADOR DEL SISTEMA CAMBIARA DE ESTATTUS LAS COSAS O LAS ELIMINARÁ*/
ALTER TABLE CAMPO_BITACORA_CONFIGURACION ADD (ID_TABLA NUMBER(4));
CREATE TABLE TABLA_CONFIGURACION(
ID_TABLA NUMBER(4),
NOMBRE VARCHAR2(100)
);
ALTER TABLE TABLA_CONFIGURACION ADD CONSTRAINT PK_ID_TBL_CONF PRIMARY KEY(ID_TABLA);
ALTER TABLE CAMPO_BITACORA_CONFIGURACION ADD CONSTRAINT FK_ID_CMP_TL FOREIGN KEY(ID_TABLA)
REFERENCES TABLA_CONFIGURACION(ID_TABLA);

/*CREATED AND EDITED BY WALTER RIVERA*/

/*    REGLA GENERAL*/

/*PARA  EL NOMBRE DE LAS SECUENCIAS
VAMOS A COLOCAR SEQ_TBL_NOMBRE_TABLA*/

/*PARA EL NOMBRE DE TRIGGERS
TRIG_(BF,AF,INST)_NOMBRE_TABLA*/
