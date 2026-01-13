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

$userDisability = $_SESSION['user']['id_discapacidad'] ?? null;
$esVisual = ($userDisability == 1);
$discapacidadRegistro = $userDisability;

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
$discapacidadRegistro = $discapacidad; // para la inserción en BD
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

// EJERCICIO 2: Ordenar palabras  
// Se espera el orden: "a,b,c,d"
$ordenCorrectoE2 = "d,a,c,d";

// EJERCICIO 3: Reactivo de Matrices
$correctaE3 = "C";

// EJERCICIO 4: Organización y Recopilación (3 subreactivos)
$correctaE4_Analogias = "B";      // Ej.: "agua - depósito"
$correctaE4_Dibujos1  = "C";      // Ej.: "Bodega"
$correctaE4_Verbal    = "MAQUINARIA"; // Ej.: "Instrumento productivo"

// EJERCICIO 5 – Versión normal (usuarios sin discapacidad visual)
// Reactivo 5.1: Rompecabezas visual 1
$correctaE5_1 = "B";
// Reactivo 5.2: Puzzle 2x2: se espera que el input "respuesta5_2" contenga la letra correcta, por ejemplo: "B"
$correctaE5_2 = "B";
// Reactivo 5.3: Búsqueda de Símbolos
$esperadoMenor        = 8;
$esperadoLlaveAbierta = 14;
$esperadoLlaveCerrada = 7;

// EJERCICIO 5 – Versión adaptada para discapacidad visual (originalmente, solo evaluaba PPE y Retención)
// Se evaluaban:
//   - PPE: adapt_respuestaPPE1 y adapt_respuestaPPE2_1
//   - Retención de Dígitos: 3 series, con bonus si las 3 son correctas (máx = 7)
$adaptCorrectaPPE1        = "C";
$adaptCorrectaPPE2_1      = "A";
$adapt_retencionEsperado1 = "6-1-7-5";
$adapt_retencionEsperado2 = "5-3-2-8";
$adapt_retencionEsperado3 = "6-2-4-8-1-3";

// EJERCICIO 6: Tabla de competencias (no se evalúa, solo se almacena la respuesta)

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
$r4_Analogias = $_POST['respuestaE4_Analogias'] ?? '';
$r4_Dibujos1  = $_POST['respuestaE3_Dibujos'] ?? '';
$r4_Verbal    = $_POST['respuestaE3_Verbal'] ?? '';

// EJERCICIO 5 – Versión normal (usuarios sin discapacidad visual)
$r5_1 = $_POST['respuesta5_1'] ?? ''; // Reactivo 5.1: Rompecabezas Visuales
$r5_2 = $_POST['respuesta5_2'] ?? ''; // Reactivo 5.2: Puzzle 2x2
$busquedaMenor = $_POST['busquedaMenor'] ?? 0;
$busquedaLlaveAbierta = $_POST['busquedaLlaveAbierta'] ?? 0;
$busquedaLlaveCerrada = $_POST['busquedaLlaveCerrada'] ?? 0;
$retencionDigitos = $_POST['retencionDigitos'] ?? '';

// EJERCICIO 5 – Versión adaptada para discapacidad visual
$adapt_respuestaPPE1   = $_POST['adapt_respuestaPPE1'] ?? '';
$adapt_respuestaPPE2_1 = $_POST['adapt_respuestaPPE2_1'] ?? '';
$adapt_retencionDigitos1 = $_POST['adapt_retencionDigitos1'] ?? '';
$adapt_retencionDigitos2 = $_POST['adapt_retencionDigitos2'] ?? '';
$adapt_retencionDigitos3 = $_POST['adapt_retencionDigitos3'] ?? '';

// EJERCICIO 6
$tablaCompetencias = $_POST['tablaCompetencias'] ?? '';

// ================================================
// 8. Evaluar las respuestas y calcular aciertos
// ================================================

// EJERCICIO 1
$evalE1_Q1 = ($r1_1 === $correctaE1_Q1) ? 1 : 0;
$evalE1_Q2 = ($r1_2 === $correctaE1_Q2) ? 1 : 0;
$evalE1_Q3 = ($r1_3 === $correctaE1_Q3) ? 1 : 0;
$aciertosE1 = $evalE1_Q1 + $evalE1_Q2 + $evalE1_Q3;

