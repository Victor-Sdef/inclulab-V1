<?php
// Verificar si la sesión no está iniciada antes de llamarla
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once '../../../../Modelo/conexion.php';

// Verificar que el usuario haya iniciado sesión
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    header('Location: ../../../ingreso.php?action=login');
    exit();
}

// Obtener el id de discapacidad del usuario desde la sesión
$usuarioIdDiscapacidad = $_SESSION['user']['id_discapacidad'] ?? null;

// Si
// Si el usuario tiene discapacidad visual (id_discapacidad == 1), no se muestra este ejercicio.
$esVisual = ($usuarioIdDiscapacidad == 1);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 2 - Evaluación de Competencia de Escritura</title>
  <link rel="stylesheet" href="/assets/css/style.css">
  <style>
    .ejercicio {
      margin-bottom: 40px;
      padding: 20px;
      border: 2px solid #0044cc;
      border-radius: 10px;
      background-color: #e3f2fd;
    }
    ul#sortable {
      list-style-type: none;
      padding: 0;
      margin: 20px 0;
      width: 300px;
    }
    ul#sortable li {
      margin: 5px 0;
      padding: 8px;
      background-color: #f9f9f9;
      border: 1px solid #ccc;
      cursor: move;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<?php if(!$esVisual): ?>
  <!-- EJERCICIO 2: Versión para usuarios sin discapacidad visual -->
  <div class="ejercicio">
    <h2>Ejercicio 2 / Evaluación de Competencia de Escritura</h2>
    <p><strong>Indicación:</strong> Lea (escuche) detenidamente cada palabra, ordene las mismas para formular una oración.

 <!-- Audio para escuchar el texto -->
 <p><strong>Escuche el audio:</strong></p>
    <audio controls>
      <source src="/inclulab-V1/assets/audio/gerencia_ejercicio2ReactivoComprensión.mp3" type="audio/mp3">
      Tu navegador no soporta el elemento de audio.
    </audio>
    
    <!-- Lista de palabras -->
    <ul>
      <li>a) Un informe detallado</li>
      <li>b) Del museo</li>
      <li>c) Escribieron</li>
      <li>d) Los funcionarios </li>
      <li>e) Para el director.</li>
    </ul>
        
    <h4>Arrastre las palabras para ordenar:</h4>
    <ul id="sortable">
      <li draggable="true" data-value="a">A) Un informe detallado</li>
      <li draggable="true" data-value="b">B) Del museo</li>
      <li draggable="true" data-value="c">C) Escribieron</li>
      <li draggable="true" data-value="d">D) Los funcionarios </li>
      <li draggable="true" data-value="e">E) Para el director.</li>
    </ul>
    
    <input type="hidden" name="ordenFinal" id="ordenFinal" value="">
  </div>
<?php else: ?>
  <!-- Para usuarios con discapacidad visual -->
  <p style="text-align:center; font-size:24px; color:#0044cc;">
    Este ejercicio no está disponible para usuarios con discapacidad visual.
  </p>
<?php endif; ?>

<!-- Script para drag & drop -->
<script>
document.addEventListener("DOMContentLoaded", () => {
    const sortableList = document.getElementById("sortable");
    let draggedItem = null;

    if(sortableList) {
        const items = sortableList.querySelectorAll("li");
        items.forEach(item => {
            item.addEventListener("dragstart", (e) => {
                draggedItem = item;
                setTimeout(() => {
                    item.style.display = "none";
                }, 0);
            });

            item.addEventListener("dragend", (e) => {
                setTimeout(() => {
                    draggedItem.style.display = "block";
                    draggedItem = null;
                }, 0);
            });
        });

        sortableList.addEventListener("dragover", (e) => {
            e.preventDefault();
        });

        sortableList.addEventListener("drop", (e) => {
            e.preventDefault();
            const targetItem = e.target.closest("li");
            if (targetItem && targetItem !== draggedItem) {
                sortableList.insertBefore(draggedItem, targetItem);
            } else {
                sortableList.appendChild(draggedItem);
            }
        });
    }
});
</script>
</body>
</html>
