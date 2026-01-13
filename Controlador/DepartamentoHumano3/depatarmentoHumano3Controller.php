<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

// 1. Incluir la conexión (ajusta la ruta según tu proyecto)
require_once '../../Modelo/conexion.php';
$pdo = Conexion::conectar();
if (!$pdo) {
    die("No se pudo establecer la conexión a la base de datos.");
}

// 2. Verificar que el usuario esté autenticado
if (!isset($_SESSION['user'])) {
    die("Error: Usuario no autenticado. Por favor, inicie sesión.");
}
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    die("Error: No se encontró el ID del usuario en la sesión.");
}

// 3. Verificar que la petición sea POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    exit();
}

// 4. Recoger datos de contexto (estos pueden venir de campos ocultos o de la sesión)
$departamento  = $_POST['prefijoDepartamento'] ?? '';
$cargo_laboral = $_POST['prefijoCargo'] ?? '';
$discapacidad  = $_POST['prefijoDiscapacidad'] ?? '';

// 5. Función para insertar en la tabla 'respuestas'
function insertRespuesta(
    $pdo, 
    $id_usuario, 
    $departamento, 
    $cargo_laboral, 
    $ejercicio, 
    $titulo_ejercicio, 
    $contexto_ejercicio, 
    $pregunta, 
    $respuesta, 
    $discapacidad, 
    $resultado
) {
    $sql = "INSERT INTO respuestas 
            (id_usuario, departamento, cargo_laboral, ejercicio, titulo_ejercicio, 
             contexto_ejercicio, pregunta, respuesta, Discapacidad, respuestaCorrectaONo)
            VALUES 
            (:id_usuario, :departamento, :cargo_laboral, :ejercicio, :titulo_ejercicio, 
             :contexto_ejercicio, :pregunta, :respuesta, :discapacidad, :resultado)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        ':id_usuario'         => $id_usuario,
        ':departamento'       => $departamento,
        ':cargo_laboral'      => $cargo_laboral,
        ':ejercicio'          => $ejercicio,
        ':titulo_ejercicio'   => $titulo_ejercicio,
        ':contexto_ejercicio' => $contexto_ejercicio,
        ':pregunta'           => $pregunta,
        ':respuesta'          => $respuesta,
        ':discapacidad'       => $discapacidad,
        ':resultado'          => $resultado
    ]);
}

/*======================================
=            EJERCICIO 1             =
======================================*/
// Ejercicio 1: Comprensión Lectora
$contextoEjercicio1 = "Ejercicio 1: Comprensión Lectora";
$correctaE1_Q1 = "A";
$correctaE1_Q2 = "A";
$correctaE1_Q3 = "A";

$r1_1 = $_POST['respuesta1'] ?? '';
$r1_2 = $_POST['respuesta2'] ?? '';
$r1_3 = $_POST['respuesta3'] ?? '';

$evalE1_Q1 = ($r1_1 === $correctaE1_Q1) ? 1 : 0;
$evalE1_Q2 = ($r1_2 === $correctaE1_Q2) ? 1 : 0;
$evalE1_Q3 = ($r1_3 === $correctaE1_Q3) ? 1 : 0;
$aciertosE1 = $evalE1_Q1 + $evalE1_Q2 + $evalE1_Q3;
$porcentajeE1 = round(($aciertosE1 / 3) * 100);

insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio1,
    "¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?", $r1_1, $discapacidad, ($evalE1_Q1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio1,
    "¿Qué se infiere de esta información?", $r1_2, $discapacidad, ($evalE1_Q2 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio1,
    "¿En qué consistió la trampa del comerciante?", $r1_3, $discapacidad, ($evalE1_Q3 ? "Si" : "No"));

/*======================================
=            EJERCICIO 2             =
======================================*/
// Ejercicio 2: Competencia de Escritura
$contextoEjercicio2 = "Ejercicio 2: Competencia de Escritura";
$ordenCorrectoE2 = "d,b,c,a,e";

$ordenFinalE2 = $_POST['ordenFinal'] ?? '';
$evalE2 = (strtolower(trim($ordenFinalE2)) === strtolower(trim($ordenCorrectoE2))) ? 1 : 0;
$aciertosE2 = $evalE2;
$porcentajeE2 = round(($aciertosE2 / 1) * 100);

insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 2,
    "Ejercicio 2: Competencia de Escritura", $contextoEjercicio2,
    "Orden final de palabras", $ordenFinalE2, $discapacidad, ($evalE2 ? "Si" : "No"));

/*======================================
=            EJERCICIO 3             =
======================================*/
// Ejercicio 3: Generación de ideas y pensamiento analítico
$contextoEjercicio3 = "Ejercicio 3: Generación de ideas y pensamiento analítico";
$correctaE3 = "B";

$rE3 = $_POST['respuestaE3'] ?? '';
$evalE3 = ($rE3 === $correctaE3) ? 1 : 0;
$aciertosE3 = $evalE3;
$porcentajeE3 = round(($aciertosE3 / 1) * 100);

insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3,
    "Ejercicio 3: Generación de ideas y pensamiento analítico", $contextoEjercicio3,
    "Respuesta de la imagen: ¿Cuál es la opción correcta?", $rE3, $discapacidad, ($evalE3 ? "Si" : "No"));

/*======================================
=            EJERCICIO 4             =
======================================*/
// Ejercicio 4: Organización y Recopilación de la Información
$contextoEjercicio4 = "Ejercicio 4: Organización y Recopilación de la Información";
$correctaE4_Analogias = "D";  // Para la analogía: opción B es la correcta
$correctaE4_Dibujos1  = "B";  // Para el reactivo con dibujos: opción D ("Bodega") es la correcta