// EJERCICIO 2
$evalE2 = (strtolower(trim($ordenFinalE2)) === strtolower(trim($ordenCorrectoE2))) ? 1 : 0;
$aciertosE2 = $evalE2;

// EJERCICIO 3
$evalE3 = ($rE3 === $correctaE3) ? 1 : 0;
$aciertosE3 = $evalE3;

// EJERCICIO 4
$evalE4_Analogias = ($r4_Analogias === $correctaE4_Analogias) ? 1 : 0;
$evalE4_Dibujos1  = ($r4_Dibujos1 === $correctaE4_Dibujos1) ? 1 : 0;
$evalE4_Verbal    = (strtoupper($r4_Verbal) === strtoupper($correctaE4_Verbal)) ? 1 : 0;
$aciertosE4 = $evalE4_Analogias + $evalE4_Dibujos1 + $evalE4_Verbal;

// EJERCICIO 5
if (!$esVisual) {
    // Versión normal: se evalúan 3 reactivos
    $evalE5_1 = ($r5_1 === $correctaE5_1) ? 1 : 0;
    $evalE5_2 = (strtoupper(trim($r5_2)) === strtoupper($correctaE5_2)) ? 1 : 0;
    $evalE5_3 = (
        ($busquedaLlaveAbierta == $esperadoLlaveAbierta) &&
        ($busquedaLlaveCerrada == $esperadoLlaveCerrada) &&
        ($busquedaMenor == $esperadoMenor)
     
    ) ? 1 : 0;
    $aciertosE5 = $evalE5_1 + $evalE5_2 + $evalE5_3;
    $porcentajeE5 = round(($aciertosE5 / 3) * 100);
} else {
    // Versión adaptada para discapacidad visual: se evaluarán tanto los reactivos "normales" como los adaptados.
    // --- Reactivos normales (5.1, 5.2, 5.3) ---
    $evalE5_1 = ($r5_1 === $correctaE5_1) ? 1 : 0;
    $evalE5_2 = (strtoupper(trim($r5_2)) === strtoupper($correctaE5_2)) ? 1 : 0;
    $evalE5_3 = (
        ($busquedaLlaveAbierta == $esperadoLlaveAbierta) &&
        ($busquedaLlaveCerrada == $esperadoLlaveCerrada) &&
        ($busquedaMenor == $esperadoMenor) &&
        ($busquedaMayor == $esperadoMayor)
    ) ? 1 : 0;
    $normalScore = $evalE5_1 + $evalE5_2 + $evalE5_3; // Máximo 3

    // --- Reactivos adaptados ---
    $evalAdaptPPE1 = ($adapt_respuestaPPE1 === $adaptCorrectaPPE1) ? 1 : 0;
    $evalAdaptPPE2_1 = ($adapt_respuestaPPE2_1 === $adaptCorrectaPPE2_1) ? 1 : 0;
    $formatted1 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos1)));
    $formatted2 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos2)));
    $formatted3 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos3)));
    $evalAdaptRetencion1 = ($formatted1 === $adapt_retencionEsperado1) ? 1 : 0;
    $evalAdaptRetencion2 = ($formatted2 === $adapt_retencionEsperado2) ? 1 : 0;
    $evalAdaptRetencion3 = ($formatted3 === $adapt_retencionEsperado3) ? 1 : 0;
    $totalRetencion = $evalAdaptRetencion1 + $evalAdaptRetencion2 + $evalAdaptRetencion3;
    $bonusRetencion = ($totalRetencion === 3) ? 2 : 0;
    $adaptScore = $evalAdaptPPE1 + $evalAdaptPPE2_1 + $totalRetencion + $bonusRetencion; // Máximo 7

    // Suma total de ambas ramas: máximo = 3 + 7 = 10.
    $rawScore = $normalScore + $adaptScore;
    // Escalamos a un máximo de 9.
    $aciertosE5 = round(($rawScore / 10) * 9);
    $porcentajeE5 = round(($aciertosE5 / 9) * 100);
}

// EJERCICIO 6: No se evalúa, solo se almacena la respuesta

