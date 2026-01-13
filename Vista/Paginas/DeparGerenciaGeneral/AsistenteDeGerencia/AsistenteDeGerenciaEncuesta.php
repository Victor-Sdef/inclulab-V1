<?php
session_start();

if (!isset($_SESSION['user'])) {
    header('Location: ../ingreso.php?action=login');
    exit();
}
require '../../../../Modelo/conexion.php';

$nombreUsuario = isset($_SESSION['user']['nombre']) ? $_SESSION['user']['nombre'] : 'Usuario';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Encuesta de Competencias(Departamento De Gerencia General)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: sans-serif;
            margin: 20px;
            background: #f8f8f8;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }

        .survey-container {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            text-align: center;
            color: #007BFF;
            margin-bottom: 20px;
        }

        fieldset {
            border: 2px solid #007BFF;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
        }

        legend {
            font-size: 1.2em;
            font-weight: bold;
            color: #007BFF;
            padding: 0 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
            vertical-align: middle;
            font-size: 1em;
        }

        th {
            background-color: #007BFF;
            color: white;
            font-weight: bold;
        }

        input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .radio-label {
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            font-size: 1em;
            padding: 10px;
            margin: 5px;
            border: 2px solid #ddd;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }

        input[type="radio"]:checked + .radio-label {
            border-color: #007BFF;
            background-color: #e6f7ff;
        }

        .fixed-button {
            display: block;
            width: 95%;
            padding: 12px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            margin-top: 20px;
        }

        .fixed-button:hover {
            background-color: #0056b3;
        }

        /* Estilos para accesibilidad */
        .radio-label:focus, .fixed-button:focus {
            outline: 2px solid #007BFF;
            outline-offset: 2px;
        }

        .survey-container, table, th, td {
            border-color: #ddd;
        }

        /* Estilos responsivos */
        @media (max-width: 768px) {
            .survey-container {
                padding: 10px;
            }

            th, td {
                padding: 8px 10px;
                font-size: 0.9em;
            }

            .radio-label {
                padding: 8px;
                font-size: 0.9em;
            }

            .fixed-button {
                padding: 10px 15px;
                font-size: 0.9em;
            }
        }
    </style>
</head>
<body>
    <div class="survey-container">
        <h2>Bienvenido/a, <?php echo htmlspecialchars($nombreUsuario); ?></h2>
        <br>
        <h1>Encuesta de Competencias (Departamento Gerencia General/Asistente de Gerencia)</h1>
        <form id="surveyForm" method="post" action="procesar_encuesta.php">
            <input type="hidden" name="id" value="1">
            <input type="hidden" name="id_usuario" value="<?php echo isset($_SESSION['user']['id']) ? $_SESSION['user']['id'] : 'usuario_actual'; ?>">
            <input type="hidden" name="nombre_departamento" value="Departamento Gerencia General">
            <input type="hidden" name="cargo_departamento" value="AsistenteDeGerencia">
            <input type="hidden" name="discapacidad" value="auditiva, visual y fisica">

            <table>
                <thead>
                    <tr>
                        <th>Competencia</th>
                        <th>Preguntas</th>
                        <th>No hay problema</th>
                        <th>Problema leve</th>
                        <th>Problema moderado</th>
                        <th>Problema grave</th>
                        <th>Problema completo</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $preguntas = [
                        ['Adaptabilidad / Flexibilidad', [
                            '¿Ha tenido dificultad para realizar cambios en su vida personal, social y laboral, tomando en cuenta las posibles consecuencias que pudieran surgir?',
                            '¿Se considera una persona curiosa, imaginativa y buscadora de experiencias?',
                            '¿Ha tenido dificultad para ser una persona sociable, abierta y expresiva, lo contrario de ser tímido, reservado e inhibido?',
                            '¿Es una persona activa, optimista y capaz de realizar proyectos y nuevos retos con responsabilidad?',
                            '¿Tiene la capacidad de adaptarse a normas y reglas de un grupo de trabajo?',
                        ]],
                        ['Construcción de relaciones', [
                            '¿Ha tenido dificultad para ser amigable, servicial y responsable, lo contrario de ser poco amistoso, negativista y desafiante?',
                            '¿Logra controlar y regular sus emociones cuando las cosas no marchan bien en situaciones de alta tensión o estrés?',
                            '¿Puede mantener relaciones interpersonales estables con superiores y compañeros fortaleciendo el clima laboral?',
                        ]],
                        ['Escucha Activa y Hablado', [
                            '¿En una reunión o junta de trabajo le cuesta mantenerse concentrado por más de 45 min?',
                            '¿Logra comprender todo lo que la otra persona trata de comunicarle?',
                            '¿Ha tenido dificultad para comunicarse de forma asertiva, de manera que pueda expresar claramente sus dudas e inquietudes?',
                            '¿Presenta dificultades en articulación y fluidez de la voz al momento de expresarse de forma verbal, que le impidan mantener una conversación?',
                        ]],
                        ['Liderazgo', [
                            '¿Ha tenido dificultades para dirigir grupos de trabajo?',
                            '¿Posee habilidades para elaborar y dirigir actividades con responsabilidad, amabilidad, optimismo y confianza?', 
                            '¿Tiende a buscar las mejores opciones y los medios para alcanzar las metas del grupo?',
                            '¿Posee un buen manejo y control de sus emociones (ira, alegría, tristeza, miedo) de manera que le permitan direccionar y orientar al grupo de trabajo?',                  
                        ]],
                        ['Persuación y Negociación', [
                            '¿Ha tenido dificultad para comunicarse de manera asertiva utilizando un lenguaje o argumentos sencillos hacia los demás?',
                            '¿Ha tenido dificultad para organizar sus ideas u opiniones, para emitir criterios, creando un espacio de negociación mutua?',
                            '¿Mantiene una postura serena ante los desafíos y dificultades demostrando seguridad, confianza y optimismo a la hora de convencer y tomar decisiones?',
                        ]],
                        ['Asertividad y Firmeza', [
                            '¿Evita confrontaciones o tensiones y emplea estrategias, para llegar a acuerdos?',
                            '¿Ha tenido dificultades para comprender los deseos verbales e ideas de los demás, sin que se crea un espacio de negociación mutua?',
                            '¿Se le dificulta mantenerse tranquilo, respetuoso y comprometido con los demás, cuando existen pensamientos y decisiones en las que no esté de acuerdo?',
                        ]], 
                    ];

                    $contadorPreguntas = 1;
                    foreach ($preguntas as $competencia) {
                        $nombreCompetencia = $competencia[0];
                        $listaPreguntas = $competencia[1];
                        $totalPreguntas = count($listaPreguntas);
                        echo '<tr><td rowspan="' . $totalPreguntas . '">' . $nombreCompetencia . '</td>';
                        foreach ($listaPreguntas as $pregunta) {
                            echo '<td>' . $pregunta . '</td>';
                            for ($i = 1; $i <= 5; $i++) {
                                $valor = '';
                                switch ($i) {
                                    case 1:
                                        $valor = 'No hay problema';
                                        break;
                                    case 2:
                                        $valor = 'Problema leve';
                                        break;
                                    case 3:
                                        $valor = 'Problema moderado';
                                        break;
                                    case 4:
                                        $valor = 'Problema grave';
                                        break;
                                    case 5:
                                        $valor = 'Problema completo';
                                        break;
                                }
                                echo '<td><input type="radio" name="q' . $contadorPreguntas . '" id="q' . $contadorPreguntas . '-' . $i . '" value="' . $valor . '" required><label for="q' . $contadorPreguntas . '-' . $i . '" class="radio-label">' . $valor . '</label></td>';
                            }
                            echo '</tr>';
                            $contadorPreguntas++;
                        }
                    }
                    ?>
                </tbody>
            </table>
            <button type="submit" class="fixed-button">Enviar Encuesta</button>
        </form>
    </div>

<!-- Tus dos archivos JS separados -->
<!-- <script src="../../../Vista/assets/js/Inicio/accesibilidad.js"></script>

<script src="../../../Vista/assets/js/DepartamentoDeProduccion1/DepartamentoDeProduccion1.js"></script>
 -->

</body>
</html>