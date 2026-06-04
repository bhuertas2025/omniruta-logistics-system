USE OmniRuta;
GO

-- ============================================================
-- 1. GEOGRAFÍA NACIONAL COMPLETA (24 Deptos + Callao)
-- ============================================================

SET IDENTITY_INSERT Departamento ON;
INSERT INTO Departamento (id_departamento, nombre, codigo_ubigeo) VALUES 
(1, 'Amazonas', '01'),       (2, 'Áncash', '02'),         (3, 'Apurímac', '03'), 
(4, 'Arequipa', '04'),       (5, 'Ayacucho', '05'),       (6, 'Cajamarca', '06'), 
(7, 'Callao', '07'),         (8, 'Cusco', '08'),          (9, 'Huancavelica', '09'), 
(10, 'Huánuco', '10'),       (11, 'Ica', '11'),           (12, 'Junín', '12'), 
(13, 'La Libertad', '13'),   (14, 'Lambayeque', '14'),    (15, 'Lima', '15'), 
(16, 'Loreto', '16'),        (17, 'Madre de Dios', '17'), (18, 'Moquegua', '18'), 
(19, 'Pasco', '19'),         (20, 'Piura', '20'),         (21, 'Puno', '21'), 
(22, 'San Martín', '22'),    (23, 'Tacna', '23'),         (24, 'Tumbes', '24'), 
(25, 'Ucayali', '25');
SET IDENTITY_INSERT Departamento OFF;
GO

SET IDENTITY_INSERT Provincia ON;
INSERT INTO Provincia (id_provincia, id_departamento, nombre, codigo_ubigeo) VALUES 
(1, 1, 'Chachapoyas', '0101'),     (2, 2, 'Huaraz', '0201'),          (3, 2, 'Santa', '0218'),
(4, 3, 'Abancay', '0301'),         (5, 4, 'Arequipa', '0401'),        (6, 5, 'Huamanga', '0501'), 
(7, 6, 'Cajamarca', '0601'),       (8, 7, 'Callao', '0701'),          (9, 8, 'Cusco', '0801'), 
(10, 9, 'Huancavelica', '0901'),   (11, 10, 'Huánuco', '1001'),       (12, 11, 'Ica', '1101'), 
(13, 12, 'Huancayo', '1201'),      (14, 13, 'Trujillo', '1301'),      (15, 14, 'Chiclayo', '1401'), 
(16, 15, 'Lima', '1501'),          (17, 15, 'Barranca', '1502'),      (18, 16, 'Maynas', '1601'), 
(19, 17, 'Tambopata', '1701'),     (20, 18, 'Mariscal Nieto', '1801'),(21, 19, 'Pasco', '1901'), 
(22, 20, 'Piura', '2001'),         (23, 21, 'Puno', '2101'),          (24, 21, 'San Román', '2111'),
(25, 22, 'San Martín', '2204'),    (26, 23, 'Tacna', '2301'),         (27, 24, 'Tumbes', '2401'), 
(28, 25, 'Coronel Portillo', '2501'); 
SET IDENTITY_INSERT Provincia OFF;
GO

SET IDENTITY_INSERT Distrito ON;
INSERT INTO Distrito (id_distrito, id_provincia, nombre, codigo_ubigeo) VALUES 
(1, 1, 'Chachapoyas', '010101'),       (2, 2, 'Huaraz', '020101'),          (3, 3, 'Chimbote', '021801'),
(4, 4, 'Abancay', '030101'),           (5, 5, 'Arequipa Centro', '040101'), (6, 6, 'Ayacucho', '050101'),
(7, 7, 'Cajamarca', '060101'),         (8, 8, 'Callao', '070101'),          (9, 9, 'Cusco', '080101'),
(10, 10, 'Huancavelica', '090101'),    (11, 11, 'Huánuco', '100101'),       (12, 12, 'Ica', '110101'),
(13, 13, 'Huancayo', '120101'),        (14, 14, 'Trujillo', '130101'),      (15, 15, 'Chiclayo', '140101'),
(16, 16, 'Lima Cercado', '150101'),    (17, 16, 'San Isidro', '150131'),    (18, 17, 'Barranca', '150201'),
(19, 17, 'Paramonga', '150202'),       (20, 18, 'Iquitos', '160101'),       (21, 19, 'Puerto Maldonado', '170101'),
(22, 20, 'Moquegua', '180101'),        (23, 21, 'Chaupimarca', '190101'),   (24, 22, 'Piura', '200101'),
(25, 23, 'Puno', '210101'),            (26, 24, 'Juliaca', '211101'),       (27, 25, 'Tarapoto', '220401'),
(28, 26, 'Tacna', '230101'),           (29, 27, 'Tumbes', '240101'),        (30, 28, 'Callería', '250101'); 
SET IDENTITY_INSERT Distrito OFF;
GO

-- ============================================================
-- 2. CATÁLOGOS BASE
-- ============================================================

INSERT INTO Parametro (codigo, descripcion, valor) VALUES 
('IGV_VIGENTE', 'Impuesto General a las Ventas', '18.00'),
('PESO_MAX_PERMITIDO', 'Peso máximo general por bulto', '500.00');

INSERT INTO TipoVia (descripcion) VALUES 
('Avenida'), ('Jirón'), ('Calle'), ('Carretera Panamericana'), ('Vía Fluvial');

INSERT INTO TipoAgencia (descripcion) VALUES 
('Sede Principal'), ('Hub Regional'), ('Agencia Autorizada'), ('Punto de Recojo');

INSERT INTO TipoVehiculo (descripcion, modalidad) VALUES 
('Tractocamión 30TN', 'Terrestre'), ('Furgoneta Cerrada 10TN', 'Terrestre'), 
('Moto de Reparto', 'Terrestre'), ('Barcaza de Carga', 'Fluvial');

INSERT INTO TipoServicio (descripcion, peso_max_kg, volumen_max_m3, dias_entrega_max) VALUES 
('Express 24H (Terrestre)', 50, 0.5000, 1),
('Estándar Regional', 100, 2.0000, 3),
('Carga Pesada Nacional', 500, 5.0000, 5),
('Fluvial Amazónico', 300, 3.0000, 10);

INSERT INTO EstadoEncomienda (descripcion, color_hex) VALUES 
('Registrado', '#6B7280'), ('En Tránsito', '#F59E0B'), 
('En Agencia Destino', '#3B82F6'), ('Entregado', '#10B981'), ('Incidencia', '#EF4444');

INSERT INTO Cargo (descripcion) VALUES 
('Gerente de Operaciones'), ('Jefe de Agencia'), ('Conductor Interprovincial'), 
('Almacenero'), ('Atención al Cliente');

INSERT INTO MetodoPago (descripcion) VALUES 
('Efectivo'), ('Yape / Plin'), ('Tarjeta Crédito/Débito'), ('Transferencia BCP');
GO

-- ============================================================
-- 3. DIRECCIONES ESTANDARIZADAS
-- ============================================================

