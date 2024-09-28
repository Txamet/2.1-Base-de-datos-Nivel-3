DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

CREATE TABLE IF NOT EXISTS `optica`.`direcciones` (
  `id_direccion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(5) NOT NULL,
  `piso` VARCHAR(10) NULL,
  `puerta` VARCHAR(10) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_direccion`),
  UNIQUE INDEX `idDirecciones_UNIQUE` (`id_direccion` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `optica`.`proveedores` (
  `id_proveedor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_direccion` INT UNSIGNED NOT NULL,
  `telefono` INT UNSIGNED NOT NULL,
  `fax` INT UNSIGNED NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  INDEX `idDirecciones_idx` (`id_direccion` ASC) VISIBLE,
  UNIQUE INDEX `NIF_UNIQUE` (`nif` ASC) VISIBLE,
  CONSTRAINT `FK_id_direccion`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `optica`.`direcciones` (`id_direccion`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_direccion` INT UNSIGNED NOT NULL,
  `telefono` INT UNSIGNED NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_alta` DATE NOT NULL,
  `Cliente_que_recomendo` INT UNSIGNED NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `idDirecciones_idx` (`id_direccion` ASC) VISIBLE,
  CONSTRAINT `FK_idDirecciones`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `optica`.`direcciones` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id_gafas` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `graduacion_vidrio_derecho` FLOAT UNSIGNED NOT NULL,
  `graduacion_vidrio_izquierdo` FLOAT UNSIGNED NOT NULL,
  `montura` ENUM("flotante", "pasta", "metalica") NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_vidrio_derecho` VARCHAR(45) NULL,
  `color_vidrio_izquierdo` VARCHAR(45) NULL,
  `precio` FLOAT UNSIGNED NOT NULL,
  `id_proveedor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `idProveedores_idx` (`id_proveedor` ASC) VISIBLE,
  UNIQUE INDEX `id_gafas_UNIQUE` (`id_gafas` ASC) VISIBLE,
  CONSTRAINT `FK_id_proveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `optica`.`proveedores` (`id_proveedor`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `id_venta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_gafas` INT UNSIGNED NOT NULL,
  `id_cliente` INT UNSIGNED NOT NULL,
  `empleado_venta` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  `periodo_ventas` ENUM("Q1", "Q2", "Q3", "Q4") NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `idGafas_idx` (`id_gafas` ASC) VISIBLE,
  INDEX `idClientes_idx` (`id_cliente` ASC) VISIBLE,
  UNIQUE INDEX `idVentas_UNIQUE` (`id_venta` ASC) VISIBLE,
  CONSTRAINT `FK_id_gafas`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `optica`.`gafas` (`id_gafas`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `optica`.`clientes` (`id_cliente`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

INSERT INTO direcciones VALUES(1, "Pedrell", 15, 2, 2, "Barcelona", "08032", "España");
INSERT INTO direcciones VALUES(2, "Parca", 26, 5, 3, "Madrid", "28005", "España");
INSERT INTO direcciones VALUES(3, "Pastel", 8, NULL, NULL, "Palencia", "34002", "España");
INSERT INTO direcciones VALUES(4, "Abedul", 37, NULL, NULL, "Zaragoza", "50013", "España");
INSERT INTO direcciones VALUES(5, "Floresta", 105, 3, 1, "Barcelona", "08015", "España");

INSERT INTO proveedores VALUES(1, "Gafas Modernas, SL", 3, 678256983, 976369521, "12345678L");
INSERT INTO proveedores VALUES(2, "Fashion Glasses, SL", 4, 635987421, 979358306, "87654321P");

INSERT INTO clientes VALUES(1, "Josefina", 1, 678945321, "josefina@gmail.com", "2024-06-16", NULL);
INSERT INTO clientes VALUES(2, "Antonio", 2, 632154789, "antonio@gamil.com", "2024-07-11", NULL);
INSERT INTO clientes VALUES(3, "Esmeralda", 5, 635482917, "esmeralda@gmail.com", "2024-08-21", 1);

INSERT INTO gafas VALUES(1, "Moschino", 3, 3.5, "pasta", "verde", NULL, NULL, 350, 1);
INSERT INTO gafas VALUES(2, "Lacoste", 1.5, 1.25, "metalica", "negro", "negro", "negro", 279.99, 2);
INSERT INTO gafas VALUES(3, "Lanvin", 2.5, 1.5, "flotante", "rojo", NULL, NULL, 185, 1);

INSERT INTO ventas VALUES(1, 1, 1, "Carmen", "2024-06-16", "Q2");
INSERT INTO ventas VALUES(2, 2, 2, "Carmen", "2024-07-11", "Q3");
INSERT INTO ventas VALUES(3, 3, 3, "Manuel", "2024-08-21", "Q3");
