-- ============================================================
--  SISTEMA LOGÍSTICO INTEGRAL: OmniRuta Express
--  SQL Server — Modelo Físico Final (3FN Completo)
--  29 Tablas | Filegroups Configurados | Optimizaciones Aplicadas
-- ============================================================

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'OmniRuta')
    DROP DATABASE OmniRuta;
GO

-- 1. CREACIÓN DE LA BD CON FILEGROUPS Y DATAFILES
CREATE DATABASE OmniRuta
ON PRIMARY 
(
    NAME = 'OmniRuta_Pri_Data',
    FILENAME = 'C:\SQLData\OmniRuta_Pri_Data.mdf',
    SIZE = 50MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10MB
),
FILEGROUP FG_Transaccional
(
    NAME = 'OmniRuta_Trans_Data',
    FILENAME = 'C:\SQLData\OmniRuta_Trans_Data.ndf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 20MB
),
FILEGROUP FG_Historico
(
    NAME = 'OmniRuta_Hist_Data',
    FILENAME = 'C:\SQLData\OmniRuta_Hist_Data.ndf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 50MB
)
LOG ON 
(
    NAME = 'OmniRuta_Log',
    FILENAME = 'C:\SQLData\OmniRuta_Log.ldf',
    SIZE = 50MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 10MB
) COLLATE Modern_Spanish_CI_AS;
GO

USE OmniRuta;
GO

-- ============================================================
--  1. GEOGRAFÍA (PRIMARY)
-- ============================================================

CREATE TABLE Departamento (
    id_departamento  TINYINT      NOT NULL IDENTITY(1,1),
    nombre           VARCHAR(80)  NOT NULL,
    codigo_ubigeo    CHAR(2)      NOT NULL,
    CONSTRAINT PK_Departamento      PRIMARY KEY (id_departamento),
    CONSTRAINT UQ_Departamento_ubigeo UNIQUE (codigo_ubigeo),
    CONSTRAINT UQ_Departamento_nombre UNIQUE (nombre)
) ON [PRIMARY];

CREATE TABLE Provincia (
    id_provincia     SMALLINT     NOT NULL IDENTITY(1,1),
    id_departamento  TINYINT      NOT NULL,
    nombre           VARCHAR(80)  NOT NULL,
    codigo_ubigeo    CHAR(4)      NOT NULL,
    CONSTRAINT PK_Provincia         PRIMARY KEY (id_provincia),
    CONSTRAINT UQ_Provincia_ubigeo  UNIQUE (codigo_ubigeo),
    CONSTRAINT FK_Provincia_Depto   FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
) ON [PRIMARY];

CREATE TABLE Distrito (
    id_distrito      INT          NOT NULL IDENTITY(1,1),
    id_provincia     SMALLINT     NOT NULL,
    nombre           VARCHAR(80)  NOT NULL,
    codigo_ubigeo    CHAR(6)      NOT NULL,
    CONSTRAINT PK_Distrito          PRIMARY KEY (id_distrito),
    CONSTRAINT UQ_Distrito_ubigeo   UNIQUE (codigo_ubigeo),
    CONSTRAINT FK_Distrito_Prov     FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
) ON [PRIMARY];

-- ============================================================
--  2. CATÁLOGOS BASE Y PARÁMETROS (PRIMARY)
-- ============================================================

CREATE TABLE Parametro (
    id_parametro     TINYINT      NOT NULL IDENTITY(1,1),
    codigo           VARCHAR(30)  NOT NULL,
    descripcion      VARCHAR(100) NOT NULL,
    valor            VARCHAR(200) NOT NULL,
    fecha_vigencia   DATE         NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    CONSTRAINT PK_Parametro    PRIMARY KEY (id_parametro),
    CONSTRAINT UQ_Param_Codigo UNIQUE (codigo)
) ON [PRIMARY];

CREATE TABLE TipoVia (
    id_tipo_via  TINYINT      NOT NULL IDENTITY(1,1),
    descripcion  VARCHAR(60)  NOT NULL,
    CONSTRAINT PK_TipoVia PRIMARY KEY (id_tipo_via)
) ON [PRIMARY];

