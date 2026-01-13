<?php
session_start();
require_once '../../../Modelo/conexion.php';

// Verificar que el usuario esté autenticado y sea admin
if (!isset($_SESSION['user']) || $_SESSION['user']['id_estado_rol'] != 1) {
    header('Location: ../../ingreso.php?action=login');
    exit();
}

$pdo = Conexion::conectar();
if (!$pdo) {
    die("Error al conectar a la base de datos");
}

// Recoger los filtros enviados desde GET; se esperan arrays
$filterDepartamentos = isset($_GET['departamento']) ? $_GET['departamento'] : [];
$filterCargos = isset($_GET['cargo']) ? $_GET['cargo'] : [];
$filterEjercicios = isset($_GET['ejercicio']) ? $_GET['ejercicio'] : [];

// Construir la consulta base para la tabla preguntasYrespuestas
$sql = "SELECT * FROM preguntasYrespuestas WHERE 1=1";
$params = [];

// Filtrar por departamentos
if (!empty($filterDepartamentos)) {
    $placeholders = [];
    foreach ($filterDepartamentos as $i => $dept) {
        $key = ":dept$i";
        $placeholders[] = $key;
        $params[$key] = $dept;
    }
    $sql .= " AND nombre_departamento IN (" . implode(",", $placeholders) . ")";
}

// Filtrar por cargos
if (!empty($filterCargos)) {
    $placeholders = [];
    foreach ($filterCargos as $i => $cargo) {
        $key = ":cargo$i";
        $placeholders[] = $key;
        $params[$key] = $cargo;
    }
    $sql .= " AND cargo_laboral IN (" . implode(",", $placeholders) . ")";
}

// Filtrar por ejercicios (1 al 5)
if (!empty($filterEjercicios)) {
    $placeholders = [];
    foreach ($filterEjercicios as $i => $ej) {
        $key = ":ejercicio$i";
        $placeholders[] = $key;
        $params[$key] = $ej;
    }
    $sql .= " AND ejercicio IN (" . implode(",", $placeholders) . ")";
}

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$registros = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Agrupar resultados por departamento para mostrar separadores
$grouped = [];
foreach ($registros as $row) {
    $dept = $row['nombre_departamento'];
    if (!isset($grouped[$dept])) {
        $grouped[$dept] = [];
    }
    $grouped[$dept][] = $row;
}