// ================================================
// 9. Insertar las respuestas en la base de datos
// ================================================
// Ejercicio 1
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
    "¿Qué le pidió la abuela a Juan?", $r1_1, $discapacidadRegistro, ($evalE1_Q1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
    "¿Qué se infiere de la información?", $r1_2, $discapacidadRegistro, ($evalE1_Q2 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
    "¿En qué consistió la trampa del comerciante?", $r1_3, $discapacidadRegistro, ($evalE1_Q3 ? "Si" : "No"));

// Ejercicio 2
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 2,
    "Ejercicio 2: Competencia de Escritura", $contextoEjercicio,
    "Orden final de palabras", $ordenFinalE2, $discapacidadRegistro, ($evalE2 ? "Si" : "No"));

// Ejercicio 3
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3,
    "Ejercicio 3: Generación de ideas y pensamiento analítico", $contextoEjercicio,
    "Imagen faltante (opción)", $rE3, $discapacidadRegistro, ($evalE3 ? "Si" : "No"));

// Ejercicio 4
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y recopilación de la información", $contextoEjercicio,
    "Analogías verbales: BOTELLA es a ____ como ____ es a PLATO", $r4_Analogias, $discapacidadRegistro, ($evalE4_Analogias ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y recopilación de la información", $contextoEjercicio,
    "Reactivo con dibujos: Seleccione el nombre correcto a la figura", $r4_Dibujos1, $discapacidadRegistro, ($evalE4_Dibujos1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y recopilación de la información", $contextoEjercicio,
    "Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones", $r4_Verbal, $discapacidadRegistro, ($evalE4_Verbal ? "Si" : "No"));

// Ejercicio 5
if (!$esVisual) {
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.1: Rompecabezas Visuales", $r5_1, $discapacidadRegistro, ($evalE5_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.2: Puzzle 2x2", $r5_2, $discapacidadRegistro, ($evalE5_2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.3: Búsqueda de Símbolos", "Mayor: $busquedaMayor, Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada",
        $discapacidadRegistro, ($evalE5_3 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Serie de dígitos escuchada", $retencionDigitos, $discapacidadRegistro, "N/A");
} else {
    // Versión adaptada: se insertan tanto los reactivos normales como los adaptados.
    // Reactivos normales:
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.1: Rompecabezas Visuales", $r5_1, $discapacidadRegistro, ($evalE5_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.2: Puzzle 2x2", $r5_2, $discapacidadRegistro, ($evalE5_2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.3: Búsqueda de Símbolos", "Mayor: $busquedaMayor, Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada",
        $discapacidadRegistro, ($evalE5_3 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Serie de dígitos escuchada", $retencionDigitos, $discapacidadRegistro, "N/A");
    // Reactivos adaptados:
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Adaptado - PPE 1", $adapt_respuestaPPE1, $discapacidadRegistro, ($evalAdaptPPE1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Adaptado - PPE 2", $adapt_respuestaPPE2_1, $discapacidadRegistro, ($evalAdaptPPE2_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Adaptado - Retención de Dígitos (Serie 1)", $formatted1, $discapacidadRegistro, ($evalAdaptRetencion1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Adaptado - Retención de Dígitos (Serie 2)", $formatted2, $discapacidadRegistro, ($evalAdaptRetencion2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Adaptado - Retención de Dígitos (Serie 3)", $formatted3, $discapacidadRegistro, ($evalAdaptRetencion3 ? "Si" : "No"));
}

// Ejercicio 6: Se almacena la respuesta sin evaluación
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 6,
    "Ejercicio 6: Competencias (Tabla)", $contextoEjercicio,
    "Evaluación de competencias (tabla)", $tablaCompetencias, $discapacidadRegistro, "N/A");

// ================================================
// 10. Calcular porcentajes de aciertos y mostrar resumen
// ================================================
$porcentajeE1 = round(($aciertosE1 / 3) * 100);
$porcentajeE2 = round(($aciertosE2 / 1) * 100);
$porcentajeE3 = round(($aciertosE3 / 1) * 100);
$porcentajeE4 = round(($aciertosE4 / 3) * 100);
if (!$esVisual) {
    $porcentajeE5 = round(($aciertosE5 / 3) * 100);
} else {
    $porcentajeE5 = round(($aciertosE5 / 9) * 100);
}

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
echo "  <tr><td>Ejercicio 5</td><td>{$aciertosE5} de " . (!$esVisual ? "3" : "9") . " ({$porcentajeE5}%)</td></tr>";
echo "  <tr><td>Ejercicio 6</td><td>N/A</td></tr>";
echo "</table>";
?>