CREATE TABLE TipoAgencia (
    id_tipo_agencia  TINYINT      NOT NULL IDENTITY(1,1),
    descripcion      VARCHAR(60)  NOT NULL,
    CONSTRAINT PK_TipoAgencia PRIMARY KEY (id_tipo_agencia)
) ON [PRIMARY];

CREATE TABLE TipoVehiculo (
    id_tipo_vehiculo  TINYINT      NOT NULL IDENTITY(1,1),
    descripcion       VARCHAR(60)  NOT NULL,
    modalidad         VARCHAR(20)  NOT NULL,
    CONSTRAINT PK_TipoVehiculo PRIMARY KEY (id_tipo_vehiculo),
    CONSTRAINT CK_Modalidad    CHECK (modalidad IN ('Terrestre','Fluvial','Aéreo'))
) ON [PRIMARY];

CREATE TABLE TipoServicio (
    id_tipo_servicio  TINYINT        NOT NULL IDENTITY(1,1),
    descripcion       VARCHAR(80)    NOT NULL,
    peso_max_kg       INT            NOT NULL,
    volumen_max_m3    DECIMAL(8,4)   NOT NULL,
    dias_entrega_max  TINYINT        NOT NULL,
    CONSTRAINT PK_TipoServicio PRIMARY KEY (id_tipo_servicio),
    CONSTRAINT CK_PesoMax      CHECK (peso_max_kg > 0)
) ON [PRIMARY];

CREATE TABLE EstadoEncomienda (
    id_estado    TINYINT      NOT NULL IDENTITY(1,1),
    descripcion  VARCHAR(50)  NOT NULL,
    color_hex    CHAR(7)      NOT NULL DEFAULT '#CCCCCC',
    CONSTRAINT PK_EstadoEncomienda PRIMARY KEY (id_estado)
) ON [PRIMARY];

-- Corrección 3FN: Se removió el salario_base de aquí
CREATE TABLE Cargo (
    id_cargo      TINYINT        NOT NULL IDENTITY(1,1),
    descripcion   VARCHAR(80)    NOT NULL,
    CONSTRAINT PK_Cargo PRIMARY KEY (id_cargo)
) ON [PRIMARY];

CREATE TABLE MetodoPago (
    id_metodo_pago TINYINT      NOT NULL IDENTITY(1,1),
    descripcion    VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_MetodoPago PRIMARY KEY (id_metodo_pago)
) ON [PRIMARY];

-- ============================================================
--  3. DIRECCIONES ESTANDARIZADAS (PRIMARY)
-- ============================================================

CREATE TABLE DireccionEstandar (
    id_direccion     INT          NOT NULL IDENTITY(1,1),
    id_tipo_via      TINYINT      NOT NULL,
    nombre_via       VARCHAR(100) NOT NULL,
    numero           VARCHAR(10)  NULL,
    interior         VARCHAR(20)  NULL,
    referencia       VARCHAR(150) NULL,
    id_distrito      INT          NOT NULL,
    CONSTRAINT PK_DireccionEstandar PRIMARY KEY (id_direccion),
    CONSTRAINT FK_DirEstandar_Via      FOREIGN KEY (id_tipo_via) REFERENCES TipoVia(id_tipo_via),
    CONSTRAINT FK_DirEstandar_Distrito FOREIGN KEY (id_distrito) REFERENCES Distrito(id_distrito)
) ON [PRIMARY];

-- ============================================================
--  4. INFRAESTRUCTURA Y LOGÍSTICA (PRIMARY)
-- ============================================================

CREATE TABLE Hub (
    id_hub           SMALLINT     NOT NULL IDENTITY(1,1),
    nombre           VARCHAR(100) NOT NULL,
    codigo_hub       CHAR(4)      NOT NULL,
    id_direccion     INT          NOT NULL,
    es_hub_principal BIT          NOT NULL DEFAULT 0,
    CONSTRAINT PK_Hub             PRIMARY KEY (id_hub),
    CONSTRAINT UQ_Hub_codigo      UNIQUE (codigo_hub),
    CONSTRAINT FK_Hub_Direccion   FOREIGN KEY (id_direccion) REFERENCES DireccionEstandar(id_direccion)
) ON [PRIMARY];

