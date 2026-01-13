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

// ================================================
// 6. Definir respuestas correctas para cada ejercicio
// ================================================
// EJERCICIO 1 (Comprensión Lectora, 3 preguntas)
$correctaE1_Q1 = "A";
$correctaE1_Q2 = "A";
$correctaE1_Q3 = "A";

// EJERCICIO 2 (Ordenar palabras)
$ordenCorrectoE2 = "a,b,c,d";

if ($_SESSION['user']['id_discapacidad'] == 1) {
    // Para usuarios con discapacidad visual (versión adaptada)
    $correctaE3 = "D"; // O el valor que corresponda en la versión adaptada
} else {
    // Para usuarios sin discapacidad visual (versión original)
    $correctaE3 = "C";
}


// EJERCICIO 4 (Organización y Recopilación, 3 subreactivos)
$correctaE4_Analogias = "B";      // Ej.: "agua - depósito"
$correctaE4_Dibujos1  = "B";      // Ej.: "Material de oficina"
$correctaE4_Verbal    = "MAQUINARIA"; // Ej.: "Instrumento productivo"

// EJERCICIO 5 – Versión original (usuarios sin discapacidad visual, 3 ítems)
$correctaE5_1 = "C";
$correctaE5_2 = "C,B,A,D";
// Para esta versión se insertan los valores de PPE y símbolos como "N/A"
$correctaPPE1  = "A"; // no vale
$correctaPPE2  = "A"; // no vale

$esperadoMayor = 0;
$esperadoMenor = 11;
$esperadoLlaveAbierta = 23;
$esperadoLlaveCerrada = 14;

// EJERCICIO 5 – Versión adaptada para discapacidad visual (4 ítems: 3 PPE + 4 Retención)
$adaptCorrectaPPE1        = "C";
$adaptCorrectaPPE2_1      = "A";
$adaptCorrectaPPE2_2      = "C";
$adapt_retencionEsperado1 = "1-5-6-8";
$adapt_retencionEsperado2 = "2-3-5-8";
$adapt_retencionEsperado3 = "1-3-7-8";
$adapt_retencionEsperado4 = "1-2-3-4-6-8";

// EJERCICIO 6 (Tabla de competencias) – No se valida

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
if ($_SESSION['user']['id_discapacidad'] == 1) {
    // Versión adaptada para discapacidad visual
    $adapt_respuestaPPE1   = $_POST['adapt_respuestaPPE1'] ?? '';
    $adapt_respuestaPPE2_1 = $_POST['adapt_respuestaPPE2_1'] ?? '';
    $adapt_respuestaPPE2_2 = $_POST['adapt_respuestaPPE2_2'] ?? '';
    // Recoger los 4 campos para el reactivo de retención de dígitos adaptado
    $adapt_retencionDigitos1 = $_POST['adapt_retencionDigitos1'] ?? '';
    $adapt_retencionDigitos2 = $_POST['adapt_retencionDigitos2'] ?? '';
    $adapt_retencionDigitos3 = $_POST['adapt_retencionDigitos3'] ?? '';
    $adapt_retencionDigitos4 = $_POST['adapt_retencionDigitos4'] ?? '';
    
    // Evaluar PPE
    $evalAdaptPPE1 = ($adapt_respuestaPPE1 === $adaptCorrectaPPE1) ? 1 : 0;
    $evalAdaptPPE2_1 = ($adapt_respuestaPPE2_1 === $adaptCorrectaPPE2_1) ? 1 : 0;
    $evalAdaptPPE2_2 = ($adapt_respuestaPPE2_2 === $adaptCorrectaPPE2_2) ? 1 : 0;
    
    // Formatear cada uno de los 4 campos de retención: eliminar caracteres no numéricos y poner guiones entre dígitos
    $formatted1 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos1)));
    $formatted2 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos2)));
    $formatted3 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos3)));
    $formatted4 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos4)));
    
    // Evaluar cada serie individualmente
    $evalAdaptRetencion1 = (strtolower(trim($formatted1)) === strtolower(trim($adapt_retencionEsperado1))) ? 1 : 0;
    $evalAdaptRetencion2 = (strtolower(trim($formatted2)) === strtolower(trim($adapt_retencionEsperado2))) ? 1 : 0;
    $evalAdaptRetencion3 = (strtolower(trim($formatted3)) === strtolower(trim($adapt_retencionEsperado3))) ? 1 : 0;
    $evalAdaptRetencion4 = (strtolower(trim($formatted4)) === strtolower(trim($adapt_retencionEsperado4))) ? 1 : 0;
    
    // Total para versión adaptada: 3 PPE + 4 Retención = 7 ítems
    $aciertosE5 = $evalAdaptPPE1 + $evalAdaptPPE2_1 + $evalAdaptPPE2_2 + $evalAdaptRetencion1 + $evalAdaptRetencion2 + $evalAdaptRetencion3 + $evalAdaptRetencion4;
    $porcentajeE5 = round(($aciertosE5 / 7) * 100);
} else {
    // Versión original para usuarios sin discapacidad visual (3 ítems)
    $r5_1 = $_POST['respuesta5_rompecabezas'] ?? '';
    $slot1 = $_POST['slot1'] ?? '';
    $slot2 = $_POST['slot2'] ?? '';
    $slot3 = $_POST['slot3'] ?? '';
    $slot4 = $_POST['slot4'] ?? '';
    $subE5_2 = strtolower(trim($slot1 . "," . $slot2 . "," . $slot3 . "," . $slot4));
    $respuestaPPE1 = $_POST['respuestaPPE1'] ?? '';
    $respuestaPPE2 = $_POST['respuestaPPE2'] ?? '';
    $busquedaMayor = $_POST['busquedaMayor'] ?? 0;
    $busquedaMenor = $_POST['busquedaMenor'] ?? 0;
    $busquedaLlaveAbierta = $_POST['busquedaLlaveAbierta'] ?? 0;
    $busquedaLlaveCerrada = $_POST['busquedaLlaveCerrada'] ?? 0;
    $retencionDigitos = $_POST['retencionDigitos'] ?? '';
    
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
}

