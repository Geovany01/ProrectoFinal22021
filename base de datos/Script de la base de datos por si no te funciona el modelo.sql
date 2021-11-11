-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema proyecto_progra22021
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `proyecto_progra22021` ;

-- -----------------------------------------------------
-- Schema proyecto_progra22021
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_progra22021` DEFAULT CHARACTER SET utf8 ;
USE `proyecto_progra22021` ;

-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`clientes` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(60) NULL DEFAULT NULL,
  `apellidos` VARCHAR(60) NULL DEFAULT NULL,
  `NIT` VARCHAR(12) NULL DEFAULT NULL,
  `genero` BIT(1) NULL DEFAULT NULL,
  `telefono` VARCHAR(25) NULL DEFAULT NULL,
  `correoElectronico` VARCHAR(45) NULL DEFAULT NULL,
  `fechaIngreso` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`proveedores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`proveedores` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`proveedores` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `proveedor` VARCHAR(60) NULL DEFAULT NULL,
  `NIT` VARCHAR(12) NULL DEFAULT NULL,
  `direccion` VARCHAR(80) NULL DEFAULT NULL,
  `telefono` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`idProveedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`compras` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`compras` (
  `idCompra` INT NOT NULL AUTO_INCREMENT,
  `noOrdenCompra` INT NULL DEFAULT NULL,
  `idProveedor` INT NULL DEFAULT NULL,
  `fechaOrden` DATE NULL DEFAULT NULL,
  `fechaIngreso` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCompra`),
  CONSTRAINT `idProveedor`
    FOREIGN KEY (`idProveedor`)
    REFERENCES `proyecto_progra22021`.`proveedores` (`idProveedor`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `idProveedor` ON `proyecto_progra22021`.`compras` (`idProveedor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`marcas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`marcas` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`marcas` (
  `idMarca` SMALLINT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`idMarca`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`productos` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `producto` VARCHAR(50) NULL DEFAULT NULL,
  `idMarca` SMALLINT NULL DEFAULT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `imagen` VARCHAR(100) NULL DEFAULT NULL,
  `precioCosto` DECIMAL(8,2) NULL DEFAULT NULL,
  `precioVenta` DECIMAL(8,2) NULL DEFAULT NULL,
  `existencia` INT NULL DEFAULT NULL,
  `fechaIngreso` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `idMarca`
    FOREIGN KEY (`idMarca`)
    REFERENCES `proyecto_progra22021`.`marcas` (`idMarca`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `idMarca` ON `proyecto_progra22021`.`productos` (`idMarca` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`comprasdetalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`comprasdetalle` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`comprasdetalle` (
  `idCompraDetalle` BIGINT NOT NULL AUTO_INCREMENT,
  `idCompra` INT NULL DEFAULT NULL,
  `idProducto` INT NULL DEFAULT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `precioCostoUnitario` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idCompraDetalle`),
  CONSTRAINT `idCompra`
    FOREIGN KEY (`idCompra`)
    REFERENCES `proyecto_progra22021`.`compras` (`idCompra`)
    ON UPDATE CASCADE,
  CONSTRAINT `idProductoCompras`
    FOREIGN KEY (`idProducto`)
    REFERENCES `proyecto_progra22021`.`productos` (`idProducto`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `idCompra` ON `proyecto_progra22021`.`comprasdetalle` (`idCompra` ASC) VISIBLE;

CREATE INDEX `idProductoCompras` ON `proyecto_progra22021`.`comprasdetalle` (`idProducto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`puestos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`puestos` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`puestos` (
  `idPuesto` SMALLINT NOT NULL AUTO_INCREMENT,
  `puesto` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`idPuesto`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`empleados` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`empleados` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(60) NULL DEFAULT NULL,
  `apellidos` VARCHAR(60) NULL DEFAULT NULL,
  `direccion` VARCHAR(80) NULL DEFAULT NULL,
  `telefono` VARCHAR(25) NULL DEFAULT NULL,
  `DPI` VARCHAR(15) NULL DEFAULT NULL,
  `genero` BIT(1) NULL DEFAULT NULL,
  `fechaNacimiento` DATE NULL DEFAULT NULL,
  `idPuesto` SMALLINT NULL DEFAULT NULL,
  `fechaInicioLabores` DATE NULL DEFAULT NULL,
  `fechaIngreso` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEmpleado`),
  CONSTRAINT `idPuesto`
    FOREIGN KEY (`idPuesto`)
    REFERENCES `proyecto_progra22021`.`puestos` (`idPuesto`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `idPuesto` ON `proyecto_progra22021`.`empleados` (`idPuesto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`menu` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menu_nombre` VARCHAR(255) NOT NULL,
  `id_padre` INT NOT NULL DEFAULT '0',
  `link` VARCHAR(255) NOT NULL,
  `estatus` ENUM('0', '1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`rol` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`rol` (
  `rolId` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(255) NULL DEFAULT NULL,
  `estatus` ENUM('0', '1') NULL DEFAULT '1',
  PRIMARY KEY (`rolId`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`users` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`users` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(45) NULL DEFAULT NULL,
  `pass` VARCHAR(45) NULL DEFAULT NULL,
  `rol` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  CONSTRAINT `rol`
    FOREIGN KEY (`rol`)
    REFERENCES `proyecto_progra22021`.`rol` (`rolId`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `rol_idx` ON `proyecto_progra22021`.`users` (`rol` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`ventas` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`ventas` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `noFactura` INT NULL DEFAULT NULL,
  `serie` CHAR(1) NULL DEFAULT NULL,
  `fechaFactura` DATE NULL DEFAULT NULL,
  `idCliente` INT NULL DEFAULT NULL,
  `idEmpleado` INT NULL DEFAULT NULL,
  `fechaIngreso` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVenta`),
  CONSTRAINT `idCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `proyecto_progra22021`.`clientes` (`idCliente`)
    ON UPDATE CASCADE,
  CONSTRAINT `idEmpleado`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `proyecto_progra22021`.`empleados` (`idEmpleado`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `idCliente` ON `proyecto_progra22021`.`ventas` (`idCliente` ASC) VISIBLE;

CREATE INDEX `idEmpleado` ON `proyecto_progra22021`.`ventas` (`idEmpleado` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `proyecto_progra22021`.`ventasdetalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_progra22021`.`ventasdetalle` ;

CREATE TABLE IF NOT EXISTS `proyecto_progra22021`.`ventasdetalle` (
  `idVentaDetalle` BIGINT NOT NULL AUTO_INCREMENT,
  `idVenta` INT NULL DEFAULT NULL,
  `idProducto` INT NULL DEFAULT NULL,
  `cantidad` VARCHAR(45) NULL DEFAULT NULL,
  `precioUnitario` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idVentaDetalle`),
  CONSTRAINT `idProductoVentas`
    FOREIGN KEY (`idProducto`)
    REFERENCES `proyecto_progra22021`.`productos` (`idProducto`)
    ON UPDATE CASCADE,
  CONSTRAINT `idVenta`
    FOREIGN KEY (`idVenta`)
    REFERENCES `proyecto_progra22021`.`ventas` (`idVenta`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `idVenta` ON `proyecto_progra22021`.`ventasdetalle` (`idVenta` ASC) VISIBLE;

CREATE INDEX `idProductoVentas` ON `proyecto_progra22021`.`ventasdetalle` (`idProducto` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
