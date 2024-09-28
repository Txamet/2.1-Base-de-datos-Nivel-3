USE `youtube` ;

INSERT INTO `youtube`.`usuarios` (`email`, `password`, `nombre`, `fecha_nacimiento`, `sexo`, `pais`, `codigo_postal`)
VALUES 
('juan.perez@gmail.com', 'pass123', 'Juan Pérez', '1990-05-12', 'hombre', 'México', '11000'),
('maria.lopez@gmail.com', 'pass456', 'María López', '1985-10-25', 'mujer', 'Argentina', 'C1000'),
('carlos.gomez@gmail.com', 'pass789', 'Carlos Gómez', '1995-08-18', 'hombre', 'España', '28001'),
('ana.sanchez@gmail.com', 'pass321', 'Ana Sánchez', '2000-07-30', 'mujer', 'Colombia', '111221');

INSERT INTO `youtube`.`videos` (`titulo`, `descripcion`, `tamano_archivo`, `nombre_archivo`, `duracion`, `thumbnail`, `total_reproducciones`, `total_likes`, `total_dislikes`, `fecha_creacion`, `estado`, `id_usuario`)
VALUES 
('Cómo hacer una pizza', 'Video tutorial de cocina', 500.25, 'pizza.mp4', '00:10:35', NULL, 1000, 250, 10, '2023-09-15 14:30:00', 'publico', 1),
('Viaje a las montañas', 'Un vlog sobre viajes', 300.10, 'montanas.mp4', '00:08:20', NULL, 1200, 300, 25, '2023-09-20 10:10:00', 'publico', 2),
('Curso de programación', 'Aprende a programar en Python', 800.60, 'python.mp4', '00:15:45', NULL, 5000, 1500, 45, '2023-08-10 09:45:00', 'privado', 3);

INSERT INTO `youtube`.`canales` (`nombre`, `descripcion`, `fecha_creacion`, `id_usuario`)
VALUES 
('Cocina Fácil', 'Recetas sencillas y rápidas', '2020-01-15', 1),
('Viajes y Aventura', 'Explorando el mundo', '2021-05-22', 2),
('Código Maestro', 'Tutoriales de programación', '2019-10-01', 3);

INSERT INTO `youtube`.`suscripciones` (`id_canal`, `id_usuario`)
VALUES 
(1, 2), 
(2, 1), 
(3, 4);

INSERT INTO `youvaloracion_videostube`.`etiquetas` (`nombre`)
VALUES 
('cocina'), 
('viajes'), 
('programación'), 
('tutorial');

INSERT INTO `youtube`.`valoracion_videos` (`valoracion`, `fecha`, `id_video`, `id_usuario`)
VALUES 
('like', '2023-09-16 10:30:00', 1, 2), 
('dislike', '2023-09-17 12:15:00', 2, 3),
('like', '2023-09-18 09:00:00', 3, 1);

INSERT INTO `youtube`.`comentarios` (`texto`, `fecha`, `id_usuario`, `id_video`)
VALUES 
('Excelente video, muy útil!', '2023-09-16 10:45:00', 2, 1), 
('Me encantó el viaje!', '2023-09-17 12:30:00', 1, 2),
('Muy buen tutorial, gracias!', '2023-09-18 09:15:00', 4, 3);

INSERT INTO `youtube`.`valoracion_comentarios` (`valoracion`, `fecha`, `id_usuario`, `id_comentario`)
VALUES 
('like', '2023-09-16 11:00:00', 1, 1), 
('dislike', '2023-09-17 12:45:00', 3, 2),
('like', '2023-09-18 09:30:00', 2, 3);

INSERT INTO `youtube`.`playlists` (`nombre`, `fecha_creacion`, `estado`, `id_usuario`, `id_video`)
VALUES 
('Recetas Fáciles', '2023-09-19', 'publico', 1, 1), 
('Lugares por Explorar', '2023-09-20', 'privado', 2, 2),
('Aprende Python', '2023-09-21', 'publico', 3, 3);

INSERT INTO `youtube`.`etiquetas_en_videos` (`id_video`, `id_etiqueta`)
VALUES 
(1, 1), 
(2, 2), 
(3, 3);



