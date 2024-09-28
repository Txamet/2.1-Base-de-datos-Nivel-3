USE `Spotify` ;

INSERT INTO `Spotify`.`usuarios` (`email`, `password`, `fecha_nacimiento`, `sexo`, `pais`, `codigo_postal`, `tipo`)
VALUES 
('juan.perez@gmail.com', 'password123', '1990-05-21', 'hombre', 'España', '28001', 'premium'),
('maria.gomez@gmail.com', 'pass456', '1985-10-10', 'mujer', 'México', '10010', 'free'),
('pedro.lopez@gmail.com', 'pass789', '1995-03-15', 'hombre', 'Argentina', '50000', 'free');

INSERT INTO `Spotify`.`suscripciones` (`fecha_inicio`, `fecha_renovacion`, `forma_pago`, `id_usuario`)
VALUES 
('2022-01-01', '2023-01-01', 'tarjeta', 1),
('2023-03-10', '2024-03-10', 'paypal', 2);

INSERT INTO `Spotify`.`tarjetas_credito` (`numero`, `caducidad`, `codigo_seguridad`, `id_usuario`)
VALUES 
(123456, '12/25', '123', 1);

INSERT INTO `Spotify`.`paypal` (`nombre_usuario`, `id_usuario`)
VALUES 
('mariagomez23', 2);

INSERT INTO `Spotify`.`pagos` (`fecha`, `importe`, `id_usuario`)
VALUES 
('2023-01-01 10:00:00', 9.99, 1),
('2023-03-10 11:00:00', 9.99, 2);

INSERT INTO `Spotify`.`playlists` (`titulo`, `numero_canciones`, `fecha_creacion`, `fecha_eliminacion`, `estado`, `id_usuario`)
VALUES 
('Mis Favoritas', 20, '2023-01-01', '2023-12-31', 'activa', 1),
('Rock Clásico', 15, '2022-05-15', '2023-05-15', 'borrada', 2);

INSERT INTO `Spotify`.`artistas` (`nombre`)
VALUES 
('The Beatles'),
('Queen'),
('Adele');

INSERT INTO `Spotify`.`albumes` (`titulo`, `fecha_publicacion`, `id_artista`)
VALUES 
('Abbey Road', 1969, 1),
('A Night at the Opera', 1975, 2),
('25', 2015, 3);

INSERT INTO `Spotify`.`canciones` (`titulo`, `duracion`, `reproducciones`, `id_album`, `id_artista`)
VALUES 
('Here Comes the Sun', '00:03:05', 1500000, 1, 1),
('Bohemian Rhapsody', '00:05:55', 3000000, 2, 2),
('Hello', '00:04:55', 2500000, 3, 3);

INSERT INTO `Spotify`.`canciones_playlist` (`id_cancion`, `id_usuario`, `fecha_ingreso`, `id_playlist`)
VALUES 
(1, 1, '2023-01-02', 1),
(2, 1, '2023-01-03', 1),
(3, 2, '2022-05-16', 2);

INSERT INTO `Spotify`.`artistas_seguidos` (`id_usuario`, `id_artista`)
VALUES 
(1, 1),
(2, 3);

INSERT INTO `Spotify`.`albumes_favoritos` (`id_usuario`, `id_album`)
VALUES 
(1, 1),
(2, 3);

INSERT INTO `Spotify`.`canciones_favoritas` (`id_usuario`, `id_cancion`)
VALUES 
(1, 1),
(2, 3);

INSERT INTO `Spotify`.`genero` (`nombre`)
VALUES 
('Rock'),
('Pop'),
('Soul');

INSERT INTO `Spotify`.`artistas_relacionados` (`id_artista`, `id_genero`)
VALUES 
(1, 1), -- The Beatles - Rock
(2, 1), -- Queen - Rock
(3, 2); -- Adele - Pop