// EJERCICIO 6 (Tabla de competencias) – Recoger datos
$adapt1 = $_POST['adapt1'] ?? '';
$adapt2 = $_POST['adapt2'] ?? '';
$adapt3 = $_POST['adapt3'] ?? '';
$adapt4 = $_POST['adapt4'] ?? '';
$adapt5 = $_POST['adapt5'] ?? '';
$relaciones1 = $_POST['relaciones1'] ?? '';
$relaciones2 = $_POST['relaciones2'] ?? '';
$relaciones3 = $_POST['relaciones3'] ?? '';
$escucha1 = $_POST['escucha1'] ?? '';
$escucha2 = $_POST['escucha2'] ?? '';
$escucha3 = $_POST['escucha3'] ?? '';
$escucha4 = $_POST['escucha4'] ?? '';
$asert1 = $_POST['asert1'] ?? '';
$asert2 = $_POST['asert2'] ?? '';
$asert3 = $_POST['asert3'] ?? '';
$tablaCompetencias = "Adapt1:$adapt1, Adapt2:$adapt2, Adapt3:$adapt3, Adapt4:$adapt4, Adapt5:$adapt5, " .
                     "Rel1:$relaciones1, Rel2:$relaciones2, Rel3:$relaciones3, " .
                     "Esc1:$escucha1, Esc2:$escucha2, Esc3:$escucha3, Esc4:$escucha4, " .
                     "As1:$asert1, As2:$asert2, As3:$asert3";

// ================================================
// 8. Validar las respuestas y calcular aciertos
// ================================================
// --- EJERCICIO 1 ---
$evalE1_Q1 = ($r1_1 === $correctaE1_Q1) ? 1 : 0;
$evalE1_Q2 = ($r1_2 === $correctaE1_Q2) ? 1 : 0;
$evalE1_Q3 = ($r1_3 === $correctaE1_Q3) ? 1 : 0;
$aciertosE1 = $evalE1_Q1 + $evalE1_Q2 + $evalE1_Q3;  // Máximo: 3

// --- EJERCICIO 2 ---
$evalE2 = (strtolower(trim($ordenFinalE2)) === strtolower(trim($ordenCorrectoE2))) ? 1 : 0;
$aciertosE2 = $evalE2;  // Máximo: 1

