-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-04-2025 a las 18:09:53
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inclulab`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `discapacidad`
--

CREATE TABLE `discapacidad` (
  `id_discapacidad` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `discapacidad`
--

INSERT INTO `discapacidad` (`id_discapacidad`, `tipo`) VALUES
(1, 'visual'),
(2, 'auditiva'),
(3, 'fisica'),
(4, 'NULL'),
(5, 'intelectual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicios`
--

CREATE TABLE `ejercicios` (
  `id_ejercicio` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id_estado` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`id_estado`, `nombre`, `descripcion`) VALUES
(1, 'admin', 'Administración del sistema'),
(2, 'usuarios', 'Estado para usuarios'),
(3, 'activo', 'Registro activo'),
(4, 'no activo', 'Registro no activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id_pregunta` int(11) NOT NULL,
  `id_ejercicio` int(11) NOT NULL,
  `texto` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntasyrespuestas`
--

CREATE TABLE `preguntasyrespuestas` (
  `id` int(11) NOT NULL,
  `nombre_departamento` varchar(255) NOT NULL,
  `cargo_laboral` varchar(255) NOT NULL,
  `ejercicio` int(11) NOT NULL,
  `pregunta` text NOT NULL,
  `respuesta` text NOT NULL,
  `fecha_respuesta` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preguntasyrespuestas`
--

INSERT INTO `preguntasyrespuestas` (`id`, `nombre_departamento`, `cargo_laboral`, `ejercicio`, `pregunta`, `respuesta`, `fecha_respuesta`) VALUES
(1, 'Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:05'),
(2, 'Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿Qué se infiere de esta información?', 'B) Que la abuela pidió 1 metro adicional para el quinto moño', '2025-03-04 23:58:05'),
(3, 'Departamento De Gerencia General', 'Asistente de Gerencia', 1, '¿En qué consistió la trampa del comerciante?', 'B) Sacó la pieza de cinta, cortó 10 metros y se los entregó', '2025-03-04 23:58:05'),
(4, 'Departamento De Gerencia General', 'Asistente de Gerencia', 2, 'Orden final de palabras', 'd,c,a,b,e', '2025-03-04 23:58:05'),
(5, 'Departamento De Gerencia General', 'Asistente de Gerencia', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A', '2025-03-04 23:58:05'),
(6, 'Departamento De Gerencia General', 'Asistente de Gerencia', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua', '2025-03-04 23:58:05'),
(7, 'Departamento De Gerencia General', 'Asistente de Gerencia', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B', '2025-03-04 23:58:05'),
(8, 'Departamento De Gerencia General', 'Asistente de Gerencia', 5, 'Rompecabezas 2x2: Valor del slot', 'B', '2025-03-04 23:58:05'),
(9, 'Departamento De Gerencia General', 'Asistente de Gerencia', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', '2025-03-04 23:58:05'),
(10, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:06'),
(11, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿Qué se infiere de esta información?', 'B) Que la abuela pidió 1 metro adicional para el quinto moño', '2025-03-04 23:58:06'),
(12, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 1, '¿En qué consistió la trampa del comerciante?', 'B) Sacó la pieza de cinta, cortó 10 metros y se los entregó', '2025-03-04 23:58:06'),
(13, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 2, 'Orden final de palabras', 'd,c,a,b,e', '2025-03-04 23:58:06'),
(14, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A', '2025-03-04 23:58:06'),
(15, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua', '2025-03-04 23:58:06'),
(16, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B', '2025-03-04 23:58:06'),
(17, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, 'Rompecabezas 2x2: Valor del slot', 'B', '2025-03-04 23:58:06'),
(18, 'Departamento De Gerencia General', 'Jefe Coordinador De Comunicación Organizacional', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', '2025-03-04 23:58:06'),
(19, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:06'),
(20, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿Qué se infiere de esta información?', 'B) Que la abuela pidió 1 metro adicional para el quinto moño', '2025-03-04 23:58:06'),
(21, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 1, '¿En qué consistió la trampa del comerciante?', 'B) Sacó la pieza de cinta, cortó 10 metros y se los entregó', '2025-03-04 23:58:06'),
(22, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 2, 'Orden final de palabras', 'd,c,a,b,e', '2025-03-04 23:58:06'),
(23, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A', '2025-03-04 23:58:06'),
(24, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua', '2025-03-04 23:58:06'),
(25, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B', '2025-03-04 23:58:06'),
(26, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, 'Rompecabezas 2x2: Valor del slot', 'B', '2025-03-04 23:58:06'),
(27, 'Departamento De Gerencia General', 'Jefe Coordinador Jurídico', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', '2025-03-04 23:58:06'),
(28, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:06'),
(29, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿Qué se infiere de esta información?', 'B) Que la abuela pidió 1 metro adicional para el quinto moño', '2025-03-04 23:58:06'),
(30, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 1, '¿En qué consistió la trampa del comerciante?', 'B) Sacó la pieza de cinta, cortó 10 metros y se los entregó', '2025-03-04 23:58:06'),
(31, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 2, 'Orden final de palabras', 'd,c,a,b,e', '2025-03-04 23:58:06'),
(32, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A', '2025-03-04 23:58:06'),
(33, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua', '2025-03-04 23:58:06'),
(34, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B', '2025-03-04 23:58:06'),
(35, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, 'Rompecabezas 2x2: Valor del slot', 'B', '2025-03-04 23:58:06'),
(36, 'Departamento De Gerencia General', 'Asistente De Comunicación Organizacional', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', '2025-03-04 23:58:06'),
(37, 'Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:06'),
(38, 'Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿Qué se infiere de esta información?', 'B) Que la abuela pidió 1 metro adicional para el quinto moño', '2025-03-04 23:58:06'),
(39, 'Departamento De Gerencia General', 'Asistente Jurídico', 1, '¿En qué consistió la trampa del comerciante?', 'B) Sacó la pieza de cinta, cortó 10 metros y se los entregó', '2025-03-04 23:58:06'),
(40, 'Departamento De Gerencia General', 'Asistente Jurídico', 2, 'Orden final de palabras', 'd,c,a,b,e', '2025-03-04 23:58:06'),
(41, 'Departamento De Gerencia General', 'Asistente Jurídico', 3, 'Reactivo de Matrices: ¿Cuál es la imagen que falta para completar la secuencia?', 'A) Opción A', '2025-03-04 23:58:06'),
(42, 'Departamento De Gerencia General', 'Asistente Jurídico', 4, 'BOTELLA es a ... como PLATO es a ...', 'B) vino - agua', '2025-03-04 23:58:06'),
(43, 'Departamento De Gerencia General', 'Asistente Jurídico', 5, 'Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?', 'B', '2025-03-04 23:58:06'),
(44, 'Departamento De Gerencia General', 'Asistente Jurídico', 5, 'Rompecabezas 2x2: Valor del slot', 'B', '2025-03-04 23:58:06'),
(45, 'Departamento De Gerencia General', 'Asistente Jurídico', 5, 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', '2025-03-04 23:58:06'),
(46, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 1, '¿Qué hizo la abuela con la cinta?', 'B) Se dispuso a elaborar 5 moños...', '2025-03-04 23:58:07'),
(47, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Se dio cuenta...', '2025-03-04 23:58:07'),
(48, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 1, '¿Qué tuvo que hacer Juan?', 'C) Volver a la papelería...', '2025-03-04 23:58:07'),
(49, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b', '2025-03-04 23:58:07'),
(50, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:07'),
(51, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 4, 'Analogías: BOTELLA es a ...', 'B', '2025-03-04 23:58:07'),
(52, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 4, 'Reactivo con dibujos', 'A', '2025-03-04 23:58:07'),
(53, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR', '2025-03-04 23:58:07'),
(54, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:07'),
(55, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:07'),
(56, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2', '2025-03-04 23:58:07'),
(57, 'Departamento De Talento Humano 1', 'Jefe Coordinador de Talento Humano', 5, 'Retención de Dígitos', '6-1-7-5', '2025-03-04 23:58:07'),
(58, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 1, '¿Qué hizo la abuela con la cinta?', 'B) Se dispuso a elaborar 5 moños...', '2025-03-04 23:58:07'),
(59, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Se dio cuenta...', '2025-03-04 23:58:07'),
(60, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 1, '¿Qué tuvo que hacer Juan?', 'C) Volver a la papelería...', '2025-03-04 23:58:07'),
(61, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b', '2025-03-04 23:58:07'),
(62, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:07'),
(63, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 4, 'Analogías: BOTELLA es a ...', 'B', '2025-03-04 23:58:07'),
(64, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 4, 'Reactivo con dibujos', 'A', '2025-03-04 23:58:07'),
(65, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR', '2025-03-04 23:58:07'),
(66, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:07'),
(67, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:07'),
(68, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2', '2025-03-04 23:58:07'),
(69, 'Departamento De Talento Humano 1', 'Analista de Talento Humano', 5, 'Retención de Dígitos', '6-1-7-5', '2025-03-04 23:58:07'),
(70, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 1, '¿Qué hizo la abuela con la cinta?', 'B) Se dispuso a elaborar 5 moños...', '2025-03-04 23:58:07'),
(71, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Se dio cuenta...', '2025-03-04 23:58:07'),
(72, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 1, '¿Qué tuvo que hacer Juan?', 'C) Volver a la papelería...', '2025-03-04 23:58:07'),
(73, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b', '2025-03-04 23:58:07'),
(74, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:07'),
(75, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 4, 'Analogías: BOTELLA es a ...', 'B', '2025-03-04 23:58:07'),
(76, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 4, 'Reactivo con dibujos', 'A', '2025-03-04 23:58:07'),
(77, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR', '2025-03-04 23:58:07'),
(78, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:07'),
(79, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:07'),
(80, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2', '2025-03-04 23:58:07'),
(81, 'Departamento De Talento Humano 1', 'Médico Ocupacional', 5, 'Retención de Dígitos', '6-1-7-5', '2025-03-04 23:58:07'),
(82, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 1, '¿Qué hizo la abuela con la cinta?', 'B) Se dispuso a elaborar 5 moños...', '2025-03-04 23:58:08'),
(83, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 1, '¿Qué le sucedió a la abuela al elaborar los moños?', 'B) Se dio cuenta...', '2025-03-04 23:58:08'),
(84, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 1, '¿Qué tuvo que hacer Juan?', 'C) Volver a la papelería...', '2025-03-04 23:58:08'),
(85, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 2, 'Ordenar palabras (mariposas)', 'd,a,c,b', '2025-03-04 23:58:08'),
(86, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:08'),
(87, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 4, 'Analogías: BOTELLA es a ...', 'B', '2025-03-04 23:58:08'),
(88, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 4, 'Reactivo con dibujos', 'A', '2025-03-04 23:58:08'),
(89, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 4, 'Reactivo verbal (supervisor)', 'SUPERVISOR', '2025-03-04 23:58:08'),
(90, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:08'),
(91, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:08'),
(92, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Búsqueda de Símbolos (>, <, {, })', '3,2,2,2', '2025-03-04 23:58:08'),
(93, 'Departamento De Talento Humano 1', 'Analista de Capacitación y Desarrollo', 5, 'Retención de Dígitos', '6-1-7-5', '2025-03-04 23:58:08'),
(94, 'Departamento De Talento Humano 2', 'Recepcionista', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:08'),
(95, 'Departamento De Talento Humano 2', 'Recepcionista', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:08'),
(96, 'Departamento De Talento Humano 2', 'Recepcionista', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:08'),
(97, 'Departamento De Talento Humano 2', 'Recepcionista', 2, 'Ordene las palabras: a) El idioma latín, b) ha aportado una, c) gran cantidad, d) a nuestro lenguaje, e) de palabras', 'a,b,c,e,d', '2025-03-04 23:58:08'),
(98, 'Departamento De Talento Humano 2', 'Recepcionista', 3, 'Reactivo de Matrices: elija la imagen que completa el patrón', 'A', '2025-03-04 23:58:08'),
(99, 'Departamento De Talento Humano 2', 'Recepcionista', 4, 'Analogía: PISCINA es a ____ como ____ es a GASOLINA', 'B', '2025-03-04 23:58:08'),
(100, 'Departamento De Talento Humano 2', 'Recepcionista', 4, 'Reactivos con dibujos: Seleccione el nombre correcto para la figura', 'C', '2025-03-04 23:58:08'),
(101, 'Departamento De Talento Humano 2', 'Recepcionista', 4, 'Reactivo verbal: Instrumento que tiene por objeto multiplicar la capacidad productiva del trabajo humano', 'MAQUINA', '2025-03-04 23:58:08'),
(102, 'Departamento De Talento Humano 2', 'Recepcionista', 5, 'Reactivo Rompecabezas Visuales', 'B', '2025-03-04 23:58:08'),
(103, 'Departamento De Talento Humano 2', 'Recepcionista', 5, 'Figuras Incompletas: elija la pieza que completa el conjunto', 'B', '2025-03-04 23:58:09'),
(104, 'Departamento De Talento Humano 2', 'Recepcionista', 5, 'Búsqueda de Símbolos: ¿Cuántos >, <, {, }?', '3,2,2,2', '2025-03-04 23:58:09'),
(105, 'Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:09'),
(106, 'Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:09'),
(107, 'Departamento De Talento Humano 2', 'Trabajadora Social', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:09'),
(108, 'Departamento De Talento Humano 2', 'Trabajadora Social', 2, 'Ordenar palabras (El idioma latín...)', 'a,b,c,e,d', '2025-03-04 23:58:09'),
(109, 'Departamento De Talento Humano 2', 'Trabajadora Social', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:09'),
(110, 'Departamento De Talento Humano 2', 'Trabajadora Social', 4, 'Analogía: PISCINA es a ____ como ____ es a GASOLINA', 'B', '2025-03-04 23:58:09'),
(111, 'Departamento De Talento Humano 2', 'Trabajadora Social', 4, 'Reactivos con dibujos', 'C', '2025-03-04 23:58:09'),
(112, 'Departamento De Talento Humano 2', 'Trabajadora Social', 4, 'Reactivo verbal: Instrumento que multiplica la capacidad productiva', 'MAQUINA', '2025-03-04 23:58:09'),
(113, 'Departamento De Talento Humano 2', 'Trabajadora Social', 5, 'Reactivo Rompecabezas Visuales', 'B', '2025-03-04 23:58:09'),
(114, 'Departamento De Talento Humano 2', 'Trabajadora Social', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:09'),
(115, 'Departamento De Talento Humano 2', 'Trabajadora Social', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:09'),
(116, 'Departamento De Talento Humano 2', 'Analista de nómina', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:09'),
(117, 'Departamento De Talento Humano 2', 'Analista de nómina', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:09'),
(118, 'Departamento De Talento Humano 2', 'Analista de nómina', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:09'),
(119, 'Departamento De Talento Humano 2', 'Analista de nómina', 2, 'Ordenar palabras (El idioma latín...)', 'a,b,c,e,d', '2025-03-04 23:58:09'),
(120, 'Departamento De Talento Humano 2', 'Analista de nómina', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:09'),
(121, 'Departamento De Talento Humano 2', 'Analista de nómina', 4, 'Analogía: PISCINA es a ____ como ____ es a GASOLINA', 'B', '2025-03-04 23:58:09'),
(122, 'Departamento De Talento Humano 2', 'Analista de nómina', 4, 'Reactivos con dibujos', 'C', '2025-03-04 23:58:09'),
(123, 'Departamento De Talento Humano 2', 'Analista de nómina', 4, 'Reactivo verbal: Instrumento que multiplica la capacidad productiva', 'MAQUINA', '2025-03-04 23:58:09'),
(124, 'Departamento De Talento Humano 2', 'Analista de nómina', 5, 'Reactivo Rompecabezas Visuales', 'B', '2025-03-04 23:58:09'),
(125, 'Departamento De Talento Humano 2', 'Analista de nómina', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:09'),
(126, 'Departamento De Talento Humano 2', 'Analista de nómina', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:09'),
(127, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:09'),
(128, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:09'),
(129, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:09'),
(130, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 2, 'Ordenar palabras (El idioma latín...)', 'a,b,c,e,d', '2025-03-04 23:58:09'),
(131, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:09'),
(132, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 4, 'Analogía: PISCINA es a ____ como ____ es a GASOLINA', 'B', '2025-03-04 23:58:09'),
(133, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 4, 'Reactivos con dibujos', 'C', '2025-03-04 23:58:09'),
(134, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 4, 'Reactivo verbal: Instrumento que multiplica la capacidad productiva', 'MAQUINA', '2025-03-04 23:58:09'),
(135, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 5, 'Reactivo Rompecabezas Visuales', 'B', '2025-03-04 23:58:09'),
(136, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:09'),
(137, 'Departamento De Talento Humano 2', 'Auxiliar de nómina', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:09'),
(138, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:09'),
(139, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:09'),
(140, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:09'),
(141, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 2, 'Ordenar palabras (El idioma latín...)', 'a,b,c,e,d', '2025-03-04 23:58:09'),
(142, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:10'),
(143, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 4, 'Analogía: PISCINA es a ____ como ____ es a GASOLINA', 'B', '2025-03-04 23:58:10'),
(144, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 4, 'Reactivos con dibujos', 'C', '2025-03-04 23:58:10'),
(145, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 4, 'Reactivo verbal: Instrumento que multiplica la capacidad productiva', 'MAQUINA', '2025-03-04 23:58:10'),
(146, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 5, 'Reactivo Rompecabezas Visuales', 'B', '2025-03-04 23:58:10'),
(147, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 5, 'Figuras Incompletas', 'B', '2025-03-04 23:58:10'),
(148, 'Departamento De Talento Humano 2', 'Analista de selección de personal', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:10'),
(149, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:10'),
(150, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más de la misma cinta', '2025-03-04 23:58:10'),
(151, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro empezando por el número 1 hasta el 100...', '2025-03-04 23:58:10'),
(152, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 2, 'Ordenar palabras: \"Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director\"', 'a,b,c,d,e', '2025-03-04 23:58:10'),
(153, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 3, 'Reactivo de Matrices: elija la imagen que completa el patrón', 'A', '2025-03-04 23:58:10'),
(154, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 4, 'Analogías verbales: BOTELLA es a ... como ... es a PLATO', 'B', '2025-03-04 23:58:10'),
(155, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 4, 'Reactivos con dibujos: Seleccione el nombre correcto para la figura', 'A', '2025-03-04 23:58:10'),
(156, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:10'),
(157, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 5, 'Puzzle 2x2 (slots)', 'B', '2025-03-04 23:58:10'),
(158, 'Departamento De Talento Humano 3', 'Auxiliar de Selección de Personal', 5, 'Búsqueda de Símbolos (¿Cuántos >, <, {, }?)', '3,2,2,2', '2025-03-04 23:58:10'),
(159, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:10'),
(160, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más de la misma cinta', '2025-03-04 23:58:10'),
(161, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:10'),
(162, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 2, 'Ordenar palabras: \"Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director\"', 'a,b,c,d,e', '2025-03-04 23:58:10'),
(163, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:10'),
(164, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 4, 'Analogías verbales: BOTELLA es a ... como ... es a PLATO', 'B', '2025-03-04 23:58:10'),
(165, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 4, 'Reactivos con dibujos', 'A', '2025-03-04 23:58:10'),
(166, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:10'),
(167, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 5, 'Puzzle 2x2 (slots)', 'B', '2025-03-04 23:58:10'),
(168, 'Departamento De Talento Humano 3', 'Auxiliar de Capacitación y Desarrollo', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:10'),
(169, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:10'),
(170, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:10'),
(171, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:10'),
(172, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 2, 'Ordenar palabras: \"Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director\"', 'a,b,c,d,e', '2025-03-04 23:58:10'),
(173, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:10'),
(174, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 4, 'Analogías verbales: BOTELLA es a ... como ... es a PLATO', 'B', '2025-03-04 23:58:10'),
(175, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 4, 'Reactivos con dibujos', 'A', '2025-03-04 23:58:10'),
(176, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:10'),
(177, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 5, 'Puzzle 2x2 (slots)', 'B', '2025-03-04 23:58:10'),
(178, 'Departamento De Talento Humano 3', 'Auxiliar de Talento Humano', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:10'),
(179, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:10'),
(180, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:10'),
(181, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:10'),
(182, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 2, 'Ordenar palabras: \"Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director\"', 'a,b,c,d,e', '2025-03-04 23:58:10'),
(183, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:11'),
(184, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 4, 'Analogías verbales: BOTELLA es a ... como ... es a PLATO', 'B', '2025-03-04 23:58:11'),
(185, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 4, 'Reactivos con dibujos', 'A', '2025-03-04 23:58:11'),
(186, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:11'),
(187, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 5, 'Puzzle 2x2 (slots)', 'B', '2025-03-04 23:58:11'),
(188, 'Departamento De Talento Humano 3', 'Técnico de Seguridad y Salud Ocupacional', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:11'),
(189, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:11'),
(190, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más...', '2025-03-04 23:58:11'),
(191, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro...', '2025-03-04 23:58:11'),
(192, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 2, 'Ordenar palabras: \"Un informe detallado, Del museo, Escribieron, Los funcionarios, Para el director\"', 'a,b,c,d,e', '2025-03-04 23:58:11'),
(193, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 3, 'Reactivo de Matrices', 'A', '2025-03-04 23:58:11'),
(194, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 4, 'Analogías verbales: BOTELLA es a ... como ... es a PLATO', 'B', '2025-03-04 23:58:11'),
(195, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 4, 'Reactivos con dibujos', 'A', '2025-03-04 23:58:11'),
(196, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 5, 'Reactivo puzles visuales 1', 'B', '2025-03-04 23:58:11'),
(197, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 5, 'Puzzle 2x2 (slots)', 'B', '2025-03-04 23:58:11'),
(198, 'Departamento De Talento Humano 3', 'Auxiliar de Seguridad y Salud Ocupacional', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:11'),
(199, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:11'),
(200, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más de la misma cinta y elaboró el quinto moño.', '2025-03-04 23:58:11'),
(201, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro empezando por el número 1 hasta el 100, dando en total 90 cm.', '2025-03-04 23:58:11'),
(202, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 2, 'Ordenar palabras: Son insectos pertenecientes, Con alas escamosas, Al orden de los lepidópteros, Las mariposas', 'd,a,c,b', '2025-03-04 23:58:11'),
(203, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 3, 'Reactivo de Matrices: elija la imagen que completa el patrón', 'A', '2025-03-04 23:58:11'),
(204, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 4, 'Analogías verbales: BOTELLA es a ... como ... es a PLATO', 'B', '2025-03-04 23:58:11'),
(205, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 4, 'Reactivos con dibujos: Seleccione el nombre correcto para la figura', 'A', '2025-03-04 23:58:11'),
(206, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 4, 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', '2025-03-04 23:58:11'),
(207, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 5, 'Reactivo de puzles visuales 1', 'B', '2025-03-04 23:58:11'),
(208, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 5, 'Puzzle 2x2 (slots)', 'B', '2025-03-04 23:58:11'),
(209, 'Departamento De Talento Humano 4', 'Auxiliar de Servicios Generales', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:11'),
(210, 'Departamento De Talento Humano 4', 'Mensajero', 1, '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A) 1 metro con noventa centímetros', '2025-03-04 23:58:11'),
(211, 'Departamento De Talento Humano 4', 'Mensajero', 1, '¿Qué se infiere de esta información?', 'A) Que la abuela le pidió que fuera a comprar un metro más de la misma cinta y elaboró el quinto moño.', '2025-03-04 23:58:11'),
(212, 'Departamento De Talento Humano 4', 'Mensajero', 1, '¿En qué consistió la trampa del comerciante?', 'A) Estaba midiendo con el metro empezando por el número 1 hasta el 100, dando en total 90 cm.', '2025-03-04 23:58:11'),
(213, 'Departamento De Talento Humano 4', 'Mensajero', 2, 'Ordenar palabras: Son insectos pertenecientes, Con alas escamosas, Al orden de los lepidópteros, Las mariposas', 'd,a,c,b', '2025-03-04 23:58:11'),
(214, 'Departamento De Talento Humano 4', 'Mensajero', 3, 'Reactivo de Matrices: elija la imagen que completa el patrón', 'A', '2025-03-04 23:58:11'),
(215, 'Departamento De Talento Humano 4', 'Mensajero', 4, 'Analogías verbales: BOTELLA es a ... como ... es a PLATO', 'B', '2025-03-04 23:58:12'),
(216, 'Departamento De Talento Humano 4', 'Mensajero', 4, 'Reactivos con dibujos: Seleccione el nombre correcto para la figura', 'A', '2025-03-04 23:58:12'),
(217, 'Departamento De Talento Humano 4', 'Mensajero', 4, 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', '2025-03-04 23:58:12'),
(218, 'Departamento De Talento Humano 4', 'Mensajero', 5, 'Reactivo de puzles visuales 1', 'B', '2025-03-04 23:58:12'),
(219, 'Departamento De Talento Humano 4', 'Mensajero', 5, 'Puzzle 2x2 (slots)', 'B', '2025-03-04 23:58:12'),
(220, 'Departamento De Talento Humano 4', 'Mensajero', 5, 'Búsqueda de Símbolos', '3,2,2,2', '2025-03-04 23:58:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id_respuesta` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `departamento` text NOT NULL,
  `cargo_laboral` text NOT NULL,
  `ejercicio` int(11) NOT NULL,
  `titulo_ejercicio` text NOT NULL,
  `contexto_ejercicio` text NOT NULL,
  `pregunta` text NOT NULL,
  `respuesta` text NOT NULL,
  `respuestaCorrectaoNo` text NOT NULL,
  `Discapacidad` text NOT NULL,
  `fecha_respuesta` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `respuestas`
--

INSERT INTO `respuestas` (`id_respuesta`, `id_usuario`, `departamento`, `cargo_laboral`, `ejercicio`, `titulo_ejercicio`, `contexto_ejercicio`, `pregunta`, `respuesta`, `respuestaCorrectaoNo`, `Discapacidad`, `fecha_respuesta`) VALUES
(1, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:17'),
(2, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Qué se infiere de esta información?', 'C', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:17'),
(3, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:17'),
(4, 39, 'Departamento de Talento Humano 4', 'Mensajero', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicio 2: Competencia de Escritura', 'Orden final de palabras', 'd,a,c,b', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:17'),
(5, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Analogías verbales: … es a AGUA DULCE como MAR es a …', 'C', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:17'),
(6, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivos con Dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:17'),
(7, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivo verbal: Persona que tiene como función principal la de vigilar el cumplimiento de las órdenes e instrucciones', 'OBREROS', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:18'),
(8, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:19'),
(9, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Qué se infiere de esta información?', 'C', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:19'),
(10, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:19'),
(11, 39, 'Departamento de Talento Humano 4', 'Mensajero', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicio 2: Competencia de Escritura', 'Orden final de palabras', 'd,a,c,b', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:19'),
(12, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Analogías verbales: … es a AGUA DULCE como MAR es a …', 'C', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:19'),
(13, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivos con Dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:19'),
(14, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivo verbal: Persona que tiene como función principal la de vigilar el cumplimiento de las órdenes e instrucciones', 'OBREROS', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-06 15:39:20'),
(15, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'C', 'No', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(16, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'C', 'No', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(17, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(18, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'a,b,c,d,e', 'Si', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(19, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(20, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías (PISCINA es a ... como ... es a GASOLINA)', 'B', 'Si', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(21, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos (Almacén/Bodega)', 'C', 'No', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(22, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal (Instrumento productivo)', 'SUPERVISORES', 'No', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(23, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 5, 'Ejercicio 5 ADAPTADO: Reactivo de Información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Para qué sirven las gafas como equipo o material de uso personal en una empresa?', 'B', 'No', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(24, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 5, 'Ejercicio 5 ADAPTADO: Reactivo de Semejanzas', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué se parecen los aguantes y el casco?', 'C', 'No', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(25, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 5, 'Ejercicio 5 ADAPTADO: Reactivo de Semejanzas', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué se parecen el departamento financiero y el departamento de recursos humanos?', 'B', 'No', 'auditiva, visual, fisica', '2025-03-10 10:14:23'),
(26, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 5, 'Ejercicio 5 ADAPTADO: Reactivo de Retención de Dígitos', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos en orden ascendente', '1-2-3-4-6-8', 'N/A', 'auditiva, visual, fisica', '2025-03-10 10:14:24'),
(27, 41, 'Departamento de Talento Humano 2', 'Analista De Nómina', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva, visual, fisica', '2025-03-10 10:14:24'),
(28, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:11'),
(29, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Qué se infiere de esta información?', 'B', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:11'),
(30, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿En qué consistió la trampa del comerciante?', 'C', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:11'),
(31, 39, 'Departamento de Talento Humano 4', 'Mensajero', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicio 2: Competencia de Escritura', 'Orden final de palabras', 'd,a,c,b', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:11'),
(32, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Analogías verbales: … es a AGUA DULCE como MAR es a …', 'C', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:11'),
(33, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivos con Dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:11'),
(34, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivo verbal: Persona que tiene como función principal la de vigilar el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(35, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?', 'A', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(36, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿Qué se infiere de esta información?', 'B', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(37, 39, 'Departamento de Talento Humano 4', 'Mensajero', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicio 1: Comprensión Lectora', '¿En qué consistió la trampa del comerciante?', 'C', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(38, 39, 'Departamento de Talento Humano 4', 'Mensajero', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicio 2: Competencia de Escritura', 'Orden final de palabras', 'd,a,c,b', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(39, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Analogías verbales: … es a AGUA DULCE como MAR es a …', 'C', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(40, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivos con Dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(41, 39, 'Departamento de Talento Humano 4', 'Mensajero', 3, 'Ejercicio 3: Organización y Recopilación de la Información', 'Ejercicio 3: Organización y Recopilación de la Información', 'Reactivo verbal: Persona que tiene como función principal la de vigilar el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'Si', 'auditiva, visual, fisica, intelectual', '2025-03-22 01:18:12'),
(42, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física y Auditiva', '¿Qué hizo la abuela con la cinta?', 'A', 'No', 'auditiva', '2025-03-24 11:22:27'),
(43, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física y Auditiva', '¿Qué le sucedió a la abuela al elaborar los moños?', 'A', 'No', 'auditiva', '2025-03-24 11:22:27'),
(44, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física y Auditiva', '¿Qué tuvo que hacer Juan?', 'B', 'No', 'auditiva', '2025-03-24 11:22:27'),
(45, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 2, 'Ejercicio 2: Ordenar palabras', 'Ejercicios para Discapacidad: Física y Auditiva', 'Orden final de palabras', 'd,a,c,b', 'Si', 'auditiva', '2025-03-24 11:22:27'),
(46, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 3, 'Ejercicio 3: Reactivo de Matrices', 'Ejercicios para Discapacidad: Física y Auditiva', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva', '2025-03-24 11:22:27'),
(47, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 4, 'Ejercicio 4: Analogías', 'Ejercicios para Discapacidad: Física y Auditiva', 'Complete la frase: BOTELLA es a ____ como PLATO es a ____', 'C', 'No', 'auditiva', '2025-03-24 11:22:28'),
(48, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 4, 'Ejercicio 4: Reactivo con dibujos', 'Ejercicios para Discapacidad: Física y Auditiva', 'Observa la imagen y selecciona el nombre correcto.', 'C', 'Si', 'auditiva', '2025-03-24 11:22:28'),
(49, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 4, 'Ejercicio 4: Reactivos verbales', 'Ejercicios para Discapacidad: Física y Auditiva', 'Significado: Persona que vigila el cumplimiento de las órdenes.', 'SUPERVISOR', 'Si', 'auditiva', '2025-03-24 11:22:28'),
(50, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 5, 'Ejercicio 5: Rompecabezas visuales', 'Ejercicios para Discapacidad: Física y Auditiva', 'Observa el rompecabezas y selecciona la opción que complete la figura.', 'C', 'Si', 'auditiva', '2025-03-24 11:22:28'),
(51, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 5, 'Ejercicio 5: Figuras Incompletas', 'Ejercicios para Discapacidad: Física y Auditiva', 'Observa la figura y selecciona la pieza que la complete.', 'C', 'No', 'auditiva', '2025-03-24 11:22:28'),
(52, 37, 'Departamento de Talento Humano 1', 'Jefe Coordinador De Talento Humano', 5, 'Ejercicio 5: Búsqueda de Símbolos', 'Ejercicios para Discapacidad: Física y Auditiva', 'Cuenta los símbolos en la imagen', 'Mayor: 11, Menor: 9, Llave Abierta: 10, Llave Cerrada: 25', 'No', 'auditiva', '2025-03-24 11:22:28'),
(53, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'No', '3', '2025-03-29 22:37:20'),
(54, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo Juan al llegar a la papelería?', 'C', 'Si', '3', '2025-03-29 22:37:20'),
(55, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo el comerciante?', 'A', 'Si', '3', '2025-03-29 22:37:20'),
(56, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Orden final de palabras', 'd,b,c,a,e', 'Si', '3', '2025-03-29 22:37:20'),
(57, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 3, 'Ejercicio 3: Competencia generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Imagen faltante (opción)', 'A', 'Si', '3', '2025-03-29 22:37:20'),
(58, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'D', 'Si', '3', '2025-03-29 22:37:20'),
(59, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', '3', '2025-03-29 22:37:20'),
(60, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'OBREROS', 'Si', '3', '2025-03-29 22:37:20'),
(61, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo Rompecabezas Visuales', 'B', 'Si', '3', '2025-03-29 22:37:20'),
(62, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Puzzle 3x3 (Slots)', 'B', 'Si', '3', '2025-03-29 22:37:20'),
(63, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', 'N/A', '3', '2025-03-29 22:37:20'),
(64, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Semejanzas: ¿En qué se parecen los guantes y el casco?', 'A', 'N/A', '3', '2025-03-29 22:37:20'),
(65, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'No', '3', '2025-03-29 22:37:21'),
(66, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo Juan al llegar a la papelería?', 'C', 'Si', '3', '2025-03-29 22:37:21'),
(67, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo el comerciante?', 'A', 'Si', '3', '2025-03-29 22:37:21'),
(68, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Orden final de palabras', 'd,b,c,a,e', 'Si', '3', '2025-03-29 22:37:21'),
(69, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 3, 'Ejercicio 3: Competencia generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Imagen faltante (opción)', 'A', 'Si', '3', '2025-03-29 22:37:21'),
(70, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'D', 'Si', '3', '2025-03-29 22:37:21'),
(71, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', '3', '2025-03-29 22:37:21'),
(72, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'OBREROS', 'Si', '3', '2025-03-29 22:37:21'),
(73, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo Rompecabezas Visuales', 'B', 'Si', '3', '2025-03-29 22:37:21'),
(74, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Puzzle 3x3 (Slots)', 'B', 'Si', '3', '2025-03-29 22:37:21'),
(75, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', 'N/A', '3', '2025-03-29 22:37:21'),
(76, 39, 'Departamento Financiero', 'Auxiliar de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Semejanzas: ¿En qué se parecen los guantes y el casco?', 'A', 'N/A', '3', '2025-03-29 22:37:22'),
(77, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'No', '3', '2025-03-30 20:26:10'),
(78, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo Juan al llegar a la papelería?', 'C', 'Si', '3', '2025-03-30 20:26:10'),
(79, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo el comerciante?', 'C', 'No', '3', '2025-03-30 20:26:10'),
(80, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Orden final de palabras', 'd,b,c,a,e', 'Si', '3', '2025-03-30 20:26:10'),
(81, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 3, 'Ejercicio 3: Competencia generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Imagen faltante (opción)', 'B', 'No', '3', '2025-03-30 20:26:10'),
(82, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'No', '3', '2025-03-30 20:26:10'),
(83, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', '3', '2025-03-30 20:26:11'),
(84, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'OBREROS', 'Si', '3', '2025-03-30 20:26:11'),
(85, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo Rompecabezas Visuales', 'B', 'Si', '3', '2025-03-30 20:26:11'),
(86, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Puzzle 3x3 (Slots)', 'B', 'Si', '3', '2025-03-30 20:26:11'),
(87, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', 'N/A', '3', '2025-03-30 20:26:11'),
(88, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Semejanzas: ¿En qué se parecen los guantes y el casco?', 'A', 'N/A', '3', '2025-03-30 20:26:11'),
(89, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'No', '3', '2025-03-30 20:26:12'),
(90, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo Juan al llegar a la papelería?', 'C', 'Si', '3', '2025-03-30 20:26:12'),
(91, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', '¿Qué hizo el comerciante?', 'C', 'No', '3', '2025-03-30 20:26:12'),
(92, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Orden final de palabras', 'd,b,c,a,e', 'Si', '3', '2025-03-30 20:26:12'),
(93, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 3, 'Ejercicio 3: Competencia generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Imagen faltante (opción)', 'B', 'No', '3', '2025-03-30 20:26:12'),
(94, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'No', '3', '2025-03-30 20:26:12'),
(95, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', '3', '2025-03-30 20:26:13'),
(96, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 4, 'Ejercicio 4: Competencia de organización y recopilación de la información', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'OBREROS', 'Si', '3', '2025-03-30 20:26:13'),
(97, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo Rompecabezas Visuales', 'B', 'Si', '3', '2025-03-30 20:26:13'),
(98, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Puzzle 3x3 (Slots)', 'B', 'Si', '3', '2025-03-30 20:26:13'),
(99, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Información: ¿Para qué sirven los guantes de protección?', 'A', 'N/A', '3', '2025-03-30 20:26:13'),
(100, 39, 'Departamento Financiero', 'Jefe de coordinacion de credito y cobranzas', 5, 'Ejercicio 5: Competencia de Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Física, Auditiva y Visual', 'Reactivo de Semejanzas: ¿En qué se parecen los guantes y el casco?', 'A', 'N/A', '3', '2025-03-30 20:26:13'),
(101, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-03-31 18:17:56'),
(102, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-03-31 18:17:56'),
(103, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-03-31 18:17:56'),
(104, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-03-31 18:17:56'),
(105, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-03-31 18:17:56'),
(106, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-03-31 18:17:56'),
(107, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-03-31 18:17:56'),
(108, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-03-31 18:17:56'),
(109, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-03-31 18:17:56'),
(110, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'c,b,a,d', 'Si', 'auditiva y fisica', '2025-03-31 18:17:56'),
(111, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 0, Menor: 1, Llave Abierta: 7, Llave Cerrada: 14', 'No', 'auditiva y fisica', '2025-03-31 18:17:56'),
(112, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-03-31 18:17:57'),
(113, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-03-31 18:17:57'),
(114, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-03-31 18:19:21'),
(115, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-03-31 18:19:21'),
(116, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-03-31 18:19:21'),
(117, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-03-31 18:19:21'),
(118, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-03-31 18:19:21'),
(119, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-03-31 18:19:21'),
(120, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-03-31 18:19:21'),
(121, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-03-31 18:19:21'),
(122, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-03-31 18:19:21'),
(123, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'c,b,a,d', 'Si', 'auditiva y fisica', '2025-03-31 18:19:22'),
(124, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 0, Menor: 8, Llave Abierta: 14, Llave Cerrada: 7', 'Si', 'auditiva y fisica', '2025-03-31 18:19:22'),
(125, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-03-31 18:19:22'),
(126, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-03-31 18:19:22'),
(127, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:26'),
(128, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-04-02 21:21:27'),
(129, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:27'),
(130, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-02 21:21:27'),
(131, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-04-02 21:21:27'),
(132, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:27'),
(133, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-04-02 21:21:27'),
(134, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-02 21:21:27'),
(135, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:27'),
(136, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'a,b,c,d', 'No', 'auditiva y fisica', '2025-04-02 21:21:27'),
(137, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 15, Menor: 16, Llave Abierta: 7, Llave Cerrada: 7', 'No', 'auditiva y fisica', '2025-04-02 21:21:27'),
(138, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:27'),
(139, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:27'),
(140, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:27'),
(141, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-04-02 21:21:28'),
(142, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:28'),
(143, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-02 21:21:28'),
(144, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-04-02 21:21:28'),
(145, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:28'),
(146, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-04-02 21:21:28'),
(147, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-02 21:21:28'),
(148, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:28'),
(149, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'a,b,c,d', 'No', 'auditiva y fisica', '2025-04-02 21:21:28'),
(150, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 15, Menor: 16, Llave Abierta: 7, Llave Cerrada: 7', 'No', 'auditiva y fisica', '2025-04-02 21:21:28'),
(151, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:28'),
(152, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:28'),
(153, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:29'),
(154, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-04-02 21:21:29'),
(155, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:29'),
(156, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-02 21:21:29'),
(157, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-04-02 21:21:29'),
(158, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:29'),
(159, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-04-02 21:21:29'),
(160, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-02 21:21:29'),
(161, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:29'),
(162, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'a,b,c,d', 'No', 'auditiva y fisica', '2025-04-02 21:21:29'),
(163, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 15, Menor: 16, Llave Abierta: 7, Llave Cerrada: 7', 'No', 'auditiva y fisica', '2025-04-02 21:21:29'),
(164, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:29'),
(165, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:29'),
(166, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:29'),
(167, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-04-02 21:21:29'),
(168, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30'),
(169, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30'),
(170, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30'),
(171, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30');
INSERT INTO `respuestas` (`id_respuesta`, `id_usuario`, `departamento`, `cargo_laboral`, `ejercicio`, `titulo_ejercicio`, `contexto_ejercicio`, `pregunta`, `respuesta`, `respuestaCorrectaoNo`, `Discapacidad`, `fecha_respuesta`) VALUES
(172, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-04-02 21:21:30'),
(173, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-02 21:21:30'),
(174, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30'),
(175, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'a,b,c,d', 'No', 'auditiva y fisica', '2025-04-02 21:21:30'),
(176, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 15, Menor: 16, Llave Abierta: 7, Llave Cerrada: 7', 'No', 'auditiva y fisica', '2025-04-02 21:21:30'),
(177, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:30'),
(178, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:30'),
(179, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30'),
(180, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-04-02 21:21:30'),
(181, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30'),
(182, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-02 21:21:30'),
(183, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-04-02 21:21:31'),
(184, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:31'),
(185, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-04-02 21:21:31'),
(186, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-02 21:21:31'),
(187, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:31'),
(188, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'a,b,c,d', 'No', 'auditiva y fisica', '2025-04-02 21:21:31'),
(189, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 15, Menor: 16, Llave Abierta: 7, Llave Cerrada: 7', 'No', 'auditiva y fisica', '2025-04-02 21:21:31'),
(190, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:31'),
(191, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:31'),
(192, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:31'),
(193, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'No', 'auditiva y fisica', '2025-04-02 21:21:31'),
(194, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-02 21:21:31'),
(195, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-02 21:21:31'),
(196, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'Si', 'auditiva y fisica', '2025-04-02 21:21:31'),
(197, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:32'),
(198, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'D', 'No', 'auditiva y fisica', '2025-04-02 21:21:32'),
(199, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-02 21:21:32'),
(200, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-02 21:21:32'),
(201, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'a,b,c,d', 'No', 'auditiva y fisica', '2025-04-02 21:21:32'),
(202, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 15, Menor: 16, Llave Abierta: 7, Llave Cerrada: 7', 'No', 'auditiva y fisica', '2025-04-02 21:21:32'),
(203, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:32'),
(204, 36, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-02 21:21:32'),
(205, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(206, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(207, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(208, 39, 'Departamento de Producción 2', 'Operario General', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(209, 39, 'Departamento de Producción 2', 'Operario General', 3, 'Ejercicio 3: Generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', '', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(210, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: PISCINA es a _____ como _____ es a Gasolina', 'B', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(211, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(212, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'No', 'auditiva y fisica', '2025-04-03 00:04:08'),
(213, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.1: Rompecabezas Visuales', '', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(214, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.2: Puzzle 2x2', '', 'Si', 'auditiva y fisica', '2025-04-03 00:04:08'),
(215, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.3: Búsqueda de Símbolos', 'Mayor: 0, Menor: 23, Llave Abierta: 14, Llave Cerrada: 12', 'No', 'auditiva y fisica', '2025-04-03 00:04:09'),
(216, 39, 'Departamento de Producción 2', 'Operario General', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', '', 'N/A', 'auditiva y fisica', '2025-04-03 00:04:09'),
(217, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(218, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(219, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(220, 39, 'Departamento de Producción 2', 'Operario General', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(221, 39, 'Departamento de Producción 2', 'Operario General', 3, 'Ejercicio 3: Generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', '', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(222, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: PISCINA es a _____ como _____ es a Gasolina', 'B', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(223, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(224, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'No', 'auditiva y fisica', '2025-04-03 00:04:10'),
(225, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.1: Rompecabezas Visuales', '', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(226, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.2: Puzzle 2x2', '', 'Si', 'auditiva y fisica', '2025-04-03 00:04:10'),
(227, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.3: Búsqueda de Símbolos', 'Mayor: 0, Menor: 23, Llave Abierta: 14, Llave Cerrada: 12', 'No', 'auditiva y fisica', '2025-04-03 00:04:10'),
(228, 39, 'Departamento de Producción 2', 'Operario General', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', '', 'N/A', 'auditiva y fisica', '2025-04-03 00:04:10'),
(229, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué le pidió la abuela a Juan?', 'B', 'No', 'auditiva y fisica', '2025-04-03 20:17:50'),
(230, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 20:17:50'),
(231, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'B', 'No', 'auditiva y fisica', '2025-04-03 20:17:50'),
(232, 39, 'Departamento de Producción 2', 'Operario General', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-03 20:17:50'),
(233, 39, 'Departamento de Producción 2', 'Operario General', 3, 'Ejercicio 3: Generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', '', 'Si', 'auditiva y fisica', '2025-04-03 20:17:50'),
(234, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: PISCINA es a _____ como _____ es a Gasolina', 'B', 'Si', 'auditiva y fisica', '2025-04-03 20:17:50'),
(235, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'Si', 'auditiva y fisica', '2025-04-03 20:17:51'),
(236, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'No', 'auditiva y fisica', '2025-04-03 20:17:51'),
(237, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.1: Rompecabezas Visuales', '', 'Si', 'auditiva y fisica', '2025-04-03 20:17:51'),
(238, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.2: Puzzle 2x2', '', 'Si', 'auditiva y fisica', '2025-04-03 20:17:51'),
(239, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.3: Búsqueda de Símbolos', 'Mayor: 0, Menor: 15, Llave Abierta: 18, Llave Cerrada: 15', 'No', 'auditiva y fisica', '2025-04-03 20:17:51'),
(240, 39, 'Departamento de Producción 2', 'Operario General', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', '', 'N/A', 'auditiva y fisica', '2025-04-03 20:17:51'),
(241, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué le pidió la abuela a Juan?', 'C', 'No', 'auditiva y fisica', '2025-04-03 20:24:41'),
(242, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'C', 'No', 'auditiva y fisica', '2025-04-03 20:24:41'),
(243, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 20:24:41'),
(244, 39, 'Departamento de Producción 2', 'Operario General', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-03 20:24:41'),
(245, 39, 'Departamento de Producción 2', 'Operario General', 3, 'Ejercicio 3: Generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', '', 'Si', 'auditiva y fisica', '2025-04-03 20:24:41'),
(246, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: PISCINA es a _____ como _____ es a Gasolina', 'B', 'Si', 'auditiva y fisica', '2025-04-03 20:24:41'),
(247, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'Si', 'auditiva y fisica', '2025-04-03 20:24:41'),
(248, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'No', 'auditiva y fisica', '2025-04-03 20:24:41'),
(249, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.1: Rompecabezas Visuales', '', 'Si', 'auditiva y fisica', '2025-04-03 20:24:41'),
(250, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.2: Puzzle 2x2', '', 'Si', 'auditiva y fisica', '2025-04-03 20:24:41'),
(251, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.3: Búsqueda de Símbolos', 'Mayor: 0, Menor: 0, Llave Abierta: 0, Llave Cerrada: 0', 'No', 'auditiva y fisica', '2025-04-03 20:24:41'),
(252, 39, 'Departamento de Producción 2', 'Operario General', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', '', 'N/A', 'auditiva y fisica', '2025-04-03 20:24:41'),
(253, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué le pidió la abuela a Juan?', 'C', 'No', 'auditiva y fisica', '2025-04-03 20:24:42'),
(254, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'C', 'No', 'auditiva y fisica', '2025-04-03 20:24:42'),
(255, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 20:24:42'),
(256, 39, 'Departamento de Producción 2', 'Operario General', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,b,e,a,d', 'Si', 'auditiva y fisica', '2025-04-03 20:24:42'),
(257, 39, 'Departamento de Producción 2', 'Operario General', 3, 'Ejercicio 3: Generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', '', 'Si', 'auditiva y fisica', '2025-04-03 20:24:42'),
(258, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: PISCINA es a _____ como _____ es a Gasolina', 'B', 'Si', 'auditiva y fisica', '2025-04-03 20:24:42'),
(259, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'Si', 'auditiva y fisica', '2025-04-03 20:24:42'),
(260, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'No', 'auditiva y fisica', '2025-04-03 20:24:42'),
(261, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.1: Rompecabezas Visuales', '', 'Si', 'auditiva y fisica', '2025-04-03 20:24:42'),
(262, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.2: Puzzle 2x2', '', 'Si', 'auditiva y fisica', '2025-04-03 20:24:42'),
(263, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.3: Búsqueda de Símbolos', 'Mayor: 0, Menor: 0, Llave Abierta: 0, Llave Cerrada: 0', 'No', 'auditiva y fisica', '2025-04-03 20:24:42'),
(264, 39, 'Departamento de Producción 2', 'Operario General', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', '', 'N/A', 'auditiva y fisica', '2025-04-03 20:24:42'),
(265, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 20:32:39'),
(266, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'C', 'No', 'auditiva y fisica', '2025-04-03 20:32:39'),
(267, 39, 'Departamento de Producción 2', 'Operario General', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-03 20:32:39'),
(268, 39, 'Departamento de Producción 2', 'Operario General', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,a,b,d,e', 'No', 'auditiva y fisica', '2025-04-03 20:32:39'),
(269, 39, 'Departamento de Producción 2', 'Operario General', 3, 'Ejercicio 3: Generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', '', 'Si', 'auditiva y fisica', '2025-04-03 20:32:39'),
(270, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: PISCINA es a _____ como _____ es a Gasolina', 'B', 'Si', 'auditiva y fisica', '2025-04-03 20:32:39'),
(271, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'Si', 'auditiva y fisica', '2025-04-03 20:32:39'),
(272, 39, 'Departamento de Producción 2', 'Operario General', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'SUPERVISOR', 'No', 'auditiva y fisica', '2025-04-03 20:32:39'),
(273, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.1: Rompecabezas Visuales', '', 'Si', 'auditiva y fisica', '2025-04-03 20:32:40'),
(274, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.2: Puzzle 2x2', '', 'Si', 'auditiva y fisica', '2025-04-03 20:32:40'),
(275, 39, 'Departamento de Producción 2', 'Operario General', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.3: Búsqueda de Símbolos', 'Mayor: 0, Menor: 0000000, Llave Abierta: 00000000, Llave Cerrada: 000000', 'No', 'auditiva y fisica', '2025-04-03 20:32:40'),
(276, 39, 'Departamento de Producción 2', 'Operario General', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', '', 'N/A', 'auditiva y fisica', '2025-04-03 20:32:40'),
(277, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-04 09:22:26'),
(278, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'B', 'No', 'auditiva y fisica', '2025-04-04 09:22:26'),
(279, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-04 09:22:26'),
(280, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,a,b,d,e', 'No', 'auditiva y fisica', '2025-04-04 09:22:26'),
(281, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'A', 'No', 'auditiva y fisica', '2025-04-04 09:22:26'),
(282, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-04 09:22:26'),
(283, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'No', 'auditiva y fisica', '2025-04-04 09:22:26'),
(284, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-04 09:22:26'),
(285, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-04 09:22:26'),
(286, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'c,b,a,d', 'Si', 'auditiva y fisica', '2025-04-04 09:22:27'),
(287, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 10, Menor: 8, Llave Abierta: 2, Llave Cerrada: 000000000', 'No', 'auditiva y fisica', '2025-04-04 09:22:27'),
(288, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-04 09:22:27'),
(289, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-04 09:22:27'),
(290, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Cuántos metros de cinta utilizó la abuela para el último moño?', 'A', 'Si', 'auditiva y fisica', '2025-04-04 09:22:27'),
(291, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'B', 'No', 'auditiva y fisica', '2025-04-04 09:22:27'),
(292, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'A', 'Si', 'auditiva y fisica', '2025-04-04 09:22:27'),
(293, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'c,a,b,d,e', 'No', 'auditiva y fisica', '2025-04-04 09:22:27'),
(294, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 3, 'Ejercicio 3: Generación de ideas / Matrices', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'A', 'No', 'auditiva y fisica', '2025-04-04 09:22:27'),
(295, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: BOTELLA es a ____ como ____ es a PLATO', 'B', 'Si', 'auditiva y fisica', '2025-04-04 09:22:27'),
(296, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'C', 'No', 'auditiva y fisica', '2025-04-04 09:22:28'),
(297, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 4, 'Ejercicio 4: Organización y Recopilación', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', '', 'No', 'auditiva y fisica', '2025-04-04 09:22:28'),
(298, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Rompecabezas Visual (opción única)', 'B', 'Si', 'auditiva y fisica', '2025-04-04 09:22:28'),
(299, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Puzzle 3x3 (slots)', 'c,b,a,d', 'Si', 'auditiva y fisica', '2025-04-04 09:22:28'),
(300, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo Búsqueda de Símbolos', 'Mayor: 10, Menor: 8, Llave Abierta: 2, Llave Cerrada: 000000000', 'No', 'auditiva y fisica', '2025-04-04 09:22:28'),
(301, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Serie de dígitos escuchada', '', 'N/A', 'auditiva y fisica', '2025-04-04 09:22:28'),
(302, 39, 'Departamento Administrativo 2', 'Jefe de cordinador de sistema', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', 'Adapt1:, Adapt2:, Adapt3:, Adapt4:, Adapt5:, Rel1:, Rel2:, Rel3:, Esc1:, Esc2:, Esc3:, Esc4:, As1:, As2:, As3:', 'N/A', 'auditiva y fisica', '2025-04-04 09:22:28'),
(303, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué le pidió la abuela a Juan?', 'A', 'Si', 'auditiva, fisica', '2025-04-16 00:04:34'),
(304, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿Qué se infiere de la información?', 'B', 'No', 'auditiva, fisica', '2025-04-16 00:04:34'),
(305, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 1, 'Ejercicio 1: Comprensión Lectora', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', '¿En qué consistió la trampa del comerciante?', 'C', 'No', 'auditiva, fisica', '2025-04-16 00:04:34'),
(306, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 2, 'Ejercicio 2: Competencia de Escritura', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Orden final de palabras', 'd,b,c,a,e', 'No', 'auditiva, fisica', '2025-04-16 00:04:34'),
(307, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 3, 'Ejercicio 3: Generación de ideas y pensamiento analítico', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Imagen faltante (opción)', 'C', 'No', 'auditiva, fisica', '2025-04-16 00:04:34'),
(308, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Analogías verbales: PISCINA es a _____ como _____ es a Gasolina', '', 'No', 'auditiva, fisica', '2025-04-16 00:04:34'),
(309, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo con dibujos: Seleccione el nombre correcto a la figura', 'B', 'No', 'auditiva, fisica', '2025-04-16 00:04:34'),
(310, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 4, 'Ejercicio 4: Organización y recopilación de la información', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones', 'MAQUINARI', 'Si', 'auditiva, fisica', '2025-04-16 00:04:35'),
(311, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.1: Rompecabezas Visuales', '', 'Si', 'auditiva, fisica', '2025-04-16 00:04:35'),
(312, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.2: Puzzle 2x2', '', 'Si', 'auditiva, fisica', '2025-04-16 00:04:35'),
(313, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 5, 'Ejercicio 5: Planificación y Toma de Decisiones', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Reactivo 5.3: Búsqueda de Símbolos', 'Mayor: 0, Menor: 0, Llave Abierta: 0, Llave Cerrada: 0', 'No', 'auditiva, fisica', '2025-04-16 00:04:35'),
(314, 49, 'Departamento de Gerencia General', 'Asistente Jurídico', 6, 'Ejercicio 6: Competencias (Tabla)', 'Ejercicios para Discapacidad: Auditiva, Física y Visual', 'Evaluación de competencias (tabla)', '', 'N/A', 'auditiva, fisica', '2025-04-16 00:04:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultados_encuesta`
--

CREATE TABLE `resultados_encuesta` (
  `id_encuesta` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_discapacidad` int(11) DEFAULT NULL,
  `nombre_departamento` varchar(100) NOT NULL,
  `cargo_departamento` varchar(100) NOT NULL,
  `pregunta_1` varchar(75) DEFAULT NULL,
  `pregunta_2` varchar(75) DEFAULT NULL,
  `pregunta_3` varchar(75) DEFAULT NULL,
  `pregunta_4` varchar(75) DEFAULT NULL,
  `pregunta_5` varchar(75) DEFAULT NULL,
  `pregunta_6` varchar(75) DEFAULT NULL,
  `pregunta_7` varchar(75) DEFAULT NULL,
  `pregunta_8` varchar(75) DEFAULT NULL,
  `pregunta_9` varchar(75) DEFAULT NULL,
  `pregunta_10` varchar(75) DEFAULT NULL,
  `pregunta_11` varchar(75) DEFAULT NULL,
  `pregunta_12` varchar(75) DEFAULT NULL,
  `pregunta_13` varchar(75) DEFAULT NULL,
  `pregunta_14` varchar(75) DEFAULT NULL,
  `pregunta_15` varchar(75) DEFAULT NULL,
  `pregunta_16` varchar(75) DEFAULT NULL,
  `pregunta_17` varchar(75) DEFAULT NULL,
  `pregunta_18` varchar(75) DEFAULT NULL,
  `pregunta_19` varchar(75) DEFAULT NULL,
  `pregunta_20` varchar(75) DEFAULT NULL,
  `pregunta_21` varchar(75) DEFAULT NULL,
  `pregunta_22` varchar(75) DEFAULT NULL,
  `pregunta_23` varchar(75) DEFAULT NULL,
  `pregunta_24` varchar(75) DEFAULT NULL,
  `pregunta_25` varchar(75) DEFAULT NULL,
  `pregunta_26` varchar(75) DEFAULT NULL,
  `pregunta_27` varchar(75) DEFAULT NULL,
  `pregunta_28` varchar(75) DEFAULT NULL,
  `pregunta_29` varchar(75) DEFAULT NULL,
  `pregunta_30` varchar(75) DEFAULT NULL,
  `pregunta_31` varchar(75) DEFAULT NULL,
  `pregunta_32` varchar(75) DEFAULT NULL,
  `pregunta_33` varchar(75) DEFAULT NULL,
  `pregunta_34` varchar(75) DEFAULT NULL,
  `pregunta_35` varchar(75) DEFAULT NULL,
  `pregunta_36` varchar(75) DEFAULT NULL,
  `pregunta_37` varchar(75) DEFAULT NULL,
  `pregunta_38` varchar(75) DEFAULT NULL,
  `pregunta_39` varchar(75) DEFAULT NULL,
  `pregunta_40` varchar(75) DEFAULT NULL,
  `pregunta_41` varchar(75) DEFAULT NULL,
  `pregunta_42` varchar(75) DEFAULT NULL,
  `pregunta_43` varchar(75) DEFAULT NULL,
  `pregunta_44` varchar(75) DEFAULT NULL,
  `pregunta_45` varchar(75) DEFAULT NULL,
  `pregunta_46` varchar(75) DEFAULT NULL,
  `pregunta_47` varchar(75) DEFAULT NULL,
  `pregunta_48` varchar(75) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resultados_encuesta`
--

INSERT INTO `resultados_encuesta` (`id_encuesta`, `id_usuario`, `id_discapacidad`, `nombre_departamento`, `cargo_departamento`, `pregunta_1`, `pregunta_2`, `pregunta_3`, `pregunta_4`, `pregunta_5`, `pregunta_6`, `pregunta_7`, `pregunta_8`, `pregunta_9`, `pregunta_10`, `pregunta_11`, `pregunta_12`, `pregunta_13`, `pregunta_14`, `pregunta_15`, `pregunta_16`, `pregunta_17`, `pregunta_18`, `pregunta_19`, `pregunta_20`, `pregunta_21`, `pregunta_22`, `pregunta_23`, `pregunta_24`, `pregunta_25`, `pregunta_26`, `pregunta_27`, `pregunta_28`, `pregunta_29`, `pregunta_30`, `pregunta_31`, `pregunta_32`, `pregunta_33`, `pregunta_34`, `pregunta_35`, `pregunta_36`, `pregunta_37`, `pregunta_38`, `pregunta_39`, `pregunta_40`, `pregunta_41`, `pregunta_42`, `pregunta_43`, `pregunta_44`, `pregunta_45`, `pregunta_46`, `pregunta_47`, `pregunta_48`, `fecha_registro`) VALUES
(1, 0, NULL, 'Departamento Administrativo', 'Cargos del Departamento Administrativo', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-09 23:21:48'),
(2, 0, NULL, 'Departamento Administrativo', 'Cargos del Departamento Administrativo', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-09 23:26:43'),
(3, 0, NULL, 'Departamento de Talento Humano 1', 'Cargos del Departamento de Talento Humano 1', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema leve', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'Problema leve', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', 'No hay problema', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 00:02:59'),
(4, 0, NULL, 'Departamento Administrativo', 'Cargos del Departamento Administrativo', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema completo', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 18:23:02'),
(5, 0, NULL, 'Departamento de Producción 1', 'Cargos del Departamento de Producción 1', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema grave', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema grave', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema grave', 'Problema grave', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', '2025-04-10 18:57:35'),
(6, 0, NULL, 'Departamento de Producción', 'Operario General', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema grave', 'Problema leve', 'No hay problema', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema grave', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 19:05:47'),
(7, 0, NULL, 'Departamento de Talento Humano 4', 'Cargos del Departamento de Talento Humano 4', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 19:09:20'),
(8, 0, NULL, 'Departamento de Talento Humano 4', 'Cargos del Departamento de Talento Humano 4', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema grave', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 19:10:21'),
(9, 0, NULL, 'Departamento de Talento Humano 3', 'Cargos del Departamento de Talento Humano 3', 'No hay problema', 'Problema moderado', 'Problema leve', 'Problema grave', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 19:14:15'),
(10, 0, NULL, 'Departamento de Talento Humano 2', 'Cargos del Departamento de Talento Humano 2', 'No hay problema', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema leve', 'No hay problema', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 19:16:39'),
(11, 0, NULL, 'Departamento de Talento Humano 1', 'Cargos del Departamento de Talento Humano 1', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema completo', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema completo', 'No hay problema', 'Problema grave', 'Problema completo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 19:18:23'),
(12, 0, NULL, 'Departamento Financiero', 'Cargos del Departamento Financiero', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema completo', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-10 19:22:27'),
(13, 0, NULL, 'Departamento Gerencia General', 'JefeCoordinadorJurídico', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 05:10:22'),
(14, 0, NULL, 'Departamento Financiero', 'Cargos del Departamento Financiero', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'No hay problema', 'No hay problema', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema moderado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 05:35:34'),
(15, 0, NULL, 'Departamento Gerencia General', 'AsistenteDeGerencia', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema leve', 'No hay problema', 'No hay problema', 'Problema moderado', 'Problema grave', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-16 13:18:16'),
(16, 0, NULL, 'Departamento de Talento Humano 1', 'Cargos del Departamento de Talento Humano 1', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema grave', 'Problema grave', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-20 21:02:46'),
(17, 0, NULL, 'Departamento de Talento Humano 2', 'Cargos del Departamento de Talento Humano 2', 'No hay problema', 'Problema leve', 'No hay problema', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-21 03:49:50'),
(18, 0, NULL, 'Departamento de Talento Humano 4', 'Cargos del Departamento de Talento Humano 4', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-21 06:55:42'),
(19, 0, NULL, 'Departamento Administrativo 2', 'Cargos del Departamento Administrativo 2', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema grave', 'Problema moderado', 'Problema completo', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', NULL, NULL, NULL, NULL, '2025-04-21 13:18:03'),
(20, 0, NULL, 'Departamento Administrativo 2', 'Cargos del Departamento Administrativo 2', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema grave', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', NULL, NULL, NULL, NULL, '2025-04-21 13:22:49'),
(21, 0, NULL, 'Departamento Financiero', 'Cargos del Departamento Financiero', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema moderado', 'Problema leve', 'Problema moderado', 'Problema moderado', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-21 13:27:14'),
(22, 0, NULL, 'Departamento Comercial', 'Cargos del Departamento Comercial', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', 'Problema moderado', 'Problema leve', 'No hay problema', 'Problema leve', 'Problema moderado', 'Problema grave', 'Problema completo', 'Problema grave', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-21 14:49:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_discapacidad` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL,
  `id_estado_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `id_discapacidad`, `id_estado`, `id_estado_rol`) VALUES
(36, 'Admin', 'admin@example.com', '$2y$10$N9Gn0N5hPk1YhA2dVU6lweaRa1Db4eKVSTiR2IRa60ncIBUt.3z8G', 4, 1, 1),
(37, 'Elsa Pato', 'elsapatricia@gmail.com', '$2y$10$jw2dvBZvKZVFyXL8EDZQjuKXqonbZ.qJd13pJkGlx0I9Ofx3nkwSm', 2, 3, 2),
(38, 'mauricio', '17pmauricio@gmail.com', '$2y$10$r14cfpPZ/5dUKMUyOUOXIO7KQJ7ia9oPRUN9bBLw3F2JOGv4pGuQy', 3, 3, 2),
(39, 'Mauricio Ponce', 'mauricio.ponce.48@est.ucacue.edu.ec', '$2y$10$zcUde00jlRc9ACq.zEXMYeUOdyp0Q1Az.vbiOzEOe3xUVHgL4ZWwW', 3, 3, 2),
(41, 'Veronica', 'verojuj1993@hotmail.com', '$2y$10$jt7GWo0e6T2oQTmWs2ae2e4GozYsB2JLsm.o5ZTZbGQ72i3ZlhqmG', 1, 3, 2),
(42, 'Leandro Gado', 'leandro123@gmail.com', '$2y$10$orXJM0NMyWpzkqXIWhOAN.Fr8zjy5vj033Ty3wjPGZIi6aEBvbG1m', 5, 3, 2),
(43, 'Elena Nito', 'elena@dominio.com', '$2y$10$dq6W.59BEKp2i2hrcGHsLe.AL4c9Rrrv8pQzsUYWJrAS2rbyMryuO', 3, 3, 2),
(44, 'Elba Surero', 'elbasurero4@gmail.com', '$2y$10$kCoyszDuln1df8sdP9xvfeoueJcV73nYkT8Voq5LkaCebLKSKayQm', 1, 3, 2),
(46, 'Mauricio Ponce m', '17mpmauricio@gmail.com', '$2y$10$CNJk189peiP/9Rs7oLdSfuR7z549QWkTq8nySzUyf6cOUj.qvv08q', 3, 3, 2),
(49, 'Elvis Cocho', 'elvis1999@ucacue.com', '$2y$10$5b6QO4woPYodIQ980bgSveo9hJmTP5nlV5JTzmv9VaUv1FmDQClSi', 1, 3, 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `discapacidad`
--
ALTER TABLE `discapacidad`
  ADD PRIMARY KEY (`id_discapacidad`);

--
-- Indices de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD PRIMARY KEY (`id_ejercicio`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id_pregunta`),
  ADD KEY `id_ejercicio` (`id_ejercicio`);

--
-- Indices de la tabla `preguntasyrespuestas`
--
ALTER TABLE `preguntasyrespuestas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id_respuesta`),
  ADD KEY `fk_respuestas_usuario` (`id_usuario`);

--
-- Indices de la tabla `resultados_encuesta`
--
ALTER TABLE `resultados_encuesta`
  ADD PRIMARY KEY (`id_encuesta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `unique_email` (`email`),
  ADD UNIQUE KEY `unique_nombre` (`nombre`),
  ADD KEY `fk_usuarios_discapacidad` (`id_discapacidad`),
  ADD KEY `fk_usuarios_estado` (`id_estado`),
  ADD KEY `fk_usuarios_estado_rol` (`id_estado_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `discapacidad`
--
ALTER TABLE `discapacidad`
  MODIFY `id_discapacidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  MODIFY `id_ejercicio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `preguntasyrespuestas`
--
ALTER TABLE `preguntasyrespuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id_respuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=315;

--
-- AUTO_INCREMENT de la tabla `resultados_encuesta`
--
ALTER TABLE `resultados_encuesta`
  MODIFY `id_encuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`id_ejercicio`) REFERENCES `ejercicios` (`id_ejercicio`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_fk_discapacidad` FOREIGN KEY (`id_discapacidad`) REFERENCES `discapacidad` (`id_discapacidad`) ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_fk_estado` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`) ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_fk_estado_rol` FOREIGN KEY (`id_estado_rol`) REFERENCES `estado` (`id_estado`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
