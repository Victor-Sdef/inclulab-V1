-- Crear la base de datos (si no existe) y seleccionarla
CREATE DATABASE IF NOT EXISTS inclulab 
  DEFAULT CHARACTER SET utf8mb4 
  DEFAULT COLLATE utf8mb4_general_ci;
USE inclulab;

-- Guardar el estado actual de FOREIGN_KEY_CHECKS y desactivarlo temporalmente
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminar las tablas en orden inverso a las dependencias
DROP TABLE IF EXISTS respuestas;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS discapacidad;
DROP TABLE IF EXISTS estado;

-- 1. Tabla de Estados (para relación con usuarios)
CREATE TABLE estado (
    id_estado INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT DEFAULT NULL,
    PRIMARY KEY (id_estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Tabla de Discapacidad (para relación con usuarios)
CREATE TABLE discapacidad (
    id_discapacidad INT(11) NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_discapacidad)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Tabla Usuarios (con claves foráneas hacia discapacidad y estado)
CREATE TABLE usuarios (
    id_usuario INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    id_discapacidad INT(11) NOT NULL,
    id_estado INT(11) NOT NULL,
    id_estado_rol INT(11) NOT NULL,
    PRIMARY KEY (id_usuario),
    UNIQUE KEY unique_email (email),
    UNIQUE KEY unique_nombre (nombre),
    KEY fk_usuarios_discapacidad (id_discapacidad),
    KEY fk_usuarios_estado (id_estado),
    KEY fk_usuarios_estado_rol (id_estado_rol),
    CONSTRAINT usuarios_fk_discapacidad FOREIGN KEY (id_discapacidad) REFERENCES discapacidad(id_discapacidad) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT usuarios_fk_estado FOREIGN KEY (id_estado) REFERENCES estado(id_estado) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT usuarios_fk_estado_rol FOREIGN KEY (id_estado_rol) REFERENCES estado(id_estado) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Tabla Respuestas (almacena la pregunta y la respuesta del usuario)
DROP TABLE IF EXISTS respuestas;
CREATE TABLE respuestas (
  id_respuesta INT(11) NOT NULL AUTO_INCREMENT,
  id_usuario INT(11) NOT NULL,
  departamento TEXT NOT NULL,  
  cargo_laboral TEXT NOT NULL,  
  ejercicio INT NOT NULL,  
  titulo_ejercicio TEXT NOT NULL,
  contexto_ejercicio TEXT NOT NULL,  
  pregunta TEXT NOT NULL,       -- Texto de la pregunta
  respuesta TEXT NOT NULL,       -- Respuesta dada por el usuario
  respuestaCorrectaoNo TEXT NOT NULL,       -- Respuesta dada por el usuario
  Discapacidad TEXT NOT NULL, 
  fecha_respuesta DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_respuesta),
  KEY fk_respuestas_usuario (id_usuario),
  CONSTRAINT respuestas_fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS preguntasYrespuestas;

-- Crear la tabla preguntasYrespuestas
CREATE TABLE preguntasYrespuestas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_departamento VARCHAR(255) NOT NULL,    -- Por ejemplo: "Departamento De Gerencia General"
    cargo_laboral VARCHAR(255) NOT NULL,          -- Ejemplo: "Asistente de Gerencia"
    ejercicio INT NOT NULL,                       -- Número de ejercicio (1, 2, 3, etc.)
    pregunta TEXT NOT NULL,                       -- Enunciado o texto de la pregunta
    respuesta TEXT NOT NULL,                      -- Respuesta proporcionada o solución
    fecha_respuesta DATETIME DEFAULT CURRENT_TIMESTAMP  -- Fecha y hora de inserción
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE encuesta (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  prefijoDepartamento VARCHAR(100) NOT NULL,
  prefijoCargo VARCHAR(100) NOT NULL,
  prefijoDiscapacidad VARCHAR(100) NOT NULL,
  competencia VARCHAR(255) NOT NULL,
  pregunta TEXT NOT NULL,
  no_hay_problema VARCHAR(50) DEFAULT NULL,
  problema_leve VARCHAR(50) DEFAULT NULL,
  problema_moderado VARCHAR(50) DEFAULT NULL,
  problema_grave VARCHAR(50) DEFAULT NULL,
  problema_completo VARCHAR(50) DEFAULT NULL,
  fecha DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Restaurar la configuración original de FOREIGN_KEY_CHECKS
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

                        -- ============================================================
                        -- Bloque de inserción para Departamento De Gerencia General
                        -- ============================================================
-- =========================
-- Asistente de Gerencia
-- =========================
-- Ejercicio 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) Respuesta correcta'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Qué se infiere de esta información?', 'B) Respuesta correcta'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿En qué consistió la trampa del comerciante?', 'B) Respuesta correcta');

-- Ejercicio 2: Competencia de Escritura
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente de Gerencia', 2, 'Orden final de palabras', 'd,c,a,b,e');

-- Ejercicio 3: Organización y Recopilación de la Información (Reactivo de Matrices)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente de Gerencia', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A');

-- Ejercicio 4: Organización y Recopilación de la Información (Analogías verbales)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente de Gerencia', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua');

-- Ejercicio 5: Competencia de Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente de Gerencia', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 5, 'Rompecabezas 2x2: Valor del slot', 'B'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A');

-- Ejercicio 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Qué se infiere de esta información?', 'B) Que la abuela pidió 1 metro adicional para el quinto moño'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿En qué consistió la trampa del comerciante?', 'B) Sacó la pieza de cinta, cortó 10 metros y se los entregó');

-- Ejercicio 2: Competencia de Escritura
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 2, 'Orden final de palabras', 'd,c,a,b,e');

-- Ejercicio 3: Organización y Recopilación de la Información (Reactivo de Matrices)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A');

-- Ejercicio 4: Organización y Recopilación de la Información (Analogías verbales)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua');

-- Ejercicio 5: Competencia de Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, 'Rompecabezas 2x2: Valor del slot', 'B'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A');

-- =============================
-- Jefe Coordinador Jurídico
-- =============================
-- Ejercicio 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) Respuesta correcta'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Qué se infiere de esta información?', 'B) Respuesta correcta'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿En qué consistió la trampa del comerciante?', 'B) Respuesta correcta');

-- Ejercicio 2: Competencia de Escritura
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 2, 'Orden final de palabras', 'd,c,a,b,e');

-- Ejercicio 3: Organización y Recopilación de la Información (Reactivo de Matrices)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A');

-- Ejercicio 4: Organización y Recopilación de la Información (Analogías verbales)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua');

-- Ejercicio 5: Competencia de Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, 'Rompecabezas 2x2: Valor del slot', 'B'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A');   

