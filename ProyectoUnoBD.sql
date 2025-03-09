create database LaboratorioUnoBasesDeDatos;
use LaboratorioUnoBasesDeDatos;

-- Tabla UNIR CLIENTE
CREATE TABLE UNIR_CLIENTE (
	ID int not null,
	NOMBRE varchar(100) not null,
	APELLIDO1 varchar(100) not null,
	APELLIDO2 varchar(100),
	CIUDAD varchar (100),
	CATEGORIA int,
    CONSTRAINT CLIENTE_PK PRIMARY KEY (ID)
);
-- Mostrar Tabla UNIR CLIENTE
describe UNIR_CLIENTE;

-- Tabla UNIR COMERCIAL
CREATE TABLE UNIR_COMERCIAL (
    ID INT NOT NULL,
    NOMBRE VARCHAR(100) NOT NULL,
    APELLIDO1 VARCHAR(100) NOT NULL,
    APELLIDO2 VARCHAR(100),
    COMISION DECIMAL(10, 2),
    CONSTRAINT COMERCIAL_PK PRIMARY KEY (ID)
);
-- Mostrar Tabla UNIR COMERCIAL
describe UNIR_COMERCIAL;

-- Tabla UNIR PEDIDO
CREATE TABLE UNIR_PEDIDO (
    ID INT NOT NULL,
    TOTAL DECIMAL(10, 2) NOT NULL,
    FECHA DATE,
    ID_CLIENTE INT NOT NULL,
    ID_COMERCIAL INT NOT NULL,
    CONSTRAINT PEDIDO_PK PRIMARY KEY (ID),
    CONSTRAINT FK_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES UNIR_CLIENTE(ID),
    CONSTRAINT FK_COMERCIAL FOREIGN KEY (ID_COMERCIAL) REFERENCES UNIR_COMERCIAL(ID)
);
-- Mostrar Tabla UNIR PEDIDO
describe UNIR_PEDIDO;


-- Inserción en UNIR_CLIENTE
INSERT INTO UNIR_CLIENTE (ID, NOMBRE, APELLIDO1, APELLIDO2, CIUDAD, CATEGORIA) VALUES 
(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100),
(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200),
(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL),
(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300),
(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200),
(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100),
(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300),
(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200),
(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225),
(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

-- Inserción en UNIR_COMERCIAL
INSERT INTO UNIR_COMERCIAL (ID, NOMBRE, APELLIDO1, APELLIDO2, COMISION) VALUES 
(1, 'Daniel', 'Sáez', 'Vega', 0.15),
(2, 'Juan', 'Gómez', 'López', 0.13),
(3, 'Diego', 'Flores', 'Salas', 0.11),
(4, 'Marta', 'Herrera', 'Gil', 0.14),
(5, 'Antonio', 'Carretero', 'Ortega', 0.12),
(6, 'Manuel', 'Dominguez', 'Hernández', 0.13),
(7, 'Antonio', 'Vega', 'Hernández', 0.11),
(8, 'Alfredo', 'Ruiz', 'Flores', 0.05);

-- Inserción en UNIR_PEDIDO
INSERT INTO UNIR_PEDIDO (ID, TOTAL, FECHA, ID_CLIENTE, ID_COMERCIAL) VALUES 
(1, 150.5, '2017-10-05', 5, 2),
(2, 270.65, '2016-09-10', 1, 5),
(3, 65.26, '2017-10-05', 2, 1),
(4, 110.5, '2016-08-17', 8, 3),
(5, 948.5, '2017-09-10', 5, 2),
(6, 2400.6, '2016-07-27', 7, 1),
(7, 5760, '2015-09-10', 2, 1),
(8, 1983.43, '2017-10-10', 4, 6),
(9, 2480.4, '2016-10-10', 8, 3),
(10, 250.45, '2015-06-27', 8, 2),
(11, 75.29, '2016-08-17', 3, 7),
(12, 3045.6, '2017-04-25', 2, 1),
(13, 545.75, '2019-01-25', 6, 1),
(14, 145.82, '2017-02-02', 6, 1),
(15, 370.85, '2019-03-11', 1, 5),
(16, 2389.23, '2019-03-11', 1, 5);

-- CONSULTA NO. 1
SELECT * 
FROM UNIR_PEDIDO
ORDER BY FECHA DESC;

-- CONSULTA NO. 2
SELECT * 
FROM UNIR_PEDIDO
WHERE TOTAL BETWEEN 300 AND 600
ORDER BY FECHA ASC;

-- CONSULTA NO. 3
SELECT ID, NOMBRE, APELLIDO1
FROM UNIR_CLIENTE
WHERE APELLIDO2 IS NULL
ORDER BY APELLIDO1 ASC, NOMBRE ASC;

-- CONSULTA NO. 4
SELECT DISTINCT c.ID, c.NOMBRE, c.APELLIDO1, c.APELLIDO2
FROM UNIR_CLIENTE c
INNER JOIN UNIR_PEDIDO p ON c.ID = p.ID_CLIENTE
ORDER BY c.APELLIDO1 ASC, c.APELLIDO2 ASC, c.NOMBRE ASC;

-- CONSULTA NO. 5
SELECT DISTINCT com.NOMBRE, com.APELLIDO1, com.APELLIDO2
FROM UNIR_COMERCIAL com
INNER JOIN UNIR_PEDIDO p ON com.ID = p.ID_COMERCIAL
INNER JOIN UNIR_CLIENTE cl ON p.ID_CLIENTE = cl.ID
WHERE cl.NOMBRE = 'Maria' 
  AND cl.APELLIDO1 = 'Santana' 
  AND cl.APELLIDO2 = 'Moreno';

-- VISTA RESUMEN PEDIDOS
CREATE VIEW ResumenPedidos AS
SELECT 
    p.ID AS ID_Pedido,
    p.FECHA AS Fecha_Pedido,
    cl.NOMBRE AS Nombre_Cliente,
    cl.APELLIDO1 AS Apellido1_Cliente,
    cl.APELLIDO2 AS Apellido2_Cliente,
    c.NOMBRE AS Nombre_Comercial,
    c.APELLIDO1 AS Apellido1_Comercial,
    c.APELLIDO2 AS Apellido2_Comercial,
    p.TOTAL AS Total_Venta
FROM UNIR_PEDIDO p
INNER JOIN UNIR_CLIENTE cl ON p.ID_CLIENTE = cl.ID
INNER JOIN UNIR_COMERCIAL c ON p.ID_COMERCIAL = c.ID;

-- VER VISTA RESUMEN PEDIDOS
SELECT * FROM ResumenPedidos;

-- CONSULTA VISTA RESUMEN PEDIDOS
SELECT 
    Nombre_Comercial,
    Apellido1_Comercial,
    Apellido2_Comercial,
    SUM(Total_Venta) AS Total_Ventas,
    AVG(Total_Venta) AS Promedio_Ventas,
    COUNT(ID_Pedido) AS Cantidad_Pedidos
FROM 
    ResumenPedidos
GROUP BY 
    Nombre_Comercial,
    Apellido1_Comercial,
    Apellido2_Comercial
ORDER BY 
    Total_Ventas DESC;





