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
    header('Location: ../../../ingreso.php?action=login');
    exit();
}
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    die("Error: No se encontró el ID del usuario en la sesión.");
}

// Obtener el id de discapacidad del usuario desde la sesión
$usuarioIdDiscapacidad = $_SESSION['user']['id_discapacidad'] ?? null;
// En este ejemplo, para la versión adaptada (discapacidad visual) asumimos que el id es 5.
$esVisual = ($usuarioIdDiscapacidad == 5);
$discapacidadRegistro = $usuarioIdDiscapacidad;

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
$discapacidadRegistro = $discapacidad; // Para almacenar en BD
$contextoEjercicio = "Ejercicios para Discapacidad: Auditiva, Física y Visual";

// ================================================
// 5. Definir respuestas correctas para cada ejercicio
// ================================================

// --- Ejercicio 1: Comprensión Lectora (3 preguntas)
$correctaE1_Q1 = "A";
$correctaE1_Q2 = "A";
$correctaE1_Q3 = "A";

// --- Ejercicio 2: Ordenar palabras  
// (Según el ejemplo: "El idioma latín ha aportado una gran cantidad de palabras a nuestro lenguaje.")
// Orden correcto: "c, b, e, a, d" (ajusta si es necesario)
$ordenCorrectoE2 = "c,b,e,a,d";

// --- Ejercicio 4: Organización y Recopilación
// 1) Analogías verbales: en el HTML se espera opción "B"
$correctaE4_Analogias = "B";
// 2) Reactivo con dibujos: suponemos la respuesta correcta es "C" (por ejemplo, "Artículos de carga")
// Ajusta según tu criterio
$correctaE4_Dibujos = "C";
// 3) Reactivo verbal: en el HTML se muestran opciones "SUPERVISOR", "MAQUINARI", "OBREROS" y asumiremos la correcta es "SUPERVISOR"
$correctaE4_Verbal = "MAQUINARI";

// --- Ejercicio 5 – Versión normal (usuarios sin discapacidad visual)
// Reactivo 5.3: Búsqueda de Símbolos (valores esperados)
$esperadoMayor        = 0;
$esperadoMenor        = 14;
$esperadoLlaveAbierta = 13;
$esperadoLlaveCerrada = 10;

// --- Ejercicio 5 – Versión adaptada para discapacidad visual
// Reactivos adaptados:
$adaptCorrectaPPE1        = "C";
$adaptCorrectaPPE2_1      = "A";
// Para la Retención de Dígitos se recogen 4 series; definimos las respuestas esperadas:
$adapt_retencionEsperado1 = "6-1-7-5";
$adapt_retencionEsperado2 = "5-3-2-8";
$adapt_retencionEsperado3 = "6-2-4-8-1-3";

// ================================================
// 6. Función para insertar en la tabla 'respuestas'
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
// 7. Recoger las respuestas enviadas desde la vista
// ================================================

// Ejercicio 1
$r1_1 = $_POST['respuesta1'] ?? '';
$r1_2 = $_POST['respuesta2'] ?? '';
$r1_3 = $_POST['respuesta3'] ?? '';

// Ejercicio 2
$ordenFinalE2 = $_POST['ordenFinal'] ?? '';

// Ejercicio 3
$rE3 = $_POST['respuestaE3'] ?? '';

// Ejercicio 4
$r4_Analogias = $_POST['respuesta4_Analogias'] ?? '';
$r4_Dibujos   = $_POST['respuesta4_2'] ?? '';
$r4_Verbal    = $_POST['respuesta4_3'] ?? '';

// Ejercicio 5 – Versión normal (usuarios sin discapacidad visual)
$r5_1 = $_POST['respuesta5_1'] ?? '';
$r5_2 = $_POST['respuesta5_2'] ?? '';
$busquedaMayor = $_POST['busquedaMayor'] ?? 0;
$busquedaMenor = $_POST['busquedaMenor'] ?? 0;
$busquedaLlaveAbierta = $_POST['busquedaLlaveAbierta'] ?? 0;
$busquedaLlaveCerrada = $_POST['busquedaLlaveCerrada'] ?? 0;

