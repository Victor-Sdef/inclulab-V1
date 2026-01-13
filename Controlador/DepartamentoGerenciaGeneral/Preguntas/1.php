<?php
session_start();
require_once '../../../../Modelo/conexion.php'; // ruta correcta de conexion a la BD

// Verificar que el usuario haya iniciado sesión
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    header('Location: ../../../ingreso.php?action=login');
    exit();
}

// Obtenemos el id de discapacidad del usuario desde la sesión
// (Asegúrate de que al iniciar sesión almacenes este dato en $_SESSION['user'])
$usuarioIdDiscapacidad = $_SESSION['user']['id_discapacidad'] ?? null;

// Asumimos que la discapacidad visual se identifica con el id 2 
// y la versión original se mostrará cuando el id sea 1 (o cualquier otro distinto de 2)
$esVisual = ($usuarioIdDiscapacidad == 2);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 5 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
  <!-- Aquí puedes incluir tu cabecera o menú -->
  
<?php if($esVisual): ?>
 
<!-- =========================================================
     EJERCICIO 5: Competencia de Planificación y Toma de Decisiones
     DISCAPACIDAD: auditiva, física
========================================================= -->
<div class="ejercicio">
  <h2>Ejercicio 5 / Competencia de Planificación y Toma de Decisiones</h2>
  
  <!-- Reactivo de puzles visuales -->
  <h3>Reactivo de puzles visuales</h3>
  <p><strong>Indicación:</strong> Observe la imagen e imagine que este dibujo es un rompecabezas, para ello debe escoger la opción correcta que permita completar el dibujo.</p>
  <p>
    <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.1.png" alt="Rompecabezas 1" class="img-option-center">
  </p>
  <div class="pregunta">
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta5_1" value="A" required>
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/A.png" alt="Literal A" class="literal-img">
        <span class="literal-text">A</span>
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta5_1" value="B">
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/B.png" alt="Literal B" class="literal-img">
        <span class="literal-text">B</span>
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta5_1" value="C">
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/C.png" alt="Literal C" class="literal-img">
        <span class="literal-text">C</span>
      </label>
    </div>
  </div>
  <hr>
  
  <!-- Reactivo de puzles visuales 2: Rompecabezas 2×2 -->
  <h3>Reactivo de puzles visuales 2</h3>
  <p><strong>Indicación:</strong> Observe la siguiente imagen e imagine que este dibujo es un rompecabezas; escoja la opción correcta que complete el dibujo.</p>
  <!-- Rompecabezas 2×2 -->
  <div class="puzzle-container-2x2">
    <!-- Celda 1 (ya colocada: Pieza 1) -->
    <div class="puzzle-cell" data-cell="1">
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/1.png" alt="Pieza 1" class="fixed-piece">
    </div>
    <!-- Celda 2 (ya colocada: Pieza 2) -->
    <div class="puzzle-cell" data-cell="2">
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/2.png" alt="Pieza 2" class="fixed-piece">
    </div>
    <!-- Celda 3 (ya colocada: Pieza 3) -->
    <div class="puzzle-cell" data-cell="3">
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/3.png" alt="Pieza 3" class="fixed-piece">
    </div>
    <!-- Celda 4 (slot vacío para la pieza "B") -->
    <div class="puzzle-slot" data-slot="slot1">
      <input type="hidden" name="slot1" value="">
    </div>
  </div>
  
  <!-- Piezas sueltas para arrastrar (con literales A, B, C) -->
  <div class="puzzle-pieces">
    <div class="puzzle-piece-container">
      <span class="literal">A</span>
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/A.png" alt="Pieza A" id="pieceA" draggable="true" class="puzzle-piece">
    </div>
    <div class="puzzle-piece-container">
      <span class="literal">B</span>
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/B.png" alt="Pieza B" id="pieceB" draggable="true" class="puzzle-piece">
    </div>
    <div class="puzzle-piece-container">
      <span class="literal">C</span>
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/C.png" alt="Pieza C" id="pieceC" draggable="true" class="puzzle-piece">
    </div>
  </div>
  <hr>
  
  <!-- Reactivo de Información (Protección personal) -->
  <h2>Reactivo de Información (Equipos o materiales de protección personal)</h2>
  <p>
    <strong>Indicación:</strong> Lea la siguiente información sobre equipos o materiales de protección personal usados en una empresa para prevenir lesiones y elija la respuesta correcta.
  </p>
  <p>
    <strong>¿Para qué sirven los guantes de protección?</strong>
  </p>
  <div class="pregunta">
    <div class="opcion">
      <label>
        <input type="radio" name="respuestaPPE1" value="A" required>
        A) Equipo de protección individual destinado a proteger total o parcialmente la mano.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuestaPPE1" value="B">
        B) Elemento más conocido para la protección de golpes en la cabeza.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuestaPPE1" value="C">
        C) Protegen de caídas de objetos pesados y/o punzantes.
      </label>
    </div>
  </div>
  
  <!-- Reactivo de semejanzas (guantes y casco) -->
  <h3>Reactivo de semejanzas</h3>
  <p><strong>Indicación:</strong> Compare los dos elementos y elija la opción que indique su semejanza.</p>
  <p><strong>¿En qué se parecen los guantes y el casco?</strong></p>
  <div class="pregunta">
    <div class="opcion">
      <label>
        <input type="radio" name="respuestaPPE2" value="A" required>
        A) Son equipos o materiales de uso y protección personal dentro de una empresa.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuestaPPE2" value="B">
        B) Ayudan a una empresa a prevenir, informar, y orientar de las acciones de seguridad.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuestaPPE2" value="C">
        C) Tienen como objetivo alertar a la persona de un peligro.
      </label>
    </div>
  </div>
  
  <!-- Reactivo 5.3: Búsqueda de Símbolos -->
  <h3>Reactivo Búsqueda de Símbolos</h3>
  <p><strong>Indicación:</strong> En la siguiente imagen, observe una serie de símbolos. Cuente los símbolos que se indican en el recuadro.</p>
  <p>
    <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.3.png" alt="Serie de símbolos" class="img-option-center" style="border:1px solid #ccc;">
  </p>
  <p><em>Ejemplo de símbolos a contar: {, }, &lt;, &gt;, &amp;</em></p>
  <div class="pregunta">
    <label for="busquedaLlaveAbierta">¿Cuántos '{' hay?</label>
    <input type="number" id="busquedaLlaveAbierta" name="busquedaLlaveAbierta" min="0" required>
    
    <label for="busquedaLlaveCerrada">¿Cuántos '}' hay?</label>
    <input type="number" id="busquedaLlaveCerrada" name="busquedaLlaveCerrada" min="0" required>
    
    <label for="busquedaMenor">¿Cuántos '&lt;' hay?</label>
    <input type="number" id="busquedaMenor" name="busquedaMenor" min="0" required>
    
    <label for="busquedaMayor">¿Cuántos '&gt;' hay?</label>
    <input type="number" id="busquedaMayor" name="busquedaMayor" min="0" required>
  </div>
  <hr>
  
  <!-- Reactivo de Retención de Dígitos -->
  <h2>Reactivo de Retención de Dígitos</h2>
  <p><strong>Indicación:</strong> Escuche la siguiente serie de números (se reproducirá solo una vez) y escriba los números en el mismo orden que los escuchó.</p>
  <p><em>Ejemplo:</em></p>
  <table class="tabla-digitos">
    <tr>
      <th>Reactivo</th>
      <th>Respuesta</th>
    </tr>
    <tr>
      <td>4-9-3</td>
      <td>4-9-3</td>
    </tr>
    <tr>
      <td>6-1-7-5</td>
    </tr>
    <tr>
      <td>5-3-2-8</td>
    </tr>
    <tr>
      <td>6-2-4-8-1-3</td>
    </tr>
  </table>
  <p><strong>Indique aquí la serie escuchada:</strong></p>
  <div class="pregunta">
    <label for="retencionDigitos">Escriba la serie:</label>
    <input type="text" id="retencionDigitos" name="retencionDigitos" placeholder="Ej: 6-1-7-5" required>
  </div>
