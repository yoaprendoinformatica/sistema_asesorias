-- MySQL Script generated by MySQL Workbench
-- lun 21 oct 2019 22:08:17 -05
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema asesoria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `asesoria` ;

-- -----------------------------------------------------
-- Schema asesoria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `asesoria` DEFAULT CHARACTER SET utf8 ;
USE `asesoria` ;

-- -----------------------------------------------------
-- Table `asesoria`.`tipodocumento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`tipodocumento` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`tipodocumento` (
  `tipodoc_id` INT NOT NULL AUTO_INCREMENT,
  `tipodoc_nombre` VARCHAR(45) NOT NULL,
  `tipodoc_descripcion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`tipodoc_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`usuario` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`usuario` (
  `usu_id` INT NOT NULL AUTO_INCREMENT,
  `tipodoc_id` INT NOT NULL,
  `usu_nombres` VARCHAR(45) NOT NULL,
  `usu_apellidos` VARCHAR(45) NOT NULL,
  `usu_fechanac` DATE NULL,
  `usu_documento` VARCHAR(45) NOT NULL,
  `rol_id` INT NOT NULL,
  `usu_correo` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`usu_id`),
  INDEX `fk_usutipodoc_idx` (`tipodoc_id` ASC),
  UNIQUE INDEX `usu_correo_UNIQUE` (`usu_correo` ASC),
  CONSTRAINT `fk_usutipodoc`
    FOREIGN KEY (`tipodoc_id`)
    REFERENCES `asesoria`.`tipodocumento` (`tipodoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`rol` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`rol` (
  `rol_id` INT NOT NULL AUTO_INCREMENT,
  `rol_nombre` VARCHAR(45) NOT NULL,
  `rol_descripcion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`rol_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`funcionalidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`funcionalidad` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`funcionalidad` (
  `fun_id` INT NOT NULL AUTO_INCREMENT,
  `fun_nombre` VARCHAR(45) NOT NULL,
  `fun_descripcion` VARCHAR(300) NOT NULL,
  `fun_url` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`fun_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`rolfuncion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`rolfuncion` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`rolfuncion` (
  `rolfun_id` INT NOT NULL AUTO_INCREMENT,
  `rol_id` INT NOT NULL,
  `fun_id` INT NOT NULL,
  PRIMARY KEY (`rolfun_id`),
  INDEX `fk_rolfunrol_idx` (`rol_id` ASC),
  INDEX `fk_rolfunfun_idx` (`fun_id` ASC),
  CONSTRAINT `fk_rolfunrol`
    FOREIGN KEY (`rol_id`)
    REFERENCES `asesoria`.`rol` (`rol_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rolfunfun`
    FOREIGN KEY (`fun_id`)
    REFERENCES `asesoria`.`funcionalidad` (`fun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`rolfuncionalidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`rolfuncionalidad` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`rolfuncionalidad` (
  `rol_rol_id` INT NOT NULL,
  `funcionalidad_fun_id` INT NOT NULL,
  `rolfun_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`rolfun_id`, `funcionalidad_fun_id`, `rol_rol_id`),
  INDEX `fk_rol_has_funcionalidad_funcionalidad1_idx` (`funcionalidad_fun_id` ASC),
  INDEX `fk_rol_has_funcionalidad_rol1_idx` (`rol_rol_id` ASC),
  CONSTRAINT `fk_rol_has_funcionalidad_rol1`
    FOREIGN KEY (`rol_rol_id`)
    REFERENCES `asesoria`.`rol` (`rol_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_has_funcionalidad_funcionalidad1`
    FOREIGN KEY (`funcionalidad_fun_id`)
    REFERENCES `asesoria`.`funcionalidad` (`fun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`telefono`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`telefono` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`telefono` (
  `tele_id` INT NOT NULL AUTO_INCREMENT,
  `tele_numero` VARCHAR(45) NOT NULL,
  `tele_tipo` VARCHAR(45) NOT NULL,
  `usu_id` INT NULL,
  PRIMARY KEY (`tele_id`),
  INDEX `fk_teleusu_idx` (`usu_id` ASC),
  CONSTRAINT `fk_teleusu`
    FOREIGN KEY (`usu_id`)
    REFERENCES `asesoria`.`usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`aula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`aula` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`aula` (
  `aula_id` INT NOT NULL AUTO_INCREMENT,
  `aula_numero` VARCHAR(45) NOT NULL,
  `blo_id` INT NOT NULL,
  PRIMARY KEY (`aula_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`estudiante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`estudiante` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`estudiante` (
  `idestudiante` INT NOT NULL AUTO_INCREMENT,
  `usuario_usu_id` INT NOT NULL,
  PRIMARY KEY (`idestudiante`),
  UNIQUE INDEX `idestudiante_UNIQUE` (`idestudiante` ASC),
  INDEX `fk_estudiante_usuario1_idx` (`usuario_usu_id` ASC),
  CONSTRAINT `fk_estudiante_usuario1`
    FOREIGN KEY (`usuario_usu_id`)
    REFERENCES `asesoria`.`usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`asesor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`asesor` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`asesor` (
  `idasesor` INT NOT NULL AUTO_INCREMENT,
  `id_programa` INT NOT NULL,
  `usuario_usu_id` INT NOT NULL,
  PRIMARY KEY (`idasesor`),
  UNIQUE INDEX `idasesor_UNIQUE` (`idasesor` ASC),
  INDEX `fk_asesor_usuario1_idx` (`usuario_usu_id` ASC),
  CONSTRAINT `fk_asesor_usuario1`
    FOREIGN KEY (`usuario_usu_id`)
    REFERENCES `asesoria`.`usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`asignatura` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`asignatura` (
  `idasignatura` INT NOT NULL,
  `descripcion` VARCHAR(40) NULL,
  PRIMARY KEY (`idasignatura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`asesoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`asesoria` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`asesoria` (
  `ase_id` INT NOT NULL AUTO_INCREMENT,
  `ase_fecha` TIMESTAMP NOT NULL,
  `aula_id` INT NOT NULL,
  `cali_id` INT NOT NULL,
  `idestudiante` INT NOT NULL,
  `idasesor` INT NOT NULL,
  `asignatura_idasignatura` INT NOT NULL,
  `calificacion` INT NULL,
  `observacion` VARCHAR(300) NULL,
  PRIMARY KEY (`ase_id`, `ase_fecha`),
  INDEX `fk_asesoria_aula1_idx` (`aula_id` ASC),
  INDEX `fk_asesoria_estudiante1_idx` (`idestudiante` ASC),
  INDEX `fk_asesoria_asesor1_idx` (`idasesor` ASC),
  INDEX `fk_asesoria_asignatura1_idx` (`asignatura_idasignatura` ASC),
  CONSTRAINT `fk_asesoria_aula1`
    FOREIGN KEY (`aula_id`)
    REFERENCES `asesoria`.`aula` (`aula_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesoria_estudiante1`
    FOREIGN KEY (`idestudiante`)
    REFERENCES `asesoria`.`estudiante` (`idestudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesoria_asesor1`
    FOREIGN KEY (`idasesor`)
    REFERENCES `asesoria`.`asesor` (`idasesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesoria_asignatura1`
    FOREIGN KEY (`asignatura_idasignatura`)
    REFERENCES `asesoria`.`asignatura` (`idasignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`dia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`dia` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`dia` (
  `iddia` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`iddia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`hora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`hora` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`hora` (
  `idhora` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idhora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`disponibilidad_asesor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`disponibilidad_asesor` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`disponibilidad_asesor` (
  `id_disponibilidad` INT NOT NULL,
  `dia` INT NOT NULL,
  `hora` INT NOT NULL,
  `asesor` INT NOT NULL,
  PRIMARY KEY (`id_disponibilidad`),
  INDEX `fk_disponibilidad_asesor_dia1_idx` (`dia` ASC),
  INDEX `fk_disponibilidad_asesor_hora1_idx` (`hora` ASC),
  INDEX `fk_disponibilidad_asesor_asesor1_idx` (`asesor` ASC),
  CONSTRAINT `fk_disponibilidad_asesor_dia1`
    FOREIGN KEY (`dia`)
    REFERENCES `asesoria`.`dia` (`iddia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disponibilidad_asesor_hora1`
    FOREIGN KEY (`hora`)
    REFERENCES `asesoria`.`hora` (`idhora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disponibilidad_asesor_asesor1`
    FOREIGN KEY (`asesor`)
    REFERENCES `asesoria`.`asesor` (`idasesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`asesor_asignatura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`asesor_asignatura` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`asesor_asignatura` (
  `idasesor_asignatura` INT NOT NULL AUTO_INCREMENT,
  `asesor_idasesor` INT NOT NULL,
  `asignatura_idasignatura` INT NOT NULL,
  PRIMARY KEY (`idasesor_asignatura`),
  UNIQUE INDEX `idasesor_asignatura_UNIQUE` (`idasesor_asignatura` ASC),
  INDEX `fk_asesor_asignatura_asesor1_idx` (`asesor_idasesor` ASC),
  INDEX `fk_asesor_asignatura_asignatura1_idx` (`asignatura_idasignatura` ASC),
  CONSTRAINT `fk_asesor_asignatura_asesor1`
    FOREIGN KEY (`asesor_idasesor`)
    REFERENCES `asesoria`.`asesor` (`idasesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesor_asignatura_asignatura1`
    FOREIGN KEY (`asignatura_idasignatura`)
    REFERENCES `asesoria`.`asignatura` (`idasignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesoria`.`usuario_has_rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asesoria`.`usuario_has_rol` ;

CREATE TABLE IF NOT EXISTS `asesoria`.`usuario_has_rol` (
  `usuario_usu_id` INT NOT NULL,
  `rol_rol_id` INT NOT NULL,
  PRIMARY KEY (`usuario_usu_id`, `rol_rol_id`),
  INDEX `fk_usuario_has_rol_rol1_idx` (`rol_rol_id` ASC),
  INDEX `fk_usuario_has_rol_usuario1_idx` (`usuario_usu_id` ASC),
  CONSTRAINT `fk_usuario_has_rol_usuario1`
    FOREIGN KEY (`usuario_usu_id`)
    REFERENCES `asesoria`.`usuario` (`usu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_rol_rol1`
    FOREIGN KEY (`rol_rol_id`)
    REFERENCES `asesoria`.`rol` (`rol_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
