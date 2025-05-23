-- Script SQL para crear la base de datos del proyecto final
-- Tema: Gestión de Flota de Vehículos y Mantenimiento Preventivo
-- Autora: Iona Schnaidler

-- 🔸 Paso 1: Crear la base de datos
CREATE DATABASE IF NOT EXISTS GestionFlota;
USE GestionFlota;

-- 🔸 Paso 2: Crear tabla de Vehículos
CREATE TABLE Vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    patente VARCHAR(10) UNIQUE NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    anio INT,
    tipo VARCHAR(30),
    activo BOOLEAN DEFAULT TRUE
);

-- 🔸 Paso 3: Crear tabla de Choferes
CREATE TABLE Choferes (
    id_chofer INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    dni VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE
);

-- 🔸 Paso 4: Crear tabla de Viajes
CREATE TABLE Viajes (
    id_viaje INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    id_chofer INT NOT NULL,
    origen VARCHAR(100),
    destino VARCHAR(100),
    fecha_salida DATE,
    fecha_llegada DATE,
    kilometros DECIMAL(8,2),
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo),
    FOREIGN KEY (id_chofer) REFERENCES Choferes(id_chofer)
);

-- 🔸 Paso 5: Crear tabla de Mantenimientos
CREATE TABLE Mantenimientos (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    fecha DATE,
    tipo VARCHAR(50),
    observaciones TEXT,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
);

-- 🔸 Paso 6: Crear tabla de Fallas
CREATE TABLE Fallas (
    id_falla INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    fecha DATE,
    descripcion TEXT,
    resuelta BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
);

-- 🔸 Paso 7: Crear tabla de Reparaciones
CREATE TABLE Reparaciones (
    id_reparacion INT AUTO_INCREMENT PRIMARY KEY,
    id_falla INT NOT NULL,
    fecha DATE,
    descripcion TEXT,
    costo DECIMAL(10,2),
    FOREIGN KEY (id_falla) REFERENCES Fallas(id_falla)
);

-- 🔸 Paso 8: Crear tabla de Insumos
CREATE TABLE Insumos (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    stock_actual INT DEFAULT 0
);

-- 🔸 Paso 9: Crear tabla de Combustible
CREATE TABLE Combustible (
    id_carga INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    fecha DATE,
    litros DECIMAL(6,2),
    km_actual INT,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
);

-- Vistas del sistema de gestión de flota

-- 1. Vista de viajes con choferes y vehículos
CREATE VIEW vista_viajes_chofer AS
SELECT
    v.id_viaje,
    v.fecha_salida,
    v.fecha_llegada,
    v.kilometros,
    c.nombre AS nombre_chofer,
    c.apellido AS apellido_chofer,
    vh.patente,
    vh.marca,
    vh.modelo
FROM Viajes v
JOIN Choferes c ON v.id_chofer = c.id_chofer
JOIN Vehiculos vh ON v.id_vehiculo = vh.id_vehiculo;

-- 2. Vista de mantenimientos pendientes por fallas sin resolver
CREATE VIEW vista_mantenimientos_pendientes AS
SELECT
    v.patente,
    f.descripcion AS falla,
    f.fecha AS fecha_falla,
    MAX(m.fecha) AS ultimo_mantenimiento
FROM Vehiculos v
JOIN Fallas f ON v.id_vehiculo = f.id_vehiculo AND f.resuelta = FALSE
LEFT JOIN Mantenimientos m ON v.id_vehiculo = m.id_vehiculo
GROUP BY v.patente, f.descripcion, f.fecha;

-- 3. Vista de consumo de combustible por vehículo
CREATE VIEW vista_consumo_combustible AS
SELECT
    v.patente,
    COUNT(c.id_carga) AS cantidad_cargas,
    SUM(c.litros) AS total_litros,
    MAX(c.km_actual) - MIN(c.km_actual) AS km_recorridos,
    ROUND((SUM(c.litros) / (MAX(c.km_actual) - MIN(c.km_actual))) * 100, 2) AS litros_cada_100km
FROM Combustible c
JOIN Vehiculos v ON c.id_vehiculo = v.id_vehiculo
GROUP BY v.patente;

-- 4. Vista de reparaciones costosas
CREATE VIEW vista_reparaciones_costosas AS
SELECT
    v.patente,
    r.descripcion,
    r.costo,
    r.fecha
