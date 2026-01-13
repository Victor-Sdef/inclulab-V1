<?php
require '../../../Modelo/conexion.php'; // o la ruta correcta a tu conexión

// Verifica si se recibió un ID
if (isset($_GET['id'])) {
    $id_usuario = $_GET['id'];

    // Consulta los datos del usuario específico en la tabla "respuestas"
    $conn = Conexion::conectar();
    $sql = "SELECT * FROM respuestas WHERE id_usuario = :id_usuario ORDER BY departamento";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':id_usuario', $id_usuario, PDO::PARAM_INT);
    $stmt->execute();
    $respuestas = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Agrupar por departamento (como en tu código actual)
    $grouped = [];
    foreach ($respuestas as $row) {
        $grouped[$row['departamento']][] = $row;
    }

} else {
    echo "No se proporcionó un ID de usuario.";
    exit();
}
?>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f4f6f8;
        padding: 20px;
    }

    .respuestas-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 0 10px rgba(0,0,0,0.05);
        border-radius: 8px;
        overflow: hidden;
    }

    .respuestas-table caption {
        font-size: 1.3rem;
        font-weight: bold;
        padding: 15px;
        background-color:rgb(0, 4, 107);
        color: white;
        text-align: left;
    }

    .respuestas-table thead {
        background-color:rgb(0, 9, 179);
        color: white;
    }

    .respuestas-table th, .respuestas-table td {
        padding: 10px 15px;
        text-align: left;
        border-bottom: 1px rgb(0, 0, 0);
    }

    .respuestas-table tbody tr:nth-child(even) {
        background-color:rgb(181, 177, 255);
    }

    .dept-group td {
        background-color:rgb(100, 72, 255);
        font-weight: bold;
        font-size: 1rem;
        color:rgb(0, 0, 0);
    }

    .respuestas-table td:nth-child(3), /* Departamento */
    .respuestas-table td:nth-child(4), /* Cargo */
    .respuestas-table td:nth-child(7)  /* Pregunta */ {
        font-weight: 500;
        color: #34495e;
    }
</style>

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