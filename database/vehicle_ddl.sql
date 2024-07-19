-- MySQL Script generated by MySQL Workbench
-- Fri Jul 19 21:42:23 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vehicle
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema vehicle
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vehicle` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `vehicle` ;

-- -----------------------------------------------------
-- Table `vehicle`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`.`users` (
  `username` VARCHAR(50) NOT NULL,
  `password` CHAR(68) NOT NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `vehicle`.`authorities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`.`authorities` (
  `username` VARCHAR(50) NOT NULL,
  `authority` VARCHAR(50) NOT NULL,
  UNIQUE INDEX `authorities4_idx_1` (`username` ASC, `authority` ASC),
  CONSTRAINT `authorities4_ibfk_1`
    FOREIGN KEY (`username`)
    REFERENCES `vehicle`.`users` (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `vehicle`.`vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`.`vehicle` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `make` VARCHAR(255) NOT NULL,
  `model` VARCHAR(255) NOT NULL,
  `year` INT NOT NULL,
  `intern_rest_id` INT NOT NULL,
  `enginename` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `intern_rest_id_UNIQUE` (`intern_rest_id` ASC) VISIBLE,
  INDEX `make_index` (`make` ASC) INVISIBLE,
  INDEX `model_index` (`model` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 46676
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `vehicle`.`users_has_vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`.`users_has_vehicle` (
  `users_username` VARCHAR(50) NOT NULL,
  `vehicle_id` INT NOT NULL,
  `vin` VARCHAR(17) NOT NULL,
  `active` TINYINT NOT NULL,
  `mileage` INT NOT NULL,
  PRIMARY KEY (`users_username`, `vehicle_id`),
  INDEX `fk_users_has_vehicle_vehicle1_idx` (`vehicle_id` ASC) VISIBLE,
  INDEX `fk_users_has_vehicle_users1_idx` (`users_username` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_vehicle_users1`
    FOREIGN KEY (`users_username`)
    REFERENCES `vehicle`.`users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_vehicle_vehicle1`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `vehicle`.`vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `vehicle`.`maintenance_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`.`maintenance_status` (
  `id` INT NOT NULL,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle`.`maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`.`maintenance` (
  `id` INT NOT NULL,
  `mileage` INT NOT NULL,
  `dateIn` DATE NOT NULL,
  `dateOut` DATE NOT NULL,
  `timeIn` TIME NOT NULL,
  `timeOut` TIME NOT NULL,
  `cost` FLOAT(7,2) NOT NULL,
  `vehicle_id` INT NOT NULL,
  `maintenance_status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_maintenance_vehicle1_idx` (`vehicle_id` ASC) VISIBLE,
  INDEX `fk_maintenance_maintenance_status1_idx` (`maintenance_status_id` ASC) VISIBLE,
  CONSTRAINT `fk_maintenance_vehicle1`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `vehicle`.`vehicle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_maintenance_maintenance_status1`
    FOREIGN KEY (`maintenance_status_id`)
    REFERENCES `vehicle`.`maintenance_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle`.`maintenance_rec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle`.`maintenance_rec` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `solved` TINYINT NOT NULL,
  `maintenance_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_maintenance_rek_maintenance1_idx` (`maintenance_id` ASC) VISIBLE,
  CONSTRAINT `fk_maintenance_rek_maintenance1`
    FOREIGN KEY (`maintenance_id`)
    REFERENCES `vehicle`.`maintenance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
