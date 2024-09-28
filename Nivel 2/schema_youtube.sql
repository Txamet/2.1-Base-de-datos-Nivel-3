
DROP SCHEMA IF EXISTS `youtube` ;
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

CREATE TABLE IF NOT EXISTS `youtube`.`usuarios` (
  `id_usuario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM("hombre", "mujer") NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `id_usuario_UNIQUE` (`id_usuario` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `id_video` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `tamano_archivo` FLOAT UNSIGNED NOT NULL,
  `nombre_archivo` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `thumbnail` LONGTEXT NULL,
  `total_reproducciones` INT UNSIGNED NULL,
  `total_likes` INT UNSIGNED NULL,
  `total_dislikes` INT UNSIGNED NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `estado` ENUM("publico", "oculto", "privado") NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_video`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `id_video_UNIQUE` (`id_video` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_videos`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`etiquetas` (
  `id_etiqueta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_etiqueta`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`canales` (
  `id_canal` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_canal`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `id_canal_UNIQUE` (`id_canal` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_canal`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`suscripciones` (
  `id_suscripcion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_canal` INT UNSIGNED NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_suscripcion`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_idCanal_idx` (`id_canal` ASC) VISIBLE,
  CONSTRAINT `FK_id_canal_suscripciones`
    FOREIGN KEY (`id_canal`)
    REFERENCES `youtube`.`canales` (`id_canal`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_usuario_suscripciones`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`valoracion_videos` (
  `id_valoracion_video` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `valoracion` ENUM("like", "dislike") NOT NULL,
  `fecha` DATETIME NOT NULL,
  `id_video` INT UNSIGNED NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_valoracion_video`),
  INDEX `FK_idVídeo_idx` (`id_video` ASC) VISIBLE,
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `FK_id_video_vv`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_usuario_vv`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`playlists` (
  `id_playlist` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `estado` ENUM("publico", "privado") NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_video` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_playlist`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_idVídeo_idx` (`id_video` ASC) VISIBLE,
  UNIQUE INDEX `id_playlist_UNIQUE` (`id_playlist` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_playlists`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_video_playlists`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`comentarios` (
  `id_comentario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `texto` VARCHAR(500) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_video` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_comentario`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_idVídeo_idx` (`id_video` ASC) VISIBLE,
  UNIQUE INDEX `id_comentario_UNIQUE` (`id_comentario` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_comentarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_video_comentarios`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`valoracion_comentarios` (
  `id_valoracion_comentario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `valoracion` ENUM("like", "dislike") NOT NULL,
  `fecha` DATETIME NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_comentario` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_valoracion_comentario`),
  INDEX `FK_idUsuario_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `FK_idComentario_idx` (`id_comentario` ASC) VISIBLE,
  CONSTRAINT `FK_id_usuario_vc`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `youtube`.`usuarios` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_comentario_vc`
    FOREIGN KEY (`id_comentario`)
    REFERENCES `youtube`.`comentarios` (`id_comentario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `youtube`.`etiquetas_en_videos` (
  `id_video` INT UNSIGNED NOT NULL,
  `id_etiqueta` INT UNSIGNED NOT NULL,
  UNIQUE INDEX `id_video_UNIQUE` (`id_video` ASC) VISIBLE,
  UNIQUE INDEX `id_etiqueta_UNIQUE` (`id_etiqueta` ASC) VISIBLE,
  CONSTRAINT `FK_id_video_eev`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`videos` (`id_video`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_id_etiqueta_eev`
    FOREIGN KEY (`id_etiqueta`)
    REFERENCES `youtube`.`etiquetas` (`id_etiqueta`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;
