CREATE SCHEMA biblioteca;
USE biblioteca;

CREATE TABLE editorial(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    contacto VARCHAR(50)
);

CREATE TABLE nacionalidad(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE serie(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE tematica(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE estado_libro(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE autor(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id)
);

CREATE TABLE ilustrador(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    id_nacionalidad INT NOT NULL,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad (id)
);

ALTER TABLE ilustrador
ADD COLUMN  edad INT NOT NULL;

CREATE TABLE lector(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(40) NOT NULL, 
    apellido VARCHAR(40)NOT NULL,
    contacto VARCHAR(50)
);

CREATE TABLE libro(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(40) NOT NULL,
    id_autor INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autor (id),
    id_ilustrador INT NOT NULL,
    FOREIGN KEY (id_ilustrador) REFERENCES ilustrador (id),
    id_editorial INT NOT NULL,
    FOREIGN KEY (id_editorial) REFERENCES editorial (id),
    id_tematica INT NOT NULL,
    FOREIGN KEY (id_tematica) REFERENCES tematica (id),
    id_estado INT NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado_libro (id),
    id_serie INT NOT NULL,
    FOREIGN KEY (id_serie) REFERENCES serie (id),
    detalle VARCHAR(50),
    edad INT
);

CREATE TABLE prestamo (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_libro INT NOT NULL,
FOREIGN KEY (id_libro) REFERENCES libro (id),
id_lector INT NOT NULL,
FOREIGN KEY (id_lector) REFERENCES lector (id),
f_pedido DATE,
f_devolucion DATE,
detalle VARCHAR(60)
);

select * FROM editorial;
select * FROM autor;
INSERT INTO nacionalidad VALUES 
(NULL,"argentino"),
(NULL,"brasilero"),
(NULL,"peruano"),
(NULL,"mexicano");

SELECT * FROM nacionalidad;

INSERT INTO autor VALUES 
(NULL,"Juan Carlos", 2),
(NULL,"Pedro Alfonso", 1),
(NULL,"Raúl Perez", 2);
SELECT * FROM lector;
SELECT * FROM serie;

INSERT INTO ilustrador VALUES 
(NULL,"Juan Esteban",3, 67),
(NULL,"Roberto Segura",1, 56),
(NULL,"Carlos Tami",2, 42),
(NULL,"Camila Bas",4, 23);

select * FROM ilustrador;

CREATE VIEW autores_argentinos AS 
(SELECT a.nombre FROM autor a  JOIN nacionalidad n on a.id_nacionalidad="2");


CREATE VIEW autor_Pedro AS 
(SELECT * FROM  autor WHERE nombre LIKE "Pedro Alfonso");

CREATE OR REPLACE VIEW autores_nacionalidad AS
(SELECT a.nombre FROM autor a JOIN nacionalidad n on a.id_nacionalidad=n.id);

CREATE VIEW series AS 
SELECT s.id, s.nombre FROM serie s;

CREATE OR REPLACE VIEW tematicas AS 
SELECT t.nombre FROM tematica t;
select * from autor;

DELIMITER //
CREATE FUNCTION buscar_autor (clave int)
RETURNS varchar(20)
DETERMINISTIC
BEGIN
DECLARE nombre_encontrado VARCHAR (20);
SET nombre_encontrado="inexistente";
SELECT autor.nombre into nombre_encontrado FROM autor WHERE autor.id=clave;
RETURN nombre_encontrado;
END//

SELECT buscar_autor(9);

DELIMITER //
CREATE FUNCTION rango_edad (edad int)
RETURNS varchar(20)
DETERMINISTIC
BEGIN
DECLARE rango VARCHAR (20);
SET rango="";
CASE 
WHEN edad <=30 THEN RETURN "menor de 30";
WHEN edad >30 AND edad <60 THEN RETURN "entre 30 y 60";
WHEN edad >60 THEN RETURN "mayor a 60";
END CASE;
RETURN rango;
END//

SELECT i.nombre,rango_edad(i.edad) FROM ilustrador i;