CREATE TABLE TarifarioZonal (
    id_hub_origen    SMALLINT      NOT NULL,
    id_hub_destino   SMALLINT      NOT NULL,
    id_tipo_servicio TINYINT       NOT NULL,
    precio_base      DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_TarifarioZonal   PRIMARY KEY (id_hub_origen, id_hub_destino, id_tipo_servicio),
    CONSTRAINT FK_Tarif_HubOrigen  FOREIGN KEY (id_hub_origen) REFERENCES Hub(id_hub),
    CONSTRAINT FK_Tarif_HubDestino FOREIGN KEY (id_hub_destino) REFERENCES Hub(id_hub),
    CONSTRAINT FK_Tarif_Servicio   FOREIGN KEY (id_tipo_servicio) REFERENCES TipoServicio(id_tipo_servicio),
    CONSTRAINT CK_PrecioBase       CHECK (precio_base > 0)
) ON [PRIMARY];

CREATE TABLE Agencia (
    id_agencia      INT          NOT NULL IDENTITY(1,1),
    nombre          VARCHAR(100) NOT NULL,
    id_direccion    INT          NOT NULL,
    id_hub          SMALLINT     NOT NULL,
    id_tipo_agencia TINYINT      NOT NULL,
    activa          BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Agencia          PRIMARY KEY (id_agencia),
    CONSTRAINT FK_Agencia_Direccion FOREIGN KEY (id_direccion) REFERENCES DireccionEstandar(id_direccion),
    CONSTRAINT FK_Agencia_Hub      FOREIGN KEY (id_hub) REFERENCES Hub(id_hub),
    CONSTRAINT FK_Agencia_Tipo     FOREIGN KEY (id_tipo_agencia) REFERENCES TipoAgencia(id_tipo_agencia)
) ON [PRIMARY];

-- Se añadieron atributos operativos de control vehicular
CREATE TABLE Vehiculo (
    id_vehiculo       INT           NOT NULL IDENTITY(1,1),
    placa             VARCHAR(10)   NOT NULL,
    id_tipo_vehiculo  TINYINT       NOT NULL,
    capacidad_kg      DECIMAL(10,2) NOT NULL,
    id_hub            SMALLINT      NOT NULL,
    fecha_soat        DATE          NULL,
    fecha_ultimo_mtto DATE          NULL,
    km_actual         DECIMAL(10,2) NULL,
    activo            BIT           NOT NULL DEFAULT 1,
    CONSTRAINT PK_Vehiculo          PRIMARY KEY (id_vehiculo),
    CONSTRAINT UQ_Vehiculo_placa    UNIQUE (placa),
    CONSTRAINT FK_Vehiculo_Tipo     FOREIGN KEY (id_tipo_vehiculo) REFERENCES TipoVehiculo(id_tipo_vehiculo),
    CONSTRAINT FK_Vehiculo_Hub      FOREIGN KEY (id_hub) REFERENCES Hub(id_hub)
) ON [PRIMARY];

-- ============================================================
--  5. PERSONAS (PRIMARY)
-- ============================================================

-- Se añadió distinción Corporativa (Persona Jurídica/Natural)
CREATE TABLE Cliente (
    id_cliente          INT          NOT NULL IDENTITY(1,1),
    tipo_persona        CHAR(1)      NOT NULL DEFAULT 'N', 
    nombres             VARCHAR(100) NULL,
    apellidos           VARCHAR(100) NULL,
    razon_social        VARCHAR(150) NULL,
    tipo_documento      CHAR(3)      NOT NULL, 
    num_documento       VARCHAR(15)  NOT NULL,
    id_direccion        INT          NOT NULL,
    fecha_registro      DATE         NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    activo              BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Cliente            PRIMARY KEY (id_cliente),
    CONSTRAINT UQ_Cliente_Documento  UNIQUE (tipo_documento, num_documento),
    CONSTRAINT FK_Cliente_Direccion  FOREIGN KEY (id_direccion) REFERENCES DireccionEstandar(id_direccion),
    CONSTRAINT CK_TipoPersona        CHECK (tipo_persona IN ('N','J'))
) ON [PRIMARY];

