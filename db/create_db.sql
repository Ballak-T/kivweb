
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
  `User_idUser` INT,
  PRIMARY KEY (`idPost`))
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
  PRIMARY KEY (`idReview`))
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
  PRIMARY KEY (`idTask`))
ENGINE = InnoDB;


INSERT INTO `Post` (`idPost`, `topic`, `content`, `author`, `filename`, `accepted`, `User_idUser`) VALUES
(2, 'Prispevek Novy', 'dasdasdasdsdsadasd', 'testing', '', 0, 3),
(3, 'laskdůlsad', 'sdůlfksdlfůsfd', 'testing', 'uploads/3/jen zpravodaj.pdf', 0, 3),
(4, 'erkwelkrlůewkrw', 'ůlkerůkerltůker', 'testing', '', 0, 3),
(5, 'erkwelkrlůewkrw', 'ůlkerůkerltůker', 'testing', '', 0, 3),
(6, 'sdfsdfsdf', 'sdfsdfsdf', 'testing', '', 0, 3),
(7, 'XXXXXXXX', 'XXXXXXXXXXXX', 'testing', '', 0, 3),
(8, 'LOOOOOOOOOOOOOL', 'asdasdasdasdadasdsda', 'testing', '', 0, 3);

INSERT INTO `Review` (`idReview`, `originality`, `topic`, `technique`, `language`, `recommendation`, `comment`, `User_idUser`) VALUES
(1, 1, 1, 1, 1, 1, 'dsfsdfsf', 4),
(2, 1, 1, 1, 1, 4, 'adssadasdsada', 4),
(3, 1, 1, 1, 1, 1, 'ejtlkjerlkjlektjlektjlertj', 4);

INSERT INTO `Task` (`idTask`, `Post_idPost`, `Made`, `User_idUser`) VALUES
(1, 2, 1, 4),
(2, 3, 0, 4),
(3, 4, 0, 4),
(4, 5, 1, 4),
(5, 8, 1, 4);

INSERT INTO `User` (`idUser`, `name`, `email`, `password`, `status`, `ban`, `man`) VALUES
(1, 'admin', 'admin@email.cz', '$2y$10$bvMX0iyMXMvyxEBq1QjDSucDf21Qi3I1lltyS/.uh4W93EtM1bi32', '3', 0, 1),
(2, 'test', 'balllak.tomas@gmail.com', '$2y$10$B/E992QdKi1pY7RmfKDcPeAxgj.Nj9/TsWeNNYud376uuh4fmfnFK', '2', 0, 1),
(3, 'testing', 'test@test.cz', '$2y$10$upNS1.b7A4IlAgzwu3RxhOYX4YZRGuPY2KJzxYTkCwIZjntw7A/k6', '1', 0, 0),
(4, 'recenzent', 'recenzent@email.cz', '$2y$10$hemBvxwlrteH0RJciacHD.PldIlFpUir8HFbiCnK7X6PxVtHGgGdu', '2', 0, 1);
