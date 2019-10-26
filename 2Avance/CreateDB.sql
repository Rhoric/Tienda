CREATE DATABASE IF NOT EXISTS DB_STORE;

CREATE TABLE IF NOT EXISTS `db_store`.`cliente` (
  `Id_Cliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre_Cliente` VARCHAR(255) NOT NULL,
  `Password_Cliente` VARCHAR(255) NOT NULL,
  `Direccion` VARCHAR(255) NULL,
  `Avatar_Cliente` BLOB NULL,
  PRIMARY KEY (`Id_Cliente`));

CREATE TABLE IF NOT EXISTS `db_store`.`admin` (
  `Id_Admin` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre_Admin` VARCHAR(255) NOT NULL,
  `Password_Admin` VARCHAR(255) NOT NULL,
  `Avatar_Admin` BLOB NULL,
  PRIMARY KEY (`Id_Admin`));
  
  CREATE TABLE IF NOT EXISTS `db_store`.`producto` (
  `Id_Producto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre_Producto` VARCHAR(255) NOT NULL,
  `Descripcion` VARCHAR(255) NULL,
  `Stock` INT UNSIGNED NULL,
  `Buscado` INT UNSIGNED NULL,
  `Visitado` INT UNSIGNED NULL,
  `Video` BLOB NULL,
  PRIMARY KEY (`Id_Producto`));
  
  CREATE TABLE `db_store`.`imagen` (
  `Id_Imagen` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Id_Producto` INT UNSIGNED NOT NULL,
  `Imagen` BLOB NOT NULL,
  PRIMARY KEY (`Id_Imagen`),
  INDEX `Producto_Imagen_idx` (`Id_Producto` ASC) VISIBLE,
  CONSTRAINT `Producto_Imagen`
    FOREIGN KEY (`Id_Producto`)
    REFERENCES `db_store`.`producto` (`Id_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `db_store`.`categoria` (
  `Id_Categoria` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id_Categoria`));
  
 CREATE TABLE IF NOT EXISTS `db_store`.`chat` (
  `Id_Chat` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Id_Cliente` INT UNSIGNED NOT NULL,
  `Id_Admin` INT UNSIGNED NOT NULL,
  `Id_Producto` INT UNSIGNED NOT NULL,
  `Cantidad` INT NULL,
  `Precio` INT NULL,
  PRIMARY KEY (`Id_Chat`),
  INDEX `Cliente_Chat_idx` (`Id_Cliente` ASC) VISIBLE,
  INDEX `Admin_Chat_idx` (`Id_Admin` ASC) VISIBLE,
  INDEX `Producto_Chat_idx` (`Id_Producto` ASC) VISIBLE,
  CONSTRAINT `Cliente_Chat`
    FOREIGN KEY (`Id_Cliente`)
    REFERENCES `db_store`.`cliente` (`Id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Admin_Chat`
    FOREIGN KEY (`Id_Admin`)
    REFERENCES `db_store`.`admin` (`Id_Admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Producto_Chat`
    FOREIGN KEY (`Id_Producto`)
    REFERENCES `db_store`.`producto` (`Id_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
  CREATE TABLE IF NOT EXISTS `db_store`.`mensaje` (
  `Id_Mensaje` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Id_Chat` INT UNSIGNED NOT NULL,
  `Mensaje` VARCHAR(255) NOT NULL,
  `Fecha` TIMESTAMP NULL,
  PRIMARY KEY (`Id_Mensaje`),
  INDEX `Chat_Mensaje_idx` (`Id_Chat` ASC) VISIBLE,
  CONSTRAINT `Chat_Mensaje`
    FOREIGN KEY (`Id_Chat`)
    REFERENCES `db_store`.`chat` (`Id_Chat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
 
 CREATE TABLE IF NOT EXISTS `db_store`.`rating` (
  `Id_Producto` INT UNSIGNED NOT NULL,
  `Id_Cliente` INT UNSIGNED NOT NULL,
  `Calificacion` INT NOT NULL,
  `Comentario` VARCHAR(255) NULL,
  INDEX `Producto_Rating_idx` (`Id_Producto` ASC) VISIBLE,
  INDEX `Cliente_Rating_idx` (`Id_Cliente` ASC) VISIBLE,
  CONSTRAINT `Producto_Rating`
    FOREIGN KEY (`Id_Producto`)
    REFERENCES `db_store`.`producto` (`Id_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Cliente_Rating`
    FOREIGN KEY (`Id_Cliente`)
    REFERENCES `db_store`.`cliente` (`Id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE IF NOT EXISTS `db_store`.`producto_categoria` (
  `Id_Producto` INT UNSIGNED NOT NULL,
  `Id_Categoria` INT UNSIGNED NOT NULL,
  INDEX `Producto_Producto_Categoria_idx` (`Id_Producto` ASC) VISIBLE,
  INDEX `Categoria_Producto_Categoria_idx` (`Id_Categoria` ASC) VISIBLE,
  CONSTRAINT `Producto_Producto_Categoria`
    FOREIGN KEY (`Id_Producto`)
    REFERENCES `db_store`.`producto` (`Id_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Categoria_Producto_Categoria`
    FOREIGN KEY (`Id_Categoria`)
    REFERENCES `db_store`.`categoria` (`Id_Categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