-- =========================================
-- Asistente De Comunicación Organizacional
-- =========================================
-- Ejercicio 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) Respuesta correcta'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Qué se infiere de esta información?', 'B) Respuesta correcta'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿En qué consistió la trampa del comerciante?', 'B) Respuesta correcta');

-- Ejercicio 2: Competencia de Escritura
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 2, 'Orden final de palabras', 'd,c,a,b,e');

-- Ejercicio 3: Organización y Recopilación de la Información (Reactivo de Matrices)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A');

-- Ejercicio 4: Organización y Recopilación de la Información (Analogías verbales)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua');

-- Ejercicio 5: Competencia de Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, 'Rompecabezas 2x2: Valor del slot', 'B'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A');

-- =========================================
-- Asistente Jurídico
-- =========================================
-- Ejercicio 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) Respuesta correcta'),
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Qué se infiere de esta información?', 'B) Respuesta correcta'),
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿En qué consistió la trampa del comerciante?', 'B) Respuesta correcta');

-- Ejercicio 2: Competencia de Escritura
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente Jurídico', 2, 'Orden final de palabras', 'd,c,a,b,e');

-- Ejercicio 3: Organización y Recopilación de la Información (Reactivo de Matrices)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente Jurídico', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A');

-- Ejercicio 4: Organización y Recopilación de la Información (Analogías verbales)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente Jurídico', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua');

-- Ejercicio 5: Competencia de Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento De Gerencia General', 'Asistente Jurídico', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B'),
('Departamento De Gerencia General', 'Asistente Jurídico', 5, 'Rompecabezas 2x2: Valor del slot', 'B'),
('Departamento De Gerencia General', 'Asistente Jurídico', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A');

-- ============================================================
-- Encuesta para Departamento De Gerencia General
-- ============================================================
-- Asistente De Gerencia
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente de Gerencia', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente de Gerencia', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente de Gerencia', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente de Gerencia', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente de Gerencia', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente de Gerencia', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


-- =========================
-- Asistente de Jurídico - Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente Jurídico', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente Jurídico', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente Jurídico', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente Jurídico', 5, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 5, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente Jurídico', 5, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');
 
-- =====================================================
--Jefe Coordinador De Comunicación Organizacional
-- =====================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================================================================
-- Jefe Coordinador Jurídico
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =====================================================
-- Asistente De Comunicación Organizacional
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

                -- ============================================================
                -- Bloque de inserción para Departamento De Talento Humano
                -- ============================================================
-- =========================================
-- Jefe Coordinador de Talento Humano
-- =========================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 1, '¿Qué hizo la abuela con la cinta?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 1, '¿Qué tuvo que hacer Juan?', 'C) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 3, 'Reactivo de Matrices', 'A');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 4, 'Analogías: BOTELLA es a ...', 'B'),
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 4, 'Reactivo con dibujos', 'A'),
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Reactivo puzles visuales 1', 'B'),
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Figuras Incompletas', 'B'),
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2'),
('Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Retención de Dígitos', '6-1-7-5');

-- =============================
-- Analista de Talento Humano
-- ==============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 1, '¿Qué hizo la abuela con la cinta?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 1, '¿Qué tuvo que hacer Juan?', 'C) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 3, 'Reactivo de Matrices', 'A');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 4, 'Analogías: BOTELLA es a ...', 'B'),
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 4, 'Reactivo con dibujos', 'A'),
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Reactivo puzles visuales 1', 'B'),
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Figuras Incompletas', 'B'),
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2'),
('Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Retención de Dígitos', '6-1-7-5');

-- =====================
-- Médico Ocupacional
-- ===================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Médico Ocupacional', 1, '¿Qué hizo la abuela con la cinta?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Médico Ocupacional', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Médico Ocupacional', 1, '¿Qué tuvo que hacer Juan?', 'C) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Médico Ocupacional', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Médico Ocupacional', 3, 'Reactivo de Matrices', 'A');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Médico Ocupacional', 4, 'Analogías: BOTELLA es a ...', 'B'),
('Departamento De Talento Humano 1', 'Médico Ocupacional', 4, 'Reactivo con dibujos', 'A'),
('Departamento De Talento Humano 1', 'Médico Ocupacional', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Reactivo puzles visuales 1', 'B'),
('Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Figuras Incompletas', 'B'),
('Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2'),
('Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Retención de Dígitos', '6-1-7-5');

-- =========================================
-- Analista de Capacitación y Desarrollo
-- =========================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 1, '¿Qué hizo la abuela con la cinta?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Respuesta correcta'),
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 1, '¿Qué tuvo que hacer Juan?', 'C) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 3, 'Reactivo de Matrices', 'A');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 4, 'Analogías: BOTELLA es a ...', 'B'),
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 4, 'Reactivo con dibujos', 'A'),
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Reactivo puzles visuales 1', 'B'),
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Figuras Incompletas', 'B'),
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2'),
('Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Retención de Dígitos', '6-1-7-5');

-- =========================================================================
-- Encuestas del Departamento De Talento Humano1
-- Cargo: Jefe Coordinador De Talento Humano
-- =========================================================================
-- =========================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Jefe Coordinador De Talento Humano', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Analista De Talento Humano
-- ===============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista De Talento Humano', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista De Talento Humano', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista De Talento Humano', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista De Talento Humano', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista De Talento Humano', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista De Talento Humano', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista De Talento Humano', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Médico Ocupacional
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Médico Ocupacional', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Médico Ocupacional', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Médico Ocupacional', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Médico Ocupacional', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Médico Ocupacional', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Médico Ocupacional', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Médico Ocupacional', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Analista de Capacitación y Desarrollo
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano1', 'Analista de Capacitación y Desarrollo', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

/* =======================
    Recepcionista
========================= */
-- EJERCICIO 1 (3 preguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Recepcionista',1,'¿Qué se infiere de esta información?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Recepcionista',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta correcta');

-- EJERCICIO 2 (Ordenar palabras)
-- Oración correcta: "El idioma latín ha aportado una gran cantidad de palabras a nuestro lenguaje."
-- Orden final: a,b,c,e,d
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',2,'Ordene las palabras: a) El idioma latín, b) ha aportado una, c) gran cantidad, d) a nuestro lenguaje, e) de palabras','a,b,c,e,d');

-- EJERCICIO 3 (Reactivo de Matrices)
-- Se asume que la respuesta correcta es "A"
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',3,'Reactivo de Matrices: elija la imagen que completa el patrón','A');

-- EJERCICIO 4 (3 subreactivos)
-- 4.1 Analogías verbales
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',4,'Analogía: PISCINA es a ____ como ____ es a GASOLINA','B');

-- 4.2 Reactivos con dibujos
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',4,'Reactivos con dibujos: Seleccione el nombre correcto para la figura','C');

