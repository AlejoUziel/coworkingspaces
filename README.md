
## README — Sistema de Gestión de Espacios de Co‑Working

### Descripción
Aplicación para administrar un espacio de co‑working: usuarios y membresías, reservas de espacios, equipamiento asociado y pagos. Incluye reportes filtrables y bitácora de auditoría.

### Características clave
- Autenticación con contraseña hasheada y bitácora de accesos
- Roles y permisos por funcionalidad
- ABM de catálogos parametrizables
- Reservas con validación de solapes, cupos y costos por hora
- Asociación de equipamiento con control de stock
- Pagos por reserva y por membresía
- Reportes con filtros y exportación a PDF/Excel
- Auditoría por tabla crítica

### Arquitectura
- Backend: SQL (DDL provisto). Motor sugerido: MySQL 8.x o SQL Server 2019+
- Cliente de escritorio: Java Swing (JDK 17+), estructura por paneles
- DAO/Service para acceso a datos y reglas de negocio

### Requisitos previos
- JDK 17 o superior
- IDE recomendado: IntelliJ IDEA o NetBeans
- Driver JDBC del motor elegido
- Motor de BD: MySQL 8.x o SQL Server 2019+ (ver compatibilidad abajo)

### Configuración del proyecto
1) Clonar proyecto y abrir en el IDE
2) Configurar variables de entorno o archivo de propiedades.
O desde el IDE, ejecutar `Dashboard` como aplicación.

### Pruebas
- Unitarias: servicios de cálculo de costo, validación de solapes, cupos
- Integración: DAOs contra una BD de pruebas

### Créditos
Autoría: uziel garcia. Fecha: <mention-date start="2025-11-02"/>