INSERT INTO DireccionEstandar (id_tipo_via, nombre_via, numero, interior, referencia, id_distrito) VALUES 
(2, 'Amazonas', '340', NULL, 'A una cuadra de la plaza', 1),            
(1, 'Mariscal Luzuriaga', '1000', NULL, 'Zona comercial', 2),           
(4, 'Panamericana Norte', 'Km 430', NULL, 'Terminal', 3),               
(1, 'Díaz Bárcenas', '150', NULL, 'Cruce principal', 4),                
(1, 'Ejército', '900', NULL, 'Parque Industrial', 5),                   
(2, '9 de Diciembre', '220', NULL, 'Centro histórico', 6),              
(1, 'Vía de Evitamiento', 'Sur', NULL, 'Salida a la costa', 7),         
(1, 'Sáenz Peña', '1550', NULL, 'Cerca al puerto', 8),                  
(1, 'La Cultura', '1256', NULL, 'Cruce con Vía Expresa', 9),            
(1, 'Manrique', '405', NULL, 'Frente al estadio', 10),                  
(1, 'Universitaria', '700', NULL, 'Zona sur', 11),                      
(4, 'Panamericana Sur', 'Km 300', NULL, 'Ingreso a la ciudad', 12),     
(1, 'Ferrocarril', '580', NULL, 'Cerca al mercado', 13),                
(4, 'Panamericana Norte', 'Km 560', NULL, 'Vía Evitamiento', 14),       
(1, 'Balta', '800', NULL, 'Centro Chiclayo', 15),                       
(4, 'Panamericana Sur', 'S/N', 'Lote 1', 'Peaje Villa', 16),            
(1, 'Javier Prado', '4500', NULL, 'Zona Financiera', 17),               
(1, 'Antigua Panamericana Norte', '450', NULL, 'Norte Chico', 18),      
(4, 'Panamericana Norte', 'Km 205', NULL, 'Ingreso a Paramonga', 19),   
(5, 'Malecón Tarapacá', 'S/N', NULL, 'Puerto Iquitos', 20),             
(1, 'León Velarde', '105', NULL, 'Centro', 21),                         
(1, 'Balta', '200', NULL, 'Plaza central', 22),                         
(1, 'De los Próceres', '400', NULL, 'Parte alta', 23),                  
(1, 'Sánchez Cerro', '2200', 'Zona Ind', 'Terminal terrestre', 24),     
(1, 'La Torre', '300', NULL, 'Frente al lago', 25),                     
(1, 'San Martín', '1500', NULL, 'Salida norte', 26),                    
(1, 'Vía de Evitamiento', 'Km 2', NULL, 'Salida a Yurimaguas', 27),     
(4, 'Panamericana Sur', 'Km 1300', NULL, 'Zona franca', 28),            
(4, 'Panamericana Norte', 'Km 1270', NULL, 'Frontera norte', 29),       
(5, 'Malecón Grau', 'S/N', NULL, 'Puerto Callería', 30),
(2, 'Gálvez', '123', 'Apt 4', 'A dos cuadras del centro', 18);
GO

-- ============================================================
-- 4. INFRAESTRUCTURA
-- ============================================================

INSERT INTO Hub (nombre, codigo_hub, id_direccion, es_hub_principal) VALUES 
('Hub Amazonas', 'HAMA', 1, 1),      ('Hub Áncash', 'HANC', 2, 1),       
('Hub Apurímac', 'HAPU', 4, 1),      ('Hub Arequipa', 'HARE', 5, 1),     
('Hub Ayacucho', 'HAYA', 6, 1),      ('Hub Cajamarca', 'HCAJ', 7, 1),    
('Hub Callao', 'HCAL', 8, 1),        ('Hub Cusco', 'HCUS', 9, 1),        
('Hub Huancavelica', 'HHVC', 10, 1), ('Hub Huánuco', 'HHCO', 11, 1),     
('Hub Ica', 'HICA', 12, 1),          ('Hub Junín', 'HJUN', 13, 1),       
('Hub La Libertad', 'HTRU', 14, 1),  ('Hub Lambayeque', 'HLAM', 15, 1),  
('Hub Central Lima', 'HLIM', 16, 1), ('Hub Loreto', 'HIQU', 20, 1),      
('Hub Madre de Dios', 'HMAD', 21, 1),('Hub Moquegua', 'HMOQ', 22, 1),    
('Hub Pasco', 'HPAS', 23, 1),        ('Hub Piura', 'HPIU', 24, 1),       
('Hub Puno', 'HPUN', 25, 1),         ('Hub San Martín', 'HSAM', 27, 1),  
('Hub Tacna', 'HTAC', 28, 1),        ('Hub Tumbes', 'HTUM', 29, 1),      
('Hub Ucayali', 'HUCA', 30, 1);

INSERT INTO Agencia (nombre, id_direccion, id_hub, id_tipo_agencia, activa) VALUES 
('Agencia Chachapoyas', 1, 1, 2, 1),   ('Agencia Huaraz', 2, 2, 2, 1),
('Agencia Chimbote', 3, 2, 3, 1),      ('Agencia Abancay', 4, 3, 2, 1),
('Agencia Arequipa', 5, 4, 1, 1),      ('Agencia Ayacucho', 6, 5, 2, 1),
('Agencia Cajamarca', 7, 6, 2, 1),     ('Agencia Puerto Callao', 8, 7, 1, 1),
('Agencia Cusco', 9, 8, 1, 1),         ('Agencia Huancavelica', 10, 9, 2, 1),
('Agencia Huánuco', 11, 10, 2, 1),     ('Agencia Ica', 12, 11, 2, 1),
('Agencia Huancayo', 13, 12, 1, 1),    ('Agencia Trujillo', 14, 13, 1, 1),
('Agencia Chiclayo', 15, 14, 1, 1),    ('Agencia Principal Lima', 16, 15, 1, 1),
('Agencia San Isidro', 17, 15, 3, 1),  ('Agencia Norte Chico Barranca', 18, 15, 2, 1),
('Agencia Paramonga', 19, 15, 3, 1),   ('Agencia Fluvial Iquitos', 20, 16, 1, 1),
('Agencia Tambopata', 21, 17, 2, 1),   ('Agencia Moquegua', 22, 18, 2, 1),
('Agencia Cerro de Pasco', 23, 19, 2, 1),('Agencia Piura', 24, 20, 1, 1),
('Agencia Puno', 25, 21, 2, 1),        ('Agencia Juliaca', 26, 21, 3, 1),
('Agencia Tarapoto', 27, 22, 2, 1),    ('Agencia Frontera Tacna', 28, 23, 1, 1),
('Agencia Frontera Tumbes', 29, 24, 1, 1),('Agencia Pucallpa', 30, 25, 1, 1);
GO

-- ============================================================
-- 5. TARIFARIO ZONAL
-- ============================================================