</div>

<!-- ===================== ESTILOS ADICIONALES ===================== -->
<style>
  .ejercicio {
    margin-bottom: 40px;
    padding: 20px;
    border: 2px solid #0044cc;
    border-radius: 10px;
    background-color: #e3f2fd;
  }
  .pregunta {
    margin: 15px 0;
    padding: 15px;
    background-color: #fff;
    border: 1px dashed #0044cc;
    border-radius: 8px;
  }
  .opcion {
    margin: 10px 0;
    padding: 10px;
    background-color: #f1f8e9;
    border: 1px solid #c5e1a5;
    border-radius: 8px;
  }
  .opcion label {
    font-size: 28px;
    color: #0044cc;
  }
  .literal-img {
    width: 80px;
    margin-right: 10px;
    vertical-align: middle;
  }
  .literal-text {
    font-size: 28px;
    font-weight: bold;
    color: #0044cc;
    vertical-align: middle;
  }
  .img-option-center {
    display: block;
    margin: 20px auto;
    width: 300px;
    height: auto;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  .tabla-digitos {
    margin: 0 auto 20px;
    border-collapse: collapse;
    text-align: center;
    font-size: 28px;
  }
  .tabla-digitos th, .tabla-digitos td {
    padding: 10px 15px;
    border: 1px solid #ddd;
  }
  /* Estilos para el rompecabezas 2x2 */
  .puzzle-container-2x2 {
    display: grid;
    grid-template-columns: repeat(2, 150px);
    grid-template-rows: repeat(2, 150px);
    gap: 10px;
    justify-content: center;
    margin: 20px auto;
  }
  .puzzle-cell, .puzzle-slot {
    width: 150px;
    height: 150px;
    border: 2px solid #aaa;
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #fff;
  }
  .fixed-piece {
    width: 150px;
    height: 150px;
    object-fit: cover;
  }
  .puzzle-pieces {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 15px;
    margin-top: 20px;
  }
  .puzzle-piece-container {
    display: inline-block;
    text-align: center;
    margin: 10px;
  }
  .literal {
    display: block;
    font-size: 32px;
    font-weight: bold;
    color: #0044cc;
    margin-bottom: 5px;
  }
  .puzzle-piece {
    width: 140px;
    height: 140px;
    object-fit: cover;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: move;
  }
</style>

<!-- Script para Drag & Drop (Puzzle 2x2) -->
<script>
document.addEventListener("DOMContentLoaded", () => {
  const puzzlePieces = document.querySelectorAll(".puzzle-piece");
  const puzzleSlots = document.querySelectorAll(".puzzle-slot");
  const piecesContainer = document.querySelector(".puzzle-pieces");

  puzzlePieces.forEach(piece => {
    piece.addEventListener("dragstart", dragStart);
    piece.addEventListener("dragend", dragEnd);
  });

  puzzleSlots.forEach(slot => {
    slot.addEventListener("dragover", dragOver);
    slot.addEventListener("drop", drop);
  });

  function dragStart(e) {
    e.dataTransfer.setData("text/plain", e.target.id);
    setTimeout(() => {
      e.target.classList.add("hidden");
    }, 0);
  }

  function dragEnd(e) {
    e.target.classList.remove("hidden");
  }

  function dragOver(e) {
    e.preventDefault();
  }

  function drop(e) {
    e.preventDefault();
    const slot = e.currentTarget;
    const pieceId = e.dataTransfer.getData("text/plain");
    const piece = document.getElementById(pieceId);

    // Si el slot ya tiene una pieza, reubicarla al contenedor de piezas
    const existingPiece = slot.querySelector("img.puzzle-piece");
    if (existingPiece) {
      piecesContainer.appendChild(existingPiece);
      const hiddenInput = slot.querySelector("input[type='hidden']");
      if (hiddenInput) {
        hiddenInput.value = "";
      }
    }

    // Colocar la nueva pieza en el slot
    slot.appendChild(piece);
    piece.style.width = "150px";
    piece.style.height = "150px";

    // Actualizar el input hidden del slot con el id de la pieza (esto indicará el literal)
    const hiddenInput = slot.querySelector("input[type='hidden']");
    if (hiddenInput) {
      hiddenInput.value = pieceId.replace("piece", ""); // Convertir "pieceB" en "B"
    }
  }
});
</script>

<?php endif; ?>

<!-- Scripts y cierre del documento -->
<script>
// Script para Drag & Drop (se ejecuta solo en la versión original)
document.addEventListener("DOMContentLoaded", () => {
  const puzzlePieces = document.querySelectorAll(".puzzle-piece");
  const puzzleSlots = document.querySelectorAll(".puzzle-slot");
  const piecesContainer = document.querySelector(".puzzle-pieces");

  if(puzzlePieces) {
    puzzlePieces.forEach(piece => {
      piece.addEventListener("dragstart", dragStart);
      piece.addEventListener("dragend", dragEnd);
    });
  }

  if(puzzleSlots) {
    puzzleSlots.forEach(slot => {
      slot.addEventListener("dragover", dragOver);
      slot.addEventListener("drop", drop);
    });
  }

  function dragStart(e) {
    e.dataTransfer.setData("text/plain", e.target.id);
    setTimeout(() => {
      e.target.classList.add("hidden");
    }, 0);
  }

  function dragEnd(e) {
    e.target.classList.remove("hidden");
  }

  function dragOver(e) {
    e.preventDefault();
  }

  function drop(e) {
    e.preventDefault();
    const slot = e.currentTarget;
    const pieceId = e.dataTransfer.getData("text/plain");
    const piece = document.getElementById(pieceId);

    // Si el slot ya tiene una pieza, reubicarla al contenedor de piezas
    const existingPiece = slot.querySelector("img.puzzle-piece");
    if (existingPiece) {
      piecesContainer.appendChild(existingPiece);
      const hiddenInput = slot.querySelector("input[type='hidden']");
      if (hiddenInput) {
        hiddenInput.value = "";
      }
    }

    // Colocar la nueva pieza en el slot
    slot.appendChild(piece);
    piece.style.width = "150px";
    piece.style.height = "150px";

    // Actualizar el input hidden del slot con el id de la pieza (esto indicará el literal)
    const hiddenInput = slot.querySelector("input[type='hidden']");
    if (hiddenInput) {
      hiddenInput.value = pieceId.replace("piece", ""); // Convertir "pieceB" en "B"
    }
  }
});
</script>
</body>
</html>