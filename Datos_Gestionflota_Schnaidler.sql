USE GestionFlota;

-- Vehículos
INSERT INTO Vehiculos (patente, marca, modelo, anio, tipo, activo) VALUES ('ABC123', 'Mercedes', 'Sprinter', 2020, 'Combi', TRUE);
INSERT INTO Vehiculos (patente, marca, modelo, anio, tipo, activo) VALUES ('XYZ789', 'Ford', 'Transit', 2019, 'Furgón', TRUE);
INSERT INTO Vehiculos (patente, marca, modelo, anio, tipo, activo) VALUES ('KLM456', 'Iveco', 'Daily', 2021, 'Camión', TRUE);
INSERT INTO Vehiculos (patente, marca, modelo, anio, tipo, activo) VALUES ('GHI321', 'Renault', 'Kangoo', 2022, 'Utilitario', TRUE);
INSERT INTO Vehiculos (patente, marca, modelo, anio, tipo, activo) VALUES ('QWE987', 'Toyota', 'Hiace', 2018, 'Combi', FALSE);

-- Choferes
INSERT INTO Choferes (nombre, apellido, dni, telefono, activo) VALUES ('Juan', 'Pérez', '12345678', '1123456789', TRUE);
INSERT INTO Choferes (nombre, apellido, dni, telefono, activo) VALUES ('María', 'Gómez', '23456789', '1134567890', TRUE);
INSERT INTO Choferes (nombre, apellido, dni, telefono, activo) VALUES ('Luis', 'Martínez', '34567890', '1145678901', TRUE);
INSERT INTO Choferes (nombre, apellido, dni, telefono, activo) VALUES ('Ana', 'Rodríguez', '45678901', '1156789012', FALSE);
INSERT INTO Choferes (nombre, apellido, dni, telefono, activo) VALUES ('Carlos', 'Fernández', '56789012', '1167890123', TRUE);

-- Viajes
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (3, 3, 'Ciudad0', 'Destino0', '2024-01-27', '2024-01-29', 618);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (2, 3, 'Ciudad1', 'Destino1', '2024-04-07', '2024-04-10', 203);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (1, 2, 'Ciudad2', 'Destino2', '2024-03-07', '2024-03-08', 325);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (4, 5, 'Ciudad3', 'Destino3', '2024-02-18', '2024-02-20', 552);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (1, 3, 'Ciudad4', 'Destino4', '2024-05-21', '2024-05-22', 191);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (4, 5, 'Ciudad5', 'Destino5', '2024-03-17', '2024-03-19', 500);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (4, 3, 'Ciudad6', 'Destino6', '2024-02-03', '2024-02-04', 676);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (4, 4, 'Ciudad7', 'Destino7', '2024-05-09', '2024-05-11', 110);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (3, 1, 'Ciudad8', 'Destino8', '2024-02-14', '2024-02-17', 403);
INSERT INTO Viajes (id_vehiculo, id_chofer, origen, destino, fecha_salida, fecha_llegada, kilometros) VALUES (5, 5, 'Ciudad9', 'Destino9', '2024-02-24', '2024-02-26', 300);

-- Fallas
INSERT INTO Fallas (id_vehiculo, descripcion, fecha, resuelta) VALUES (1, 'Frenos con ruido', '2024-04-12', FALSE);
INSERT INTO Fallas (id_vehiculo, descripcion, fecha, resuelta) VALUES (2, 'Luz de motor encendida', '2024-03-25', TRUE);
INSERT INTO Fallas (id_vehiculo, descripcion, fecha, resuelta) VALUES (3, 'Neumático pinchado', '2024-02-18', TRUE);
INSERT INTO Fallas (id_vehiculo, descripcion, fecha, resuelta) VALUES (1, 'Vibración al frenar', '2024-05-10', FALSE);
INSERT INTO Fallas (id_vehiculo, descripcion, fecha, resuelta) VALUES (4, 'Problemas con la batería', '2024-01-09', TRUE);

-- Reparaciones
INSERT INTO Reparaciones (id_falla, descripcion, fecha, costo) VALUES (2, 'Reemplazo de sensor de oxígeno', '2024-03-26', 32000);
INSERT INTO Reparaciones (id_falla, descripcion, fecha, costo) VALUES (3, 'Cambio de neumático', '2024-02-19', 15000);
INSERT INTO Reparaciones (id_falla, descripcion, fecha, costo) VALUES (5, 'Cambio de batería', '2024-01-10', 28000);

-- Mantenimientos
INSERT INTO Mantenimientos (id_vehiculo, fecha, tipo, observaciones) VALUES (1, '2024-03-10', 'Cambio de aceite', 'Revisión rutinaria con cambio de filtros');
INSERT INTO Mantenimientos (id_vehiculo, fecha, tipo, observaciones) VALUES (2, '2024-02-15', 'Chequeo general', 'Chequeo completo sin observaciones');
INSERT INTO Mantenimientos (id_vehiculo, fecha, tipo, observaciones) VALUES (3, '2024-04-05', 'Cambio de frenos', 'Reemplazo de pastillas delanteras');
INSERT INTO Mantenimientos (id_vehiculo, fecha, tipo, observaciones) VALUES (4, '2024-05-02', 'Revisión eléctrica', 'Chequeo del sistema de arranque');
INSERT INTO Mantenimientos (id_vehiculo, fecha, tipo, observaciones) VALUES (5, '2024-01-28', 'Alineación y balanceo', 'Ajuste de dirección');

-- Insumos
INSERT INTO Insumos (nombre, tipo, stock_actual) VALUES ('Aceite 10W40', 'Lubricante', 50);
INSERT INTO Insumos (nombre, tipo, stock_actual) VALUES ('Pastillas de freno', 'Repuesto', 20);
INSERT INTO Insumos (nombre, tipo, stock_actual) VALUES ('Filtro de aire', 'Repuesto', 30);
INSERT INTO Insumos (nombre, tipo, stock_actual) VALUES ('Neumático 195/65', 'Repuesto', 10);
INSERT INTO Insumos (nombre, tipo, stock_actual) VALUES ('Batería 12V', 'Repuesto', 15);

-- Combustible
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (5, '2024-02-26', 53.61, 26623);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (5, '2024-04-17', 68.16, 16373);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (2, '2024-03-11', 65.97, 24321);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (1, '2024-04-09', 23.43, 13090);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (3, '2024-03-11', 63.61, 13993);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (4, '2024-01-23', 52.04, 13044);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (1, '2024-01-10', 41.32, 24307);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (1, '2024-04-07', 55.2, 17406);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (5, '2024-01-30', 34.23, 12874);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (2, '2024-02-13', 43.03, 25861);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (4, '2024-03-28', 67.23, 24979);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (1, '2024-03-22', 56.7, 10207);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (2, '2024-03-04', 56.61, 32286);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (2, '2024-02-25', 66.84, 11199);
INSERT INTO Combustible (id_vehiculo, fecha, litros, km_actual) VALUES (5, '2024-01-24', 29.04, 22672);