INSERT INTO TarifarioZonal (id_hub_origen, id_hub_destino, id_tipo_servicio, precio_base) VALUES 
(15, 13, 2, 20.00),  (15, 13, 1, 35.00),  (15, 20, 2, 25.00),  
(15, 24, 3, 120.00), (15, 4, 2, 30.00),   (15, 4, 3, 150.00),  
(15, 8, 2, 45.00),   (15, 21, 2, 50.00),  (15, 23, 2, 60.00),  
(15, 12, 2, 25.00),  (15, 16, 4, 180.00), (15, 25, 3, 160.00), 
(13, 20, 1, 25.00),  (13, 14, 2, 15.00),  (14, 24, 2, 35.00),  
(6, 13, 2, 30.00),   (4, 8, 2, 35.00),    (4, 8, 1, 60.00),    
(4, 21, 2, 25.00),   (4, 23, 2, 30.00),   (8, 21, 2, 25.00),   
(12, 10, 2, 30.00),  (10, 25, 2, 50.00),  (25, 16, 4, 100.00), 
(22, 16, 4, 120.00), (22, 1, 2, 45.00);   
GO

-- ============================================================
-- 6. FLOTA Y PERSONAL
-- ============================================================

INSERT INTO Vehiculo (placa, id_tipo_vehiculo, capacidad_kg, id_hub, fecha_soat, activo) VALUES 
('ABC-001', 1, 30000.00, 15, '2026-12-31', 1), ('ABC-002', 2, 10000.00, 15, '2026-10-15', 1),
('ABC-003', 1, 30000.00, 13, '2027-01-20', 1), ('ABC-004', 2, 10000.00, 13, '2026-11-10', 1),
('ABC-005', 1, 30000.00, 4,  '2026-09-05', 1), ('ABC-006', 2, 10000.00, 4,  '2027-03-12', 1),
('ABC-007', 3, 500.00,   15, '2026-08-30', 1), ('ABC-008', 3, 500.00,   18, '2026-07-25', 1),
('ABC-009', 1, 30000.00, 12, '2026-12-11', 1), ('ABC-010', 2, 10000.00, 12, '2027-02-18', 1),
('ABC-011', 1, 30000.00, 8,  '2026-11-22', 1), ('ABC-012', 2, 10000.00, 8,  '2027-04-14', 1),
('ABC-013', 4, 150000.00,20, '2027-05-01', 1), ('ABC-014', 4, 150000.00,25, '2026-10-09', 1),
('ABC-015', 1, 30000.00, 24, '2026-09-17', 1), ('ABC-016', 2, 10000.00, 24, '2027-01-08', 1),
('ABC-017', 1, 30000.00, 6,  '2026-12-05', 1), ('ABC-018', 2, 10000.00, 6,  '2026-11-30', 1),
('ABC-019', 3, 500.00,   14, '2027-02-28', 1), ('ABC-020', 3, 500.00,   5,  '2026-08-15', 1),
('ABC-021', 1, 30000.00, 21, '2026-10-25', 1), ('ABC-022', 2, 10000.00, 21, '2027-03-20', 1),
('ABC-023', 1, 30000.00, 23, '2026-09-08', 1), ('ABC-024', 2, 10000.00, 23, '2026-12-14', 1),
('ABC-025', 1, 30000.00, 9,  '2027-01-30', 1), ('ABC-026', 2, 10000.00, 9,  '2026-11-05', 1),
('ABC-027', 3, 500.00,   25, '2026-07-19', 1), ('ABC-028', 3, 500.00,   16, '2027-04-02', 1),
('ABC-029', 1, 30000.00, 11, '2026-10-12', 1), ('ABC-030', 2, 10000.00, 11, '2026-12-28', 1),
('ABC-031', 1, 30000.00, 19, '2027-02-15', 1), ('ABC-032', 2, 10000.00, 19, '2026-09-21', 1),
('ABC-033', 4, 150000.00,20, '2026-11-08', 1), ('ABC-034', 4, 150000.00,25, '2027-03-05', 1),
('ABC-035', 1, 30000.00, 2,  '2026-08-27', 1), ('ABC-036', 2, 10000.00, 2,  '2026-12-01', 1),
('ABC-037', 1, 30000.00, 7,  '2027-01-14', 1), ('ABC-038', 2, 10000.00, 7,  '2026-10-04', 1),
('ABC-039', 3, 500.00,   8,  '2026-09-29', 1), ('ABC-040', 3, 500.00,   13, '2027-04-26', 1),
('ABC-041', 1, 30000.00, 10, '2026-11-18', 1), ('ABC-042', 2, 10000.00, 10, '2026-12-22', 1),
('ABC-043', 1, 30000.00, 22, '2027-02-09', 1), ('ABC-044', 2, 10000.00, 22, '2026-08-11', 1),
('ABC-045', 1, 30000.00, 3,  '2026-10-31', 1), ('ABC-046', 2, 10000.00, 3,  '2027-03-18', 1),
('ABC-047', 3, 500.00,   24, '2026-09-02', 1), ('ABC-048', 3, 500.00,   4,  '2026-11-15', 1),
('ABC-049', 1, 30000.00, 15, '2027-01-05', 1), ('ABC-050', 2, 10000.00, 15, '2026-12-10', 1);

INSERT INTO Empleado (nombres, apellidos, id_cargo, id_agencia, num_documento, salario, activo) VALUES 
('Carlos Augusto', 'Lopez Merino',       1, 16, '10203040', 5500.00, 1),
('Maria Fernanda', 'Salas Cornejo',      2, 18, '90807060', 3000.00, 1),
('Pedro Manuel',   'Suarez Vaca',        3, 16, '40506070', 2500.00, 1),
('Luis Enrique',   'Advincula Ramos',    3, 15, '41506071', 2500.00, 1),
('Ana Lucia',      'Torres Paredes',     4, 18, '42506072', 1800.00, 1),
('Jorge Eduardo',  'Mendoza Rivas',      5, 16, '43506073', 1500.00, 1),
('Carmen Rosa',    'Chavez Soto',        2, 14, '44506074', 3200.00, 1),
('Ricardo Alonso', 'Navarro Poma',       3, 14, '45506075', 2600.00, 1),
('Sofia Beatriz',  'Rios Espinoza',      4, 14, '46506076', 1800.00, 1),
('Diego Martin',   'Herrera Vega',       5, 14, '47506077', 1500.00, 1),
('Elena Patricia', 'Guzman Cruz',        2, 5,  '48506078', 3100.00, 1),
('Raul Antonio',   'Flores Ruiz',        3, 5,  '49506079', 2550.00, 1),
('Teresa Isabel',  'Condori Mamani',     4, 5,  '50506080', 1800.00, 1),
('Victor Hugo',    'Gutierrez Cueva',    5, 5,  '51506081', 1500.00, 1),
('Julia Elena',    'Salazar Cardenas',   2, 8,  '52506082', 3000.00, 1),
('Andres Felipe',  'Vega Montes',        3, 8,  '53506083', 2500.00, 1),
('Camila Andrea',  'Cruzado Pinto',      4, 8,  '54506084', 1800.00, 1),
('Monica Leticia', 'Campos Valera',      5, 8,  '55506085', 1500.00, 1),
('Eduardo Jose',   'Ramos Ponce',        2, 13, '56506086', 3150.00, 1),
('Lorena Paola',   'Miranda Luna',       3, 13, '57506087', 2600.00, 1),
('Alberto Luis',   'Delgado Silva',      4, 13, '58506088', 1800.00, 1),
('Diana Maria',    'Ponce Guzman',       5, 13, '59506089', 1500.00, 1),
('Martin Renato',  'Luna Cardenas',      2, 24, '60506090', 3200.00, 1),
('Roberto Carlos', 'Suarez Alvarado',    3, 24, '61506091', 2550.00, 1),
('Cecilia Ines',   'Cardenas Silva',     4, 24, '62506092', 1800.00, 1),
('Cesar Augusto',  'Alvarado Rios',      5, 24, '63506093', 1500.00, 1),
('Valeria Sofia',  'Silva Mendoza',      2, 20, '64506094', 3300.00, 1),
('Renato Arturo',  'Rios Ortiz',         3, 20, '65506095', 2700.00, 1),
('Gabriela Luz',   'Mendoza Castro',     4, 20, '66506096', 1900.00, 1),
('Arturo Felipe',  'Ortiz Villanueva',   5, 20, '67506097', 1600.00, 1);
GO

