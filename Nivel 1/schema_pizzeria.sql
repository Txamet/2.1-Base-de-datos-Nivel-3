DROP SCHEMA IF EXISTS `pizzeria` ;
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id_cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `idClientes_UNIQUE` (`id_cliente` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `id_tienda` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tienda`),
  UNIQUE INDEX `idTiendas_UNIQUE` (`id_tienda` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `id_pedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `entrega` ENUM("domicilio", "tienda") NOT NULL,
  `repartidor` VARCHAR(45) NULL,
  `hora_entrega` TIME NULL,
  `precio_total` FLOAT UNSIGNED NOT NULL,
  `id_cliente` INT UNSIGNED NOT NULL,
  `id_tienda` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pedido`),
  UNIQUE INDEX `idPedidos_UNIQUE` (`id_pedido` ASC) VISIBLE,
  INDEX `FK_id_Cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `FK_id_tienda_idx` (`id_tienda` ASC) VISIBLE,
  CONSTRAINT `FK_id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `pizzeria`.`clientes` (`id_cliente`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id_tienda`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categorias_pizzas` (
  `id_categoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `id_empleado` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefono` INT UNSIGNED NOT NULL,
  `trabajo` ENUM("cocinero", "repartidor") NULL,
  `id_tienda` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `FK_idTiendas_idx` (`id_tienda` ASC) VISIBLE,
  UNIQUE INDEX `idEmpleados_UNIQUE` (`id_empleado` ASC) VISIBLE,
  CONSTRAINT `FK_id_tiendas`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id_tienda`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id_producto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  `precio` FLOAT UNSIGNED NOT NULL,
  `tipo` ENUM("pizza", "hamburguesa", "bebida") NOT NULL,
  `id_categoria_pizza` INT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE INDEX `id_producto_UNIQUE` (`id_producto` ASC) VISIBLE,
  INDEX `fK_id_categoria_pizza_idx` (`id_categoria_pizza` ASC) VISIBLE,
  CONSTRAINT `FK_id_categoria_pizza`
    FOREIGN KEY (`id_categoria_pizza`)
    REFERENCES `pizzeria`.`categorias_pizzas` (`id_categoria`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos_pedido` (
  `id_pedido` INT UNSIGNED NOT NULL,
  `id_producto` INT UNSIGNED NOT NULL,
  `cantidad` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pedido`, `id_producto`),
  INDEX `FK_id_pedido_idx` (`id_pedido` ASC) VISIBLE,
  INDEX `FK_id_producto_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `FK_id_pedido`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `pizzeria`.`pedidos` (`id_pedido`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `pizzeria`.`productos` (`id_producto`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

INSERT INTO clientes VALUES(1, "Jose", "Bermudez", "Pascal", "Pedrell, 24, 2-2", "08032", "Barcelona", "Barcelona", 654789123);
INSERT INTO clientes VALUES(2, "Antonio", "Porcuna", "Saez", "Balmes, 15, 1-2", "08024", "Barcelona", "Barcelona", 698574132);
INSERT INTO clientes VALUES(3, "Luís", "Julià", "Ávila", "Arpella, 12", "08340", "Vilassar de Mar", "Barcelona", 632159847);

INSERT INTO tiendas VALUES(1, "Maragall, 124, local", "08031", "Barcelona", "Barcelona");
INSERT INTO tiendas VALUES(2, "Arpella, 45", "08340", "Vilassar de Mar", "Barcelona");

INSERT INTO pedidos VALUES(1, "2024-09-15", "domicilio", "David", "21:45", 15, 1, 1);
INSERT INTO pedidos VALUES(2, "2024-09-16", "domicilio", "David", "22:03", 29, 2, 1);
INSERT INTO pedidos VALUES(3, "2024-09-17", "tienda", "Federico", "20:42", 17.5, 3, 2);

INSERT INTO categorias_pizzas VALUES(1, "Clásicas");
INSERT INTO categorias_pizzas VALUES(2, "Carne");
INSERT INTO categorias_pizzas VALUES(3, "Veganas");
INSERT INTO categorias_pizzas VALUES(4, "Gourmet");
   
INSERT INTO empleados VALUES(1, "Marta", "Ruiz", "Bilbao", "12345678A", 649782153, "cocinero", 1);
INSERT INTO empleados VALUES(2, "David", "García", "Fernández", "15648237D", 639582471, "repartidor", 1);
INSERT INTO empleados VALUES(3, "Federico", "Villaplana", "Boncompte", "25418637R", 671248539, "cocinero", 2);
INSERT INTO empleados VALUES(4, "Isabel", "Martín", "Iglesias", "43156278L", 648532122, "repartidor", 2);
 
INSERT INTO productos VALUES(1, "Margarita", "Salsa tomate, mozzarella", 10, "pizza", 1);
INSERT INTO productos VALUES(2, "Barbacoa", "Salsa tomate, salsa barbacoa, cebolla, pollo, bacon", 15, "pizza", 2);
INSERT INTO productos VALUES(3, "Básica", "Queso, lechuga, cebolla", 8, "hamburguesa", NULL);
INSERT INTO productos VALUES(4, "Completa", "Queso, lechuga, cebolla, bacon, huevo", 12, "hamburguesa", NULL);
INSERT INTO productos VALUES(5, "Coca-Cola", NULL, 2.5, "bebida", NULL);
INSERT INTO productos VALUES(6, "Cerveza", NULL, 2.5, "bebida", NULL);

INSERT INTO productos_pedido VALUES(1, 1, 1);
INSERT INTO productos_pedido VALUES(1, 5, 2);
INSERT INTO productos_pedido VALUES(2, 4, 2);
INSERT INTO productos_pedido VALUES(2, 5, 2);
INSERT INTO productos_pedido VALUES(3, 2, 1);
INSERT INTO productos_pedido VALUES(3, 6, 1);
