<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

// ================================================
// 1. Incluir la conexión (ajusta la ruta según tu proyecto)
// ================================================
require_once '../../Modelo/conexion.php';
$pdo = Conexion::conectar();
if (!$pdo) {
    die("No se pudo establecer la conexión a la base de datos.");
}

// ================================================
// 2. Verificar que el usuario esté autenticado
// ================================================
if (!isset($_SESSION['user'])) {
    die("Error: Usuario no autenticado. Por favor, inicie sesión.");
}
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    die("Error: No se encontró el ID del usuario en la sesión.");
}

// ================================================
// 3. Verificar que la petición sea POST
// ================================================
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    exit();
}

// ================================================
// 4. Recoger datos de contexto enviados desde la vista
// ================================================
$departamento  = $_POST['prefijoDepartamento'] ?? '';
$cargo_laboral = $_POST['prefijoCargo'] ?? '';
$discapacidad  = $_POST['prefijoDiscapacidad'] ?? '';
// Usamos también una variable para la inserción:
$discapacidadRegistro = $discapacidad;
$contextoEjercicio = "Ejercicios para Discapacidad: Auditiva, Física y Visual";

// ================================================
// 5. Función para insertar en la tabla 'respuestas'
// ================================================
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
             contexto_ejercicio, pregunta, respuesta, Discapacidad, respuestaCorrectaoNo)
            VALUES 
            (:id_usuario, :departamento, :cargo_laboral, :ejercicio, :titulo_ejercicio, 
             :contexto_ejercicio, :pregunta, :respuesta, :discapacidad, :resultado)";
    $stmt = $pdo->prepare($sql);
    if (!$stmt->execute([
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
    ])) {
        $error = $stmt->errorInfo();
        die("Error en la inserción: " . $error[2]);
    }
}

// ================================================
// 6. Definir respuestas correctas para cada ejercicio
// ================================================
// EJERCICIO 1: Comprensión Lectora (3 preguntas)
$correctaE1_Q1 = "A";
$correctaE1_Q2 = "A";
$correctaE1_Q3 = "A";

// EJERCICIO 2: Ordenar palabras (se espera: "c,b,e,a,d")
$ordenCorrectoE2 = "c,b,e,a,d";

// EJERCICIO 3: Reactivo de Matrices
$correctaE3 = "C";

// EJERCICIO 4: Organización y Recopilación (3 subreactivos)
$correctaE4_Analogias = "B";      // Ej.: "agua - depósito"
$correctaE4_Dibujos1  = "D";      // Ej.: "Bodega"
$correctaE4_Verbal    = "MAQUINARIA"; // Ej.: "Instrumento productivo"

// EJERCICIO 5 – Versión original (usuarios sin discapacidad visual, 3 ítems)
$correctaE5_1 = "B";
$correctaE5_2 = "C,B,A,D";
// Para esta versión se insertan los valores de PPE y símbolos como "N/A"
$correctaPPE1  = "A"; // No se evalúan en esta versión
$correctaPPE2  = "A"; // No se evalúan en esta versión

// Valores esperados para el reactivo de Búsqueda de Símbolos (Ejercicio 5)
$esperadoMenor = 8;
$esperadoLlaveAbierta = 14;
$esperadoLlaveCerrada = 7;

// ================================================
// 7. Recoger las respuestas enviadas desde la vista
// ================================================
// EJERCICIO 1
$r1_1 = $_POST['respuesta1'] ?? '';
$r1_2 = $_POST['respuesta2'] ?? '';
$r1_3 = $_POST['respuesta3'] ?? '';

// EJERCICIO 2
$ordenFinalE2 = $_POST['ordenFinal'] ?? '';

// EJERCICIO 3
$rE3 = $_POST['respuestaE3'] ?? '';

// EJERCICIO 4
$r4_Analogias = $_POST['respuesta4_Analogias'] ?? '';
$r4_Dibujos1  = $_POST['respuesta4_Dibujos1'] ?? '';
$r4_Verbal    = $_POST['respuesta4_Verbal'] ?? '';

// EJERCICIO 5
$r5_1 = $_POST['respuesta5_rompecabezas'] ?? '';
$slot1 = $_POST['slot1'] ?? '';
$slot2 = $_POST['slot2'] ?? '';
$slot3 = $_POST['slot3'] ?? '';
$slot4 = $_POST['slot4'] ?? '';
$subE5_2 = strtolower(trim($slot1 . "," . $slot2 . "," . $slot3 . "," . $slot4));
$respuestaPPE1 = $_POST['respuestaPPE1'] ?? '';
$respuestaPPE2 = $_POST['respuestaPPE2'] ?? '';
$busquedaMenor = $_POST['busquedaMenor'] ?? 0;
$busquedaLlaveAbierta = $_POST['busquedaLlaveAbierta'] ?? 0;
$busquedaLlaveCerrada = $_POST['busquedaLlaveCerrada'] ?? 0;
$retencionDigitos = $_POST['retencionDigitos'] ?? '';

// Para este controlador, se procesa la versión original del Ejercicio 5
$evalE5_1 = ($r5_1 === $correctaE5_1) ? 1 : 0;
$evalE5_2 = (strtolower(trim($subE5_2)) === strtolower($correctaE5_2)) ? 1 : 0;
$evalE5_3 = (
    ($busquedaLlaveAbierta == $esperadoLlaveAbierta) &&
    ($busquedaLlaveCerrada == $esperadoLlaveCerrada) &&
    ($busquedaMenor == $esperadoMenor) &&
    ($busquedaMayor == $esperadoMayor)
) ? 1 : 0;
$aciertosE5 = $evalE5_1 + $evalE5_2 + $evalE5_3;  // Máximo: 3
$porcentajeE5 = round(($aciertosE5 / 3) * 100);