-- ============================================================
-- 7. CLIENTES Y CONTACTOS
-- ============================================================

INSERT INTO Cliente (tipo_persona, nombres, apellidos, razon_social, tipo_documento, num_documento, id_direccion) VALUES 
('J', '-', '-', 'Importaciones Alpha SAC', 'RUC', '20100000001', 16),
('J', '-', '-', 'Distribuidora Beta EIRL', 'RUC', '20100000002', 1),
('J', '-', '-', 'Comercial Gamma SA',      'RUC', '20100000003', 14),
('J', '-', '-', 'Logistica Delta SAC',     'RUC', '20100000004', 5),
('J', '-', '-', 'Textiles Epsilon SRL',    'RUC', '20100000005', 8),
('J', '-', '-', 'Agropecuaria Zeta SAC',   'RUC', '20100000006', 12),
('J', '-', '-', 'Minera Eta SA',           'RUC', '20100000007', 24),
('J', '-', '-', 'Constructora Theta EIRL', 'RUC', '20100000008', 9),
('J', '-', '-', 'Tecnologia Iota SAC',     'RUC', '20100000009', 18),
('J', '-', '-', 'Inversiones Kappa SRL',   'RUC', '20100000010', 13);

INSERT INTO Cliente (tipo_persona, nombres, apellidos, razon_social, tipo_documento, num_documento, id_direccion) VALUES 
('N', 'Daniel Alejandro', 'Jara Nunez',         '-', 'DNI', '70123456', 31),
('N', 'Bryan Arturo',     'Huertas Silva',      '-', 'DNI', '76543210', 14),
('N', 'Mateo Nicolas',    'Pescetto Castro',    '-', 'DNI', '71234567', 1),
('N', 'Jose Luis',        'Gomez Vargas',       '-', 'DNI', '72345678', 8),
('N', 'Carlos Manuel',    'Ramirez Silva',      '-', 'DNI', '43561289', 12),
('N', 'Ana Maria',        'Torres Villanueva',  '-', 'DNI', '74892310', 9),
('N', 'Luis Eduardo',     'Fernandez Rojas',    '-', 'DNI', '41209845', 18),
('N', 'Sofia Beatriz',    'Castro Mendoza',     '-', 'DNI', '78563412', 30),
('N', 'Diego Alonso',     'Vargas Cueva',       '-', 'DNI', '45127839', 28),
('N', 'Lucia Fernanda',   'Mendoza Perez',      '-', 'DNI', '73094815', 25),
('N', 'Jorge Luis',       'Quispe Mamani',      '-', 'DNI', '46813920', 21),
('N', 'Carmen Rosa',      'Rojas Condori',      '-', 'DNI', '71452638', 6),
('N', 'Miguel Angel',     'Perez Gutierrez',    '-', 'DNI', '49018273', 11),
('N', 'Elena Sofia',      'Sanchez Chavez',     '-', 'DNI', '75231904', 10),
('N', 'Fernando Jose',    'Ruiz Espinoza',      '-', 'DNI', '47382910', 4),
('N', 'Rosa Maria',       'Mamani Rios',        '-', 'DNI', '79102845', 26),
('N', 'Hugo Alberto',     'Flores Navarro',     '-', 'DNI', '42058371', 7),
('N', 'Patricia Elena',   'Condori Salazar',    '-', 'DNI', '76391024', 2),
('N', 'Raul Antonio',     'Gutierrez Vega',     '-', 'DNI', '48572013', 3),
('N', 'Teresa Isabel',    'Chavez Cruz',        '-', 'DNI', '70983412', 15),
('N', 'Victor Hugo',      'Espinoza Paredes',   '-', 'DNI', '44219583', 19),
('N', 'Silvia Leticia',   'Rios Campos',        '-', 'DNI', '72154839', 27),
('N', 'Oscar Rene',       'Navarro Herrera',    '-', 'DNI', '40682713', 29),
('N', 'Julia Ines',       'Salazar Miranda',    '-', 'DNI', '77813204', 16),
('N', 'Andres Felipe',    'Vega Ramos',         '-', 'DNI', '43901825', 12),
('N', 'Camila Andrea',    'Cruz Delgado',       '-', 'DNI', '74650192', 5),
('N', 'Ricardo Alonso',   'Paredes Ponce',      '-', 'DNI', '41728390', 18),
('N', 'Monica Paola',     'Campos Luna',        '-', 'DNI', '78319205', 11),
('N', 'Eduardo Martin',   'Herrera Guzman',     '-', 'DNI', '45671029', 23),
('N', 'Lorena Cecilia',   'Miranda Cardenas',   '-', 'DNI', '73408192', 9),
('N', 'Alberto Cesar',    'Ramos Suarez',       '-', 'DNI', '46291837', 25),
('N', 'Diana Valeria',    'Delgado Alvarado',   '-', 'DNI', '71583024', 6),
('N', 'Martin Renato',    'Ponce Silva',        '-', 'DNI', '49821035', 14),
('N', 'Paola Gabriela',   'Luna Rios',          '-', 'DNI', '75710293', 1),
('N', 'Roberto Arturo',   'Guzman Mendoza',     '-', 'DNI', '47109283', 21),
('N', 'Cecilia Natalia',  'Cardenas Ortiz',     '-', 'DNI', '79451028', 22),
('N', 'Cesar Felipe',     'Suarez Castro',      '-', 'DNI', '42381094', 3),
('N', 'Valeria Andrea',   'Alvarado Villanueva','-', 'DNI', '76829105', 4),
('N', 'Renato Guillermo', 'Silva Acosta',       '-', 'DNI', '48102934', 7),
('N', 'Gabriela Mariana', 'Rios Rojas',         '-', 'DNI', '70481923', 8);

