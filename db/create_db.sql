
-- -----------------------------------------------------
-- Schema konference
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `konference` DEFAULT CHARACTER SET utf8 ;
USE `konference` ;

-- -----------------------------------------------------
-- Table `konference`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `konference`.`User` ;

CREATE TABLE IF NOT EXISTS `konference`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(80) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `ban` TINYINT(1) NOT NULL,
  `man` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `konference`.`Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `konference`.`Type` ;

CREATE TABLE IF NOT EXISTS `konference`.`Type` (
  `idType` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `konference`.`User_has_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `konference`.`User_has_Type` ;

CREATE TABLE IF NOT EXISTS `konference`.`User_has_Type` (
  `User_idUser` INT NOT NULL,
  `Type_idType` INT NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `konference`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `konference`.`Post` ;

CREATE TABLE IF NOT EXISTS `konference`.`Post` (
  `idPost` INT NOT NULL AUTO_INCREMENT,
  `topic` VARCHAR(45) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `filename` VARCHAR(45) NULL,
  `accepted` TINYINT(1) NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idPost`),
  INDEX `fk_Post_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_Post_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `konference`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `konference`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `konference`.`Review` ;

CREATE TABLE IF NOT EXISTS `konference`.`Review` (
  `idReview` INT NOT NULL AUTO_INCREMENT,
  `originality` INT(1) NOT NULL,
  `topic` INT(1) NOT NULL,
  `technique` INT(1) NOT NULL,
  `language` INT(1) NOT NULL,
  `recommendation` INT(1) NOT NULL,
  `comment` VARCHAR(45) NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idReview`),
  INDEX `fk_Review_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_Review_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `konference`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `konference`.`Post_has_Review` (
  `Post_idPost` INT NOT NULL,
  `Review_idReview` INT NOT NULL,
  PRIMARY KEY (`Post_idPost`, `Review_idReview`),
  INDEX `fk_Post_has_Review_Review1_idx` (`Review_idReview` ASC),
  INDEX `fk_Post_has_Review_Post1_idx` (`Post_idPost` ASC),
  CONSTRAINT `fk_Post_has_Review_Post1`
    FOREIGN KEY (`Post_idPost`)
    REFERENCES `konference`.`Post` (`idPost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Report_has_Review_Review1`
    FOREIGN KEY (`Review_idReview`)
    REFERENCES `konference`.`Review` (`idReview`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `konference`.`Task` (
  `idTask` INT NOT NULL AUTO_INCREMENT,
  `Post_idPost` INT NOT NULL,
  `Made` TINYINT(1) NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idTask`),
  INDEX `fk_Task_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_Task_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `konference`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Task_Post1`
    FOREIGN KEY (`Post_idPost`)
    REFERENCES `konference`.`Post` (`idPost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO `konference`.`User` (`name`, `email`, `password`, `status`, `ban`, `man`)
VALUES ('admin','admin@email.cz','$2y$10$bvMX0iyMXMvyxEBq1QjDSucDf21Qi3I1lltyS/.uh4W93EtM1bi32','3',0,1);