$r4_Analogias = $_POST['respuesta4_Analogias'] ?? '';
$r4_Dibujos1  = $_POST['respuesta4_Dibujos1'] ?? '';

$evalE4_Analogias = ($r4_Analogias === $correctaE4_Analogias) ? 1 : 0;
$evalE4_Dibujos1  = ($r4_Dibujos1 === $correctaE4_Dibujos1) ? 1 : 0;
$aciertosE4 = $evalE4_Analogias + $evalE4_Dibujos1;
$porcentajeE4 = round(($aciertosE4 / 2) * 100);

insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y Recopilación", $contextoEjercicio4,
    "Analogías verbales: BOTELLA es a ____ como ____ es a PLATO", $r4_Analogias, $discapacidad, ($evalE4_Analogias ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y Recopilación", $contextoEjercicio4,
    "Reactivo con Dibujos: Seleccione el nombre correcto a la figura (imagen: Almacén con estanterías)", $r4_Dibujos1, $discapacidad, ($evalE4_Dibujos1 ? "Si" : "No"));

/*======================================
=            EJERCICIO 5             =
======================================*/
// Ejercicio 5: Planificación y Toma de Decisiones
// Se procesa este ejercicio solo para usuarios sin discapacidad visual.
$contextoEjercicio5 = "Ejercicio 5: Planificación y Toma de Decisiones";

// Reactivo 5.1: Rompecabezas visual 1
$correctaE5_1 = "B"; // Según ejemplo
$r5_1 = $_POST['respuesta5_1'] ?? '';
$evalE5_1 = ($r5_1 === $correctaE5_1) ? 1 : 0;

// Reactivo 5.2: Rompecabezas visual 2 (Puzzle 2x2)
// Se recoge el valor del input hidden "slot1" que debe contener la letra de la pieza colocada (correcta: "B")
$correctaE5_2 = "B";
$slot1 = $_POST['slot1'] ?? '';
$evalE5_2 = (strtoupper(trim($slot1)) === strtoupper($correctaE5_2)) ? 1 : 0;

// Reactivo 5.3: Búsqueda de Símbolos
// Se esperan: 2 llaves cerradas, 2 signos "<" y 3 signos ">"
$esperadoLlaveCerrada = 14;
$esperadoMenor = 13;
$esperadoMayor = 10;

$busquedaLlaveAbierta = $_POST['busquedaLlaveAbierta'] ?? 0;
$busquedaLlaveCerrada = $_POST['busquedaLlaveCerrada'] ?? 0;
$busquedaMenor = $_POST['busquedaMenor'] ?? 0;
$busquedaMayor = $_POST['busquedaMayor'] ?? 0;

$evalE5_3 = (
    ($busquedaLlaveCerrada == $esperadoLlaveCerrada) &&
    ($busquedaMenor == $esperadoMenor) &&
    ($busquedaMayor == $esperadoMayor)
) ? 1 : 0;

$aciertosE5 = $evalE5_1 + $evalE5_2 + $evalE5_3;
$porcentajeE5 = round(($aciertosE5 / 3) * 100);

// Insertar respuestas del Ejercicio 5
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
    "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio5,
    "Reactivo de puzles visuales 1: ¿Cuál es la opción correcta?", $r5_1, $discapacidad, ($evalE5_1 ? "Si" : "No"));

insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
    "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio5,
    "Reactivo de puzles visuales 2 (Puzzle 2x2): Valor del slot", $slot1, $discapacidad, ($evalE5_2 ? "Si" : "No"));

// Para la búsqueda de símbolos se combina la información en un string.
$respuestaBusqueda = "Mayor: $busquedaMayor, Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada";
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
    "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio5,
    "Reactivo Búsqueda de Símbolos", $respuestaBusqueda, $discapacidad, ($evalE5_3 ? "Si" : "No"));

/*======================================
=        MOSTRAR RESUMEN FINAL         =
======================================*/
echo "<style>
        .tabla-resultados {
            width: 70%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 1.1em;
        }
        .tabla-resultados th, .tabla-resultados td {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .tabla-resultados th {
            background-color: #4CAF50;
            color: #fff;
            font-size: 1.3em;
            font-weight: bold;
        }
        .tabla-resultados caption {
            margin-bottom: 10px;
            font-size: 1.6em;
            font-weight: bold;
        }
      </style>";

echo "<h1 style='text-align:center; color:#4CAF50;'>Respuestas guardadas correctamente</h1>";
echo "<table class='tabla-resultados'>";
echo "  <caption>Resumen de Resultados</caption>";
echo "  <tr><th>Ejercicio</th><th>Progreso</th></tr>";
echo "  <tr><td>Ejercicio 1</td><td>{$aciertosE1} de 3 ({$porcentajeE1}%)</td></tr>";
echo "  <tr><td>Ejercicio 2</td><td>{$aciertosE2} de 1 ({$porcentajeE2}%)</td></tr>";
echo "  <tr><td>Ejercicio 3</td><td>{$aciertosE3} de 1 ({$porcentajeE3}%)</td></tr>";
echo "  <tr><td>Ejercicio 4</td><td>{$aciertosE4} de 2 ({$porcentajeE4}%)</td></tr>";
echo "  <tr><td>Ejercicio 5</td><td>{$aciertosE5} de 3 ({$porcentajeE5}%)</td></tr>";
echo "</table>";
?>