// Ejercicio 5 – Versión adaptada para discapacidad visual
$adapt_respuestaPPE1   = $_POST['adapt_respuestaPPE1'] ?? '';
$adapt_respuestaPPE2_1 = $_POST['adapt_respuestaPPE2_1'] ?? '';
$adapt_retencionDigitos1 = $_POST['adapt_retencionDigitos1'] ?? '';
$adapt_retencionDigitos2 = $_POST['adapt_retencionDigitos2'] ?? '';
$adapt_retencionDigitos3 = $_POST['adapt_retencionDigitos3'] ?? '';
$adapt_retencionDigitos4 = $_POST['adapt_retencionDigitos4'] ?? '';

// Ejercicio 6
$tablaCompetencias = $_POST['tablaCompetencias'] ?? '';

// ================================================
// 8. Evaluar las respuestas y calcular aciertos
// ================================================

// Ejercicio 1
$evalE1_Q1 = ($r1_1 === $correctaE1_Q1) ? 1 : 0;
$evalE1_Q2 = ($r1_2 === $correctaE1_Q2) ? 1 : 0;
$evalE1_Q3 = ($r1_3 === $correctaE1_Q3) ? 1 : 0;
$aciertosE1 = $evalE1_Q1 + $evalE1_Q2 + $evalE1_Q3;

// Ejercicio 2
$evalE2 = (strtolower(trim($ordenFinalE2)) === strtolower(trim($ordenCorrectoE2))) ? 1 : 0;
$aciertosE2 = $evalE2;

// Ejercicio 3
// Nota: se debe definir la variable $correctaE3 o ajustar la evaluación según el ejercicio.
$correctaE3 = ""; // Ajusta este valor según la respuesta correcta del ejercicio 3.
$evalE3 = ($rE3 === $correctaE3) ? 1 : 0;
$aciertosE3 = $evalE3;

// Ejercicio 4
$evalE4_Analogias = (strtoupper(trim($r4_Analogias)) === strtoupper($correctaE4_Analogias)) ? 1 : 0;
$evalE4_Dibujos  = (strtoupper(trim($r4_Dibujos)) === strtoupper($correctaE4_Dibujos)) ? 1 : 0;
$evalE4_Verbal   = (strtoupper(trim($r4_Verbal)) === strtoupper($correctaE4_Verbal)) ? 1 : 0;
$aciertosE4 = $evalE4_Analogias + $evalE4_Dibujos + $evalE4_Verbal;

