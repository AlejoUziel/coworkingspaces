USE roatan_202310070132;

-- ======================================================
-- 1. USUARIOS
-- ======================================================
CREATE TABLE IF NOT EXISTS Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL, -- se encripta desde Java
    tipo_usuario ENUM('administrador', 'cliente') DEFAULT 'cliente',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATETIME NULL
);
select * from Usuarios;
-- Índices para búsquedas rápidas
CREATE INDEX idx_usuario_correo ON Usuarios(correo);
CREATE INDEX idx_usuario_tipo ON Usuarios(tipo_usuario);

-- ======================================================
-- 2. MEMBRESIAS
-- ======================================================
CREATE TABLE IF NOT EXISTS Membresias (
    id_membresia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    duracion_meses INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- ======================================================
-- 3. USUARIOS_MEMBRESIAS
-- ======================================================
CREATE TABLE IF NOT EXISTS Usuarios_Membresias (
    id_usuario_membresia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_membresia INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado ENUM('activa','vencida','suspendida') DEFAULT 'activa',
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_membresia) REFERENCES Membresias(id_membresia)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ======================================================
-- 4. ESPACIOS
-- ======================================================
CREATE TABLE IF NOT EXISTS Espacios (
    id_espacio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo ENUM('oficina','sala','escritorio') NOT NULL,
    capacidad INT,
    costo_por_hora DECIMAL(10,2) DEFAULT 0.00,
    estado ENUM('disponible','ocupado','mantenimiento') DEFAULT 'disponible'
);

-- ======================================================
-- 5. RESERVAS
-- ======================================================
CREATE TABLE IF NOT EXISTS Reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_espacio INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    costo_total DECIMAL(10,2) DEFAULT 0.00,
    estado ENUM('confirmada','cancelada','finalizada') DEFAULT 'confirmada',
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_espacio) REFERENCES Espacios(id_espacio)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Trigger para evitar reservas duplicadas en el mismo espacio y horario
CREATE UNIQUE INDEX idx_espacio_fecha_hora ON Reservas(id_espacio, fecha_reserva, hora_inicio, hora_fin);

-- ======================================================
-- 6. EQUIPAMIENTO
-- ======================================================
CREATE TABLE IF NOT EXISTS Equipamiento (
    id_equipamiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    cantidad_total INT NOT NULL,
    costo_por_hora DECIMAL(10,2) DEFAULT 0.00
);

-- ======================================================
-- 7. RESERVAS_EQUIPAMIENTO
-- ======================================================
CREATE TABLE IF NOT EXISTS Reservas_Equipamiento (
    id_reserva_equipamiento INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL,
    id_equipamiento INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_equipamiento) REFERENCES Equipamiento(id_equipamiento)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ======================================================
-- 8. PAGOS
-- ======================================================
CREATE TABLE IF NOT EXISTS Pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_reserva INT NULL,
    id_usuario_membresia INT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    metodo ENUM('efectivo','tarjeta','transferencia') DEFAULT 'efectivo',
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_usuario_membresia) REFERENCES Usuarios_Membresias(id_usuario_membresia)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- ======================================================
-- 9. HISTORIAL DE ACCESOS (para login)
-- ======================================================
CREATE TABLE IF NOT EXISTS Historial_Accesos (
    id_acceso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_acceso DATETIME DEFAULT CURRENT_TIMESTAMP,
    exito BOOLEAN DEFAULT TRUE,
    ip_acceso VARCHAR(45) NULL,
    dispositivo VARCHAR(100) NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
        ON UPDATE CASCADE ON DELETE CASCADE
);


USE roatan_202310070132;

-- ======================================================
-- 1. USUARIOS
-- ======================================================
INSERT INTO Usuarios (nombre, apellido, correo, telefono, usuario, contrasena, tipo_usuario)
VALUES
('Uziel', 'Velasquez', 'uziel@correo.com', '9999-1111', 'uzielv', '123456', 'administrador'),
('Alejandro', 'Garcia', 'alejandro@correo.com', '8888-2222', 'alejogarcia', '123456', 'cliente'),
('David', 'Martinez', 'david@correo.com', '9777-3333', 'davidm', '123456', 'cliente');

-- ======================================================
-- 2. MEMBRESIAS
-- ======================================================
INSERT INTO Membresias (nombre, descripcion, duracion_meses, precio)
VALUES
('Mensual', 'Acceso a todos los espacios durante 30 días', 1, 1200.00),
('Trimestral', 'Acceso a todos los espacios durante 3 meses', 3, 3200.00),
('Anual', 'Acceso completo durante 12 meses', 12, 11000.00);

-- ======================================================
-- 3. USUARIOS_MEMBRESIAS
-- ======================================================
INSERT INTO Usuarios_Membresias (id_usuario, id_membresia, fecha_inicio, fecha_fin, estado)
VALUES
(2, 1, '2025-10-01', '2025-10-31', 'activa'),
(3, 2, '2025-09-01', '2025-11-30', 'activa');

-- ======================================================
-- 4. ESPACIOS
-- ======================================================
INSERT INTO Espacios (nombre, tipo, capacidad, costo_por_hora, estado)
VALUES
('Oficina A', 'oficina', 4, 150.00, 'disponible'),
('Sala de Reuniones 1', 'sala', 10, 200.00, 'disponible'),
('Escritorio 5', 'escritorio', 1, 50.00, 'disponible');

-- ======================================================
-- 5. RESERVAS
-- ======================================================
INSERT INTO Reservas (id_usuario, id_espacio, fecha_reserva, hora_inicio, hora_fin, costo_total, estado)
VALUES
(2, 1, '2025-10-27', '09:00:00', '11:00:00', 300.00, 'confirmada'),
(3, 2, '2025-10-28', '14:00:00', '17:00:00', 600.00, 'confirmada');

-- ======================================================
-- 6. EQUIPAMIENTO
-- ======================================================
INSERT INTO Equipamiento (nombre, cantidad_total, costo_por_hora)
VALUES
('Proyector', 3, 75.00),
('Laptop', 5, 50.00),
('Pizarra', 2, 20.00);

-- ======================================================
-- 7. RESERVAS_EQUIPAMIENTO
-- ======================================================
INSERT INTO Reservas_Equipamiento (id_reserva, id_equipamiento, cantidad)
VALUES
(1, 1, 1),  -- Reserva 1 con 1 proyector
(2, 2, 2);  -- Reserva 2 con 2 laptops

-- ======================================================
-- 8. PAGOS
-- ======================================================
INSERT INTO Pagos (id_usuario, id_reserva, id_usuario_membresia, monto, descripcion, metodo)
VALUES
(2, 1, NULL, 300.00, 'Pago por reserva de oficina', 'tarjeta'),
(3, 2, 2, 3800.00, 'Pago por reserva y membresía trimestral', 'transferencia');

-- ======================================================
-- 9. HISTORIAL DE ACCESOS
-- ======================================================
INSERT INTO Historial_Accesos (id_usuario, exito, ip_acceso, dispositivo)
VALUES
(1, TRUE, '192.168.1.5', 'Laptop - Windows 10'),
(2, TRUE, '192.168.1.6', 'iPhone'),
(3, FALSE, '192.168.1.7', 'Tablet Android');

