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
// Si el usuario tiene discapacidad visual (id_discapacidad == 1), no mostramos este ejercicio.
$esVisual = ($usuarioIdDiscapacidad == 1);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 5 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
  

  <style>
  /* ================================
     Estilos para imágenes y elementos generales
  ================================= */
  .img-option,
  .img-option-center {
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  .img-option {
    width: 100px;
    height: auto;
    margin: 10px;
  }
  .img-option-center {
    display: block;
    margin: 20px auto;
    width: 80%;
    max-width: 400px;
    border: 3px dashed #FFD700; /* Borde dorado dashed */
    border-radius: 15px;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
  }
  .literal {
    font-size: 32px;
    font-weight: bold;
    color: #0044cc;
    margin-right: 5px;
  }

  /* ================================
     Estilos amigables para niños
  ================================= */
  body {
    font-family: "Comic Sans MS", cursive, sans-serif;
    background-color: #f0f8ff;
  }
  h3 {
    color: #FF6347; /* Tomato */
    text-align: center;
    font-size: 2em;
  }
  p {
    font-size: 1.3em;
    text-align: center;
  }
  .pregunta {
    background-color: #FFFACD; /* LemonChiffon */
    border: 2px solid #FFA07A; /* LightSalmon */
    border-radius: 15px;
    padding: 20px;
    margin: 20px auto;
    width: 90%;
    max-width: 500px;
  }
  .pregunta label {
    display: block;
    font-size: 1.5em;
    color: #2F4F4F;
    margin-bottom: 10px;
  }
  .pregunta input[type="number"] {
    width: 100%;
    padding: 10px;
    font-size: 1.4em;
    border: 2px solid #FFA07A;
    border-radius: 10px;
    margin-bottom: 15px;
  }
  hr {
    border: none;
    height: 2px;
    background: #FF6347;
    margin: 30px auto;
    width: 80%;
  }

  /* ================================
     Estilos generales para ejercicios y opciones
  ================================= */
  .ejercicio {
    margin-bottom: 40px;
    padding: 20px;
    border: 2px solid #0044cc;
    border-radius: 10px;
    background-color: #e3f2fd;
  }
  .opcion {
    margin: 10px 0;
    padding: 10px;
    background-color:  #FFFACD;
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
  .tabla-digitos {
    margin: 0 auto 20px;
    border-collapse: collapse;
    text-align: center;
    font-size: 28px;
  }
  .tabla-digitos th,
  .tabla-digitos td {
    padding: 10px 15px;
    border: 1px solid #ddd;
  }

  /* ================================
     Estilos específicos para el ejercicio (no se tocan los estilos del Puzzle)
  ================================= */
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
  .tabla-digitos th, 
  .tabla-digitos td {
    padding: 10px 15px;
    border: 1px solid #ddd;
  }

  /* ================================
     Estilos para Reactivo 5.3: Búsqueda de Símbolos
  ================================= */
  .simbolos-container {
    background-color: #FFFACD;
    border: 2px solid #FFA07A;
    border-radius: 15px;
    padding: 20px;
    margin: 20px auto;
    width: 90%;
    max-width: 500px;
  }
  .simbolos-container p {
    margin: 15px 0;
  }
  .simbolos-container img {
    display: block;
    margin: 20px auto;
    width: 80%;
    max-width: 400px;
    border: 3px dashed #FFD700;
    border-radius: 15px;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
  }
  .simbolos-container label {
    font-size: 1.5em;
    color: #2F4F4F;
    margin-bottom: 10px;
    display: block;
    text-align: left;
  }
  .simbolos-container input[type="number"] {
    width: 100%;
    padding: 10px;
    font-size: 1.4em;
    border: 2px solid #FFA07A;
    border-radius: 10px;
    margin-bottom: 15px;
  }

  /* ================================
     (Los estilos para Puzzle se mantienen sin cambios)
  ================================= */
  /* Ejemplo de estilos para Puzzle 2x2 (no se tocan) */
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
  .puzzle-piece.hidden {
    opacity: 0;
  }
</style>


  

</head>
<body>
<?php if(!$esVisual): ?>
  <!-- EJERCICIO 5: Versión para usuarios sin discapacidad visual -->
<div class="ejercicio">
  <h2>Ejercicio 5 / Competencia de Planificación y Toma de Decisiones</h2>
  
  <!-- Reactivo de puzles visuales 1 -->
  <h3>Reactivo de puzles visuales 1</h3>
  <p><strong>Indicación:</strong> Observe la imagen e imagine que este dibujo es un rompecabezas; escoja la opción correcta que complete el dibujo.</p>
  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.1.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.1.png" 
         alt="Rompecabezas 1" 
         class="img-option-center"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.1.png';">
  </p>

  </a>
  <p>Opciones de Respuesta</em></p>
  <div class="pregunta">
    <div class="opcion">
    
      <label>
        A
        <input type="radio" name="respuesta5_1" value="A" required>
        <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/A.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/A.png" 
             alt="Literal A" 
             class="literal-img"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/A.png';">
        <span class="literal-text"></span>
      </label>
    </div>
  </a>
    <div class="opcion">
      <label>
        B
        <input type="radio" name="respuesta5_1" value="B">
        <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/B.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/B.png" 
             alt="Literal B" 
             class="literal-img"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/B.png';">
        <span class="literal-text"></span>
      </label>
    </div>
</a>  
    <div class="opcion">
      <label>
        C
        <input type="radio" name="respuesta5_1" value="C">
        <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/C.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/C.png" 
             alt="Literal C" 
             class="literal-img"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/C.png';">
        <span class="literal-text"></span>
      </label>
    </div>
</a>
  </div>
  <hr>
</div>


    <!-- Reactivo de puzles visuales 2: Rompecabezas 2×2 -->
<h3>Reactivo de puzles visuales 2</h3>
<p><strong>Indicación:</strong> Observe la siguiente imagen e imagine que este dibujo es un rompecabezas; escoja la opción correcta que complete el dibujo.</p>
<div class="puzzle-container-2x2">
  <!-- Celda 1 (ya colocada: Pieza 1) -->
  <div class="puzzle-cell" data-cell="1">
  <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/4.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/4.png" 
         alt="Pieza 1" 
         class="fixed-piece"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/1.png';">
         </a>
        </div>
  <!-- Celda 2 (ya colocada: Pieza 2) -->
  <div class="puzzle-cell" data-cell="2">
  <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/4.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/2.png" 
         alt="Pieza 2" 
         class="fixed-piece"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/2.png';">
         </a>
        </div>
  <!-- Celda 3 (ya colocada: Pieza 3) -->
  <div class="puzzle-cell" data-cell="3">
  <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/4.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/3.png" 
         alt="Pieza 3" 
         class="fixed-piece"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/3.png';">
         </a>  
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
    <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/A.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/A.png" 
         alt="Pieza A" 
         id="pieceA" 
         draggable="true" 
         class="puzzle-piece"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/A.png';">
         </a>
        </div>
  <div class="puzzle-piece-container">
    <span class="literal">B</span>
    <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/B.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/B.png" 
         alt="Pieza B" 
         id="pieceB" 
         draggable="true" 
         class="puzzle-piece"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/B.png';">
         </a>
        </div>
  <div class="puzzle-piece-container">
    <span class="literal">C</span>
    <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/C.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/C.png" 
         alt="Pieza C" 
         id="pieceC" 
         draggable="true" 
         class="puzzle-piece"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/C.png';">
         </a> 
        </div>
</div>
<hr>

   <!-- Reactivo 5.3: Búsqueda de Símbolos -->
<h3>Reactivo Búsqueda de Símbolos</h3>
<p>
  <strong>Indicación:</strong> En la siguiente imagen va observar una serie de símbolos usted debe contar los símbolos que se indican en el siguiente recuadro.  Observe el ejemplo
<p>
<a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.3.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.3.png" 
       alt="Serie de símbolos" 
       class="img-option-center" 
       style="border:1px solid #ccc;"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.3.png';">
</p>
</a>
<div class="pregunta">
  
  <label for="busquedaLlaveCerrada">¿Cuántos '}' hay?</label>
  <input type="number" id="busquedaLlaveCerrada" placeholder="14" name="busquedaLlaveCerrada" min="0" required>
  
  <label for="busquedaMenor">¿Cuántos '¿' hay?</label>
  <input type="number" id="busquedaMenor" name="busquedaMenor" min="0" required>
  
  <label for="busquedaMayor">¿Cuántos '¬' hay?</label>
  <input type="number" id="busquedaMayor" name="busquedaMayor" min="0" required>
</div>

<?php else: ?>
  <p style="text-align:center; font-size:24px; color:#0044cc;">
    Este ejercicio no está disponible para usuarios con discapacidad visual.
  </p>
<?php endif; ?>
  
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
</body>
</html>