INSERT INTO ContactoCliente (id_cliente, tipo_contacto, valor, principal) VALUES 
(1, 'Correo', 'contacto@alpha.com', 1), (2, 'Correo', 'ventas@beta.pe', 1),
(3, 'Correo', 'admin@gamma.com', 1), (4, 'Correo', 'logistica@delta.com', 1),
(5, 'Correo', 'info@epsilon.com', 1), (6, 'Correo', 'agro@zeta.pe', 1),
(7, 'Correo', 'mineria@eta.com', 1), (8, 'Correo', 'obras@theta.pe', 1),
(9, 'Correo', 'tech@iota.com', 1), (10, 'Correo', 'inv@kappa.pe', 1),
(11, 'Correo', 'daniel.jara@unab.edu.pe', 1), (12, 'Correo', 'bhuertas.dev@gmail.com', 1),
(13, 'Correo', 'mateo.pescetto@gmail.com', 1), (14, 'Correo', 'jgomez.it@gmail.com', 1),
(15, 'Correo', 'carlos.ramirez89@gmail.com', 1), (16, 'Correo', 'ana.torres.c@gmail.com', 1),
(17, 'Correo', 'luis.fer.90@gmail.com', 1), (18, 'Correo', 'sofia.castro@gmail.com', 1),
(19, 'Correo', 'diego.vargas.tk@gmail.com', 1), (20, 'Correo', 'lucia.mendoza@gmail.com', 1),
(21, 'Correo', 'jorge.quispe.m@gmail.com', 1), (22, 'Correo', 'carmen.rojas.a@gmail.com', 1),
(23, 'Correo', 'miguel.perez.88@gmail.com', 1), (24, 'Correo', 'elena.sanchez.h@gmail.com', 1),
(25, 'Correo', 'fernando.ruiz@gmail.com', 1), (26, 'Correo', 'rosa.mamani@gmail.com', 1),
(27, 'Correo', 'hugo.flores.p@gmail.com', 1), (28, 'Correo', 'patricia.condori@gmail.com', 1),
(29, 'Correo', 'raul.gutierrez@gmail.com', 1), (30, 'Correo', 'teresa.chavez.m@gmail.com', 1),
(31, 'Correo', 'victor.espinoza@gmail.com', 1), (32, 'Correo', 'silvia.rios@gmail.com', 1),
(33, 'Correo', 'oscar.navarro.b@gmail.com', 1), (34, 'Correo', 'julia.salazar@gmail.com', 1),
(35, 'Correo', 'andres.vega.t@gmail.com', 1), (36, 'Correo', 'camila.cruz@gmail.com', 1),
(37, 'Correo', 'ricardo.paredes.r@gmail.com', 1), (38, 'Correo', 'monica.campos@gmail.com', 1),
(39, 'Correo', 'eduardo.herrera@gmail.com', 1), (40, 'Correo', 'lorena.miranda.k@gmail.com', 1),
(41, 'Correo', 'alberto.ramos.j@gmail.com', 1), (42, 'Correo', 'diana.delgado@gmail.com', 1),
(43, 'Correo', 'martin.ponce@gmail.com', 1), (44, 'Correo', 'paola.luna.m@gmail.com', 1),
(45, 'Correo', 'roberto.guzman@gmail.com', 1), (46, 'Correo', 'cecilia.cardenas@gmail.com', 1),
(47, 'Correo', 'cesar.suarez@gmail.com', 1), (48, 'Correo', 'valeria.alvarado@gmail.com', 1),
(49, 'Correo', 'renato.silva@gmail.com', 1), (50, 'Correo', 'gabriela.rios@gmail.com', 1);
GO

-- ============================================================
-- 8. ENCOMIENDAS (AHORA 50 PAQUETES CON PESOS PESADOS PARA FACTOR DE CARGA)
-- ============================================================

INSERT INTO Encomienda (codigo_rastreo, id_cliente_remitente, id_cliente_destinatario, id_agencia_origen, id_agencia_destino, id_tipo_servicio, tarifa_total, id_estado, fecha_registro) VALUES 
('TRK-0001', 11, 50, 16, 18, 1, 150.50, 4, '2026-01-10 08:30:00'), ('TRK-0002', 12, 49, 14, 5, 2, 450.00, 4, '2026-02-15 09:15:00'), ('TRK-0003', 13, 48, 1, 8, 2, 350.00, 4, '2026-03-20 10:45:00'),
('TRK-0004', 14, 47, 12, 24, 3, 1200.00,4, '2026-04-05 11:20:00'), ('TRK-0005', 15, 46, 9, 18, 1, 550.00, 4, '2026-05-01 14:10:00'), ('TRK-0006', 16, 45, 13, 30, 2, 600.00, 4, '2026-05-02 16:30:00'),
('TRK-0007', 17, 44, 28, 20, 4, 1800.00,4, '2026-05-05 08:00:00'), ('TRK-0008', 18, 43, 25, 21, 2, 250.00, 4, '2026-05-10 09:45:00'), ('TRK-0009', 19, 42, 6, 22, 2, 300.00, 4, '2026-01-12 11:00:00'),
('TRK-0010', 20, 41, 11, 10, 2, 150.00, 4, '2026-02-18 13:20:00'), ('TRK-0011', 21, 40, 4, 28, 2, 450.00, 4, '2026-03-22 15:50:00'), ('TRK-0012', 22, 39, 26, 7, 2, 650.00, 4, '2026-04-08 17:10:00'),
('TRK-0013', 23, 38, 2, 24, 1, 800.00, 4, '2026-05-12 08:30:00'), ('TRK-0014', 24, 37, 3, 15, 2, 200.00, 4, '2026-05-15 09:00:00'), ('TRK-0015', 25, 36, 19, 13, 2, 350.00, 4, '2026-01-20 10:15:00'),
('TRK-0016', 26, 35, 27, 29, 2, 1100.00,4, '2026-02-25 11:45:00'), ('TRK-0017', 27, 34, 16, 17, 1, 100.00, 4, '2026-03-28 14:30:00'), ('TRK-0018', 28, 33, 12, 5, 2, 450.00, 4, '2026-04-12 16:00:00'),
('TRK-0019', 29, 32, 18, 8, 2, 250.00, 4, '2026-05-18 08:45:00'), ('TRK-0020', 30, 31, 11, 23, 2, 500.00, 4, '2026-05-20 10:10:00'), ('TRK-0021', 31, 30, 9, 20, 4, 1600.00,4, '2026-01-25 12:00:00'),
('TRK-0022', 32, 29, 25, 6, 2, 400.00, 4, '2026-02-28 15:30:00'), ('TRK-0023', 33, 28, 14, 7, 2, 350.00, 4, '2026-03-05 17:45:00'), ('TRK-0024', 34, 27, 1, 21, 2, 900.00, 4, '2026-04-15 09:20:00'),
('TRK-0025', 35, 26, 22, 3, 2, 850.00, 4, '2026-05-22 11:30:00'), ('TRK-0026', 36, 25, 18, 16, 1, 150.50, 4, '2026-05-25 14:00:00'), ('TRK-0027', 37, 24, 5, 14, 3, 1300.00,4, '2026-01-30 16:15:00'),
('TRK-0028', 38, 23, 8, 1, 2, 350.00, 4, '2026-02-05 08:50:00'),  ('TRK-0029', 39, 22, 24, 12, 2, 550.00, 4, '2026-03-10 10:40:00'), ('TRK-0030', 40, 21, 18, 9, 2, 450.00, 4, '2026-04-20 13:10:00'),
('TRK-0031', 41, 20, 30, 13, 2, 600.00, 4, '2026-05-28 15:20:00'), ('TRK-0032', 42, 19, 20, 28, 4, 1900.00,4, '2026-05-29 17:00:00'), ('TRK-0033', 43, 18, 21, 25, 2, 250.00, 4, '2026-01-05 09:30:00'),
('TRK-0034', 44, 17, 22, 6, 2, 300.00, 4, '2026-02-10 11:50:00'), ('TRK-0035', 45, 16, 10, 11, 2, 150.00, 4, '2026-03-15 14:40:00'), ('TRK-0036', 46, 15, 28, 4, 2, 450.00, 4, '2026-04-25 16:10:00'),
('TRK-0037', 47, 14, 7, 26, 2, 650.00, 4, '2026-05-03 08:20:00'), ('TRK-0038', 48, 13, 24, 2, 1, 800.00, 4, '2026-05-08 10:00:00'), ('TRK-0039', 49, 12, 15, 3, 2, 200.00, 4, '2026-01-15 13:30:00'),
('TRK-0040', 50, 11, 13, 19, 2, 350.00, 4, '2026-02-20 15:15:00'), ('TRK-0041', 1, 10, 29, 27, 2, 1100.00,4, '2026-03-25 17:45:00'), ('TRK-0042', 2, 9, 17, 16, 1, 100.00, 4, '2026-04-30 08:10:00'),
('TRK-0043', 3, 8, 5, 12, 2, 450.00, 4, '2026-05-06 11:20:00'),  ('TRK-0044', 4, 7, 8, 18, 2, 250.00, 4, '2026-05-11 14:50:00'), ('TRK-0045', 5, 6, 23, 11, 2, 500.00, 4, '2026-01-22 16:30:00'),
('TRK-0046', 6, 5, 20, 9, 4, 1600.00,4, '2026-02-27 09:00:00'), ('TRK-0047', 7, 4, 6, 25, 2, 400.00, 4, '2026-03-02 11:15:00'), ('TRK-0048', 8, 3, 7, 14, 2, 350.00, 4, '2026-04-07 13:40:00'),
('TRK-0049', 9, 2, 21, 1, 2, 900.00, 4, '2026-05-13 15:50:00'),  ('TRK-0050', 10, 1, 3, 22, 2, 850.00, 4, '2026-05-19 17:20:00');