-- 4.3 Reactivos verbales
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',4,'Reactivo verbal: Instrumento que tiene por objeto multiplicar la capacidad productiva del trabajo humano','MAQUINA');

-- EJERCICIO 5 (3 subreactivos evaluados)
-- 5.1 Reactivo Rompecabezas Visuales
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',5,'Reactivo Rompecabezas Visuales','B');

-- 5.2 Figuras Incompletas
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',5,'Figuras Incompletas: elija la pieza que completa el conjunto','B');

-- 5.3 Búsqueda de Símbolos
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Recepcionista',5,'Búsqueda de Símbolos: ¿Cuántos >, <, {, }?','3,2,2,2');

/* =======================
   Trabajadora Social
========================= */
-- Repetimos la misma estructura, solo cambia cargo_laboral = 'Trabajadora Social'
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Trabajadora Social',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Trabajadora Social',1,'¿Qué se infiere de esta información?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Trabajadora Social',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Trabajadora Social',2,'Ordenar palabras (El idioma latín...)','a,b,c,e,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Trabajadora Social',3,'Reactivo de Matrices','A');

-- EJERCICIO 4
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Trabajadora Social',4,'Analogía: PISCINA es a ____ como ____ es a GASOLINA','B'),
('Departamento De Talento Humano 2','Trabajadora Social',4,'Reactivos con dibujos','C'),
('Departamento De Talento Humano 2','Trabajadora Social',4,'Reactivo verbal: Instrumento que multiplica la capacidad productiva','MAQUINA');

-- EJERCICIO 5
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Trabajadora Social',5,'Reactivo Rompecabezas Visuales','B'),
('Departamento De Talento Humano 2','Trabajadora Social',5,'Figuras Incompletas','B'),
('Departamento De Talento Humano 2','Trabajadora Social',5,'Búsqueda de Símbolos','3,2,2,2');

/* =======================
    Analista de nómina
========================= */
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de nómina',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A)Respuesta correcta'),
('Departamento De Talento Humano 2','Analista de nómina',1,'¿Qué se infiere de esta información?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 2','Analista de nómina',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de nómina',2,'Ordenar palabras (El idioma latín...)','a,b,c,e,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de nómina',3,'Reactivo de Matrices','A');

-- EJERCICIO 4
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de nómina',4,'Analogía: PISCINA es a ____ como ____ es a GASOLINA','B'),
('Departamento De Talento Humano 2','Analista de nómina',4,'Reactivos con dibujos','C'),
('Departamento De Talento Humano 2','Analista de nómina',4,'Reactivo verbal: Instrumento que multiplica la capacidad productiva','MAQUINA');

-- EJERCICIO 5
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de nómina',5,'Reactivo Rompecabezas Visuales','B'),
('Departamento De Talento Humano 2','Analista de nómina',5,'Figuras Incompletas','B'),
('Departamento De Talento Humano 2','Analista de nómina',5,'Búsqueda de Símbolos','3,2,2,2');

/* =======================
   Auxiliar de nómina
========================= */
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Auxiliar de nómina',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Auxiliar de nómina',1,'¿Qué se infiere de esta información?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Auxiliar de nómina',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Auxiliar de nómina',2,'Ordenar palabras (El idioma latín...)','a,b,c,e,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Auxiliar de nómina',3,'Reactivo de Matrices','A');

-- EJERCICIO 4
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Auxiliar de nómina',4,'Analogía: PISCINA es a ____ como ____ es a GASOLINA','B'),
('Departamento De Talento Humano 2','Auxiliar de nómina',4,'Reactivos con dibujos','C'),
('Departamento De Talento Humano 2','Auxiliar de nómina',4,'Reactivo verbal: Instrumento que multiplica la capacidad productiva','MAQUINA');

-- EJERCICIO 5
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Auxiliar de nómina',5,'Reactivo Rompecabezas Visuales','B'),
('Departamento De Talento Humano 2','Auxiliar de nómina',5,'Figuras Incompletas','B'),
('Departamento De Talento Humano 2','Auxiliar de nómina',5,'Búsqueda de Símbolos','3,2,2,2');

/* ================================
Analista de selección de personal
=================================== */
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de selección de personal',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Analista de selección de personal',1,'¿Qué se infiere de esta información?','A) Respuesta correcta'),
('Departamento De Talento Humano 2','Analista de selección de personal',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de selección de personal',2,'Ordenar palabras (El idioma latín...)','a,b,c,e,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de selección de personal',3,'Reactivo de Matrices','A');

-- EJERCICIO 4
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de selección de personal',4,'Analogía: PISCINA es a ____ como ____ es a GASOLINA','B'),
('Departamento De Talento Humano 2','Analista de selección de personal',4,'Reactivos con dibujos','C'),
('Departamento De Talento Humano 2','Analista de selección de personal',4,'Reactivo verbal: Instrumento que multiplica la capacidad productiva','MAQUINA');

-- EJERCICIO 5
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2','Analista de selección de personal',5,'Reactivo Rompecabezas Visuales','B'),
('Departamento De Talento Humano 2','Analista de selección de personal',5,'Figuras Incompletas','B'),
('Departamento De Talento Humano 2','Analista de selección de personal',5,'Búsqueda de Símbolos','3,2,2,2');

-- ==============================================
-- Ecuesta Departamento De Talento Humano 2
-- Cargo: Recepcionista  
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Recepcionista', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Recepcionista', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Recepcionista', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Recepcionista', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Recepcionista', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Recepcionista', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Recepcionista', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Trabajadora Social  
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Trabajadora Social', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Trabajadora Social', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Trabajadora Social', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Trabajadora Social', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Trabajadora Social', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Trabajadora Social', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Analista de Nómina
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de Nómina', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Construcción de relaciones
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de Nómina', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Escucha Activa y Hablado
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de Nómina', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Liderazgo
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de Nómina', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Persuasión y Negociación
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de Nómina', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- =========================
-- Competencia: Asertividad y Firmeza
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de Nómina', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de Nómina', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ============================================== 
-- Cargo: Auxiliar de Nómina
-- ============================================== 
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Auxiliar de Nómina', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Analista de selección de personal
-- ==============================================

-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de selección de personal', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de selección de personal', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de selección de personal', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de selección de personal', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 2', 'Analista de selección de personal', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 2', 'Analista de selección de personal', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--                                        ===================================================
--                                         Inserts para el Departamento de Talento Humano 3
--                                        ==================================================
--Auxiliar de Selección de Personal
-- -----------------------------------
-- EJERCICIO 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta correcta'),
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',1,'¿Qué se infiere de esta información?','A) Respuesta correcta'),
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta correcta');

-- EJERCICIO 2: Competencia de Escritura (Ordenar palabras)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',2,'Ordenar palabras: "Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director"','a,b,c,d,e');

