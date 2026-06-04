-- ============================================================
-- 10. ÍNDICES (Mínimo 2 - Rendimiento y Búsqueda)
-- ============================================================

-- Índice 1 (Non-Clustered): Optimiza las búsquedas de tracking para los clientes.
CREATE NONCLUSTERED INDEX IX_Encomienda_CodigoRastreo 
ON Encomienda (codigo_rastreo);
GO

-- Índice 2 (Non-Clustered): Acelera los cálculos del dashboard al filtrar despachos por fecha.
CREATE NONCLUSTERED INDEX IX_Despacho_FechaSalida 
ON Despacho (fecha_hora_salida);
GO


-- ============================================================
-- 11. VISTAS (Mínimo 2 - Fuente para Looker Studio)
-- ============================================================

-- Vista 1 (Simple): Directorio de vehículos operativos
IF OBJECT_ID('v_DirectorioFlotaActiva', 'V') IS NOT NULL DROP VIEW v_DirectorioFlotaActiva;
GO
CREATE VIEW v_DirectorioFlotaActiva AS
SELECT 
    v.placa, 
    v.capacidad_kg, 
    v.km_actual,
    tv.descripcion AS tipo_vehiculo
FROM Vehiculo v
INNER JOIN TipoVehiculo tv ON v.id_tipo_vehiculo = tv.id_tipo_vehiculo
WHERE v.activo = 1;
GO

-- Vista 2 (Compleja - Del script de tu compañero): Mapa de Incidencias
IF OBJECT_ID('v_DashboardMapaIncidencias', 'V') IS NOT NULL DROP VIEW v_DashboardMapaIncidencias;
GO
CREATE VIEW v_DashboardMapaIncidencias AS
SELECT 
    d.id_despacho AS [ID_Despacho],
    ho.nombre AS [Hub_Origen],
    hd.nombre AS [Hub_Destino],
    dep.nombre AS [Departamento_Origen],
    i.tipo_incidencia AS [Tipo_Problema],
    i.descripcion AS [Detalle_Incidencia],
    i.nivel_gravedad AS [Gravedad],
    i.fecha_hora_reporte AS [Fecha_Reporte]
FROM Incidencia i
INNER JOIN Despacho d ON i.id_despacho = d.id_despacho
INNER JOIN Hub ho ON d.id_hub_origen = ho.id_hub
INNER JOIN Hub hd ON d.id_hub_destino = hd.id_hub
INNER JOIN DireccionEstandar dir ON ho.id_direccion = dir.id_direccion
INNER JOIN Distrito dis ON dir.id_distrito = dis.id_distrito
INNER JOIN Provincia prov ON dis.id_provincia = prov.id_provincia
INNER JOIN Departamento dep ON prov.id_departamento = dep.id_departamento;
GO

-- Vista 3: Métricas de Operación Logística y Finanzas
IF OBJECT_ID('vw_DashboardLogistico', 'V') IS NOT NULL DROP VIEW vw_DashboardLogistico;
GO

CREATE VIEW vw_DashboardLogistico AS
SELECT 
    d.id_despacho AS [ID_Despacho],
    d.fecha_hora_salida AS [Fecha_Envio],
    DATEPART(HOUR, d.fecha_hora_salida) AS [Hora_Salida],
    ho.nombre AS [Hub_Origen],
    hd.nombre AS [Hub_Destino],
    v.placa AS [Placa_Vehiculo],
    tv.descripcion AS [Tipo_Vehiculo],
    v.capacidad_kg AS [Capacidad_Max_Vehiculo],
    
    -- Ocupación (Peso acumulado de las encomiendas asignadas a este despacho)
    ISNULL((
        SELECT SUM(e.peso_kg) 
        FROM DespachoEncomienda de 
        INNER JOIN DetalleEncomienda e ON de.id_encomienda = e.id_encomienda
        WHERE de.id_despacho = d.id_despacho
    ), 0) AS [Peso_Total_Cargado],

    -- Finanzas (Suma de la tarifa total de las encomiendas asociadas a este despacho)
    ISNULL((
        SELECT SUM(enc.tarifa_total) 
        FROM DespachoEncomienda de 
        INNER JOIN Encomienda enc ON de.id_encomienda = enc.id_encomienda
        WHERE de.id_despacho = d.id_despacho
    ), 0) AS [Tarifa_Total],
    
    -- Tiempos y Cumplimiento
    CASE 
        WHEN d.fecha_hora_llegada IS NULL THEN 'En Ruta'
        ELSE 'Entregado'
    END AS [Estado_Despacho],
    
    -- Lógica de cumplimiento: Se evalúa si llegó antes de 48 horas desde la salida
    CASE 
        WHEN d.fecha_hora_llegada IS NULL THEN 'Pendiente'
        WHEN d.fecha_hora_llegada <= DATEADD(DAY, 2, d.fecha_hora_salida) THEN 'A Tiempo'
        ELSE 'Retrasado'
    END AS [Cumplimiento_Tiempo],
    
    -- Costos y Distancia reales sacados de tu tabla Despacho
    d.costo_operativo AS [Costo_Operativo_Fijo],
    d.distancia_km AS [Distancia_KM]