// --- EJERCICIO 3 ---
$evalE3 = ($rE3 === $correctaE3) ? 1 : 0;
$aciertosE3 = $evalE3;  // Máximo: 1

// --- EJERCICIO 4 ---
$evalE4_Analogias = ($r4_Analogias === $correctaE4_Analogias) ? 1 : 0;
$evalE4_Dibujos1  = ($r4_Dibujos1 === $correctaE4_Dibujos1) ? 1 : 0;
$evalE4_Verbal    = (strtoupper($r4_Verbal) === strtoupper($correctaE4_Verbal)) ? 1 : 0;
$aciertosE4 = $evalE4_Analogias + $evalE4_Dibujos1 + $evalE4_Verbal;  // Máximo: 3

// --- EJERCICIO 5 ---
if (!isset($_POST['adapt_respuestaPPE1'])) {
    // Versión original para usuarios sin discapacidad visual (3 ítems)
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
} else {
    // Versión adaptada para usuarios con discapacidad visual (7 ítems: 3 PPE + 4 Retención)
    $evalAdaptPPE1 = ($adapt_respuestaPPE1 === $adaptCorrectaPPE1) ? 1 : 0;
    $evalAdaptPPE2_1 = ($adapt_respuestaPPE2_1 === $adaptCorrectaPPE2_1) ? 1 : 0;
    $evalAdaptPPE2_2 = ($adapt_respuestaPPE2_2 === $adaptCorrectaPPE2_2) ? 1 : 0;
    
    // Formatear y evaluar cada uno de los 4 campos de retención
    $formatted1 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos1)));
    $formatted2 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos2)));
    $formatted3 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos3)));
    $formatted4 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos4)));
    
    $evalAdaptRetencion1 = (strtolower(trim($formatted1)) === strtolower(trim($adapt_retencionEsperado1))) ? 1 : 0;
    $evalAdaptRetencion2 = (strtolower(trim($formatted2)) === strtolower(trim($adapt_retencionEsperado2))) ? 1 : 0;
    $evalAdaptRetencion3 = (strtolower(trim($formatted3)) === strtolower(trim($adapt_retencionEsperado3))) ? 1 : 0;
    $evalAdaptRetencion4 = (strtolower(trim($formatted4)) === strtolower(trim($adapt_retencionEsperado4))) ? 1 : 0;
    
    // Total para versión adaptada: 3 PPE + 4 Retención = 7 ítems
    $aciertosE5 = $evalAdaptPPE1 + $evalAdaptPPE2_1 + $evalAdaptPPE2_2 + $evalAdaptRetencion1 + $evalAdaptRetencion2 + $evalAdaptRetencion3 + $evalAdaptRetencion4;
    $porcentajeE5 = round(($aciertosE5 / 7) * 100);
}

// --- EJERCICIO 6 ---
$aciertosE6 = 0;  // No se valida

// ================================================
// 9. Insertar las respuestas en la base de datos
// ================================================
// EJERCICIO 1
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
    "¿Cuántos metros de cinta utilizó la abuela para el último moño?", $r1_1, $discapacidadRegistro, ($evalE1_Q1 ? "Si" : "No"));
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
    "Ejercicio 3: Generación de ideas / Matrices", $contextoEjercicio,
    "Imagen faltante (opción)", $rE3, $discapacidadRegistro, ($evalE3 ? "Si" : "No"));