-- EJERCICIO 3: Reactivo de Matrices (Generación de ideas y pensamiento analítico)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',3,'Reactivo de Matrices: elija la imagen que completa el patrón','A');

-- EJERCICIO 4: Organización y Recopilación de la Información (2 subreactivos)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',4,'Analogías verbales: BOTELLA es a ... como ... es a PLATO','B'),
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',4,'Reactivos con dibujos: Seleccione el nombre correcto para la figura','A');

-- EJERCICIO 5: Competencia de Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',5,'Reactivo puzles visuales 1','B'),
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',5,'Puzzle 2x2 (slots)','B'),
('Departamento De Talento Humano 3','Auxiliar de Selección de Personal',5,'Búsqueda de Símbolos (¿Cuántos >, <, {, }?)','3,2,2,2');


-- -----------------------------------------
--Auxiliar de Capacitación y Desarrollo
-- -----------------------------------------
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) 1 metro con noventa centímetros'),
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',1,'¿Qué se infiere de esta información?','A) Que la abuela le pidió que fuera a comprar un metro más de la misma cinta'),
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',1,'¿En qué consistió la trampa del comerciante?','A) Estaba midiendo con el metro...');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',2,'Ordenar palabras: "Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director"','a,b,c,d,e');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',3,'Reactivo de Matrices','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',4,'Analogías verbales: BOTELLA es a ... como ... es a PLATO','B'),
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',4,'Reactivos con dibujos','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',5,'Reactivo puzles visuales 1','B'),
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',5,'Puzzle 2x2 (slots)','B'),
('Departamento De Talento Humano 3','Auxiliar de Capacitación y Desarrollo',5,'Búsqueda de Símbolos','3,2,2,2');


-- ------------------------------------------------------------------------
-- 3) Auxiliar de Talento Humano
-- ------------------------------------------------------------------------
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A)Respuesta Correcta.'),
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',1,'¿Qué se infiere de esta información?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta Correcta.');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',2,'Ordenar palabras: "Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director"','a,b,c,d,e');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',3,'Reactivo de Matrices','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',4,'Analogías verbales: BOTELLA es a ... como ... es a PLATO','B'),
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',4,'Reactivos con dibujos','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',5,'Reactivo puzles visuales 1','B'),
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',5,'Puzzle 2x2 (slots)','B'),
('Departamento De Talento Humano 3','Auxiliar de Talento Humano',5,'Búsqueda de Símbolos','3,2,2,2');


-- ---------------------------------------------
--Técnico de Seguridad y Salud Ocupacional
-- ---------------------------------------------
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',1,'¿Qué se infiere de esta información?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta Correcta.');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',2,'Ordenar palabras: "Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director"','a,b,c,d,e');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',3,'Reactivo de Matrices','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',4,'Analogías verbales: BOTELLA es a ... como ... es a PLATO','B'),
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',4,'Reactivos con dibujos','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',5,'Reactivo puzles visuales 1','B'),
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',5,'Puzzle 2x2 (slots)','B'),
('Departamento De Talento Humano 3','Técnico de Seguridad y Salud Ocupacional',5,'Búsqueda de Símbolos','3,2,2,2');

-- --------------------------------------------
-- Auxiliar de Seguridad y Salud Ocupacional
-- ---------------------------------------------
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',1,'¿Qué se infiere de esta información?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta Correcta.');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',2,'Ordenar palabras: "Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director"','a,b,c,d,e');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',3,'Reactivo de Matrices','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',4,'Analogías verbales: BOTELLA es a ... como ... es a PLATO','B'),
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',4,'Reactivos con dibujos','A');

INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',5,'Reactivo puzles visuales 1','B'),
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',5,'Puzzle 2x2 (slots)','B'),
('Departamento De Talento Humano 3','Auxiliar de Seguridad y Salud Ocupacional',5,'Búsqueda de Símbolos','3,2,2,2');

--                                ====================================================
--                                 Encuesta para el Departamento de Talento Humano 3
--=====================================================================================
-- Cargo: Auxiliar de Selección de Personal
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 4, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 4, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 4, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Auxiliar de Capacitación y Desarrollo
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 4, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 4, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 4, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Auxiliar de Talento Humano
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 4, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 4, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 4, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Técnico de Seguridad y Salud Ocupacional
-- ==============================================

-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 4, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 4, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 4, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Auxiliar de Seguridad y Salud Ocupacional
-- ==============================================

-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 4, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 4, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 4, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--                                       =================================================
--                                        insert para el Departamento De Talento Humano 4
---==================================    =================================================
-- Auxiliar de Servicios Generales
-- ==================================
-- EJERCICIO 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',1,'¿Qué se infiere de esta información?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta Correcta.');

-- EJERCICIO 2: Competencia de Escritura
-- Orden correcto de ejemplo: "a,b,c,d" o "d,c,a,b,e" según tu versión
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',2,'Ordenar palabras: Son insectos pertenecientes, Con alas escamosas, Al orden de los lepidópteros, Las mariposas','d,a,c,b');

-- EJERCICIO 3: Reactivo de Matrices (Generación de ideas y pensamiento analítico)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',3,'Reactivo de Matrices: elija la imagen que completa el patrón','A');

-- EJERCICIO 4: Organización y Recopilación de la Información
-- 4.1 Analogías verbales
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',4,'Analogías verbales: BOTELLA es a ... como ... es a PLATO','B');

-- 4.2 Reactivos con dibujos
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',4,'Reactivos con dibujos: Seleccione el nombre correcto para la figura','A');

-- 4.3 Reactivo verbal
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',4,'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones','SUPERVISOR');

-- EJERCICIO 5: Competencia de Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',5,'Reactivo de puzles visuales 1','B'),
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',5,'Puzzle 2x2 (slots)','B'),
('Departamento De Talento Humano 4','Auxiliar de Servicios Generales',5,'Búsqueda de Símbolos','3,2,2,2');

-- ===========
-- Mensajero
-- ===========
-- EJERCICIO 1: Comprensión Lectora
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Mensajero',1,'¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 4','Mensajero',1,'¿Qué se infiere de esta información?','A) Respuesta Correcta.'),
('Departamento De Talento Humano 4','Mensajero',1,'¿En qué consistió la trampa del comerciante?','A) Respuesta Correcta.');

-- EJERCICIO 2: Competencia de Escritura
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Mensajero',2,'Ordenar palabras: Son insectos pertenecientes, Con alas escamosas, Al orden de los lepidópteros, Las mariposas','d,a,c,b');

-- EJERCICIO 3: Reactivo de Matrices
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Mensajero',3,'Reactivo de Matrices: elija la imagen que completa el patrón','A');