-- Pesos pesados industriales para que tu Factor de Carga suba al ~70%
INSERT INTO DetalleEncomienda (id_encomienda, peso_kg, volumen_m3, codigo_barras_caja, descripcion) VALUES 
(1, 12500.20, 10.04, 'CB-001', 'Bobinas de Acero'),           (2, 8500.50,  6.12, 'CB-002', 'Maquinaria Pesada'),
(3, 14000.80, 12.02, 'CB-003', 'Lotes de Cemento'),           (4, 22000.00, 18.85, 'CB-004', 'Repuestos Mineros'),
(5, 7500.20,  5.09, 'CB-005', 'Lote de Calzado Mayorista'),   (6, 15000.00, 12.22, 'CB-006', 'Papelería Industrial'),
(7, 26000.00, 20.10, 'CB-007', 'Tractores Agrícolas'),        (8, 18400.40, 14.35, 'CB-008', 'Muebles de Exportación'),
(9, 6500.50,  4.05, 'CB-009', 'Electrodomésticos Lote'),      (10, 11200.20, 8.07, 'CB-010', 'Textiles de Exportación'),
(11, 14300.30, 10.18, 'CB-011', 'Cerámicos y Mayólicas'),     (12, 12100.10, 9.03, 'CB-012', 'Medicamentos al por mayor'),
(13, 19500.50, 15.25, 'CB-013', 'Materiales de ferretería'),  (14, 13800.80, 10.04, 'CB-014', 'Cosméticos y fragancias'),
(15, 25600.60, 19.65, 'CB-015', 'Equipos de cómputo Lote'),   (16, 28000.00, 22.15, 'CB-016', 'Suministros Hospitalarios'),
(17, 5200.20,  3.01, 'CB-017', 'Repuestos Vehiculares'),      (18, 18000.00, 14.42, 'CB-018', 'Juguetes campaña navideña'),
(19, 9400.40,  7.11, 'CB-019', 'Abarrotes y conservas'),      (20, 11500.50, 8.14, 'CB-020', 'Calzado industrial Lote'),
(21, 25000.00, 19.60, 'CB-021', 'Muebles y Melamina'),        (22, 15300.30, 12.06, 'CB-022', 'Dispositivos móviles Lote'),
(23, 16800.80, 13.24, 'CB-023', 'Repuestos de motocicleta'),  (24, 12700.70, 9.03, 'CB-024', 'Equipos de laboratorio'),
(25, 24000.00, 18.75, 'CB-025', 'Fertilizantes y Urea'),      (26, 7100.10,  5.08, 'CB-026', 'Accesorios de Cómputo'),
(27, 26500.00, 20.40, 'CB-027', 'Motores de embarcación'),    (28, 11900.90, 8.02, 'CB-028', 'Rollos de Tela'),
(29, 24500.50, 18.38, 'CB-029', 'Alimentos balanceados'),     (30, 8600.60,  6.10, 'CB-030', 'Artesanías Exportación'),
(31, 18200.20, 14.21, 'CB-031', 'Equipos de EPP Industrial'), (32, 29000.00, 23.80, 'CB-032', 'Motores Fluviales Pesados'),
(33, 13200.20, 10.04, 'CB-033', 'Fibra de Alpaca Lote'),      (34, 14000.00, 11.19, 'CB-034', 'Prendas de algodón fardos'),
(35, 15000.00, 12.06, 'CB-035', 'Lácteos y Derivados'),       (36, 11500.50, 8.02, 'CB-036', 'Útiles escolares palets'),
(37, 22000.00, 17.33, 'CB-037', 'Filtros industriales agua'), (38, 25500.00, 19.95, 'CB-038', 'Neumáticos de minería'),
(39, 14200.20, 10.05, 'CB-039', 'Papel Imprenta Bobinas'),    (40, 12000.00, 9.15, 'CB-040', 'Madera procesada'),
(41, 26500.00, 20.30, 'CB-041', 'Grupos electrógenos Lote'),  (42, 11100.10, 8.01, 'CB-042', 'Cables de cobre rollos'),
(43, 26400.40, 20.40, 'CB-043', 'Baterías de Litio Lote'),    (44, 8900.90,  6.12, 'CB-044', 'Café orgánico sacos'),
(45, 17500.50, 13.26, 'CB-045', 'Pinturas e insumos'),        (46, 25000.00, 19.90, 'CB-046', 'Tubos de PVC construcción'),
(47, 13600.60, 10.04, 'CB-047', 'Kits médicos de campaña'),   (48, 13200.20, 10.17, 'CB-048', 'Calzado botines palets'),
(49, 21000.00, 16.50, 'CB-049', 'Lana hilada fardos'),        (50, 10000.00, 7.13, 'CB-050', 'Ferretería pesada');