// Lista de departamentos con sus cargos correspondientes
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
        "Auxiliar de Mantenimiento Automotriz",
        "Operario General",
        "Ayudante General"
    ],
];

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Preguntas y Respuestas - Administración</title>
    <link rel="stylesheet" href="/assets/css/inicio.css">
    <!-- Incluir jsPDF y AutoTable desde CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #0044cc;
        }
        .top-bar {
            text-align: right;
            margin-bottom: 20px;
        }
        .top-bar a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #e74c3c;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
        .filter-form {
            max-width: 800px;
            margin: 0 auto 20px;
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
            margin-bottom: 5px;
            color: #0044cc;
        }
        .filter-form label {
            display: block;
            margin-bottom: 5px;
            cursor: pointer;
        }
        .filter-form input[type="checkbox"] {
            margin-right: 5px;
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
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
        }
        table, th, td {
            border: 1px solid #0044cc;
        }
        th, td {
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background-color: #e3f2fd;
            color: #0044cc;
        }
        caption {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #0044cc;
        }
        .dept-group {
            background-color: #e3f2fd;
            font-weight: bold;
            text-align: center;
        }
        .advanced-info {
            max-width: 800px;
            margin: 20px auto;
            padding: 15px;
            border: 2px solid #0044cc;
            border-radius: 10px;
            background-color: #fff;
            font-size: 14px;
        }
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
            margin-top: -1px;
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
        // Función para descargar la tabla de resultados en PDF
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
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
        <!-- Enlace para ir al panel de usuarios -->
        <a href="usuarios.php" class="panel-btn" aria-label="Ir al panel de preguntas">
            <i class="fas fa-question-circle"></i> Ir al Panel de Usuarios
        </a>
        <!-- Botón de Cerrar Sesión -->
        <a href="../salir.php" class="logout-btn" aria-label="Cerrar sesión">
            <i class="fas fa-sign-out-alt"></i> Cerrar sesión
        </a>
    </div>
    <h1>Administración de Preguntas y Respuestas</h1>
    
    <!-- Formulario de Filtros Avanzados -->
    <form class="filter-form" method="GET" action="preguntas.php">
        <!-- Filtro de Departamentos -->
        <fieldset>
            <legend>Departamentos</legend>
            <?php foreach ($departamentoCargos as $dept => $cargos): ?>
                <label>
                    <input type="checkbox" name="departamento[]" value="<?php echo htmlspecialchars($dept); ?>"
                           class="dept-checkbox"
                        <?php echo in_array($dept, $filterDepartamentos) ? "checked" : ""; ?>>
                    <?php echo htmlspecialchars($dept); ?>
                </label>
            <?php endforeach; ?>
        </fieldset>
        <!-- Filtro de Cargos -->
        <fieldset id="cargo-container">
            <legend>Cargos Laborales (selecciona un departamento para habilitar los cargos)</legend>
            <?php foreach ($departamentoCargos as $dept => $cargos):
                    // Generamos un id único basado en el nombre del departamento
                    $deptId = 'cargo-' . strtolower(str_replace(' ', '-', $dept));
            ?>
            <fieldset class="dept-fieldset cargo-group" id="<?php echo $deptId; ?>" style="display: none;">
                <legend><?php echo htmlspecialchars($dept); ?></legend>
                <?php foreach ($cargos as $cargo): ?>
                    <label>
                        <input type="checkbox" name="cargo[]" value="<?php echo htmlspecialchars($cargo); ?>"
                        <?php echo in_array($cargo, $filterCargos) ? "checked" : ""; ?>>
                        <?php echo htmlspecialchars($cargo); ?>
                    </label>
                <?php endforeach; ?>
            </fieldset>
            <?php endforeach; ?>
        </fieldset>
        <!-- Filtro de Ejercicio -->
        <fieldset>
            <legend>Ejercicio (1 al 5)</legend>
            <?php 
            $ejercicios = [1, 2, 3, 4, 5];
            foreach ($ejercicios as $ej): ?>
                <label>
                    <input type="checkbox" name="ejercicio[]" value="<?php echo $ej; ?>"
                        <?php echo in_array($ej, $filterEjercicios) ? "checked" : ""; ?>>
                    <?php echo $ej; ?>
                </label>
            <?php endforeach; ?>
        </fieldset>
        <button type="submit">Filtrar</button>
    </form>

    <!-- Botón para descargar la consulta en PDF -->
    <div style="max-width: 800px; margin: 20px auto; text-align: center;">
        <button onclick="downloadPDF()" style="padding: 10px 20px; font-size: 18px; background-color: #0044cc; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
            Descargar Consulta en PDF
        </button>
    </div>

    <!-- Tabla de Resultados Agrupados por Departamento -->
    <table class="respuestas-table">
        <caption>Listado de Preguntas y Respuestas (Tabla "preguntasYrespuestas")</caption>
        <thead>
            <tr>
                <th>ID</th>
                <th>Departamento</th>
                <th>Cargo</th>
                <th>Ejercicio</th>
                <th>Pregunta</th>
                <th>Respuesta</th>
                <th>Fecha Respuesta</th>
            </tr>
        </thead>
        <tbody>
            <?php if (!empty($registros)): ?>
                <?php foreach ($grouped as $dept => $rows): ?>
                    <!-- Fila separadora para el Departamento -->
                    <tr class="dept-group">
                        <td colspan="7"><?php echo htmlspecialchars($dept); ?></td>
                    </tr>
                    <?php foreach ($rows as $row): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($row['id']); ?></td>
                            <td><?php echo htmlspecialchars($row['nombre_departamento']); ?></td>
                            <td><?php echo htmlspecialchars($row['cargo_laboral']); ?></td>
                            <td><?php echo htmlspecialchars($row['ejercicio']); ?></td>
                            <td><?php echo htmlspecialchars($row['pregunta']); ?></td>
                            <td><?php echo htmlspecialchars($row['respuesta']); ?></td>
                            <td><?php echo htmlspecialchars($row['fecha_respuesta']); ?></td>
                        </tr>
                    <?php endforeach; ?>
                <?php endforeach; ?>
            <?php else: ?>
                <tr>
                    <td colspan="7">No se encontraron registros.</td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>

    <!-- Script para habilitar/deshabilitar los cargos según el departamento seleccionado -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        function updateCargoGroups() {
            // Para cada checkbox de departamento, se muestra u oculta el grupo de cargos correspondiente
            document.querySelectorAll('.dept-checkbox').forEach(function(checkbox) {
                var dept = checkbox.value;
                // Generamos el id de la sección de cargos a partir del valor del departamento
                var deptId = 'cargo-' + dept.toLowerCase().replace(/\s+/g, '-');
                var cargoGroup = document.getElementById(deptId);
                if (cargoGroup) {
                    if (checkbox.checked) {
                        cargoGroup.style.display = 'block';
                    } else {
                        cargoGroup.style.display = 'none';
                        // Desmarcar los cargos si se deselecciona el departamento
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
        document.querySelectorAll('.dept-checkbox').forEach(function(checkbox) {
            checkbox.addEventListener('change', updateCargoGroups);
        });
    });
    </script>
</body>
</html>