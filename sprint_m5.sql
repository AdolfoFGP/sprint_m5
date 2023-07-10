# Sprint M5
/*
Cada usuario tiene información sobre: nombre, apellido, edad, correo electrónico y número de veces
que ha utilizado la aplicación (por defecto es 1, pero al insertar los registros debe indicar un número
manual).
Cada operario tiene información sobre: nombre, apellido, edad, correo electrónico y número de veces
que ha servido de soporte (por defecto es 1, pero al insertar los registros debe indicar un número
manual).
Cada vez que se realiza un soporte, se reconoce quien es el operario, el cliente, la fecha y la evaluación
que recibe el soporte.
Diagrame el modelo entidad relación.

Construya una base de datos. Asigne un usuario con todos los privilegios. Construya las tablas.
Agregue 5 usuarios, 5 operadores y 10 operaciones de soporte. Los datos debe crearlos según su
imaginación.

*/


CREATE DATABASE sprintM5;
USE sprintM5;

CREATE USER 'userM5'@'localhost' IDENTIFIED BY 'clave321';
GRANT ALL PRIVILEGES ON sprintM5.* TO 'userM5'@'localhost';
FLUSH PRIVILEGES;

DROP TABLE IF EXISTS usuario, operario, soporte;

CREATE TABLE usuario (
id_usuario INT PRIMARY KEY,
nombre VARCHAR(25),
apellido VARCHAR(25),
edad TINYINT,
correo VARCHAR(50),
numUsosApp INT DEFAULT 1);

INSERT INTO usuario (id_usuario, nombre, apellido, edad, correo, numUsosApp)
VALUES
(1, 'Juan', 'Pérez', 28, 'juanperez@example.com', 10),
(2, 'María', 'García', 32, 'mariagarcia@example.com', 25),
(3, 'Andrés', 'Rodríguez', 24, 'andresrodriguez@example.com', 15),
(4, 'Laura', 'López', 35, 'lauralopez@example.com', 65),
(5, 'Carlos', 'Torres', 30, 'carlostorres@example.com', 7);

CREATE TABLE operario (
id_operario INT PRIMARY KEY,
nombre VARCHAR(25),
apellido VARCHAR(25),
edad TINYINT,
correo VARCHAR(50),
numServSoporte INT DEFAULT 1);

INSERT INTO operario (id_operario, nombre, apellido, edad, correo, numServSoporte)
VALUES
(1, 'Pedro', 'Sánchez', 28, 'pedrosanchez@example.com', 56),
(2, 'Ana', 'Martínez', 35, 'anamartinez@example.com', 34),
(3, 'Luis', 'Gómez', 42, 'luisgomez@example.com', 64),
(4, 'Sara', 'Vargas', 31, 'saravargas@example.com', 23),
(5, 'Daniel', 'Hernández', 27, 'danielhernandez@example.com', 36);


CREATE TABLE soporte (
id_usuario INT,
id_operario INT,
fecha DATE,
evaluación TINYINT,
CONSTRAINT usuario_fk FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
CONSTRAINT operario_fk FOREIGN KEY (id_operario) REFERENCES operario(id_operario));

INSERT INTO soporte (id_usuario, id_operario, fecha, evaluación) VALUES
(1, 2, '2023-03-15', 4),
(5, 4, '2023-02-28', 2),
(5, 3, '2023-05-10', 3),
(2, 2, '2023-01-21', 5),
(4, 5, '2023-06-05', 1),
(2, 1, '2023-03-03', 5),
(1, 1, '2023-02-14', 3),
(1, 3, '2023-04-18', 2),
(5, 5, '2023-05-29', 4),
(3, 1, '2023-01-08', 1);

TABLE usuario;
TABLE operario;
TABLE soporte;

# Seleccione las 3 operaciones con mejor evaluación.
SELECT * FROM soporte 
ORDER BY evaluación 
DESC LIMIT 3;

# Seleccione las 3 operaciones con menos evaluación.
SELECT * FROM soporte 
ORDER BY evaluación 
ASC LIMIT 3;

# Seleccione al operario que más soportes ha realizado.
SELECT * FROM operario o JOIN(
	SELECT id_operario, COUNT(evaluación) AS Conteo_soportes FROM soporte 
	GROUP BY id_operario 
	ORDER BY Conteo_soportes DESC 
    LIMIT 1) om ON o.id_operario = om.id_operario; 

# Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT * FROM usuario
WHERE numUsosAPP = (SELECT MAX(numUsosApp) FROM usuario);

# Agregue 10 años a los tres primeros usuarios registrados.
SET SQL_SAFE_UPDATES = 0;
UPDATE usuario 
SET edad =
	CASE WHEN id_usuario = 1 THEN edad + 10
		 WHEN id_usuario = 2 THEN edad + 10
		 WHEN id_usuario = 3 THEN edad + 10 
         ELSE edad 
	END; 
SET SQL_SAFE_UPDATES = 1;

TABLE usuario;

# Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
ALTER TABLE usuario CHANGE correo email VARCHAR(50);
ALTER TABLE operario CHANGE correo email VARCHAR(50);

TABLE usuario;
TABLE operario;

# Seleccione solo los operarios mayores de 20 años.
SELECT * FROM operario
WHERE edad > 20;

# Según la tabla que creé son todos mayores a 20
# Aquí otro para probar que funciona
SELECT * FROM operario
WHERE edad > 30;

