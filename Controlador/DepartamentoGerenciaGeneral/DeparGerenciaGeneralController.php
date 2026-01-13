<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

// 1. Incluir la conexión y obtener la instancia PDO
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

// 3. Obtener el id de discapacidad y determinar versión (se asume que id 1 es para usuarios visuales)
$userDisability = $_SESSION['user']['id_discapacidad'] ?? null;
$esVisual = ($userDisability == 1);
$discapacidadRegistro = $userDisability;

// 4. Procesamos solo si la petición es POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // 5. Recoger datos de contexto enviados desde la vista (por ejemplo, campos ocultos)
    $departamento  = $_POST['prefijoDepartamento'] ?? '';
    $cargo_laboral = $_POST['prefijoCargo'] ?? '';
    $contextoEjercicio = "Ejercicios para Discapacidad: Física, Auditiva y Visual";

    /**
     * Función para insertar una respuesta en la tabla 'respuestas'
     */
    function insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, $ejercicio, $titulo_ejercicio, $contexto_ejercicio, $pregunta, $respuesta, $discapacidad, $resultado) {
        $sql = "INSERT INTO respuestas 
                (id_usuario, departamento, cargo_laboral, ejercicio, titulo_ejercicio, 
                 contexto_ejercicio, pregunta, respuesta, Discapacidad, respuestaCorrectaoNo)
                VALUES 
                (:id_usuario, :departamento, :cargo_laboral, :ejercicio, :titulo_ejercicio, 
                 :contexto_ejercicio, :pregunta, :respuesta, :discapacidad, :resultado)";
        $stmt = $pdo->prepare($sql);
        if(!$stmt->execute([
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
        ])){
            $error = $stmt->errorInfo();
            die("Error en la inserción: " . $error[2]);
        }
    }

    /*------------------------------------------
      6. Definir respuestas correctas para la evaluación
    ------------------------------------------*/
    // Ejercicio 1: Comprensión Lectora (3 preguntas)
    $correctaE1_Q1 = "A";
    $correctaE1_Q2 = "A";
    $correctaE1_Q3 = "A";
    
    // Ejercicio 2: Ordenar palabras (se espera: "d,b,c,a,e")
    $ordenCorrecto = "d,b,c,a,e";
    
    // Ejercicio 3: Reactivo de Matrices
    $correctaE3 = "A";
    
    // Ejercicio 4: Organización y recopilación de la información
    $correctaE4_1 = "D";
    $correctaE4_2 = "A";
    $correctaE4_3 = "OBREROS";
    
    // Ejercicio 5:
    if (!$esVisual) {
        $correctaE5_1 = "B";
        $correctaE5_2 = "B";
        // En la versión normal no evaluamos PPE ni Retención de Dígitos aquí (se insertan como "N/A")
        $esperadoLlaveAbierta = 2;
        $esperadoLlaveCerrada = 2;
        $esperadoMenor = 2;
        $esperadoMayor = 3;
    } else {
        $adaptCorrectaPPE1 = "C";
        $adaptCorrectaPPE2_1 = "A";
        $adaptCorrectaPPE2_2 = "C";
        // Definir los valores esperados para cada serie de Retención de Dígitos adaptado
        $adapt_retencionEsperado1 = "6-1-7-5";
        $adapt_retencionEsperado2 = "5-3-2-8";
        $adapt_retencionEsperado3 = "6-2-4-8-1-3";
    }

    /*------------------------------------------
      7. Recoger las respuestas del formulario
    ------------------------------------------*/
    // Ejercicio 1
    $r1 = $_POST['respuesta1'] ?? '';
    $r2 = $_POST['respuesta2'] ?? '';
    $r3 = $_POST['respuesta3'] ?? '';

    // Ejercicio 2
    $ordenFinal = $_POST['ordenFinal'] ?? '';

    // Ejercicio 3
    $rE3 = $_POST['respuestaE3'] ?? '';

    // Ejercicio 4
    $r4_1 = $_POST['respuesta4_1'] ?? '';
    $r4_2 = $_POST['respuesta4_2'] ?? '';
    $r4_3 = $_POST['respuesta4_3'] ?? '';

    // Ejercicio 5
    if (!$esVisual) {
        $r5_1 = $_POST['respuesta5_1'] ?? '';
        $r5_2 = $_POST['slot1'] ?? ''; // Valor del rompecabezas 2x2
        $respuestaPPE1 = $_POST['respuestaPPE1'] ?? '';
        $respuestaPPE2 = $_POST['respuestaPPE2'] ?? '';
        $busquedaLlaveAbierta = $_POST['busquedaLlaveAbierta'] ?? 0;
        $busquedaLlaveCerrada = $_POST['busquedaLlaveCerrada'] ?? 0;
        $busquedaMenor = $_POST['busquedaMenor'] ?? 0;
        $busquedaMayor = $_POST['busquedaMayor'] ?? 0;
        $retencionDigitos = $_POST['retencionDigitos'] ?? '';
    } else {
        $adapt_respuestaPPE1 = $_POST['adapt_respuestaPPE1'] ?? '';
        $adapt_respuestaPPE2_1 = $_POST['adapt_respuestaPPE2_1'] ?? '';
        $adapt_respuestaPPE2_2 = $_POST['adapt_respuestaPPE2_2'] ?? '';
        // Recoger tres campos para el reactivo de retención de dígitos adaptado
        $adapt_retencionDigitos1 = $_POST['adapt_retencionDigitos1'] ?? '';
        $adapt_retencionDigitos2 = $_POST['adapt_retencionDigitos2'] ?? '';
        $adapt_retencionDigitos3 = $_POST['adapt_retencionDigitos3'] ?? '';
        // Formatear cada serie: remover caracteres que no sean dígitos y poner guiones entre ellos
        $formatted1 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos1)));
        $formatted2 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos2)));
        $formatted3 = implode('-', str_split(preg_replace('/\D/', '', $adapt_retencionDigitos3)));
    }

    /*------------------------------------------
      8. Evaluar las respuestas
    ------------------------------------------*/
    $evalE1_Q1 = ($r1 === $correctaE1_Q1) ? 1 : 0;
    $evalE1_Q2 = ($r2 === $correctaE1_Q2) ? 1 : 0;
    $evalE1_Q3 = ($r3 === $correctaE1_Q3) ? 1 : 0;
    $aciertosE1 = $evalE1_Q1 + $evalE1_Q2 + $evalE1_Q3;

    $evalE2 = (strtolower(trim($ordenFinal)) === strtolower(trim($ordenCorrecto))) ? 1 : 0;
    $evalE3 = ($rE3 === $correctaE3) ? 1 : 0;

    $evalE4_1 = ($r4_1 === $correctaE4_1) ? 1 : 0;
    $evalE4_2 = ($r4_2 === $correctaE4_2) ? 1 : 0;
    $evalE4_3 = ($r4_3 === $correctaE4_3) ? 1 : 0;
    $aciertosE4 = $evalE4_1 + $evalE4_2 + $evalE4_3;

    if (!$esVisual) {
        $evalE5_1 = ($r5_1 === $correctaE5_1) ? 1 : 0;
        $evalE5_2 = ($r5_2 === $correctaE5_2) ? 1 : 0;
        // Para la versión normal, las evaluaciones de PPE se marcan como "N/A" y se evalúan otros reactivos
        $evalPPE1 = 0;
        $evalPPE2 = 0;
        $evalSimbolos = (
            ($busquedaLlaveAbierta == $esperadoLlaveAbierta) &&
            ($busquedaLlaveCerrada == $esperadoLlaveCerrada) &&
            ($busquedaMenor == $esperadoMenor) &&
            ($busquedaMayor == $esperadoMayor)
        ) ? 1 : 0;
        // En la versión normal se cuentan 3 ítems para Ejercicio 5
        $aciertosE5 = $evalE5_1 + $evalE5_2 + $evalSimbolos;
        $porcentajeE5 = round(($aciertosE5 / 3) * 100);
    } else {
        $evalAdaptPPE1 = ($adapt_respuestaPPE1 === $adaptCorrectaPPE1) ? 1 : 0;
        $evalAdaptPPE2_1 = ($adapt_respuestaPPE2_1 === $adaptCorrectaPPE2_1) ? 1 : 0;
        $evalAdaptPPE2_2 = ($adapt_respuestaPPE2_2 === $adaptCorrectaPPE2_2) ? 1 : 0;
        // Evaluar cada serie de Retención de Dígitos adaptado
        $evalAdaptRetencion1 = ($formatted1 === $adapt_retencionEsperado1) ? 1 : 0;
        $evalAdaptRetencion2 = ($formatted2 === $adapt_retencionEsperado2) ? 1 : 0;
        $evalAdaptRetencion3 = ($formatted3 === $adapt_retencionEsperado3) ? 1 : 0;
        // Sumar las evaluaciones de retención (cada serie vale 1 punto)
        $evalAdaptRetencion = $evalAdaptRetencion1 + $evalAdaptRetencion2 + $evalAdaptRetencion3;
        // Ahora, en la versión adaptada, se evalúan 4 ítems: 3 de retención + 3 de PPE (cada uno 1 punto) = total 6 puntos
        $aciertosE5 = $evalAdaptPPE1 + $evalAdaptPPE2_1 + $evalAdaptPPE2_2 + $evalAdaptRetencion;
        $porcentajeE5 = round(($aciertosE5 / 6) * 100);
    }

    $porcentajeE1 = round(($aciertosE1 / 3) * 100);
    $porcentajeE2 = round(($evalE2 / 1) * 100);
    $porcentajeE3 = round(($evalE3 / 1) * 100);
    $porcentajeE4 = round(($aciertosE4 / 3) * 100);

    /*------------------------------------------
      9. Insertar respuestas en la base de datos
    ------------------------------------------*/
    // Ejercicio 1
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
        "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
        "¿Qué le pidió la abuela a Juan?", $r1, $discapacidadRegistro, ($evalE1_Q1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
        "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
        "¿Qué hizo Juan al llegar a la papelería?", $r2, $discapacidadRegistro, ($evalE1_Q2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 1,
        "Ejercicio 1: Comprensión Lectora", $contextoEjercicio,
        "¿Qué hizo el comerciante?", $r3, $discapacidadRegistro, ($evalE1_Q3 ? "Si" : "No"));

    // Ejercicio 2
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 2,
        "Ejercicio 2: Competencia de Escritura", $contextoEjercicio,
        "Orden final de palabras", $ordenFinal, $discapacidadRegistro, ($evalE2 ? "Si" : "No"));

    // Ejercicio 3
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 3,
        "Ejercicio 3: Competencia generación de ideas y pensamiento analítico", $contextoEjercicio,
        "Imagen faltante (opción)", $rE3, $discapacidadRegistro, ($evalE3 ? "Si" : "No"));

    // Ejercicio 4
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
        "Ejercicio 4: Competencia de organización y recopilación de la información", $contextoEjercicio,
        "Analogías verbales: BOTELLA es a ____ como ____ es a PLATO", $r4_1, $discapacidadRegistro, ($evalE4_1 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
        "Ejercicio 4: Competencia de organización y recopilación de la información", $contextoEjercicio,
        "Reactivo con dibujos: Seleccione el nombre correcto a la figura", $r4_2, $discapacidadRegistro, ($evalE4_2 ? "Si" : "No"));
    insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 4,
        "Ejercicio 4: Competencia de organización y recopilación de la información", $contextoEjercicio,
        "Reactivo verbal: Persona que vigila el cumplimiento de las órdenes e instrucciones", $r4_3, $discapacidadRegistro, ($evalE4_3 ? "Si" : "No"));

    // Ejercicio 5
    if (!$esVisual) {
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo Rompecabezas Visuales", $r5_1, $discapacidadRegistro, ($evalE5_1 ? "Si" : "No"));
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Puzzle 3x3 (Slots)", $r5_2, $discapacidadRegistro, ($evalE5_2 ? "Si" : "No"));
        // Para la versión normal, se insertan las respuestas de PPE y símbolos con evaluación "N/A"
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Información: ¿Para qué sirven los guantes de protección?", $respuestaPPE1, $discapacidadRegistro, "N/A");
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Semejanzas: ¿En qué se parecen los guantes y el casco?", $respuestaPPE2, $discapacidadRegistro, "N/A");
    } else {
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5 ADAPTADO: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Información: ¿Para qué sirven las gafas como equipo o material de uso personal?", $adapt_respuestaPPE1, $discapacidadRegistro, ($evalAdaptPPE1 ? "Si" : "No"));
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5 ADAPTADO: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Semejanzas: ¿En qué se parecen el departamento financiero y el departamento de recursos humanos?", $adapt_respuestaPPE2_1, $discapacidadRegistro, ($evalAdaptPPE2_1 ? "Si" : "No"));
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5 ADAPTADO: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Semejanzas: (Segunda parte) ¿En qué se parecen el departamento financiero y el departamento de recursos humanos?", $adapt_respuestaPPE2_2, $discapacidadRegistro, ($evalAdaptPPE2_2 ? "Si" : "No"));
        // Insertar cada serie del reactivo de Retención de Dígitos adaptado
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5 ADAPTADO: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Retención de Dígitos: Ingrese la serie en orden ascendente (Serie 1)", $formatted1, $discapacidadRegistro, ($evalAdaptRetencion1 ? "Si" : "No"));
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5 ADAPTADO: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Retención de Dígitos: Ingrese la serie en orden ascendente (Serie 2)", $formatted2, $discapacidadRegistro, ($evalAdaptRetencion2 ? "Si" : "No"));
        insertRespuesta($pdo, $id_usuario, $departamento, $cargo_laboral, 5,
            "Ejercicio 5 ADAPTADO: Competencia de Planificación y Toma de Decisiones", $contextoEjercicio,
            "Reactivo de Retención de Dígitos: Ingrese la serie en orden ascendente (Serie 3)", $formatted3, $discapacidadRegistro, ($evalAdaptRetencion3 ? "Si" : "No"));
    }

    /*------------------------------------------
      10. Calcular porcentajes de aciertos
    ------------------------------------------*/
    $porcentajeE1 = round(($aciertosE1 / 3) * 100);
    $porcentajeE2 = round(($evalE2 / 1) * 100);
    $porcentajeE3 = round(($evalE3 / 1) * 100);
    $porcentajeE4 = round(($aciertosE4 / 3) * 100);
    // En la versión normal, se evalúan 3 ítems; en la adaptada, 6 ítems (3 PPE + 3 Retención)
    $porcentajeE5 = (!$esVisual) ? round(($aciertosE5 / 3) * 100) : round(($aciertosE5 / 6) * 100);

    /*------------------------------------------
      11. Mostrar resumen de resultados
    ------------------------------------------*/
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
    echo "  <tr><td>Ejercicio 2</td><td>{$evalE2} de 1 ({$porcentajeE2}%)</td></tr>";
    echo "  <tr><td>Ejercicio 3</td><td>{$evalE3} de 1 ({$porcentajeE3}%)</td></tr>";
    echo "  <tr><td>Ejercicio 4</td><td>{$aciertosE4} de 3 ({$porcentajeE4}%)</td></tr>";
    echo "  <tr><td>Ejercicio 5</td><td>{$aciertosE5} de " . (!$esVisual ? "3" : "6") . " ({$porcentajeE5}%)</td></tr>";
    //echo "  <tr><td>Ejercicio 6</td><td>N/A</td></tr>";
    echo "</table>";
}
?>