-- EJERCICIO 4: Analogías, Dibujos y Verbal
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Mensajero',4,'Analogías verbales: BOTELLA es a ... como ... es a PLATO','B'),
('Departamento De Talento Humano 4','Mensajero',4,'Reactivos con dibujos: Seleccione el nombre correcto para la figura','A'),
('Departamento De Talento Humano 4','Mensajero',4,'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones','SUPERVISOR');

-- EJERCICIO 5: Planificación y Toma de Decisiones
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4','Mensajero',5,'Reactivo de puzles visuales 1','B'),
('Departamento De Talento Humano 4','Mensajero',5,'Puzzle 2x2 (slots)','B'),
('Departamento De Talento Humano 4','Mensajero',5,'Búsqueda de Símbolos','3,2,2,2');

--                                        ===================================================
--                                         Encuestas para el Departamento de Talento Humano 4
-- ===========================================================================================
-- Cargo: Auxiliar de Servicios Generales
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 4, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 4, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 4, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Mensajero
-- ==============================================

-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Mensajero', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Mensajero', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Mensajero', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento De Talento Humano 4', 'Mensajero', 4, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 4, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento De Talento Humano 4', 'Mensajero', 4, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

                              -- ============================================================
                              -- Bloque de inserción para Departamento Administrativo 1
                              -- ============================================================
-- =============================
-- Jefe Coordinador de Compras
-- =============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños?', 'A) Respuesta Correcta'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 4, 'Reactivo con dibujos', 'C(Articulos De Carga)'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 4, 'Reactivo verbal (supervisores)', 'SUPERVISORES');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 5, 'Reactivo puzles visuales 2', 'C'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 5, 'Figuras Incompletas', 'A'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- ==============================================
-- Cargo: Jefe Coordinador de Compras
-- ==============================================

-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 1', 'Jefe Coordinador de Compras', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

                           
                       -- ============================================================
                       -- Bloque de inserción para Departamento Administrativo 2
                       -- ============================================================
-- =============================
-- Jefe Coordinador de Sistemas
-- =============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 1, '¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 1, '¿Qué se infiere de esta información?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 1, '¿En que consistiò la trampa del Comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 2, 'Ordenar palabras (idioma latìn)', 'c,b,e,a,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 3, 'Reactivo de Matrices', 'C');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 4, 'Analogías: Piscina es a ...', 'B'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 4, 'Reactivo con dibujos', 'D(Bodega)'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 4, 'Reactivo verbal (maquinaria)', 'A');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistemas', 5, 'Búsqueda de Símbolos (&, ¡, {)', '8,14,7');

-- =============================================
-- Asistente de Compras Proveedores Nacionales
-- =============================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿Qué se infiere de esta información?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿En que consistiò la trampa del Comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 2, 'Ordenar palabras (idioma latìn)', 'c,b,e,a,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 3, 'Reactivo de Matrices', 'C');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 4, 'Analogías: Piscina es a ...', 'B'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 4, 'Reactivo con dibujos', 'D(Bodega)'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 4, 'Reactivo verbal (maquinaria)', 'A');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 5, 'Búsqueda de Símbolos (&, ¡, {)', '8,14,7');


-- =============================================
-- Asistente de Compras Proveedores Extranjeros
-- ==============================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿Qué se infiere de esta información?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿En que consistiò la trampa del Comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 2, 'Ordenar palabras (idioma latìn)', 'c,b,e,a,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 3, 'Reactivo de Matrices', 'C');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 4, 'Analogías: Piscina es a ...', 'B'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 4, 'Reactivo con dibujos', 'D(Bodega)'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 4, 'Reactivo verbal (maquinaria)', 'A');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 5, 'Búsqueda de Símbolos (&, ¡, {)', '8,14,7');


-- ======================
-- Asistente de Bodega
-- ======================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Bodega', 1, '¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Bodega', 1, '¿Qué se infiere de esta información?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Bodega', 1, '¿En que consistiò la trampa del Comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Bodega', 2, 'Ordenar palabras (idioma latìn)', 'c,b,e,a,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Bodega', 3, 'Reactivo de Matrices', 'C');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Bodega', 4, 'Analogías: Piscina es a ...', 'B'),
('Departamento Administrativo 2', 'Asistente de Bodega', 4, 'Reactivo con dibujos', 'D(Bodega)'),
('Departamento Administrativo 2', 'Asistente de Bodega', 4, 'Reactivo verbal (maquinaria)', 'A');

-- EJERCICIO 5 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Bodega', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Administrativo 2', 'Asistente de Bodega', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento Administrativo 2', 'Asistente de Bodega', 5, 'Búsqueda de Símbolos (&, ¡, {)', '8,14,7');

-- ======================
-- Asistente de Sistemas
-- ======================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿Qué se infiere de esta información?', 'A) Respuesta Correcta'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿En que consistiò la trampa del Comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 2, 'Ordenar palabras (idioma latìn)', 'c,b,e,a,d');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 3, 'Reactivo de Matrices', 'C');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 4, 'Analogías: Piscina es a ...', 'B'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 4, 'Reactivo con dibujos', 'D(Bodega)'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 4, 'Reactivo verbal (maquinaria)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 5, 'Búsqueda de Símbolos (&, ¡, {)', '8, 14, 7');

--                            ====================================================
--                                Encuestas para Departamento Administrativo 2
-- ===============================================================================
-- Cargo: Jefe Coordinador de Sistema
-- =======================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =======================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Jefe Coordinador de Sistema', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Asistente de Compras Proveedores Nacionales
-- ==============================================

-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Nacionales', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Asistente de Compras Proveedores Extranjeros
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Compras Proveedores Extranjeros', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ==============================================
-- Cargo: Asistente Bodega
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente Bodega', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente Bodega', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente Bodega', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente Bodega', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente Bodega', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente Bodega', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente Bodega', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ============================================== 
-- Cargo: Asistente de Sistemas
-- ==============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');
-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Administrativo 2', 'Asistente de Sistemas', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

                              -- ====================================================
                              -- Bloque de inserción para el Departamento Financiero
                              -- ====================================================
-- ===================================
-- Jefe Coordinador de Contabilidad
-- ===================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Jefe Coordinador de Contabilidad', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

-- =========================================
-- Jefe Coordinador de Crédito y Cobranzas
-- =========================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Jefe Coordinador De Credito y Cobranzas', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Jefe Coordinador De Crédito y Cobranzas', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

-- ==========================
-- Analista De Contabilidad
-- ==========================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Analista De Contabilidad', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Analista De Contabilidad', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Analista De Contabilidad', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Analista De Contabilidad', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

-- ==========================
-- Analista De Tesorería
-- ==========================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Analista De Tesorería', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Analista De Tesorería', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Analista De Tesorería', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Analista De Tesorería', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

-- ===============================
-- Jefe Coordinador De Tesorería
-- ===============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

-- ===============================
-- Jefe Coordinador De Tesorería
-- ===============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

-- ===========================
-- Auxiliar De Contabilidad
-- ===========================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

-- ==================================
-- Auxiliar De Crédito y Cobranzas
-- ==================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Qué hizo Juan al llegar a la papelería? ', 'A) Respuesta Correcta'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 2, 'Ordenar palabras (funcionarios del museo)', 'd,b,c,a,e');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 3, 'Reactivo de Matrices', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 4, 'Analogías: BOTELLA es a ...', 'D'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 4, 'Reactivo con dibujos', 'B(Material de protección personal)'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 4, 'Reactivo verbal(obreros)', 'B');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 5, 'Reactivo rompecabezas visuales', 'B'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 5, 'Figuras Incompletas', 'B'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 5, 'Búsqueda de Símbolos (}, ¿, ¬)', '14,13,10');