CREATE TABLE ContactoCliente (
    id_contacto    INT          NOT NULL IDENTITY(1,1),
    id_cliente     INT          NOT NULL,
    tipo_contacto  VARCHAR(20)  NOT NULL, 
    valor          VARCHAR(100) NOT NULL,
    principal      BIT          NOT NULL DEFAULT 0,
    CONSTRAINT PK_ContactoCliente PRIMARY KEY (id_contacto),
    CONSTRAINT FK_Contacto_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
) ON [PRIMARY];

CREATE TABLE ClienteContactoEmergencia (
    id_contacto_emerg INT          NOT NULL IDENTITY(1,1),
    id_cliente        INT          NOT NULL,
    nombre            VARCHAR(100) NOT NULL,
    parentesco        VARCHAR(50)  NOT NULL,
    telefono          VARCHAR(20)  NOT NULL,
    CONSTRAINT PK_ClienteEmergencia PRIMARY KEY (id_contacto_emerg),
    CONSTRAINT FK_Emergencia_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
) ON [PRIMARY];

-- Corrección 3FN: Salario movido directamente a la entidad Empleado
CREATE TABLE Empleado (
    id_empleado     INT            NOT NULL IDENTITY(1,1),
    nombres         VARCHAR(100)   NOT NULL,
    apellidos       VARCHAR(100)   NOT NULL,
    id_cargo        TINYINT        NOT NULL,
    id_agencia      INT            NULL, 
    num_documento   VARCHAR(15)    NOT NULL,
    salario         DECIMAL(10,2)  NOT NULL,
    activo          BIT            NOT NULL DEFAULT 1,
    CONSTRAINT PK_Empleado           PRIMARY KEY (id_empleado),
    CONSTRAINT UQ_Empleado_Doc       UNIQUE (num_documento),
    CONSTRAINT FK_Empleado_Cargo     FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo),
    CONSTRAINT FK_Empleado_Agencia   FOREIGN KEY (id_agencia) REFERENCES Agencia(id_agencia),
    CONSTRAINT CK_Salario_Positivo   CHECK (salario > 0)
) ON [PRIMARY];

CREATE TABLE EmpleadoAgenciaHistorial (
    id_historial   INT      NOT NULL IDENTITY(1,1),
    id_empleado    INT      NOT NULL,
    id_agencia     INT      NOT NULL,
    fecha_inicio   DATE     NOT NULL,
    fecha_fin      DATE     NULL,
    CONSTRAINT PK_EmpAgHistorial PRIMARY KEY (id_historial),
    CONSTRAINT FK_Historial_Emp    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    CONSTRAINT FK_Historial_Agencia FOREIGN KEY (id_agencia) REFERENCES Agencia(id_agencia)
) ON [PRIMARY];

-- ============================================================
--  6. OPERACIÓN TRANSACCIONAL (FG_Transaccional)
-- ============================================================

