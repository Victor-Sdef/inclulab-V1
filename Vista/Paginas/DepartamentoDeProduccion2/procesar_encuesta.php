<?php
session_start();
require '../../../Modelo/conexion.php';

// Procesamiento de la encuesta
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Verificamos si los datos del usuario y departamento están presentes
    if (empty($_POST['id_usuario']) || empty($_POST['nombre_departamento']) || empty($_POST['cargo_departamento'])) {
        echo "Faltan datos del usuario o departamento.";
        exit();
    }

    $id_usuario = $_POST['id_usuario'];
    $nombre_departamento = $_POST['nombre_departamento'];
    $cargo_departamento = $_POST['cargo_departamento'];

// Verificamos si el usuario está autenticado
if (!isset($_SESSION['user'])) {
    header('Location: ../../../ingreso.php?action=login');
    exit();
}

// Aceptar solo peticiones POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo "Acceso no permitido.";
    exit();
}

// Obtener y validar los datos enviados
$id_usuario = isset($_POST['id_usuario']) ? $_POST['id_usuario'] : null;
$nombre_departamento = isset($_POST['nombre_departamento']) ? $_POST['nombre_departamento'] : null;
$cargo_departamento = isset($_POST['cargo_departamento']) ? $_POST['cargo_departamento'] : null;

// Validar que los campos obligatorios existan
if (!$id_usuario || !$nombre_departamento || !$cargo_departamento) {
    echo "Faltan datos del usuario o departamento.";
    exit();
}

// Capturar respuestas
$respuestas = [];
for ($i = 1; $i <= 34; $i++) {
    $respuestas["q$i"] = isset($_POST["q$i"]) ? $_POST["q$i"] : null;
}

// Verificar si alguna respuesta falta
foreach ($respuestas as $clave => $respuesta) {
    if ($respuesta === null) {
        echo "Falta responder la pregunta: $clave";
        exit();
    }
}

// Conexión
$conn = Conexion::conectar();

// Preparar la consulta SQL
$sql = "INSERT INTO resultados_encuesta (
    id_usuario,
    nombre_departamento,
    cargo_departamento,
    pregunta_1, pregunta_2, pregunta_3, pregunta_4, pregunta_5,
    pregunta_6, pregunta_7, pregunta_8, pregunta_9, pregunta_10,
    pregunta_11, pregunta_12, pregunta_13, pregunta_14, pregunta_15,
    pregunta_16, pregunta_17, pregunta_18, pregunta_19, pregunta_20,
    pregunta_21, pregunta_22, pregunta_23, pregunta_24,  
    pregunta_25, pregunta_26, pregunta_27, pregunta_28, pregunta_29, 
    pregunta_30, pregunta_31, pregunta_32, pregunta_33, pregunta_34, fecha_registro
) VALUES (
    :id_usuario,
    :nombre_departamento,
    :cargo_departamento,
    :q1, :q2, :q3, :q4, :q5,
    :q6, :q7, :q8, :q9, :q10,
    :q11, :q12, :q13, :q14, :q15,
    :q16, :q17, :q18, :q19, :q20, 
    :q21, :q22, :q23, :q24, :q25,
    :q26, :q27, :q28, :q29, :q30,
    :q31, :q32, :q33, :q34,
    NOW( )
)";

// Preparar y ejecutar
$stmt = $conn->prepare($sql);

$valores = [
    ':id_usuario' => $id_usuario,
    ':nombre_departamento' => $nombre_departamento,
    ':cargo_departamento' => $cargo_departamento,
];

for ($i = 1; $i <= 34; $i++) {
    $valores[":q$i"] = $respuestas["q$i"];
}

try {
    $stmt->execute($valores);
    // Redireccionar después de guardar correctamente
    header("Location: encuesta_enviada.php");
    exit();
} catch (PDOException $e) {
    echo "Error al guardar la encuesta: " . $e->getMessage();
    exit();
 }
}