// Ejercicio 5
if (!$esVisual) {
    // Versión normal: se evalúan 3 reactivos
    // Nota: se deben definir las variables $correctaE5_1 y $correctaE5_2 según corresponda.
    $correctaE5_1 = ""; // Ajusta este valor
    $correctaE5_2 = ""; // Ajusta este valor

    $evalE5_1 = (strtoupper(trim($r5_1)) === strtoupper($correctaE5_1)) ? 1 : 0;
    $evalE5_2 = (strtoupper(trim($r5_2)) === strtoupper($correctaE5_2)) ? 1 : 0;
    $evalE5_3 = (
        ($busquedaLlaveAbierta == $esperadoLlaveAbierta) &&
        ($busquedaLlaveCerrada == $esperadoLlaveCerrada) &&
        ($busquedaMenor == $esperadoMenor) &&
        ($busquedaMayor == $esperadoMayor)
    ) ? 1 : 0;
    $aciertosE5 = $evalE5_1 + $evalE5_2 + $evalE5_3; // Máximo 3
    $porcentajeE5 = round(($aciertosE5 / 3) * 100);
} else {
    // Versión adaptada: se evalúan tanto los reactivos "normales" como los adaptados.
    // Nota: se deben definir las variables $correctaE5_1 y $correctaE5_2 según corresponda.
    $correctaE5_1 = ""; // Ajusta este valor
    $correctaE5_2 = ""; // Ajusta este valor

    $evalE5_1 = (strtoupper(trim($r5_1)) === strtoupper($correctaE5_1)) ? 1 : 0;
    $evalE5_2 = (strtoupper(trim($r5_2)) === strtoupper($correctaE5_2)) ? 1 : 0;
    $evalE5_3 = (
        ($busquedaLlaveAbierta == $esperadoLlaveAbierta) &&
        ($busquedaLlaveCerrada == $esperadoLlaveCerrada) &&
        ($busquedaMenor == $esperadoMenor) &&
        ($busquedaMayor == $esperadoMayor)
    ) ? 1 : 0;
    $normalScore = $evalE5_1 + $evalE5_2 + $evalE5_3; // Máximo 3

    $evalAdaptPPE1 = (strtoupper(trim($adapt_respuestaPPE1)) === strtoupper($adaptCorrectaPPE1)) ? 1 : 0;
    $evalAdaptPPE2_1 = (strtoupper(trim($adapt_respuestaPPE2_1)) === strtoupper($adaptCorrectaPPE2_1)) ? 1 : 0;
    
    // Formatear retención de dígitos
    $formatted1 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos1)));
    $formatted2 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos2)));
    $formatted3 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos3)));
    $formatted4 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos4)));
    
    $evalAdaptRetencion1 = (strtoupper(trim($formatted1)) === strtoupper($adapt_retencionEsperado1)) ? 1 : 0;
    $evalAdaptRetencion2 = (strtoupper(trim($formatted2)) === strtoupper($adapt_retencionEsperado2)) ? 1 : 0;
    $evalAdaptRetencion3 = (strtoupper(trim($formatted3)) === strtoupper($adapt_retencionEsperado3)) ? 1 : 0;
    // Se podría definir $adapt_retencionEsperado4 si se usa un cuarto reactivo, de lo contrario se omite.
    $evalAdaptRetencion4 = 0;
    $retencionScore = $evalAdaptRetencion1 + $evalAdaptRetencion2 + $evalAdaptRetencion3 + $evalAdaptRetencion4;
    $bonusRetencion = ($retencionScore === 4) ? 1 : 0;
    $adaptScore = $evalAdaptPPE1 + $evalAdaptPPE2_1 + $retencionScore + $bonusRetencion; // Máximo 7

    // Raw score total: normal (max 3) + adaptado (max 7) = 10.
    $rawScore = $normalScore + $adaptScore;
    // Escalamos a un máximo de 9
    $aciertosE5 = round(($rawScore / 10) * 9);
    $porcentajeE5 = round(($aciertosE5 / 9) * 100);
}

// Ejercicio 6: No se evalúa, solo se almacena la respuesta

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
    "Analogías verbales: PISCINA es a _____ como _____ es a Gasolina", $r4_Analogias, $discapacidadRegistro, ($evalE4_Analogias ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y recopilación de la información", $contextoEjercicio,
    "Reactivo con dibujos: Seleccione el nombre correcto a la figura", $r4_Dibujos, $discapacidadRegistro, ($evalE4_Dibujos ? "Si" : "No"));
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
        "Reactivo 5.3: Búsqueda de Símbolos", 
        "Mayor: $busquedaMayor, Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada",
        $discapacidadRegistro, ($evalE5_3 ? "Si" : "No"));
} else {
    // Versión adaptada: reactivos normales y adaptados
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.1: Rompecabezas Visuales", $r5_1, $discapacidadRegistro, ($evalE5_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.2: Puzzle 2x2", $r5_2, $discapacidadRegistro, ($evalE5_2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo 5.3: Búsqueda de Símbolos", 
        "Mayor: $busquedaMayor, Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada",
        $discapacidadRegistro, ($evalE5_3 ? "Si" : "No"));
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
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Adaptado - Retención de Dígitos (Serie 4)", $formatted4, $discapacidadRegistro, ($evalAdaptRetencion4 ? "Si" : "No"));
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
$porcentajeE5 = (!$esVisual) ? round(($aciertosE5 / 3) * 100) : round(($aciertosE5 / 6) * 100);

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
echo "  <tr><td>Ejercicio 5</td><td>{$aciertosE5} de " . (!$esVisual ? "3" : "6") . " ({$porcentajeE5}%)</td></tr>";
echo "  <tr><td>Ejercicio 6</td><td>N/A</td></tr>";
echo "</table>";
?>