CREATE TABLE Encomienda (
    id_encomienda          BIGINT         NOT NULL IDENTITY(1,1),
    codigo_rastreo         VARCHAR(20)    NOT NULL,
    id_cliente_remitente   INT            NOT NULL,
    id_cliente_destinatario INT           NOT NULL,
    id_agencia_origen      INT            NOT NULL,
    id_agencia_destino     INT            NOT NULL,
    id_tipo_servicio       TINYINT        NOT NULL,
    tarifa_total           DECIMAL(10,2)  NOT NULL,
    fecha_registro         DATETIME       NOT NULL DEFAULT GETDATE(),
    id_estado              TINYINT        NOT NULL,
    CONSTRAINT PK_Encomienda               PRIMARY KEY (id_encomienda),
    CONSTRAINT UQ_Encomienda_codigo        UNIQUE (codigo_rastreo),
    CONSTRAINT FK_Encomienda_Remitente     FOREIGN KEY (id_cliente_remitente) REFERENCES Cliente(id_cliente),
    CONSTRAINT FK_Encomienda_Destinatario  FOREIGN KEY (id_cliente_destinatario) REFERENCES Cliente(id_cliente),
    CONSTRAINT FK_Encomienda_AgOrigen      FOREIGN KEY (id_agencia_origen) REFERENCES Agencia(id_agencia),
    CONSTRAINT FK_Encomienda_AgDestino     FOREIGN KEY (id_agencia_destino) REFERENCES Agencia(id_agencia),
    CONSTRAINT FK_Encomienda_TipoServicio  FOREIGN KEY (id_tipo_servicio) REFERENCES TipoServicio(id_tipo_servicio),
    CONSTRAINT FK_Encomienda_Estado        FOREIGN KEY (id_estado) REFERENCES EstadoEncomienda(id_estado)
) ON [FG_Transaccional];

-- Renombrado para mantener estándar PascalCase
CREATE TABLE DetalleEncomienda (
    id_detalle         BIGINT         NOT NULL IDENTITY(1,1),
    id_encomienda      BIGINT         NOT NULL,
    peso_kg            DECIMAL(10,3)  NOT NULL,
    volumen_m3         DECIMAL(8,5)   NOT NULL,
    codigo_barras_caja VARCHAR(30)    NOT NULL,
    descripcion        VARCHAR(200)   NULL,
    CONSTRAINT PK_DetalleEncomienda PRIMARY KEY (id_detalle),
    CONSTRAINT FK_Detalle_Encomienda FOREIGN KEY (id_encomienda) REFERENCES Encomienda(id_encomienda),
    CONSTRAINT UQ_Detalle_CodigoBarras UNIQUE (codigo_barras_caja)
) ON [FG_Transaccional];

-- ============================================================
--  7. FACTURACIÓN (FG_Transaccional)
-- ============================================================

CREATE TABLE ComprobantePago (
    id_comprobante   BIGINT        NOT NULL IDENTITY(1,1),
    id_encomienda    BIGINT        NOT NULL,
    tipo_comprobante CHAR(1)       NOT NULL, 
    serie            VARCHAR(4)    NOT NULL,
    correlativo      VARCHAR(8)    NOT NULL,
    subtotal         DECIMAL(10,2) NOT NULL,
    porcentaje_igv   DECIMAL(5,2)  NOT NULL DEFAULT 18.00,
    id_metodo_pago   TINYINT       NOT NULL,
    fecha_emision    DATETIME      NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Comprobante PRIMARY KEY (id_comprobante),
    CONSTRAINT UQ_Comprobante_SerieCorr UNIQUE (serie, correlativo),
    CONSTRAINT FK_Comprobante_Enc FOREIGN KEY (id_encomienda) REFERENCES Encomienda(id_encomienda),
    CONSTRAINT FK_Comprobante_Metodo FOREIGN KEY (id_metodo_pago) REFERENCES MetodoPago(id_metodo_pago),
    CONSTRAINT CK_TipoComprobante CHECK (tipo_comprobante IN ('B','F'))
) ON [FG_Transaccional];

-- ============================================================
--  8. DESPACHOS E INCIDENCIAS (FG_Transaccional)
-- ============================================================

CREATE TABLE Despacho (
    id_despacho          INT       NOT NULL IDENTITY(1,1),
    id_vehiculo          INT       NOT NULL,
    id_empleado_conductor INT      NOT NULL,
    id_hub_origen        SMALLINT  NOT NULL,
    id_hub_destino       SMALLINT  NOT NULL,
    fecha_hora_salida    DATETIME  NOT NULL,
    fecha_hora_llegada   DATETIME  NULL,
    distancia_km         DECIMAL(10,2) NOT NULL, 
    costo_operativo      DECIMAL(10,2) NOT NULL, 
    CONSTRAINT PK_Despacho            PRIMARY KEY (id_despacho),
    CONSTRAINT FK_Despacho_Vehiculo   FOREIGN KEY (id_vehiculo) REFERENCES Vehiculo(id_vehiculo),
    CONSTRAINT FK_Despacho_Conductor  FOREIGN KEY (id_empleado_conductor) REFERENCES Empleado(id_empleado),
    CONSTRAINT FK_Despacho_HubO       FOREIGN KEY (id_hub_origen) REFERENCES Hub(id_hub),
    CONSTRAINT FK_Despacho_HubD       FOREIGN KEY (id_hub_destino) REFERENCES Hub(id_hub)
) ON [FG_Transaccional];