FROM Despacho d
INNER JOIN Hub ho ON d.id_hub_origen = ho.id_hub
INNER JOIN Hub hd ON d.id_hub_destino = hd.id_hub
INNER JOIN Vehiculo v ON d.id_vehiculo = v.id_vehiculo
INNER JOIN TipoVehiculo tv ON v.id_tipo_vehiculo = tv.id_tipo_vehiculo;
GO

-- ============================================================
-- 12. STORED PROCEDURES (Mínimo 5 requeridos)
-- ============================================================

-- SP 1: Registro/Inserción (Transaccional)
CREATE PROCEDURE usp_RegistrarIncidencia
    @id_despacho INT,
    @id_empleado INT,
    @tipo_incidencia VARCHAR(50),
    @descripcion VARCHAR(300),
    @nivel_gravedad VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Incidencia (id_despacho, id_empleado, tipo_incidencia, descripcion, nivel_gravedad, fecha_hora_reporte)
    VALUES (@id_despacho, @id_empleado, @tipo_incidencia, @descripcion, @nivel_gravedad, GETDATE());
END;
GO

-- SP 2: Consulta con Parámetros (Reciclando la consulta de Rutas Rentables)
CREATE PROCEDURE usp_TopRutasRentables
    @CantidadTop INT -- Parámetro para elegir si quieres el Top 3, Top 5, etc.
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP (@CantidadTop)
        ao.nombre AS [Agencia Origen],
        ad.nombre AS [Agencia Destino],
        COUNT(e.id_encomienda) AS [Total Envíos],
        SUM(e.tarifa_total) AS [Ingresos Totales (S/.)]
    FROM Encomienda e
    INNER JOIN Agencia ao ON e.id_agencia_origen = ao.id_agencia
    INNER JOIN Agencia ad ON e.id_agencia_destino = ad.id_agencia
    GROUP BY ao.nombre, ad.nombre
    ORDER BY [Ingresos Totales (S/.)] DESC;
END;
GO

-- SP 3: Consulta con Parámetros (Reciclando la consulta de Rendimiento de Flota)
CREATE PROCEDURE usp_RendimientoFlota
    @Modalidad VARCHAR(20) -- Parámetro para filtrar por Terrestre o Fluvial
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        v.placa AS [Placa del Vehículo],
        tv.descripcion AS [Tipo de Unidad],
        COUNT(d.id_despacho) AS [Total Despachos],
        SUM(d.distancia_km) AS [Kilómetros Recorridos]
    FROM Despacho d
    INNER JOIN Vehiculo v ON d.id_vehiculo = v.id_vehiculo
    INNER JOIN TipoVehiculo tv ON v.id_tipo_vehiculo = tv.id_tipo_vehiculo
    WHERE tv.modalidad = @Modalidad
    GROUP BY v.placa, tv.descripcion
    ORDER BY [Total Despachos] DESC;
END;
GO

-- SP 4: Consulta con Parámetros (Reciclando la consulta de Cuellos de Botella)
CREATE PROCEDURE usp_AlertasCuellosBotella
    @Mes INT,
    @Anio INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        ho.nombre AS [Hub Origen],
        hd.nombre AS [Hub Destino],
        COUNT(i.id_incidencia) AS [Cantidad de Incidencias]
    FROM Incidencia i
    INNER JOIN Despacho d ON i.id_despacho = d.id_despacho
    INNER JOIN Hub ho ON d.id_hub_origen = ho.id_hub
    INNER JOIN Hub hd ON d.id_hub_destino = hd.id_hub
    WHERE MONTH(d.fecha_hora_salida) = @Mes AND YEAR(d.fecha_hora_salida) = @Anio
    GROUP BY ho.nombre, hd.nombre
    ORDER BY [Cantidad de Incidencias] DESC;
END;
GO

-- SP 5: Actualización / Eliminación Lógica
CREATE PROCEDURE usp_BajaLogicaVehiculo
    @id_vehiculo INT
AS
BEGIN
    SET NOCOUNT ON;
    -- Se cumple la eliminación lógica cambiando el estado 'activo' sin usar DELETE
    UPDATE Vehiculo
    SET activo = 0
    WHERE id_vehiculo = @id_vehiculo;
END;
GO