// EJERCICIO 4
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y Recopilación", $contextoEjercicio,
    "Analogías verbales: BOTELLA es a ____ como ____ es a PLATO", $r4_Analogias, $discapacidadRegistro, ($evalE4_Analogias ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y Recopilación", $contextoEjercicio,
    "Reactivo con dibujos: Seleccione el nombre correcto a la figura", $r4_Dibujos1, $discapacidadRegistro, ($evalE4_Dibujos1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
    "Ejercicio 4: Organización y Recopilación", $contextoEjercicio,
    "Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones", $r4_Verbal, $discapacidadRegistro, ($evalE4_Verbal ? "Si" : "No"));

// EJERCICIO 5
if (!isset($_POST['adapt_respuestaPPE1'])) {
    // Versión original para usuarios sin discapacidad visual (3 ítems)
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Rompecabezas Visual (opción única)", $r5_1, $discapacidadRegistro, ($evalE5_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Puzzle 3x3 (slots)", $subE5_2, $discapacidadRegistro, ($evalE5_2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Reactivo Búsqueda de Símbolos", "Mayor: $busquedaMayor, Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada",
        $discapacidadRegistro, ($evalE5_3 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5: Planificación y Toma de Decisiones", $contextoEjercicio,
        "Serie de dígitos escuchada", $retencionDigitos, $discapacidadRegistro, "N/A");
} else {
    // Versión adaptada para usuarios con discapacidad visual
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Reactivo de Información", $contextoEjercicio,
        "¿Para qué sirven las gafas como equipo o material de uso personal en una empresa?", $adapt_respuestaPPE1, $discapacidadRegistro, ($evalAdaptPPE1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Reactivo de Semejanzas", $contextoEjercicio,
        "¿En qué se parecen los aguantes y el casco?", $adapt_respuestaPPE2_1, $discapacidadRegistro, ($evalAdaptPPE2_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Reactivo de Semejanzas", $contextoEjercicio,
        "¿En qué se parecen el departamento financiero y el departamento de recursos humanos?", $adapt_respuestaPPE2_2, $discapacidadRegistro, ($evalAdaptPPE2_2 ? "Si" : "No"));
    // Insertar cada serie de retención de dígitos (4 ítems)
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Reactivo de Retención de Dígitos", $contextoEjercicio,
        "Serie de dígitos en orden ascendente (Serie 1)", $formatted1, $discapacidadRegistro, ($evalAdaptRetencion1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Reactivo de Retención de Dígitos", $contextoEjercicio,
        "Serie de dígitos en orden ascendente (Serie 2)", $formatted2, $discapacidadRegistro, ($evalAdaptRetencion2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Reactivo de Retención de Dígitos", $contextoEjercicio,
        "Serie de dígitos en orden ascendente (Serie 3)", $formatted3, $discapacidadRegistro, ($evalAdaptRetencion3 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
        "Ejercicio 5 ADAPTADO: Reactivo de Retención de Dígitos", $contextoEjercicio,
        "Serie de dígitos en orden ascendente (Serie 4)", $formatted4, $discapacidadRegistro, ($evalAdaptRetencion4 ? "Si" : "No"));
}

// EJERCICIO 6 (Tabla de competencias)
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 6,
    "Ejercicio 6: Competencias (Tabla)", $contextoEjercicio,
    "Evaluación de competencias (tabla)", $tablaCompetencias, $discapacidadRegistro, "N/A");

// ================================================
// 10. Calcular porcentajes de aciertos
// ================================================
$porcentajeE1 = round(($aciertosE1 / 3) * 100);
$porcentajeE2 = round(($aciertosE2 / 1) * 100);
$porcentajeE3 = round(($aciertosE3 / 1) * 100);
$porcentajeE4 = round(($aciertosE4 / 3) * 100);

if ($_SESSION['user']['id_discapacidad'] == 1) {
    // Versión adaptada para usuarios con discapacidad visual: Ejercicio 5 tiene 7 ítems (3 PPE + 4 Retención)
    $porcentajeE5 = round(($aciertosE5 / 7) * 100);
    $porcentajeE6 = "N/A";

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
    echo "  <tr><td>Ejercicio 4</td><td>{$aciertosE4} de 3 ({$porcentajeE4}%)</td></tr>";
    echo "  <tr><td>Ejercicio 5</td><td>{$aciertosE5} de 7 ({$porcentajeE5}%)</td></tr>";
    echo "  <tr><td>Ejercicio 6</td><td>{$porcentajeE6}</td></tr>";
    echo "</table>";
} else {
    // Versión original para usuarios sin discapacidad visual: Ejercicio 5 tiene 3 ítems
    $porcentajeE5 = round(($aciertosE5 / 3) * 100);
    $porcentajeE6 = "N/A";

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
    echo "  <tr><td>Ejercicio 4</td><td>{$aciertosE4} de 3 ({$porcentajeE4}%)</td></tr>";
    echo "  <tr><td>Ejercicio 5</td><td>{$aciertosE5} de 3 ({$porcentajeE5}%)</td></tr>";
    echo "  <tr><td>Ejercicio 6</td><td>{$porcentajeE6}</td></tr>";
    echo "</table>";
}
?>