FROM Reparaciones r
JOIN Fallas f ON r.id_falla = f.id_falla
JOIN Vehiculos v ON f.id_vehiculo = v.id_vehiculo
WHERE r.costo > 100000;

-- 5. Vista de choferes activos y cantidad de viajes
CREATE VIEW vista_choferes_activos AS
SELECT
    c.id_chofer,
    c.nombre,
    c.apellido,
    c.telefono,
    COUNT(v.id_viaje) AS total_viajes
FROM Choferes c
LEFT JOIN Viajes v ON c.id_chofer = v.id_chofer
WHERE c.activo = TRUE
GROUP BY c.id_chofer;

-- 1. Función para calcular el total de kilómetros recorridos por un vehículo
DELIMITER //
CREATE FUNCTION f_km_totales_vehiculo(id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(kilometros) INTO total
    FROM Viajes
    WHERE id_vehiculo = id;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;

-- 2. Función para obtener el promedio de costo de reparaciones de un vehículo
DELIMITER //
CREATE FUNCTION f_promedio_reparacion(id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(r.costo) INTO promedio
    FROM Reparaciones r
    JOIN Fallas f ON r.id_falla = f.id_falla
    WHERE f.id_vehiculo = id;
    RETURN IFNULL(promedio, 0);
END;
//
DELIMITER ;

-- 3. Función para verificar si un chofer tiene más de X viajes
DELIMITER //
CREATE FUNCTION f_chofer_muy_activo(id INT, minimo INT)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) INTO cantidad
    FROM Viajes
    WHERE id_chofer = id;
    RETURN cantidad > minimo;
END;
//
DELIMITER ;

-- 1. Agregar un nuevo viaje (con vehículo, chofer y kilometraje)
DELIMITER //
CREATE PROCEDURE sp_registrar_viaje (
    IN p_id_vehiculo INT,
    IN p_id_chofer INT,
    IN p_origen VARCHAR(100),
    IN p_destino VARCHAR(100),
    IN p_fecha_salida DATE,
    IN p_fecha_llegada DATE,
    IN p_kilometros DECIMAL(8,2)
)
BEGIN
    INSERT INTO Viajes (
        id_vehiculo, id_chofer, origen, destino,
        fecha_salida, fecha_llegada, kilometros
    ) VALUES (
        p_id_vehiculo, p_id_chofer, p_origen, p_destino,
        p_fecha_salida, p_fecha_llegada, p_kilometros
    );
END;
//
DELIMITER ;

-- 2. Marcar una falla como resuelta
DELIMITER //
CREATE PROCEDURE sp_resolver_falla (
    IN p_id_falla INT
)
BEGIN
    UPDATE Fallas
    SET resuelta = TRUE
    WHERE id_falla = p_id_falla;
END;
//
DELIMITER ;

-- 3. Registrar mantenimiento de rutina para un vehículo
DELIMITER //
CREATE PROCEDURE sp_mantenimiento_rutina (
    IN p_id_vehiculo INT,
    IN p_tipo VARCHAR(50),
    IN p_observaciones TEXT
)
BEGIN
    INSERT INTO Mantenimientos (
        id_vehiculo, fecha, tipo, observaciones
    ) VALUES (
        p_id_vehiculo, CURDATE(), p_tipo, p_observaciones
    );
END;
//
DELIMITER ;

-- Trigger 1: asignar fecha automáticamente en Combustible si no se indica
DELIMITER //
CREATE TRIGGER tr_fecha_carga_combustible
BEFORE INSERT ON Combustible
FOR EACH ROW
BEGIN
    IF NEW.fecha IS NULL THEN
        SET NEW.fecha = CURDATE();
    END IF;
END;
//
DELIMITER ;

-- Trigger 2: registrar mantenimiento cuando se resuelve una falla
DELIMITER //
CREATE TRIGGER tr_falla_resuelta_actualiza_mantenimiento
AFTER UPDATE ON Fallas
FOR EACH ROW
BEGIN
    IF OLD.resuelta = FALSE AND NEW.resuelta = TRUE THEN
        INSERT INTO Mantenimientos (
            id_vehiculo, fecha, tipo, observaciones
        ) VALUES (
            NEW.id_vehiculo,
            CURDATE(),
            'Correctivo por falla resuelta',
            CONCAT('Falla ID ', NEW.id_falla, ': ', NEW.descripcion)
        );
    END IF;
END;
//
DELIMITER ;


