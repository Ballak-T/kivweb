-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Počítač: localhost
-- Vytvořeno: Pon 27. lis 2017, 23:26
-- Verze serveru: 5.7.20-0ubuntu0.16.04.1
-- Verze PHP: 7.0.25-1+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `konference`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `Post`
--

CREATE TABLE `Post` (
  `idPost` int(11) NOT NULL,
  `topic` varchar(45) NOT NULL,
  `content` longtext NOT NULL,
  `author` varchar(45) NOT NULL,
  `filename` varchar(45) DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `User_idUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `Post`
--

INSERT INTO `Post` (`idPost`, `topic`, `content`, `author`, `filename`, `accepted`, `User_idUser`) VALUES
(2, 'Prispevek Novy', 'dasdasdasdsdsadasd', 'testing', '', 0, 3),
(3, 'laskdůlsad', 'sdůlfksdlfůsfd', 'testing', 'uploads/3/jen zpravodaj.pdf', 0, 3),
(4, 'erkwelkrlůewkrw', 'ůlkerůkerltůker', 'testing', '', 0, 3),
(5, 'erkwelkrlůewkrw', 'ůlkerůkerltůker', 'testing', '', 0, 3),
(6, 'sdfsdfsdf', 'sdfsdfsdf', 'testing', '', 0, 3),
(7, 'XXXXXXXX', 'XXXXXXXXXXXX', 'testing', '', 0, 3),
(8, 'LOOOOOOOOOOOOOL', 'asdasdasdasdadasdsda', 'testing', '', 0, 3);

-- --------------------------------------------------------

--
-- Struktura tabulky `Post_has_Review`
--

CREATE TABLE `Post_has_Review` (
  `Post_idPost` int(11) NOT NULL,
  `Review_idReview` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `Post_has_Review`
--

INSERT INTO `Post_has_Review` (`Post_idPost`, `Review_idReview`) VALUES
(2, 1),
(8, 2),
(5, 3);

-- --------------------------------------------------------

--
-- Struktura tabulky `Review`
--

CREATE TABLE `Review` (
  `idReview` int(11) NOT NULL,
  `originality` int(1) NOT NULL,
  `topic` int(1) NOT NULL,
  `technique` int(1) NOT NULL,
  `language` int(1) NOT NULL,
  `recommendation` int(1) NOT NULL,
  `comment` varchar(45) NOT NULL,
  `User_idUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `Review`
--

INSERT INTO `Review` (`idReview`, `originality`, `topic`, `technique`, `language`, `recommendation`, `comment`, `User_idUser`) VALUES
(1, 1, 1, 1, 1, 1, 'dsfsdfsf', 4),
(2, 1, 1, 1, 1, 4, 'adssadasdsada', 4),
(3, 1, 1, 1, 1, 1, 'ejtlkjerlkjlektjlektjlertj', 4);

-- --------------------------------------------------------

--
-- Struktura tabulky `Task`
--

CREATE TABLE `Task` (
  `idTask` int(11) NOT NULL,
  `Post_idPost` int(11) NOT NULL,
  `Made` tinyint(1) NOT NULL,
  `User_idUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `Task`
--

INSERT INTO `Task` (`idTask`, `Post_idPost`, `Made`, `User_idUser`) VALUES
(1, 2, 1, 4),
(2, 3, 0, 4),
(3, 4, 0, 4),
(4, 5, 1, 4),
(5, 8, 1, 4);

-- --------------------------------------------------------

--
-- Struktura tabulky `Type`
--

CREATE TABLE `Type` (
  `idType` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabulky `User`
--

CREATE TABLE `User` (
  `idUser` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(80) NOT NULL,
  `status` varchar(45) NOT NULL,
  `ban` tinyint(1) NOT NULL,
  `man` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `User`
--

INSERT INTO `User` (`idUser`, `name`, `email`, `password`, `status`, `ban`, `man`) VALUES
(1, 'admin', 'admin@email.cz', '$2y$10$bvMX0iyMXMvyxEBq1QjDSucDf21Qi3I1lltyS/.uh4W93EtM1bi32', '3', 0, 1),
(2, 'test', 'balllak.tomas@gmail.com', '$2y$10$B/E992QdKi1pY7RmfKDcPeAxgj.Nj9/TsWeNNYud376uuh4fmfnFK', '2', 0, 1),
(3, 'testing', 'test@test.cz', '$2y$10$upNS1.b7A4IlAgzwu3RxhOYX4YZRGuPY2KJzxYTkCwIZjntw7A/k6', '1', 0, 0),
(4, 'recenzent', 'recenzent@email.cz', '$2y$10$hemBvxwlrteH0RJciacHD.PldIlFpUir8HFbiCnK7X6PxVtHGgGdu', '2', 0, 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `User_has_Type`
--

CREATE TABLE `User_has_Type` (
  `User_idUser` int(11) NOT NULL,
  `Type_idType` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `Post`
--
ALTER TABLE `Post`
  ADD PRIMARY KEY (`idPost`),
  ADD KEY `fk_Post_User1_idx` (`User_idUser`);

--
-- Klíče pro tabulku `Post_has_Review`
--
ALTER TABLE `Post_has_Review`
  ADD PRIMARY KEY (`Post_idPost`,`Review_idReview`),
  ADD KEY `fk_Post_has_Review_Review1_idx` (`Review_idReview`),
  ADD KEY `fk_Post_has_Review_Post1_idx` (`Post_idPost`);

--
-- Klíče pro tabulku `Review`
--
ALTER TABLE `Review`
  ADD PRIMARY KEY (`idReview`),
  ADD KEY `fk_Review_User1_idx` (`User_idUser`);

--
-- Klíče pro tabulku `Task`
--
ALTER TABLE `Task`
  ADD PRIMARY KEY (`idTask`),
  ADD KEY `fk_Task_User1_idx` (`User_idUser`),
  ADD KEY `fk_Task_Post1` (`Post_idPost`);

--
-- Klíče pro tabulku `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`idType`);

--
-- Klíče pro tabulku `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`idUser`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `Post`
--
ALTER TABLE `Post`
  MODIFY `idPost` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT pro tabulku `Review`
--
ALTER TABLE `Review`
  MODIFY `idReview` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pro tabulku `Task`
--
ALTER TABLE `Task`
  MODIFY `idTask` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pro tabulku `Type`
--
ALTER TABLE `Type`
  MODIFY `idType` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pro tabulku `User`
--
ALTER TABLE `User`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `Post`
--
ALTER TABLE `Post`
  ADD CONSTRAINT `fk_Post_User1` FOREIGN KEY (`User_idUser`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `Post_has_Review`
--
ALTER TABLE `Post_has_Review`
  ADD CONSTRAINT `fk_Post_has_Review_Post1` FOREIGN KEY (`Post_idPost`) REFERENCES `Post` (`idPost`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Report_has_Review_Review1` FOREIGN KEY (`Review_idReview`) REFERENCES `Review` (`idReview`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `Review`
--
ALTER TABLE `Review`
  ADD CONSTRAINT `fk_Review_User1` FOREIGN KEY (`User_idUser`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Omezení pro tabulku `Task`
--
ALTER TABLE `Task`
  ADD CONSTRAINT `fk_Task_Post1` FOREIGN KEY (`Post_idPost`) REFERENCES `Post` (`idPost`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Task_User1` FOREIGN KEY (`User_idUser`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
