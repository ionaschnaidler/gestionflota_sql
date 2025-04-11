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



