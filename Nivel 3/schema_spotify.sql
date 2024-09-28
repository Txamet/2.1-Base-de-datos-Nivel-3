
DROP SCHEMA IF EXISTS `Spotify` ;
CREATE SCHEMA IF NOT EXISTS `Spotify` DEFAULT CHARACTER SET utf8 ;
USE `Spotify` ;

CREATE TABLE IF NOT EXISTS `Spotify`.`usuarios` (
  `id_usuario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM("hombre", "mujer") NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `tipo` ENUM("free", "premium") NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `idUsuarios_UNIQUE` (`id_usuario` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`suscripciones` (
  `id_suscripcion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATE NOT NULL,
  `fecha_renovacion` DATE NOT NULL,
  `forma_pago` ENUM("tarjeta", "paypal") NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_suscripcion`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `id_suscripcion_UNIQUE` (`id_suscripcion` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_suscripciones`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`tarjetas_credito` (
  `id_tarjeta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero` INT UNSIGNED NOT NULL,
  `caducidad` VARCHAR(5) NOT NULL,
  `codigo_seguridad` VARCHAR(5) NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `id_tarjeta_UNIQUE` (`id_tarjeta` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_tarjetas`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`paypal` (
  `id_paypal` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_paypal`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `id_paypal_UNIQUE` (`id_paypal` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_paypal`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`pagos` (
  `id_pago` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `importe` FLOAT NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_pago`),
  INDEX `fK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `id_pago_UNIQUE` (`id_pago` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_pagos`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`playlists` (
  `id_playlist` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `numero_canciones` INT UNSIGNED NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `fecha_eliminacion` DATE NOT NULL,
  `estado` ENUM("activa", "borrada") NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `idPlaylists_UNIQUE` (`id_playlist` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_playlists`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`artistas` (
  `id_artista` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `imagen` BLOB NULL,
  PRIMARY KEY (`id_artista`),
  UNIQUE INDEX `id_artista_UNIQUE` (`id_artista` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`albumes` (
  `id_album` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `fecha_publicacion` YEAR NOT NULL,
  `imagen` BLOB NULL,
  `id_artista` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_album`),
  INDEX `FK_idArtista_idx` (`id_artista` ASC) VISIBLE,
  UNIQUE INDEX `id_album_UNIQUE` (`id_album` ASC) VISIBLE,
  CONSTRAINT `FK_id_artista_albumes`
    FOREIGN KEY (`id_artista`)
    REFERENCES `Spotify`.`artistas` (`id_artista`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`canciones` (
  `id_cancion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `reproducciones` INT UNSIGNED NOT NULL,
  `id_album` INT UNSIGNED NOT NULL,
  `id_artista` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_cancion`),
  INDEX `FK_idÁlbum_idx` (`id_album` ASC) VISIBLE,
  INDEX `FK_idArtista_idx` (`id_artista` ASC) VISIBLE,
  UNIQUE INDEX `id_cancion_UNIQUE` (`id_cancion` ASC) VISIBLE,
  CONSTRAINT `FK_id_album_canciones`
    FOREIGN KEY (`id_album`)
    REFERENCES `Spotify`.`albumes` (`id_album`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_artista_canciones`
    FOREIGN KEY (`id_artista`)
    REFERENCES `Spotify`.`artistas` (`id_artista`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`canciones_playlist` (
  `id_canciones_playlist` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_cancion` INT UNSIGNED NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `id_playlist` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_canciones_playlist`),
  INDEX `fK_idCanciones_idx` (`id_cancion` ASC) VISIBLE,
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_idPlaylists_idx` (`id_playlist` ASC) VISIBLE,
  UNIQUE INDEX `idCanciones de Playlist_UNIQUE` (`id_canciones_playlist` ASC) VISIBLE,
  CONSTRAINT `FK_id_cancion_cp`
    FOREIGN KEY (`id_cancion`)
    REFERENCES `Spotify`.`canciones` (`id_cancion`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_usuario_cp`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_playlist_cp`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `Spotify`.`playlists` (`id_playlist`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`artistas_seguidos` (
  `idArtistas seguidos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_artista` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idArtistas seguidos`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_idArtista_idx` (`id_artista` ASC) VISIBLE,
  UNIQUE INDEX `idArtistas seguidos_UNIQUE` (`idArtistas seguidos` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_as`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_artista_as`
    FOREIGN KEY (`id_artista`)
    REFERENCES `Spotify`.`artistas` (`id_artista`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`albumes_favoritos` (
  `id_favoritos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_album` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_favoritos`),
  UNIQUE INDEX `id_favoritos_UNIQUE` (`id_favoritos` ASC) VISIBLE,
  INDEX `FK_id_usuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_id_album_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_af`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_album_af`
    FOREIGN KEY (`id_album`)
    REFERENCES `Spotify`.`albumes` (`id_album`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`canciones_favoritas` (
  `id_favoritos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_cancion` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_favoritos`),
  UNIQUE INDEX `id_favoritos_UNIQUE` (`id_favoritos` ASC) VISIBLE,
  INDEX `FK_id_usuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_id_cancion_idx` (`id_cancion` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_cf`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Spotify`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_cancion_cf`
    FOREIGN KEY (`id_cancion`)
    REFERENCES `Spotify`.`canciones` (`id_cancion`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`genero` (
  `id_genero` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_genero`),
  UNIQUE INDEX `id_genero_UNIQUE` (`id_genero` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Spotify`.`artistas_relacionados` (
  `id_relacion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_artista` INT UNSIGNED NOT NULL,
  `id_genero` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_relacion`),
  UNIQUE INDEX `id_relacion_UNIQUE` (`id_relacion` ASC) VISIBLE,
  INDEX `FK_id_artista_idx` (`id_artista` ASC) VISIBLE,
  INDEX `FK_id_genero_idx` (`id_genero` ASC) VISIBLE,
  CONSTRAINT `FK_id_artista_ar`
    FOREIGN KEY (`id_artista`)
    REFERENCES `Spotify`.`artistas` (`id_artista`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_genero_ar`
    FOREIGN KEY (`id_genero`)
    REFERENCES `Spotify`.`genero` (`id_genero`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;