--                        ========================================
--                         Encuestas del Departamento Financiero
--=================================================================
-- cargo_laboral: Jefe Coordinador De Contabilidad
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se cree un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Contabilidad', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo_laboral: Jefe De Coordinador De Crédito y Cobranzas
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe De Coordinador De Crédito y Cobranzas', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--================================================================= 
-- cargo: Analista De Contabilidad
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Contabilidad', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--============================================= 
-- cargo:  Analista De Tesorería
-- ============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Analista De Tesorería', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--============================================= 
-- cargo:  Jefe Coordinador De Tesorería
-- ============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Jefe Coordinador De Tesorería', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--============================================= 
-- cargo:  Auxiliar De Contabilidad
-- ============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Contabilidad', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--============================================= 
-- cargo:  Auxiliar De Crédito y Cobranzas
-- ============================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuación y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Financiero', 'Auxiliar De Crédito y Cobranzas', 7, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

                                   -- ====================================================
                                   -- Bloque de inserción para el Departamento Comercial
                                   -- ====================================================
-- ============================
-- Jefe Coordinador de ventas
-- =============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de ventas', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de ventas', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de ventas', 3, 'Reactivo generación de ideas y pensamiento analítico ', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de ventas', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 4, 'Reactivo con dibujos', 'C(Artículo de carga)'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de ventas', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 5, 'Figuras Incompletas', 'A'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de ventas', 5, 'Reactivo de informacion', 'A, C'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 5, 'Reactivo de semejanzas', 'A'),
('Departamento Comercial', 'Jefe Coordinador de ventas', 5, 'reactivo retencion de digitos', '5-7-1-6,   8-2-3-5,  3-1-8-4-2-6');

-- ===================================
-- Jefe Coordinador de Marketing
-- ===================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 3, 'Reactivo generación de ideas y pensamiento analítico ', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 4, 'Reactivo con dibujos', 'C(Artículo de carga)'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, 'Figuras Incompletas', 'A'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, 'Reactivo de informacion', 'A, C'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, 'Reactivo de semejanzas', 'A'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, 'reactivo retencion de digitos', '5-7-1-6,   8-2-3-5,  3-1-8-4-2-6');

-- ===================================
-- Asistente de Atención al Cliente
-- ===================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 3, 'Reactivo generación de ideas y pensamiento analítico ', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 4, 'Reactivo con dibujos', 'C(Artículo de carga)'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, 'Figuras Incompletas', 'A'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, 'Reactivo de informacion', 'A, C'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, 'Reactivo de semejanzas', 'A'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, 'reactivo retencion de digitos', '5-7-1-6,   8-2-3-5,  3-1-8-4-2-6');

-- ===========
-- Vendedor
-- ===========
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Vendedor', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Vendedor', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 3, 'Reactivo generación de ideas y pensamiento analítico ', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento Comercial', 'Vendedor', 4, 'Reactivo con dibujos', 'C(Artículo de carga)'),
('Departamento Comercial', 'Vendedor', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento Comercial', 'Vendedor', 5, 'Figuras Incompletas', 'A'),
('Departamento Comercial', 'Vendedor', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 5, 'Reactivo de informacion', 'A, C'),
('Departamento Comercial', 'Vendedor', 5, 'Reactivo de semejanzas', 'A'),
('Departamento Comercial', 'Vendedor', 5, 'reactivo retencion de digitos', '5-7-1-6,   8-2-3-5,  3-1-8-4-2-6');

-- ==========================
-- Asistente de Marketing
-- ==========================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 3, 'Reactivo generación de ideas y pensamiento analítico ', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento Comercial', 'Asistente de Marketing', 4, 'Reactivo con dibujos', 'C(Artículo de carga)'),
('Departamento Comercial', 'Asistente de Marketing', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento Comercial', 'Asistente de Marketing', 5, 'Figuras Incompletas', 'A'),
('Departamento Comercial', 'Asistente de Marketing', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 5, 'Reactivo de informacion', 'A, C'),
('Departamento Comercial', 'Asistente de Marketing', 5, 'Reactivo de semejanzas', 'A'),
('Departamento Comercial', 'Asistente de Marketing', 5, 'reactivo retencion de digitos', '5-7-1-6,   8-2-3-5,  3-1-8-4-2-6');

-- ====================
-- Cajero Facturador
-- ====================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Cajero Facturador', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento Comercial', 'Cajero Facturador', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 3, 'Reactivo generación de ideas y pensamiento analítico ', 'B');

-- EJERCICIO 4 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento Comercial', 'Cajero Facturador', 4, 'Reactivo con dibujos', 'C(Artículo de carga)'),
('Departamento Comercial', 'Cajero Facturador', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento Comercial', 'Cajero Facturador', 5, 'Figuras Incompletas', 'A'),
('Departamento Comercial', 'Cajero Facturador', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 5, 'Reactivo de informacion', 'A, C'),
('Departamento Comercial', 'Cajero Facturador', 5, 'Reactivo de semejanzas', 'A'),
('Departamento Comercial', 'Cajero Facturador', 5, 'reactivo retencion de digitos', '5-7-1-6,   8-2-3-5,  3-1-8-4-2-6');

--                    =========================================================
--                           Encuestas para el Departamento Comercial 1
--                    =========================================================
--================================================================= 
-- cargo_laboral: Jefe Coordinador de Ventas
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Ventas', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Ventas', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Ventas', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Ventas', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Ventas', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Ventas', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Ventas', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo_laboral: Jefe Coordinador de Marketing
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Jefe Coordinador de Marketing', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Jefe Coordinador de Marketing', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo_laboral: Asistente de Atención al Cliente
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Atención al Cliente', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Atención al Cliente', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo_laboral: Vendedor
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Vendedor', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Vendedor', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo_laboral: Asistente de Marketing
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Asistente de Marketing', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Asistente de Marketing', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo_laboral: Cajero Facturador
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- =========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Construcción de relaciones
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Escucha Activa y Hablado
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Liderazgo
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Persuasión y Negociación
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- ========================= 
-- Competencia: Asertividad y Firmeza
-- ========================= 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento Comercial', 'Cajero Facturador', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento Comercial', 'Cajero Facturador', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

                -- =========================================================
                -- Bloque de inserción para el Departamento de Produccion 1
                -- =========================================================
-- =============================
--  Asistente de Planificación
-- =============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Asistente de Planificación', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Asistente de Planificación', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Asistente de Planificación', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Asistente de Planificación', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Asistente de Planificación', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Asistente de Planificación', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Asistente de Planificación', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Asistente de Planificación', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Asistente de Planificación', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Asistente de Planificación', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Asistente de Planificación', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Asistente de Planificación', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Asistente de Planificación', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Asistente de Planificación', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Asistente de Planificación', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Asistente de Planificación', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ================================
--  Jefe Coordinador de Producción
-- ================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Producción', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ===================================
--  Jefe Coordinador de Mantenimiento
-- ===================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Jefe Coordinador de Mantenimiento', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ================================
--  Supervisor de Sección
-- ================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Sección', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Sección', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Sección', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Sección', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Sección', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Sección', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Sección', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Supervisor de Sección', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Supervisor de Sección', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Supervisor de Sección', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Sección', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Supervisor de Sección', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Supervisor de Sección', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Sección', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Sección', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Sección', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- =======================================
--  Supervisor de Mantenimiento Eléctrico
-- =======================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Eléctrico', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ==========================================
--  Supervisor de Mantenimiento Mecánico
-- ==========================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Mecánico', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ========================================
--  Supervisor de Mantenimiento Automotriz
-- ========================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Supervisor de Mantenimiento Automotriz', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ========================================
--  Auxiliar de Mantenimiento Eléctrico
-- ========================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Eléctrico', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ======================================
--  Auxiliar de Mantenimiento Mecánico
-- =======================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Mecánico', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

-- ======================================
-- Auxiliar de Mantenimiento Automotriz
-- =======================================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Qué hizo la abuela con la cinta?', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Qué le sucedió a la abuela cuando estaba elaborando los moños? ', 'A) Respuesta Correcta'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Qué tuvo que hacer Juan?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b');

-- EJERCICIO 3
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 3, 'Reactivo matrices ', 'C');

--Evaluación adaptadA para personas con discapacidad visual
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 3, 'Reactivo generación de ideas y pensamiento analítico', 'C');

