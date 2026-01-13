<?php
session_start();
require_once '../../../Modelo/conexion.php';

// Verificar que el usuario esté autenticado y sea admin
if (!isset($_SESSION['user']) || $_SESSION['user']['id_estado_rol'] != 1) {
    header('Location: ../../ingreso.php?action=login');
    exit();
}

try {
    // Conexión a la base de datos
    $pdo = Conexion::conectar();
    if (!$pdo) {
        throw new Exception("Error al conectar a la base de datos");
    }
    
    // ======================================================
    // SECCIÓN 1: Listado de Usuarios con edición en línea
    // ======================================================
    $sqlUsuarios = "SELECT id_usuario, nombre, email, id_discapacidad FROM usuarios";
    $stmtUsuarios = $pdo->query($sqlUsuarios);
    $usuarios = $stmtUsuarios->fetchAll(PDO::FETCH_ASSOC);

    $sqlDisc = "SELECT id_discapacidad, tipo FROM discapacidad";
    $stmtDisc = $pdo->query($sqlDisc);
    $discapacidades = $stmtDisc->fetchAll(PDO::FETCH_ASSOC);

    // ======================================================
    // SECCIÓN 2: Consultas Avanzadas a la tabla respuestas
    // ======================================================
    // Recoger filtros enviados por GET (se esperan arrays para varios valores)
    $filtroDept = isset($_GET['dept_resp']) ? $_GET['dept_resp'] : [];
    $filtroCargo = isset($_GET['cargo_resp']) ? $_GET['cargo_resp'] : [];
    $filtroEj = isset($_GET['ej_resp']) ? $_GET['ej_resp'] : [];
    $filtroIdUsuario = isset($_GET['id_usuario_resp']) ? trim($_GET['id_usuario_resp']) : '';

    // Verificar que se haya seleccionado al menos un departamento, un cargo, un ejercicio y un usuario
    $errorAdvanced = "";
    // Si el formulario fue enviado (al menos uno de los filtros viene en GET)
    if (!empty($_GET)) {
        if (empty($filtroDept) || empty($filtroCargo) || empty($filtroEj) || $filtroIdUsuario === '') {
            $errorAdvanced = "Debe seleccionar al menos un departamento, un cargo, un ejercicio y un usuario para la consulta avanzada.";
        }
    }

    // Solo se ejecuta la consulta avanzada si no hay error
    if (empty($errorAdvanced)) {
        // Construir la consulta base para la tabla respuestas (sin JOIN)
        $sqlRespuestas = "SELECT * FROM respuestas WHERE 1=1";
        $paramsRespuestas = [];

        if (!empty($filtroDept)) {
            $placeholders = [];
            foreach ($filtroDept as $i => $dept) {
                $key = ":dept$i";
                $placeholders[] = $key;
                $paramsRespuestas[$key] = $dept;
            }
            $sqlRespuestas .= " AND departamento IN (" . implode(",", $placeholders) . ")";
        }
        if (!empty($filtroCargo)) {
            $placeholders = [];
            foreach ($filtroCargo as $i => $cargoVal) {
                // Separar la cadena usando " | " como delimitador
                $parts = explode(" | ", $cargoVal);
                // Si se obtuvo el formato esperado, usar la segunda parte (el cargo)
                $cargo = (count($parts) === 2) ? trim($parts[1]) : trim($cargoVal);
                $key = ":cargo$i";
                $placeholders[] = $key;
                $paramsRespuestas[$key] = $cargo;
            }
            $sqlRespuestas .= " AND cargo_laboral IN (" . implode(",", $placeholders) . ")";
        }
        if (!empty($filtroEj)) {
            $placeholders = [];
            foreach ($filtroEj as $i => $ej) {
                $key = ":ejercicio$i";
                $placeholders[] = $key;
                $paramsRespuestas[$key] = $ej;
            }
            $sqlRespuestas .= " AND ejercicio IN (" . implode(",", $placeholders) . ")";
        }
        if ($filtroIdUsuario !== '') {
            $sqlRespuestas .= " AND id_usuario = :idusuario";
            $paramsRespuestas[':idusuario'] = $filtroIdUsuario;
        }

        $stmtRespuestas = $pdo->prepare($sqlRespuestas);
        $stmtRespuestas->execute($paramsRespuestas);
        $respuestas = $stmtRespuestas->fetchAll(PDO::FETCH_ASSOC);

        // Agrupar los registros por el campo "departamento"
        $grouped = [];
        foreach ($respuestas as $row) {
            $dept = $row['departamento'];
            if (!isset($grouped[$dept])) {
                $grouped[$dept] = [];
            }
            $grouped[$dept][] = $row;
        }
    } else {
        // Si falta algún filtro requerido, no se ejecuta la consulta avanzada
        $respuestas = [];
        $grouped = [];
    }
    
    // Lista de cargos agrupados por departamento (para el formulario de filtros)
    $departamentoCargos = [
        "Departamento De Gerencia General" => [
            "Asistente De Gerencia",
            "Jefe Coordinador De Comunicación Organizacional",
            "Jefe Coordinador Jurídico",
            "Asistente De Comunicación Organizacional",
            "Asistente Jurídico"
        ],
        "Departamento De Talento Humano" => [
            "Jefe Coordinador de Talento Humano",
            "Analista de Talento Humano",
            "Médico Ocupacional",
            "Analista de Capacitación y Desarrollo",
             "Recepcionista",
            "Trabajadora Social",
            "Analista de nómina",
            "Auxiliar de nómina",
            "Analista de selección de personal",
            "Auxiliar de Selección de Personal",
            "Auxiliar de Capacitación y Desarrollo",
            "Auxiliar de Talento Humano",
            "Técnico de Seguridad y Salud Ocupacional",
            "Auxiliar de Seguridad y Salud Ocupacional",
            "Auxiliar de Servicios Generales",
            "Mensajero"
        ],
        "Departamento Administrativo" => [
            "Jefe  Coordinador de Compras",
             "Jefe  Coordinador de Sistema",
            "Asistente de Compras Proveedores Nacionales",
            "Asistente de Compras Proveedores Extranjeros",
            "Asistente Bodega",
            "Asistente de Sistemas"
        ], 
        "Departamento Financiero" => [
            "Jefe Coordinador De Contabilidad",
            "Jefe De Coordinador De Crédito y Cobranzas",
            "Analista De Contabilidad",
            "Analista De Tesorería",
            "Jefe Coordinador De Tesorería",
            "Auxiliar De Contabilidad",
            "Auxiliar De Crédito y Cobranzas"
        ],
        "Departamento Comercial" => [
            "Jefe Coordinador de ventas",
            "Jefe de Coordinador de Marketing",
            "Asistente de Atención al Cliente",
            "Vendedor",
            "Asistente de Marketing",
            "Cajero Facturador"
        ],
        "Departamento de Produccion" => [
            "Asistente de Planificación",
            "Jefe Coordinador de Producción",
            "Jefe Coordinador de Mantenimiento",
            "Supervisor de Sección",
            "Supervisor de Mantenimiento Eléctrico",
            "Supervisor de Mantenimiento Mecánico",
            "Supervisor de Mantenimiento Automotriz",
            "Auxiliar de Mantenimiento Eléctrico",
            "Auxiliar de Mantenimiento Mecánico",
            "Auxiliar de Mantenimiento Automotriz" ,
             "Operario General",
            "Ayudante General"
        ],
       
    ];
    
} catch (Exception $e) {
    die("Se produjo un error: " . $e->getMessage());
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administrar Usuarios y Respuestas</title>
    <link rel="stylesheet" href="/assets/css/inicio.css">
    <!-- jQuery para la edición en línea de usuarios -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Incluir jsPDF y AutoTable para descargar PDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <style>
        /* Estilos para el listado de usuarios */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        table, th, td {
            border: 1px solid #0044cc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #e3f2fd;
        }
        caption {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #0044cc;
        }
        .action-btn {
            display: inline-block;
            padding: 5px 10px;
            margin: 2px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .delete-btn {
            background-color: #e74c3c;
            color: #fff;
        }
        .delete-btn:hover {
            background-color: #c0392b;
        }
        .editable {
            cursor: pointer;
        }
        .editable:hover {
            background-color: #f0f8ff;
        }
        input.edit-input, select.edit-input {
            width: 90%;
            font-size: 1.2rem;
            padding: 5px;
        }
        /* Estilos para el formulario de filtros de respuestas */
        .filter-form {
            max-width: 800px;
            margin: 20px auto;
            padding: 15px;
            background-color: #fff;
            border: 2px solid #0044cc;
            border-radius: 10px;
        }
        .filter-form fieldset {
            border: none;
            margin-bottom: 15px;
        }
        .filter-form legend {
            font-weight: bold;
            color: #0044cc;
            margin-bottom: 5px;
        }
        .filter-form label {
            display: block;
            margin-bottom: 5px;
        }
        .filter-form input[type="checkbox"] {
            margin-right: 5px;
        }
        .filter-form input[type="text"] {
            margin-top: 5px;
            padding: 5px;
            width: 200px;
        }
        .filter-form button {
            width: 100%;
            padding: 10px;
            font-size: 18px;
            background-color: #0044cc;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .filter-form button:hover {
            background-color: #003399;
        }
        /* Estilos para la tabla de respuestas */
        .respuestas-table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        .respuestas-table th, .respuestas-table td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        .respuestas-table th {
            background-color: #0044cc;
            color: #fff;
        }
        .respuestas-table caption {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #0044cc;
        }
        /* Separador para grupo de departamento en respuestas */
        .dept-group {
            background-color: #e3f2fd;
            font-weight: bold;
            text-align: center;
        }
        /* Agrupación de cargos por departamento en el formulario */
        .dept-fieldset {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px dashed #ccc;
            border-radius: 5px;
        }
        .dept-fieldset legend {
            color: #333;
            font-weight: normal;
            font-size: 16px;
        }
        /* Estilo para el botón de cerrar sesión */
        .logout-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #e74c3c;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        /* Estilo para el mensaje de error de consulta avanzada */
        .error-msg {
            color: red;
            font-weight: bold;
            text-align: center;
            margin: 10px auto;
        }
        .panel-btn {
            text-decoration: none;
            background-color: #28a745;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1.2em;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.3s ease;
            border: 2px solid #28a745;
            align-self: center;
            margin-top: -18px;
        }
        .panel-btn i {
            margin-right: 3px;
        }
        .panel-btn:hover {
            background-color: #218838;
            border-color: #218838;
        }
    </style>

    <script>
        // Exportar la lista de discapacidades a JS (para edición en línea de usuarios)
        var opcionesDiscapacidad = <?php echo json_encode($discapacidades); ?>;
        
        // Función para descargar la tabla de respuestas en PDF usando jsPDF y AutoTable
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            var doc = new jsPDF();
            doc.autoTable({ html: '.respuestas-table' });
            doc.save("consulta_respuestas.pdf");
        }
    </script>
</head>
<body>
  
<!-- Encabezado -->
<link rel="stylesheet" href="../../assets/css/logo.css">
<div class="header-container1">
  <div class="logo">
    <img src="../../../assets/imagenes/logo.png" alt="Logo de IncluLab" 
         onerror="this.onerror=null; this.src='/04.PDO-MYSQL-V1/assets/imagenes/logo.png';">
    <h1>IncluLab</h1>
  </div>
  <!-- Enlace para ir al panel de preguntas -->
  <a href="preguntas.php" class="panel-btn" aria-label="Ir al panel de preguntas">
    <i class="fas fa-question-circle"></i> Ir al Panel de Preguntas
  </a>
  <!-- Botón de Cerrar Sesión -->
  <a href="../salir.php" class="logout-btn" aria-label="Cerrar sesión">
    <i class="fas fa-sign-out-alt"></i> Cerrar sesión
  </a>
</div>

    <h1>Panel de Administración</h1>

    <!-- SECCIÓN 1: Listado de Usuarios con edición en línea -->
    <table id="usuariosTable">
        <caption>Listado de Usuarios</caption>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Correo</th>
                <th>Discapacidad</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($usuarios): ?>
                <?php foreach ($usuarios as $user): ?>
                    <tr data-id="<?php echo htmlspecialchars($user['id_usuario']); ?>">
                        <td><?php echo htmlspecialchars($user['id_usuario']); ?></td>
                        <td class="editable" data-field="nombre"><?php echo htmlspecialchars($user['nombre']); ?></td>
                        <td class="editable" data-field="email"><?php echo htmlspecialchars($user['email']); ?></td>
                        <td class="editable" data-field="id_discapacidad">
                            <?php 
                            foreach ($discapacidades as $d) {
                                if ($d['id_discapacidad'] == $user['id_discapacidad']) {
                                    echo htmlspecialchars($d['tipo']);
                                    break;
                                }
                            }
                            ?>
                        </td>
                        <td>
                            <a href="eliminar_usuario.php?id=<?php echo $user['id_usuario']; ?>" 
                               class="action-btn delete-btn" 
                               onclick="return confirm('¿Está seguro de eliminar al usuario: <?php echo $user['nombre']; ?>?');"></a>
                               Eliminar
                            </a>
                            <a href="ver_postulacion.php?id=<?php echo $user['id_usuario']; ?>" 
                               class="action-btn delete-btn" 
                               onclick="return confirm('¿Va a ver la postulación de <?php echo $user['nombre']; ?>?');">
                               Ver Postulacion
                            </a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php else: ?>
                <tr><td colspan="5">No se encontraron usuarios.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>

    <!-- Script para edición en línea de usuarios -->
    <script>
    $(document).ready(function(){
        $('.editable').on('dblclick', function(){
            var currentElement = $(this);
            var currentText = currentElement.text().trim();
            var field = currentElement.data('field');
            var row = currentElement.closest('tr');
            var userId = row.data('id');
            var input;
            if (field === 'id_discapacidad') {
                input = $('<select class="edit-input"></select>');
                opcionesDiscapacidad.forEach(function(opt){
                    var option = $('<option></option>')
                        .val(opt.id_discapacidad)
                        .text(opt.tipo);
                    if (opt.tipo === currentText) {
                        option.attr('selected', 'selected');
                    }
                    input.append(option);
                });
            } else {
                input = $('<input type="text" class="edit-input" />').val(currentText);
            }
            currentElement.html(input);
            input.focus();
            input.on('blur', function(){
                var newValue = $(this).val().trim();
                var displayValue = newValue;
                if (field === 'id_discapacidad') {
                    displayValue = $(this).find('option:selected').text();
                }
                currentElement.html(displayValue);
                $.ajax({
                    url: 'actualizar_usuario_ajax.php',
                    type: 'POST',
                    data: {
                        id: userId,
                        field: field,
                        value: newValue
                    },
                    success: function(response){
                        console.log("Actualizado:", response);
                    },
                    error: function(){
                        alert("Error al actualizar el usuario.");
                    }
                });
            });
        });
    });
    </script>

    <!-- SECCIÓN 2: Consultas Avanzadas a la Tabla respuestas -->
    <h2>Consultas a la tabla "respuestas"</h2>
    <form class="filter-form" method="GET" action="usuarios.php">
        <fieldset>
            <legend>Departamento</legend>
            <!-- Se muestran los departamentos disponibles -->
            <label>
                <input type="checkbox" name="dept_resp[]" value="Departamento De Gerencia General" class="dept-checkbox-advanced"
                <?php echo (isset($_GET['dept_resp']) && in_array("Departamento De Gerencia General", $_GET['dept_resp'])) ? "checked" : ""; ?>>
                Departamento De Gerencia General
            </label>
            <label>
                <input type="checkbox" name="dept_resp[]" value="Departamento De Talento Humano" class="dept-checkbox-advanced"
                <?php echo (isset($_GET['dept_resp']) && in_array("Departamento De Talento Humano", $_GET['dept_resp'])) ? "checked" : ""; ?>>
                Departamento De Talento Humano
            </label>
            <label>
                <input type="checkbox" name="dept_resp[]" value="Departamento Administrativo " class="dept-checkbox-advanced"
                <?php echo (isset($_GET['dept_resp']) && in_array("Departamento Administrativo", $_GET['dept_resp'])) ? "checked" : ""; ?>>
                Departamento Administrativo
            </label>
            <label>
                <input type="checkbox" name="dept_resp[]" value="Departamento Financiero" class="dept-checkbox-advanced"
                <?php echo (isset($_GET['dept_resp']) && in_array("Departamento Financiero", $_GET['dept_resp'])) ? "checked" : ""; ?>>
                Departamento Financiero
            </label>
            <label>
                <input type="checkbox" name="dept_resp[]" value="Departamento Comercial" class="dept-checkbox-advanced"
                <?php echo (isset($_GET['dept_resp']) && in_array("Departamento Comercial", $_GET['dept_resp'])) ? "checked" : ""; ?>>
                Departamento Comercial
            </label>
            <label>
                <input type="checkbox" name="dept_resp[]" value="Departamento de Produccion" class="dept-checkbox-advanced"
                <?php echo (isset($_GET['dept_resp']) && in_array("Departamento de Produccion", $_GET['dept_resp'])) ? "checked" : ""; ?>>
                Departamento de Produccion
            </label>
        </fieldset>
        <fieldset>
            <legend>Cargo Laboral (Agrupados por Departamento)</legend>
            <?php foreach ($departamentoCargos as $dept => $cargos): 
                // Generar un ID único para cada grupo de cargos basado en el nombre del departamento
                $deptId = 'cargo-' . strtolower(str_replace(' ', '-', $dept));
            ?>
            <fieldset class="dept-fieldset cargo-group" id="<?php echo $deptId; ?>" style="display: none;">
                <legend><?php echo htmlspecialchars($dept); ?></legend>
                <?php foreach ($cargos as $cargo): ?>
                    <label>
                        <input type="checkbox" name="cargo_resp[]" value="<?php echo htmlspecialchars($dept . " | " . $cargo); ?>"
                        <?php echo (isset($filtroCargo) && in_array($dept . " | " . $cargo, $filtroCargo)) ? "checked" : ""; ?>>
                        <?php echo htmlspecialchars($cargo); ?>
                    </label>
                <?php endforeach; ?>
            </fieldset>
            <?php endforeach; ?>
        </fieldset>
        <fieldset>
            <legend>Ejercicio (1 al 5)</legend>
            <?php 
            $ejercicios = [1, 2, 3, 4, 5];
            foreach ($ejercicios as $ej): ?>
                <label>
                    <input type="checkbox" name="ej_resp[]" value="<?php echo $ej; ?>"
                    <?php echo (isset($filtroEj) && in_array($ej, $filtroEj)) ? "checked" : ""; ?>>
                    <?php echo $ej; ?>
                </label>
            <?php endforeach; ?>
        </fieldset>
        <fieldset>
            <legend>Usuario</legend>
            <select name="id_usuario_resp">
                <option value="">-- Seleccione un usuario --</option>
                <?php foreach ($usuarios as $user): ?>
                    <option value="<?php echo htmlspecialchars($user['id_usuario']); ?>" <?php echo (isset($_GET['id_usuario_resp']) && $_GET['id_usuario_resp'] == $user['id_usuario']) ? "selected" : ""; ?>>
                        <?php echo htmlspecialchars($user['nombre']); ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </fieldset>
        <button type="submit">Filtrar Respuestas</button>
    </form>

    <!-- Mostrar mensaje de error si faltan campos requeridos en la consulta avanzada -->
    <?php if (!empty($errorAdvanced)): ?>
        <div class="error-msg"><?php echo $errorAdvanced; ?></div>
    <?php endif; ?>

    <!-- Botón para descargar consulta en PDF -->
    <div style="max-width: 800px; margin: 20px auto; text-align: center;">
        <button onclick="downloadPDF()" style="padding: 10px 20px; font-size: 18px; background-color: #0044cc; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
            Descargar Consulta en PDF
        </button>
    </div>

    <!-- Tabla de resultados agrupada por Departamento -->
    <table class="respuestas-table">
        <caption>Listado de Respuestas Guardadas para Postulacion(Tabla "respuestas")</caption>
        <thead>
            <tr>
                <th>ID Respuesta</th>
                <th>ID Usuario</th>
                <th>Departamento</th>
                <th>Cargo</th>
                <th>Ejercicio</th>
                <th>Discapacidades que pueden postular</th>
                <th>Pregunta</th>
                <th>Respuesta Contestada</th>
                <th>¿La Respuesta es Correcta?</th>
                <th>Fecha Respuesta</th>
            </tr>
        </thead>
        <tbody>
            <?php if (!empty($respuestas)): ?>
                <?php foreach ($grouped as $dept => $rows): ?>
                    <tr class="dept-group">
                        <td colspan="10"><?php echo htmlspecialchars($dept); ?></td>
                    </tr>
                    <?php foreach ($rows as $row): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['id_respuesta']); ?></td>
                            <td><?php echo htmlspecialchars($row['id_usuario']); ?></td>
                            <td><?php echo htmlspecialchars($row['departamento']); ?></td>
                            <td><?php echo htmlspecialchars($row['cargo_laboral']); ?></td>
                            <td><?php echo htmlspecialchars($row['ejercicio']); ?></td>
                            <td><?php echo htmlspecialchars($row['Discapacidad']); ?></td>
                            <td><?php echo htmlspecialchars($row['pregunta']); ?></td>
                            <td><?php echo htmlspecialchars($row['respuesta']); ?></td>
                            <td><?php echo htmlspecialchars($row['respuestaCorrectaoNo']); ?></td>
                            <td><?php echo htmlspecialchars($row['fecha_respuesta']); ?></td>
                        </tr>
                    <?php endforeach; ?>
                <?php endforeach; ?>
            <?php else: ?>
                <tr><td colspan="10">No se encontraron registros en la tabla respuestas.</td></tr>
            <?php endif; ?>
        </tbody>
    </table>

    <!-- Script para habilitar/deshabilitar los cargos según el departamento seleccionado -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        function updateCargoGroups() {
            // Por cada checkbox de departamento (para respuestas) se muestra u oculta el grupo de cargos correspondiente
            document.querySelectorAll('.dept-checkbox-advanced').forEach(function(checkbox) {
                var dept = checkbox.value;
                // Generamos el id de la sección de cargos a partir del valor del departamento
                var deptId = 'cargo-' + dept.toLowerCase().replace(/\s+/g, '-');
                var cargoGroup = document.getElementById(deptId);
                if (cargoGroup) {
                    if (checkbox.checked) {
                        cargoGroup.style.display = 'block';
                    } else {
                        cargoGroup.style.display = 'none';
                        // Opcional: desmarcar los cargos si se deselecciona el departamento
                        cargoGroup.querySelectorAll('input[type="checkbox"]').forEach(function(cb) {
                            cb.checked = false;
                        });
                    }
                }
            });
        }
        // Ejecutar actualización inicial
        updateCargoGroups();
        // Agregar evento change a cada checkbox de departamento
        document.querySelectorAll('.dept-checkbox-advanced').forEach(function(checkbox) {
            checkbox.addEventListener('change', updateCargoGroups);
        });
    });
    </script>
</body>
</html>
