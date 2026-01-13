<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Incluir el archivo de conexión y obtener la instancia PDO
require_once '../../Modelo/conexion.php';
$pdo = Conexion::conectar();

if (!$pdo) {
    die("No se pudo establecer la conexión a la base de datos.");
}

// Verificar que el usuario esté autenticado
if (!isset($_SESSION['user'])) {
    die("Error: Usuario no autenticado. Por favor, inicie sesión.");
}

// Obtener el id del usuario desde la sesión (asegúrate de que se almacene con la clave 'id_usuario')
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    die("Error: No se encontró el ID del usuario en la sesión.");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // Recoger datos de prefijo enviados desde la vista
    $departamento  = $_POST['prefijoDepartamento'] ?? '';
    $cargo_laboral = $_POST['prefijoCargo'] ?? '';
    $discapacidad  = $_POST['prefijoDiscapacidad'] ?? '';

    // Contexto general para los ejercicios
    $contextoEjercicio = "Ejercicios para Discapacidad: Física y Auditiva";

    /**
     * Función para insertar una respuesta en la tabla 'respuestas'
     */
    function insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, $ejercicio, $titulo_ejercicio, $contexto_ejercicio, $pregunta, $respuesta, $discapacidad, $resultado) {
        $sql = "INSERT INTO respuestas 
                    (id_usuario, departamento, cargo_laboral, ejercicio, titulo_ejercicio, contexto_ejercicio, pregunta, respuesta, Discapacidad, respuestaCorrectaONo)
                VALUES 
                    (:id_usuario, :departamento, :cargo_laboral, :ejercicio, :titulo_ejercicio, :contexto_ejercicio, :pregunta, :respuesta, :discapacidad, :resultado)";
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

    /*------------------------------------------
      Definir respuestas correctas para la evaluación
    -------------------------------------------*/
    // Ejercicio 1 (Comprensión Lectora)
    $correctaE1_Q1 = "B";
    $correctaE1_Q2 = "B";
    $correctaE1_Q3 = "C";

    // Ejercicio 2 (Ordenar palabras)
    $ordenCorrecto = "d,a,c,b";

    // Ejercicio 3 (Reactivo de Matrices)
    $correctaE3 = "C";

    // Ejercicio 4
    $correctaE4_1 = "B";
    $correctaE4_2 = "C";
    $correctaE4_3 = "SUPERVISOR";

    // Ejercicio 5
    $correctaE5_1 = "C";
    $correctaE5_2 = "A";
    $esperadoMayor        = 3;
    $esperadoMenor        = 2;
    $esperadoLlaveAbierta = 2;
    $esperadoLlaveCerrada = 2;

    /*------------------------------------------
      Recoger las respuestas del formulario
    -------------------------------------------*/
    $respuesta1   = $_POST['respuesta1'] ?? '';
    $respuesta2   = $_POST['respuesta2'] ?? '';
    $respuesta3   = $_POST['respuesta3'] ?? '';
    $ordenFinal   = $_POST['ordenFinal'] ?? '';
    $respuestaE3  = $_POST['respuestaE3'] ?? '';
    $respuesta4_1 = $_POST['respuesta4_1'] ?? '';
    $respuesta4_2 = $_POST['respuesta4_2'] ?? '';
    $respuesta4_3 = $_POST['respuesta4_3'] ?? '';
    $respuesta5_1 = $_POST['respuesta5_1'] ?? '';
    $respuesta5_2 = $_POST['respuesta5_2'] ?? '';
    $busquedaMayor         = $_POST['busquedaMayor'] ?? 0;
    $busquedaMenor         = $_POST['busquedaMenor'] ?? 0;
    $busquedaLlaveAbierta  = $_POST['busquedaLlaveAbierta'] ?? 0;
    $busquedaLlaveCerrada  = $_POST['busquedaLlaveCerrada'] ?? 0;
    $simbolosRespuesta = "Mayor: $busquedaMayor, Menor: $busquedaMenor, Llave Abierta: $busquedaLlaveAbierta, Llave Cerrada: $busquedaLlaveCerrada";

    /*------------------------------------------
      Evaluar las respuestas
    -------------------------------------------*/
    // Ejercicio 1
    $evalE1_Q1 = ($respuesta1 === $correctaE1_Q1) ? "Si" : "No";
    $evalE1_Q2 = ($respuesta2 === $correctaE1_Q2) ? "Si" : "No";
    $evalE1_Q3 = ($respuesta3 === $correctaE1_Q3) ? "Si" : "No";
    $aciertosE1 = (($evalE1_Q1 === "Si") + ($evalE1_Q2 === "Si") + ($evalE1_Q3 === "Si"));

    // Ejercicio 2
    $evalE2 = (strtolower($ordenFinal) === $ordenCorrecto) ? "Si" : "No";
    $aciertosE2 = ($evalE2 === "Si") ? 1 : 0;

    // Ejercicio 3
    $evalE3 = ($respuestaE3 === $correctaE3) ? "Si" : "No";
    $aciertosE3 = ($evalE3 === "Si") ? 1 : 0;

    // Ejercicio 4
    $evalE4_1 = ($respuesta4_1 === $correctaE4_1) ? "Si" : "No";
    $evalE4_2 = ($respuesta4_2 === $correctaE4_2) ? "Si" : "No";
    $evalE4_3 = (strtoupper($respuesta4_3) === $correctaE4_3) ? "Si" : "No";
    $aciertosE4 = (($evalE4_1 === "Si") + ($evalE4_2 === "Si") + ($evalE4_3 === "Si"));

    // Ejercicio 5
    $evalE5_1 = ($respuesta5_1 === $correctaE5_1) ? "Si" : "No";
    $evalE5_2 = ($respuesta5_2 === $correctaE5_2) ? "Si" : "No";
    $evalE5_3 = ($busquedaMayor == $esperadoMayor &&
                 $busquedaMenor == $esperadoMenor &&
                 $busquedaLlaveAbierta == $esperadoLlaveAbierta &&
                 $busquedaLlaveCerrada == $esperadoLlaveCerrada) ? "Si" : "No";
    $aciertosE5 = (($evalE5_1 === "Si") + ($evalE5_2 === "Si") + ($evalE5_3 === "Si"));

    /*------------------------------------------
      Inserciones en la base de datos
    -------------------------------------------*/
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1, "Ejercicio 1: Comprensión Lectora", $contextoEjercicio, "¿Qué hizo la abuela con la cinta?", $respuesta1, $discapacidad, $evalE1_Q1);
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1, "Ejercicio 1: Comprensión Lectora", $contextoEjercicio, "¿Qué le sucedió a la abuela al elaborar los moños?", $respuesta2, $discapacidad, $evalE1_Q2);
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1, "Ejercicio 1: Comprensión Lectora", $contextoEjercicio, "¿Qué tuvo que hacer Juan?", $respuesta3, $discapacidad, $evalE1_Q3);

    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 2, "Ejercicio 2: Ordenar palabras", $contextoEjercicio, "Orden final de palabras", $ordenFinal, $discapacidad, $evalE2);

    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3, "Ejercicio 3: Reactivo de Matrices", $contextoEjercicio, "Imagen faltante (opción)", $respuestaE3, $discapacidad, $evalE3);

    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4, "Ejercicio 4: Analogías", $contextoEjercicio, "Complete la frase: BOTELLA es a ____ como PLATO es a ____", $respuesta4_1, $discapacidad, $evalE4_1);
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4, "Ejercicio 4: Reactivo con dibujos", $contextoEjercicio, "Observa la imagen y selecciona el nombre correcto.", $respuesta4_2, $discapacidad, $evalE4_2);
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4, "Ejercicio 4: Reactivos verbales", $contextoEjercicio, "Significado: Persona que vigila el cumplimiento de las órdenes.", $respuesta4_3, $discapacidad, $evalE4_3);

    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5, "Ejercicio 5: Rompecabezas visuales", $contextoEjercicio, "Observa el rompecabezas y selecciona la opción que complete la figura.", $respuesta5_1, $discapacidad, $evalE5_1);
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5, "Ejercicio 5: Figuras Incompletas", $contextoEjercicio, "Observa la figura y selecciona la pieza que la complete.", $respuesta5_2, $discapacidad, $evalE5_2);
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5, "Ejercicio 5: Búsqueda de Símbolos", $contextoEjercicio, "Cuenta los símbolos en la imagen", $simbolosRespuesta, $discapacidad, $evalE5_3);

    /*------------------------------------------
      Generar resumen de resultados
    -------------------------------------------*/
    $totalEj1 = $aciertosE1 . " de 3";
    $totalEj2 = $aciertosE2 . " de 1";
    $totalEj3 = $aciertosE3 . " de 1";
    $totalEj4 = $aciertosE4 . " de 3";
    $totalEj5 = $aciertosE5 . " de 3";

    // Estilos para la tabla (puedes moverlos a un archivo CSS externo)
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
    echo "  <tr>";
    echo "      <th>Ejercicio</th>";
    echo "      <th>Progreso</th>";
    echo "  </tr>";
    echo "  <tr><td>Ejercicio 1</td><td>$totalEj1</td></tr>";
    echo "  <tr><td>Ejercicio 2</td><td>$totalEj2</td></tr>";
    echo "  <tr><td>Ejercicio 3</td><td>$totalEj3</td></tr>";
    echo "  <tr><td>Ejercicio 4</td><td>$totalEj4</td></tr>";
    echo "  <tr><td>Ejercicio 5</td><td>$totalEj5</td></tr>";
    echo "</table>";

} else {
    echo "Método de petición no válido.";
}
    