-- EJERCICIO 4 (4 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 4, 'Analogías Verbales: AGUA DULCE es a ... como MAR es a ...', 'C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 4, 'Reactivo con dibujos', 'B(Material de protección personal )'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 4, 'Reactivo con dibujos adaptado a discapacidad visual', 'D(equipo de protección personal)'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 4, 'Reactivo verbal(supervisores)', 'A');

-- EJERCICIO 5 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 5, 'Reactivo rompecabezas visuales', 'C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 5, 'Figuras Incompletas', 'C,B,A,D'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 5, 'Búsqueda de Símbolos (>, [, ))', '11,23,14');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 5, 'Reactivo de informacion', 'A, C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 5, 'Reactivo de semejanzas', 'A, C'),
('Departamento de Produccion 1', 'Auxiliar de Mantenimiento Automotriz', 5, 'reactivo retencion de digitos', '1-5-6-8,   2-3-5-8,  1-3-7-8,  1-2-3-4-6-8');

                -- =========================================================
                --     Encuestas para el Departamento de Produccion 1 
                -- =========================================================
--================================================================= 
-- cargo: Asistente de Planificación
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Asistente de Planificación', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Asistente de Planificación', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Asistente de Planificación', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Asistente de Planificación', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Asistente de Planificación', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Asistente de Planificación', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Asistente de Planificación', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Asistente de Planificación', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo: Jefe Coordinador de Producción
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Producción', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--================================================================= 
-- cargo: Jefe Coordinador de Mantenimiento
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Jefe Coordinador de Mantenimiento', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--================================================================= 
-- cargo: Supervisor de Sección
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Supervisor de Sección', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Sección', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Sección', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Sección', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Sección', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Sección', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Sección', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Sección', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--================================================================= 
-- cargo: Supervisor de Mantenimiento Eléctrico
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Eléctrico', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--================================================================= 
-- cargo: Supervisor de Mantenimiento Mecánico
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Mecánico', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo: Supervisor de Mantenimiento Automotriz
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Supervisor de Mantenimiento Automotriz', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo: Auxiliar de Mantenimiento Mecánico
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Mecánico', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

--================================================================= 
-- cargo: Auxiliar de Mantenimiento Automotriz
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================
-- Competencia: Liderazgo
-- ==========================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para dirigir grupos de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--===========================================
-- Competencia: Persuasión y Negociación
-- ==========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 5, '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 5, '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 5, '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Asertividad y Firmeza
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 6, '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 6, '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 6, '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--========================================
-- Competencia: Trabajo en Equipo
--========================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 7, '¿Ha tenido dificultad para trabajar en equipo y colaborar con otros?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 7, '¿Es capaz de compartir ideas y recursos con los demás para lograr un objetivo común?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 7, '¿Es capaz de aceptar críticas constructivas y aprender de ellas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 7, '¿Es capaz de motivar y apoyar a sus compañeros de trabajo para lograr un ambiente positivo y productivo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 1', 'Auxiliar de Mantenimiento Automotriz', 8, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

                -- =========================================================
                -- Bloque de inserción para el Departamento de Produccion 2
                -- =========================================================
-- =============================
--  Operario General
-- =============================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Operario General', 1, '¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Operario General', 1, '¿Qué se infiere de esta información?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Operario General', 1, '¿En qué consistió la trampa del comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 1 ADAPTADO PARA DISCAPACIDAD VISUAL
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Operario General', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Operario General', 1, '¿Qué hizo Juan al llegar a la papelería?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Operario General', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Operario General', 2, 'Ordenar palabras (el idioma latín)', 'c,b,e,a,d');

-- EJERCICIO 3 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Operario General', 3, 'Analogías Verbales: PISCINA es a ... como ... es a GASOLINA', 'B'),
('Departamento de Produccion 2', 'Operario General', 3, 'reactivo con dibujos', 'C(Articulos de carga)'),
('Departamento de Produccion 2', 'Operario General', 3, 'Reactivo Verbal(maquinaria)', 'A');

--EJERCICIO 3 ADAPTADO PARA LA DISCAPACIDAD VISUAL
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Operario General', 3, 'reactivo con dibujos adaptado para discapacidad visual', 'C(Articulos de carga)');

