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
    header('Location: ../../../ingreso.php?action=login');
    exit();
}
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    die("Error: No se encontró el ID del usuario en la sesión.");
}

// 3. Recoger datos de contexto (estos pueden venir de campos ocultos o de la sesión)
$departamento  = $_POST['prefijoDepartamento'] ?? '';
$cargo_laboral = $_POST['prefijoCargo'] ?? '';
$discapacidad  = $_POST['prefijoDiscapacidad'] ?? '';

// Obtener el id de discapacidad para condiciones específicas (por ejemplo, para mostrar adaptaciones)
$usuarioIdDiscapacidad = $_SESSION['user']['id_discapacidad'] ?? null;

/* =======================================================
   Función para insertar cada respuesta en la tabla "respuestas"
======================================================= */
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

/* ================================
   EJERCICIO 1: Comprensión Lectora
   - Se esperan 3 respuestas correctas (todas "A" en este ejemplo)
================================ */
$contextoE1 = "Ejercicio 1: Comprensión Lectora";
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


if ($_SESSION['user']['id_discapacidad'] == 5) {
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoE1,
    "¿Qué le pidió la abuela a Juan?", $r1_1, $discapacidad, ($evalE1_Q1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoE1,
    "¿Qué hizo Juan al llegar a la papelería? ", $r1_2, $discapacidad, ($evalE1_Q2 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoE1,
    "¿Qué hizo el comerciante?", $r1_3, $discapacidad, ($evalE1_Q3 ? "Si" : "No"));

} else {
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "¿Qué hizo la abuela con la cinta?", $contextoE1,
    "¿Cuántos metros de cinta utilizó la abuela para hacer el último moño?", $r1_1, $discapacidad, ($evalE1_Q1 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoE1,
    "¿Qué le sucedió a la abuela cuando estaba elaborando los moños?", $r1_2, $discapacidad, ($evalE1_Q2 ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
    "Ejercicio 1: Comprensión Lectora", $contextoE1,
    "¿Qué tuvo que hacer Juan?", $r1_3, $discapacidad, ($evalE1_Q3 ? "Si" : "No"));

}
/* ================================
   EJERCICIO 2: Competencia de Escritura
   - Se espera que el orden final sea "d,a,c,b" (todo en minúsculas)
================================ */
$contextoE2 = "Ejercicio 2: Competencia de Escritura";
$ordenCorrectoE2 = "d,a,c,b";

// Recoger la respuesta del input oculto "ordenFinal"
$ordenFinalE2 = $_POST['ordenFinal'] ?? '';
$ordenFinalE2 = strtolower(trim($ordenFinalE2)); // Normalizamos la respuesta

$evalE2 = ($ordenFinalE2 === $ordenCorrectoE2) ? 1 : 0;
$aciertosE2 = $evalE2;
$porcentajeE2 = round(($aciertosE2 / 1) * 100);

insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 2,
    "Ejercicio 2: Competencia de Escritura", $contextoE2,
    "Orden final de palabras", $ordenFinalE2, $discapacidad, ($evalE2 ? "Si" : "No"));

/* ================================
   EJERCICIO 3: Organización y Recopilación de la Información
   Se procesan 3 subpreguntas:
     1) Analogías verbales (se espera "C")
     2) Reactivos con Dibujos (se espera "C")
     3) Reactivo verbal (se espera "SUPERVISOR")
================================ */
$contextoE3 = "Ejercicio 3: Organización y Recopilación de la Información";

// Subpregunta 1: Analogías verbales
$correctaE3_Analogias = "C";
$rE3_Analogias = $_POST['respuestaE3_Analogias'] ?? '';
$evalE3_Analogias = ($rE3_Analogias === $correctaE3_Analogias) ? 1 : 0;

// Subpregunta 2: Reactivos con Dibujos
$correctaE3_Dibujos = "C";
$rE3_Dibujos = $_POST['respuestaE3_Dibujos'] ?? '';
$evalE3_Dibujos = ($rE3_Dibujos === $correctaE3_Dibujos) ? 1 : 0;

// Subpregunta 3: Reactivo verbal
$correctaE3_Verbal = "SUPERVISOR";
$rE3_Verbal = $_POST['respuestaE3_Verbal'] ?? '';
$evalE3_Verbal = (strtoupper(trim($rE3_Verbal)) === strtoupper($correctaE3_Verbal)) ? 1 : 0;

$aciertosE3 = $evalE3_Analogias + $evalE3_Dibujos + $evalE3_Verbal;
$porcentajeE3 = round(($aciertosE3 / 3) * 100);



insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3,
    "Ejercicio 3: Organización y Recopilación de la Información", $contextoE3,
    "Analogías verbales: … es a AGUA DULCE como MAR es a …", $rE3_Analogias, $discapacidad, ($evalE3_Analogias ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3,
    "Ejercicio 3: Organización y Recopilación de la Información", $contextoE3,
    "Reactivos con Dibujos: Seleccione el nombre correcto a la figura", $rE3_Dibujos, $discapacidad, ($evalE3_Dibujos ? "Si" : "No"));
insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3,
    "Ejercicio 3: Organización y Recopilación de la Información", $contextoE3,
    "Reactivo verbal: Persona que tiene como función principal la de vigilar el cumplimiento de las órdenes e instrucciones", $rE3_Verbal, $discapacidad, ($evalE3_Verbal ? "Si" : "No"));

/* ================================
   RESUMEN FINAL
================================ */
$totalAciertos = $aciertosE1 + $aciertosE2 + $aciertosE3;
$totalMaximo = 3 + 2 + 3; // Total máximo = 7
$porcentajeTotal = round(($totalAciertos / $totalMaximo) * 100);

// Mostrar resumen final
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
echo "  <tr><td>Ejercicio 3</td><td>{$aciertosE3} de 3 ({$porcentajeE3}%)</td></tr>";
echo "  <tr><td>Total</td><td>{$totalAciertos} de {$totalMaximo} ({$porcentajeTotal}%)</td></tr>";
echo "</table>";
?>