// ================================================
// 8. Validar las respuestas y calcular aciertos
// ================================================
// EJERCICIO 1
$evalE1_Q1 = ($r1_1 === $correctaE1_Q1) ? 1 : 0;
$evalE1_Q2 = ($r1_2 === $correctaE1_Q2) ? 1 : 0;
$evalE1_Q3 = ($r1_3 === $correctaE1_Q3) ? 1 : 0;
$aciertosE1 = $evalE1_Q1 + $evalE1_Q2 + $evalE1_Q3;  // Máximo: 3

// EJERCICIO 2
$evalE2 = (strtolower(trim($ordenFinalE2)) === strtolower(trim($ordenCorrectoE2))) ? 1 : 0;
$aciertosE2 = $evalE2;  // Máximo: 1

// EJERCICIO 3
$evalE3 = ($rE3 === $correctaE3) ? 1 : 0;
$aciertosE3 = $evalE3;  // Máximo: 1

// EJERCICIO 4
$evalE4_Analogias = ($r4_Analogias === $correctaE4_Analogias) ? 1 : 0;
$evalE4_Dibujos1  = ($r4_Dibujos1 === $correctaE4_Dibujos1) ? 1 : 0;
$evalE4_Verbal    = (strtoupper($r4_Verbal) === strtoupper($correctaE4_Verbal)) ? 1 : 0;
$aciertosE4 = $evalE4_Analogias + $evalE4_Dibujos1 + $evalE4_Verbal;  // Máximo: 3

// EJERCICIO 5 ya se procesó anteriormente
// (aciertosE5 y porcentajeE5 ya están calculados)

// ================================================
// 9. Insertar las respuestas en la base de datos
// ================================================
// EJERCICIO 1
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
    "¿Qué le pidió la abuela a Juan?", $r1_1, $discapacidadRegistro, ($evalE1_Q1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
    "¿Qué se infiere de la información?", $r1_2, $discapacidadRegistro, ($evalE1_Q2 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
    "¿En qué consistió la trampa del comerciante?", $r1_3, $discapacidadRegistro, ($evalE1_Q3 ? "Si" : "No"));

// EJERCICIO 2
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 2,
    "Ejercicio 2: Competencia de Escritura", $contextoEjercicio,
    "Orden final de palabras", $ordenFinalE2, $discapacidadRegistro, ($evalE2 ? "Si" : "No"));

// EJERCICIO 3
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3,
    "Ejercicio 3: Generación de ideas y pensamiento analítico", $contextoEjercicio,
    "Imagen faltante (opción)", $rE3, $discapacidadRegistro, ($evalE3 ? "Si" : "No"));

// EJERCICIO 4
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y recopilación de la información", $contextoEjercicio,
    "Analogías verbales: BOTELLA es a ____ como ____ es a PLATO", $r4_Analogias, $discapacidadRegistro, ($evalE4_Analogias ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y recopilación de la información", $contextoEjercicio,
    "Reactivo con dibujos: Seleccione el nombre correcto a la figura", $r4_Dibujos1, $discapacidadRegistro, ($evalE4_Dibujos1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y recopilación de la información", $contextoEjercicio,
    "Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones", $r4_Verbal, $discapacidadRegistro, ($evalE4_Verbal ? "Si" : "No"));

// EJERCICIO 5
if (!isset($_POST['adapt_respuestaPPE1'])) {
    // Versión original para usuarios sin discapacidad visual (3 ítems)
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Rompecabezas Visuales", $r5_1, $discapacidadRegistro, ($evalE5_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Puzzle 3x3 (slots)", $subE5_2, $discapacidadRegistro, ($evalE5_2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Búsqueda de Símbolos", "Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada",
        $discapacidadRegistro, ($evalE5_3 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Serie de dígitos escuchada", $retencionDigitos, $discapacidadRegistro, "N/A");
} else {
    // Si se usara la versión adaptada, se procesaría la otra lógica (no incluida en este controlador)
}

// EJERCICIO 6 (Tabla de competencias) – No se valida en este ejemplo
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 6,
    "Ejercicio 6: Competencias (Tabla)", $contextoEjercicio,
    "Evaluación de competencias (tabla)", $tablaCompetencias ?? "N/A", $discapacidadRegistro, "N/A");

// ================================================
// 10. Calcular porcentajes de aciertos y mostrar resumen
// ================================================
$porcentajeE1 = round(($aciertosE1 / 3) * 100);
$porcentajeE2 = round(($aciertosE2 / 1) * 100);
$porcentajeE3 = round(($aciertosE3 / 1) * 100);
$porcentajeE4 = round(($aciertosE4 / 3) * 100);
$porcentajeE5 = round(($aciertosE5 / 3) * 100);

echo "<style>
        .tabla-resultados {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            font-size: 1.2em;
        }
        .tabla-resultados th, .tabla-resultados td {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .tabla-resultados th {
            background-color: #4CAF50;
            color: #fff;
            font-size: 1.5em;
            font-weight: bold;
        }
        .tabla-resultados tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .tabla-resultados caption {
            margin-bottom: 10px;
            font-size: 1.8em;
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
echo "  <tr><td>Ejercicio 4</td><td>{$aciertosE4} de 3 ({$porcentajeE4}%)</td></tr>";
echo "  <tr><td>Ejercicio 5</td><td>{$aciertosE5} de 3 ({$porcentajeE5}%)</td></tr>";
echo "</table>";
?>