-- EJERCICIO 4 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Operario General', 4, 'Reactivo Busqueda de Símbolos(}, ¿, ¬)', '14,13,10');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (2 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Operario General', 5, 'Reactivo de informacion', 'C, C'),
('Departamento de Produccion 2', 'Operario General', 5, 'reactivo retencion de digitos', '6-1-7-5,   5-3-2-8,   6-2-4-8-1-3');

-- ===================
--  Ayudante General
-- ===================
-- EJERCICIO 1
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Ayudante General', 1, '¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Ayudante General', 1, '¿Qué se infiere de esta información?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Ayudante General', 1, '¿En qué consistió la trampa del comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 1 ADAPTADO PARA DISCAPACIDAD VISUAL
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Ayudante General', 1, '¿Qué le pidió la abuela a Juan?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Ayudante General', 1, '¿Qué hizo Juan al llegar a la papelería?', 'A) Respuesta Correcta'),
('Departamento de Produccion 2', 'Ayudante General', 1, '¿Qué hizo el comerciante?', 'A) Respuesta Correcta');

-- EJERCICIO 2
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Ayudante General', 2, 'Ordenar palabras (el idioma latín)', 'c,b,e,a,d');

-- EJERCICIO 3 (3 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Ayudante General', 3, 'Analogías Verbales: PISCINA es a ... como ... es a GASOLINA', 'B'),
('Departamento de Produccion 2', 'Ayudante General', 3, 'reactivo con dibujos', 'C(Articulos de carga)'),
('Departamento de Produccion 2', 'Ayudante General', 3, 'Reactivo Verbal(maquinaria)', 'A');

--EJERCICIO 3 ADAPTADO PARA LA DISCAPACIDAD VISUAL
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Ayudante General', 3, 'reactivo con dibujos adaptado para discapacidad visual', 'C(Articulos de carga)');

-- EJERCICIO 4 
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Ayudante General', 4, 'Reactivo Busqueda de Símbolos(}, ¿, ¬)', '14,13,10');

-- planificación y toma de decisiones, adaptado para la discapacidad visual (2 subpreguntas)
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Produccion 2', 'Ayudante General', 5, 'Reactivo de informacion', 'C, C'),
('Departamento de Produccion 2', 'Ayudante General', 5, 'reactivo retencion de digitos', '6-1-7-5,   5-3-2-8,   6-2-4-8-1-3');

--                              =========================================================
--                                   Encuestas para el Departamento de Producción 2
--                              =========================================================
-- ========================================
-- cargo: Ayudante General
-- ========================================

-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');


--================================================================= 
-- cargo: Operario General
-- ================================================
-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================

-- Competencia: Adaptabilidad / Flexibilidad
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES 
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 1, '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================= 
-- Competencia: Construcción de relaciones
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 2, '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--==================================================
-- Competencia: Escucha Activa y Hablado
-- ================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Logra comprender todo lo que la otra persona trata de comunicarle?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 3, '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),

--================================================================= 
-- Competencia: Inspección de Productos, Instalación, Manejo de recursos materiales, Mantenimiento de equipos, Operación y Control, Reparación
--=================================================================
INSERT INTO preguntasYrespuestas (nombre_departamento, cargo_laboral, ejercicio, pregunta, respuesta)
VALUES
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultad para planificar, identificar problemas y buscar la mejor solución? (por ejemplo, búsqueda de estrategias, asesoramiento o pedir ayuda.)', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Puede recordar con facilidad información aprendida para realizar actividades y tareas laborales?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para manejar de forma adecuada sus responsabilidades asociadas con el rendimiento en la realización de tareas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para reaccionar de manera inmediata frente a situaciones que pudieran ser peligrosas?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para discriminar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para observar formas, tamaño, contornos y detalles de determinados objetos de lejos utilizando los dos ojos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de cerca utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para observar formas, tamaños, contornos y detalles de determinados objetos de lejos utilizando primero el ojo derecho y luego el ojo izquierdo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades o deficiencias tales como ver rayos de luz, calidad de la imagen afectada; distorsión de la imagen, y ver estrellas o flashes?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para distinguir sonidos, su grado de intensidad y de donde provienen?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para identificar si el sonido proviene del lado derecho o el izquierdo de su oído?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades para identificar y discriminar determinados olores como agradables y desagradables?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha presentado dificultades para sentir la textura (liso- rugoso), calidad (buena- mala), presión (poco- mucho) y temperatura (frio- caliente) de determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultades tales como entumecimiento, hormigueo, sensaciones anormales de cosquilleo, calor o frío al tocar determinados objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Ha tenido dificultad para manejar, recoger, manipular, atrapar y soltar objetos, utilizando la mano, los dedos y varias partes de su cuerpo?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Dispone de toda la fuerza muscular en brazos, manos, piernas y pies para levantar objetos pesados?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Desde un lugar determinado puede desplazarse sin mayor inconveniente y realizar actividades que requieran de sentarse, pararse, tomar y dirigir ciertos objetos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta movimientos rápidos y pequeños en el cuerpo que no puede controlar (movimientos repetitivos en manos, brazos, piernas) como consecuencia de una afección en su salud?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Requiere de muletas, prótesis o silla de ruedas para desplazarse de un lugar a otro?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para mantener y pasar de una postura corporal a otra, por ejemplo; estar sentado, acostado, en cuclillas o arrodillado?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Presenta dificultades para trasladar materiales de un lugar a otro utilizando sus extremidades superiores e inferiores?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo'),
('Departamento de Producción 2', 'Auxiliar de Mantenimiento Automotriz', 4, '¿Tiene dificultad para andar, subir, bajar, tanto en distancias largas como cortas, sobre suelos inclinados, rectos o con obstáculos?', 'Opciones: No hay problema, Problema leve, Problema moderado, Problema grave, Problema completo');

-- INSERT para la tabla estado
INSERT INTO estado (id_estado, nombre, descripcion) VALUES 
  (1, 'admin', 'Administración del sistema'),
  (2, 'usuarios', 'Estado para usuarios'),
  (3, 'activo', 'Registro activo'),
  (4, 'no activo', 'Registro no activo');

-- INSERT para la tabla discapacidad
INSERT INTO discapacidad (tipo) VALUES 
  ('visual'),
  ('auditiva'),
  ('fisica'),
  ('NULL'),
  ('intelectual');

-- INSERT para un usuario administrador
-- Se asume que el registro en discapacidad 'NULL' obtuvo id_discapacidad = 4.
INSERT INTO usuarios (nombre, email, password, id_discapacidad, id_estado, id_estado_rol)
VALUES ('Admin', 'admin@example.com', '$2y$10$.rIyYSYL/W1RXM9QipK1ZOSTn0pZ3gukZ3oQfr.Urkza09jBmQRS2', 4, 1, 1);