CREATE TABLE DespachoEncomienda (
    id_despacho      INT      NOT NULL,
    id_encomienda    BIGINT   NOT NULL,
    fecha_inclusion  DATETIME NOT NULL DEFAULT GETDATE(),
    posicion_carga   TINYINT  NULL,
    CONSTRAINT PK_DespachoEncomienda PRIMARY KEY (id_despacho, id_encomienda),
    CONSTRAINT FK_DepEnc_Despacho    FOREIGN KEY (id_despacho) REFERENCES Despacho(id_despacho),
    CONSTRAINT FK_DepEnc_Encomienda  FOREIGN KEY (id_encomienda) REFERENCES Encomienda(id_encomienda)
) ON [FG_Transaccional];

CREATE TABLE Incidencia (
    id_incidencia      INT          NOT NULL IDENTITY(1,1),
    id_despacho        INT          NOT NULL,
    id_empleado        INT          NOT NULL,
    tipo_incidencia    VARCHAR(50)  NOT NULL,
    descripcion        VARCHAR(300) NOT NULL,
    nivel_gravedad     VARCHAR(20)  NOT NULL,
    fecha_hora_reporte DATETIME     NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Incidencia PRIMARY KEY (id_incidencia),
    CONSTRAINT FK_Incidencia_Despacho FOREIGN KEY (id_despacho) REFERENCES Despacho(id_despacho),
    CONSTRAINT FK_Incidencia_Empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    CONSTRAINT CK_Gravedad CHECK (nivel_gravedad IN ('Bajo','Medio','Alto','Crítico'))
) ON [FG_Transaccional];

-- ============================================================
--  9. AUDITORÍA Y SEGUIMIENTO (FG_Historico)
-- ============================================================

CREATE TABLE Seguimiento (
    id_seguimiento  BIGINT       NOT NULL IDENTITY(1,1),
    id_encomienda   BIGINT       NOT NULL,
    id_agencia      INT          NOT NULL,
    id_estado       TINYINT      NOT NULL,
    fecha_hora      DATETIME     NOT NULL DEFAULT GETDATE(),
    observacion     VARCHAR(500) NULL,
    id_empleado     INT          NOT NULL,
    CONSTRAINT PK_Seguimiento          PRIMARY KEY (id_seguimiento),
    CONSTRAINT FK_Seguimiento_Enc      FOREIGN KEY (id_encomienda) REFERENCES Encomienda(id_encomienda),
    CONSTRAINT FK_Seguimiento_Agencia  FOREIGN KEY (id_agencia) REFERENCES Agencia(id_agencia),
    CONSTRAINT FK_Seguimiento_Estado   FOREIGN KEY (id_estado) REFERENCES EstadoEncomienda(id_estado),
    CONSTRAINT FK_Seguimiento_Empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
) ON [FG_Historico];

CREATE TABLE EntregaFinal (
    id_encomienda     BIGINT       NOT NULL,
    dni_receptor      VARCHAR(15)  NOT NULL,
    nombre_receptor   VARCHAR(150) NOT NULL,
    fecha_entrega     DATETIME     NOT NULL DEFAULT GETDATE(),
    observacion       VARCHAR(200) NULL,
    CONSTRAINT PK_EntregaFinal PRIMARY KEY (id_encomienda),
    CONSTRAINT FK_EntregaFinal_Enc FOREIGN KEY (id_encomienda) REFERENCES Encomienda(id_encomienda)
) ON [FG_Historico];
GO