INSERT INTO ComprobantePago (id_encomienda, tipo_comprobante, serie, correlativo, subtotal, porcentaje_igv, id_metodo_pago) VALUES 
(1, 'F', 'F001', '00000001', 127.54, 18.00, 2),  (2, 'F', 'F001', '00000002', 381.35, 18.00, 3),
(3, 'F', 'F001', '00000003', 296.61, 18.00, 4),  (4, 'F', 'F001', '00000004', 1016.95,18.00, 1),
(5, 'F', 'F001', '00000005', 466.10, 18.00, 2),  (6, 'F', 'F001', '00000006', 508.47, 18.00, 3),
(7, 'F', 'F001', '00000007', 1525.42,18.00, 4),  (8, 'F', 'F001', '00000008', 211.86, 18.00, 1),
(9, 'F', 'F001', '00000009', 254.23, 18.00, 2),  (10,'F', 'F001', '00000010', 127.11, 18.00, 3),
(11,'F', 'F001', '00000011', 381.35, 18.00, 4),  (12,'F', 'F001', '00000012', 550.84, 18.00, 1),
(13,'B', 'B001', '00000013', 677.96, 18.00, 2),  (14,'B', 'B001', '00000014', 169.49, 18.00, 3),
(15,'B', 'B001', '00000015', 296.61, 18.00, 4),  (16,'B', 'B001', '00000016', 932.20, 18.00, 1),
(17,'B', 'B001', '00000017', 84.74,  18.00, 2),  (18,'B', 'B001', '00000018', 381.35, 18.00, 3),
(19,'B', 'B001', '00000019', 211.86, 18.00, 4),  (20,'B', 'B001', '00000020', 423.72, 18.00, 1),
(21,'B', 'B001', '00000021', 1355.93,18.00, 2),  (22,'B', 'B001', '00000022', 338.98, 18.00, 3),
(23,'B', 'B001', '00000023', 296.61, 18.00, 4),  (24,'B', 'B001', '00000024', 762.71, 18.00, 1),
(25,'B', 'B001', '00000025', 720.33, 18.00, 2),  (26,'B', 'B001', '00000026', 127.54, 18.00, 3),
(27,'B', 'B001', '00000027', 1101.69,18.00, 4),  (28,'B', 'B001', '00000028', 296.61, 18.00, 1),
(29,'B', 'B001', '00000029', 466.10, 18.00, 2),  (30,'B', 'B001', '00000030', 381.35, 18.00, 3),
(31,'B', 'B001', '00000031', 508.47, 18.00, 4),  (32,'B', 'B001', '00000032', 1610.16,18.00, 1),
(33,'B', 'B001', '00000033', 211.86, 18.00, 2),  (34,'B', 'B001', '00000034', 254.23, 18.00, 3),
(35,'B', 'B001', '00000035', 127.11, 18.00, 4),  (36,'B', 'B001', '00000036', 381.35, 18.00, 1),
(37,'B', 'B001', '00000037', 550.84, 18.00, 2),  (38,'B', 'B001', '00000038', 677.96, 18.00, 3),
(39,'B', 'B001', '00000039', 169.49, 18.00, 4),  (40,'B', 'B001', '00000040', 296.61, 18.00, 1),
(41,'F', 'F001', '00000041', 932.20, 18.00, 2),  (42,'F', 'F001', '00000042', 84.74,  18.00, 3),
(43,'F', 'F001', '00000043', 381.35, 18.00, 4),  (44,'F', 'F001', '00000044', 211.86, 18.00, 1),
(45,'F', 'F001', '00000045', 423.72, 18.00, 2),  (46,'F', 'F001', '00000046', 1355.93,18.00, 3),
(47,'F', 'F001', '00000047', 338.98, 18.00, 4),  (48,'F', 'F001', '00000048', 296.61, 18.00, 1),
(49,'F', 'F001', '00000049', 762.71, 18.00, 2),  (50,'F', 'F001', '00000050', 720.33, 18.00, 3);
GO

-- ============================================================
-- 9. DESPACHOS, INCIDENCIAS E HISTÓRICO (Corregido desde la raíz)
-- ============================================================

