-- MySQL Script generated by MySQL Workbench
-- Wed Dec  5 14:19:08 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Country` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cities` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Country` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Country_idx` (`Country` ASC) VISIBLE,
  CONSTRAINT `Country`
    FOREIGN KEY (`Country`)
    REFERENCES `mydb`.`Country` (`ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Adresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adresses` (
  `ID` INT NOT NULL,
  `Adress` VARCHAR(45) NULL,
  `City` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `ID_idx` (`City` ASC) VISIBLE,
  CONSTRAINT `CITY`
    FOREIGN KEY (`City`)
    REFERENCES `mydb`.`Cities` (`ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Makers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Makers` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Adress` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Adress_idx` (`Adress` ASC) VISIBLE,
  CONSTRAINT `Adress`
    FOREIGN KEY (`Adress`)
    REFERENCES `mydb`.`Adresses` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sklad time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sklad time` (
  `ID` INT NOT NULL,
  `Storage time` INT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medicine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medicine` (
  `ID` INT NOT NULL,
  `Medical name` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Drug`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Drug` (
  `ID` INT NULL,
  `Name` VARCHAR(45) NULL,
  `Image` VARCHAR(45) NULL,
  `Maker` INT NULL,
  `Sklad time` INT NULL,
  `Medicine` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Maker_idx` (`Maker` ASC) VISIBLE,
  INDEX `Medicine_idx` (`Medicine` ASC) VISIBLE,
  CONSTRAINT `Maker`
    FOREIGN KEY (`Maker`)
    REFERENCES `mydb`.`Makers` (`ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Storage time`
    FOREIGN KEY (`Sklad time`)
    REFERENCES `mydb`.`Sklad time` (`ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Medicine`
    FOREIGN KEY (`Medicine`)
    REFERENCES `mydb`.`Medicine` (`ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Distributers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Distributers` (
  `ID` INT NOT NULL,
  `INN` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Adress` INT NULL,
  PRIMARY KEY (`ID`, `INN`),
  INDEX `Adress_idx` (`Adress` ASC) VISIBLE,
  CONSTRAINT `Adress`
    FOREIGN KEY (`Adress`)
    REFERENCES `mydb`.`Adresses` (`ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Postav`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Postav` (
  `ID` INT NOT NULL,
  `Date` DATE NULL,
  `Destributor` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `Distributor_idx` (`Destributor` ASC) VISIBLE,
  CONSTRAINT `Distributor`
    FOREIGN KEY (`Destributor`)
    REFERENCES `mydb`.`Distributers` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dopolnen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dopolnen` (
  `Supply` INT NOT NULL,
  `Drug` INT NULL,
  `Price` INT NULL,
  `Quantity` INT NULL,
  PRIMARY KEY (`Supply`),
  INDEX `Drug_idx` (`Drug` ASC) VISIBLE,
  CONSTRAINT `Supply`
    FOREIGN KEY (`Supply`)
    REFERENCES `mydb`.`Postav` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Drug`
    FOREIGN KEY (`Drug`)
    REFERENCES `mydb`.`Drug` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `mydb`.`Check`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Check` (
  `ID` INT NOT NULL,
  `Date` DATE NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sales` (
  `Check` INT NOT NULL,
  `Drug` INT NOT NULL,
  `Price` INT NULL COMMENT 'Suppliment price+Drugstore profit',
  `Quantity` INT NULL,
  PRIMARY KEY (`Check`, `Drug`),
  INDEX `Drug_idx` (`Drug` ASC) VISIBLE,
  CONSTRAINT `Check`
    FOREIGN KEY (`Check`)
    REFERENCES `mydb`.`Check` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Drug`
    FOREIGN KEY (`Drug`)
    REFERENCES `mydb`.`Drug` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sklad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sklad` (
  `Drug` INT NOT NULL,
  `Quantity` INT NULL COMMENT 'Suppliment.quantity-sales.quantity',
  PRIMARY KEY (`Drug`),
  CONSTRAINT `Drug`
    FOREIGN KEY (`Drug`)
    REFERENCES `mydb`.`Drug` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
