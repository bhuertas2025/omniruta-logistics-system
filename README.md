# 🚛 OmniRuta Express - Sistema Logístico Integral

Proyecto de Arquitectura Empresarial Inteligente (AEI) y Base de Datos Transaccional desarrollado para el control, auditoría y análisis de operaciones logísticas a nivel nacional.

## 📋 Descripción del Proyecto
OmniRuta soluciona la falta de trazabilidad en los despachos y la ausencia de métricas de rentabilidad mediante un modelo de datos altamente normalizado (3FN). El sistema integra el registro transaccional en el backend con una capa de visualización analítica en tiempo real, permitiendo a la gerencia monitorear los Acuerdos de Nivel de Servicio (SLA), factores de carga e incidencias operativas.

## 🏗️ Stack Tecnológico y Arquitectura (TOGAF 10 ADM)
* **Base de Datos:** Microsoft SQL Server 2022+ 
* **Almacenamiento Físico:** Distribución de I/O en 3 Filegroups (`PRIMARY`, `Transaccional`, `Historico`).
* **Lógica de Negocio:** Stored Procedures (Prevención de Inyección SQL) y Soft Deletes.
* **Capa Analítica (BI):** Google Looker Studio.
* **Conectividad:** Túnel TCP híbrido vía `ngrok` (exposición de puerto local 1433 a la nube).
* **Modelado:** Draw.io (Conceptual / Físico) y Antigravity (TOGAF).

## ⚙️ Guía de Despliegue
Para replicar el entorno de producción, ejecutar los scripts ubicados en la carpeta `/03_Base_Datos` desde SQL Server Management Studio (SSMS) en el siguiente orden estricto:

1. **`01_DDL_Creacion_Tablas_Filegroups.sql`**: Construcción del esquema, partición de discos y restricciones (Constraints, FKs, UQs).
2. **`02_DML_Insercion_Datos_Historico.sql`**: Carga de datos semilla (Geografía, Tarifarios, Flota) e histórico de despachos.
3. **`03_Logica_Vistas_Indices_SPs.sql`**: Despliegue de los Procedimientos Almacenados, Vistas de desnormalización y creación de Índices Non-Clustered.

## 👨‍💻 Autor
* **Bryan Cristopher Huertas Pascacio**
* *Programa Académico de Ingeniería de Sistemas e Informática*
* *Universidad Nacional de Barranca (UNAB)*

---
*Repositorio creado para la sustentación del Sub-Producto U2 - Feria Tecnológica.*