-- 46 Despachos a Tiempo y 4 Retrasados a propósito
INSERT INTO Despacho (id_vehiculo, id_empleado_conductor, id_hub_origen, id_hub_destino, fecha_hora_salida, fecha_hora_llegada, distancia_km, costo_operativo) VALUES 
(1, 3, 15, 4,  '2026-02-16 05:00:00', '2026-02-17 02:00:00', 1015.0, 850.00), (1, 4, 15, 13, '2026-03-21 07:00:00', '2026-03-21 17:30:00', 560.00, 500.00),
(2, 8, 13, 24, '2026-04-06 08:00:00', '2026-04-06 18:00:00', 450.00, 300.00), (2, 12,4,  8,  '2026-05-02 06:00:00', '2026-05-02 16:30:00', 500.00, 400.00),
(1, 16,15, 12, '2026-05-03 04:00:00', '2026-05-03 14:00:00', 300.00, 250.00), (2, 20,15, 11, '2026-05-06 09:00:00', '2026-05-06 14:30:00', 300.00, 200.00),
(1, 24,15, 23, '2026-05-11 05:00:00', '2026-05-12 06:00:00', 1200.0, 950.00), (13,28,20, 20, '2026-01-13 08:00:00', '2026-01-13 18:00:00', 50.00,  100.00),
(14,30,15, 25, '2026-02-19 06:00:00', '2026-02-20 18:00:00', 800.00, 700.00), (1, 3, 15, 2,  '2026-03-01 05:00:00', '2026-03-01 13:00:00', 400.00, 350.00),
(3, 4, 15, 1,  '2026-03-10 06:00:00', '2026-03-11 14:00:00', 1200.0, 950.00), (5, 8, 15, 3,  '2026-03-15 07:00:00', '2026-03-16 08:00:00', 900.00, 750.00),
(9, 12,15, 5,  '2026-03-20 04:00:00', '2026-03-20 14:00:00', 560.00, 450.00), (11,16,15, 6,  '2026-03-25 05:00:00', '2026-03-26 05:00:00', 850.00, 700.00),
(15,20,15, 7,  '2026-04-01 08:00:00', '2026-04-01 09:30:00', 25.00,  50.00),  (17,24,15, 8,  '2026-04-05 06:00:00', '2026-04-06 10:00:00', 1100.0, 900.00),
(21,28,15, 9,  '2026-04-10 05:00:00', '2026-04-10 15:00:00', 450.00, 380.00), (23,30,15, 10, '2026-04-15 04:00:00', '2026-04-15 12:00:00', 400.00, 320.00),
(25,3, 15, 11, '2026-04-20 07:00:00', '2026-04-20 12:00:00', 300.00, 250.00), (29,4, 15, 12, '2026-04-25 06:00:00', '2026-04-25 14:00:00', 310.00, 260.00),
(31,8, 15, 13, '2026-05-01 05:00:00', '2026-05-01 15:00:00', 560.00, 480.00), (35,12,15, 14, '2026-05-05 08:00:00', '2026-05-05 20:00:00', 750.00, 600.00),
(37,16,15, 15, '2026-05-10 09:00:00', '2026-05-10 10:30:00', 40.00,  60.00),  (41,20,15, 16, '2026-05-15 05:00:00', '2026-05-18 15:00:00', 1800.0, 1500.0),
(43,24,15, 17, '2026-05-20 06:00:00', '2026-05-22 06:00:00', 1500.0, 1200.0), (45,28,15, 18, '2026-05-25 04:00:00', '2026-05-26 04:00:00', 1200.0, 950.00),
(49,30,15, 19, '2026-05-28 07:00:00', '2026-05-28 17:00:00', 350.00, 300.00), 
(1, 3, 15, 20, '2026-06-01 05:00:00', '2026-06-02 05:00:00', 1000.0, 850.00),
(3, 4, 15, 21, '2026-06-05 06:00:00', '2026-06-06 10:00:00', 1300.0, 1050.0), (5, 8, 15, 22, '2026-06-10 08:00:00', '2026-06-12 08:00:00', 1400.0, 1150.0),
(9, 12,15, 23, '2026-06-15 05:00:00', '2026-06-16 05:00:00', 1200.0, 950.00), (11,16,15, 24, '2026-06-20 04:00:00', '2026-06-21 14:00:00', 1300.0, 1000.0),
(15,20,15, 25, '2026-06-25 06:00:00', '2026-06-26 18:00:00', 800.00, 700.00), (17,24,13, 2,  '2026-01-05 07:00:00', '2026-01-05 11:00:00', 200.00, 180.00),
(21,28,4,  21, '2026-01-10 08:00:00', '2026-01-10 14:00:00', 300.00, 250.00), (23,30,4,  23, '2026-01-15 06:00:00', '2026-01-15 12:00:00', 350.00, 280.00),
(25,3, 6,  21, '2026-01-20 05:00:00', '2026-01-20 13:00:00', 400.00, 350.00), 
(29,4, 12, 10, '2026-01-25 07:00:00', '2026-01-25 15:00:00', 380.00, 300.00),
(31,8, 10, 25, '2026-02-01 06:00:00', '2026-02-02 10:00:00', 500.00, 420.00), (35,12,22, 16, '2026-02-05 08:00:00', '2026-02-06 18:00:00', 700.00, 600.00),
(37,16,22, 1,  '2026-02-10 05:00:00', '2026-02-10 15:00:00', 450.00, 380.00), (41,20,24, 20, '2026-02-15 06:00:00', '2026-02-15 10:00:00', 250.00, 200.00),
(43,24,24, 14, '2026-02-20 07:00:00', '2026-02-20 11:00:00', 220.00, 190.00), (45,28,14, 13, '2026-02-25 08:00:00', '2026-02-25 12:00:00', 200.00, 180.00),
(49,30,13, 14, '2026-03-05 06:00:00', '2026-03-05 10:00:00', 200.00, 180.00), (1, 3, 15, 4,  '2026-03-10 05:00:00', '2026-03-11 02:00:00', 1015.0, 850.00),
(3, 4, 4,  8,  '2026-04-01 06:00:00', '2026-04-10 16:00:00', 1100.0, 950.00), 
(5, 8, 8,  23, '2026-04-15 05:00:00', '2026-04-22 15:00:00', 1200.0, 980.00), 
(9, 12,20, 24, '2026-05-05 04:00:00', '2026-05-15 14:00:00', 1300.0, 1050.0), 
(11,16,15, 25, '2026-05-20 07:00:00', '2026-05-28 17:00:00', 800.00, 750.00);

-- Vinculando los 50 paquetes a los 50 despachos (Uno a uno para simplificar la volumetría industrial)
INSERT INTO DespachoEncomienda (id_despacho, id_encomienda, posicion_carga) VALUES 
(1, 1, 1), (2, 2, 1), (3, 3, 1), (4, 4, 1), (5, 5, 1), (6, 6, 1), (7, 7, 1), (8, 8, 1), (9, 9, 1), (10, 10, 1),
(11, 11, 1), (12, 12, 1), (13, 13, 1), (14, 14, 1), (15, 15, 1), (16, 16, 1), (17, 17, 1), (18, 18, 1), (19, 19, 1), (20, 20, 1),
(21, 21, 1), (22, 22, 1), (23, 23, 1), (24, 24, 1), (25, 25, 1), (26, 26, 1), (27, 27, 1), (28, 28, 1), (29, 29, 1), (30, 30, 1),
(31, 31, 1), (32, 32, 1), (33, 33, 1), (34, 34, 1), (35, 35, 1), (36, 36, 1), (37, 37, 1), (38, 38, 1), (39, 39, 1), (40, 40, 1),
(41, 41, 1), (42, 42, 1), (43, 43, 1), (44, 44, 1), (45, 45, 1), (46, 46, 1), (47, 47, 1), (48, 48, 1), (49, 49, 1), (50, 50, 1);

-- Generando estados de Seguimiento para que todos estén ENTREGADOS (Estado 4)
INSERT INTO Seguimiento (id_encomienda, id_agencia, id_estado, observacion, id_empleado, fecha_hora)
SELECT id_encomienda, 1, 4, 'Entregado conforme en destino', 1, '2026-06-25 12:00:00' FROM Encomienda;

-- Las Incidencias Exactas (3 Mecánicas, 1 Clima, 1 Vía) con Cajamarca corregido
INSERT INTO Incidencia (id_despacho, id_empleado, tipo_incidencia, descripcion, nivel_gravedad, fecha_hora_reporte) VALUES 
(47, 4,  'Falla Mecánica', 'Batería descargada en el trayecto, requiere puente.', 'Bajo', '2026-04-05 10:00:00'),
(48, 8,  'Falla Mecánica', 'Avería de caja de cambios.', 'Alto', '2026-04-18 14:30:00'),
(49, 12, 'Falla Mecánica', 'Fuga de refrigerante en el motor.', 'Medio', '2026-05-10 08:15:00'),
(28, 3,  'Bloqueo de Vía', 'Paro de transportistas bloqueando la Panamericana.', 'Alto', '2026-06-01 09:30:00'),
(38, 3,  'Clima Adverso',  'Derrumbe en la carretera por fuertes lluvias en la sierra norte.', 'Medio', '2026-01-20 09:15:00');
GO