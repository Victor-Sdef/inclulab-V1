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

// Asumimos que la discapacidad visual se identifica con id=1
$esVisual = ($usuarioIdDiscapacidad == 1);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 5 - Evaluación de Competencias</title>

  <!-- Un CSS general (opc.) -->
  <link rel="stylesheet" href="/assets/css/style.css">

  <style>
  /* Estilos amigables para niños */
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
  .img-option-center {
    display: block;
    margin: 20px auto;
    width: 80%;
    max-width: 400px;
    border: 3px dashed #FFD700; /* Gold dashed border */
    border-radius: 15px;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
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
  
  /* Estilos específicos adicionales */
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
  /* Puzzle 2x2 (versión no adaptada) */
  .puzzle-container-2x2 {
    display: grid;
    grid-template-columns: repeat(2, 150px);
    grid-template-rows: repeat(2, 150px);
    gap: 10px;
    justify-content: center;
    margin: 20px auto;
  }
  .puzzle-cell, 
  .puzzle-slot {
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
  .hidden {
    opacity: 0;
  }
</style>

</head>
<body>

<?php if ($esVisual): ?>
  <!-- =========================================================
       EJERCICIO 5 ADAPTADO (DISCAPACIDAD NO VISUAL)
       COMPETENCIA: Planificación y Toma de Decisiones
       ========================================================= -->

  

  <div class="ejercicio">
    <h2>Ejercicio 5 para Discapacidad Visual / Competencia de Planificación y Toma de Decisiones</h2>
    
    <!-- Reactivo de Información -->
    <h3>Reactivo de Información</h3>
    <p>
      A continuación, se le presentará información acerca de los equipos o materiales de protección personal que deben ser usados en una empresa...
    </p>
    <p>
      <strong>¿Para qué sirven las gafas como equipo o material de uso personal en una empresa?</strong>
    </p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="A" required>
          a) Es el elemento más conocido para la protección de golpes en la cabeza.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="B">
          b) Es un equipo de protección individual destinado a proteger total o parcialmente la mano...
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="C">
          c) El uso adecuado proporciona seguridad y ayuda al cuidado de la salud ocular...
        </label>
      </div>
    </div>
    <hr>
    
    <!-- Reactivo de Semejanzas -->
    <h3>Reactivo de Semejanzas</h3>
    <p>¿En qué se parecen los guantes y el casco?</p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_1" value="A" required>
          a) Son equipos o materiales de uso y protección personal que deben ser usados en una empresa.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_1" value="B">
          b)  Ayudan a una empresa a prevenir, informar, y orientar de las acciones de seguridad.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_1" value="C">
          c) Tienen como objetivo de alertar a la persona de un peligro.
        </label>
      </div>
    </div>
    <p><strong>¿En qué se parecen el departamento financiero y el departamento de recursos humanos?</strong></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_2" value="A" required>
          a) Constantemente buscan personal adecuado a los requerimientos de la empresa y lidian con el personal ya existente en la organización
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_2" value="B">
          b) Son empleados con habilidades intelectuales, prácticas para desempeñar un cargo, realizando tareas determinadas en una empresa.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_2" value="C">
          c) Son secciones de la empresa que tienen por finalidad realizar ciertas tareas encomendadas.  
        </label>
      </div>
    </div>
    <hr>


<!-- Reactivo de Retención de Dígitos (Adaptado) -->
<link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">

<h3>Reactivo de Retención de Dígitos</h3>
<p>
  <strong>Indicación:</strong> A continuación, va a escuchar una serie de números, escuche con cuidado, solo se va a repetir una vez, cuando termine escriba los números en el mismo orden que escucho.
</p>

<!-- Audio para escuchar el texto, con Controles Personalizados -->
<p><strong>Escuche el audio:</strong></p>
<div class="audio-container">
  <!-- El audio en sí, con id "audio-Ej5" -->
  <audio 
    id="audio-Ej5" 
    ontimeupdate="updateProgressBar('Ej5')"
  >
    <!-- Primera ruta (absoluta) -->
    <source 
      src="/04.PDO-MYSQL-V1/assets/audio/retencion de digitos.mp3" 
      type="audio/mp3"
    >
    <!-- Segunda ruta (relativa, subiendo 4 niveles) -->
    <source 
      src="../../../../assets/audio/retencion de digitos.mp3" 
      type="audio/mp3"
    >
    Tu navegador no soporta el elemento de audio.
  </audio>

  <!-- Velocidad actual con id "speed-Ej5" -->
  <div class="speed-display" id="speed-Ej5">
    Normal
  </div>

  <!-- Barra de progreso con id "progress-Ej5" -->
  <div class="progress-bar" onclick="setAudioProgress(event, 'Ej5')">
    <span id="progress-Ej5"></span>
  </div>

  <!-- Botones de control (type="button" para evitar envío del formulario) -->
  <div class="audio-controls">
    <button class="play-btn" type="button" onclick="playAudio('Ej5')">
      ▶️ Play
    </button>
    <button class="pause-btn" type="button" onclick="pauseAudio('Ej5')">
      ⏸️ Pause
    </button>
    <button class="speed-down-btn" type="button" onclick="changeSpeed('Ej5', 0.5)">
      ⏪ Velocidad /2
    </button>
    <button class="speed-up-btn" type="button" onclick="changeSpeed('Ej5', 2)">
      ⏩ Velocidad x2
    </button>
  </div>
</div>
<div><h1>Ejemplo</h1></div>
<!-- Tabla de ejemplos -->
<table class="tabla-digitos">
  <tr>
    <th>Reactivo</th>
    <th>Respuesta</th>
  </tr>
  <tr>
    <td>4-9-3</td>
    <td>4-9-3</td>
  </tr>
  Fijese como en el ejemplo.
  <tr>
    <td>6-1-7-5</td>
  </tr>
  <td>5-3-2-8</td>
  </tr>
  <td>6-2-4-8-1-3</td>
  </tr>
</table>

<p><strong>Escriba aquí cada serie:</strong></p>
<div class="pregunta">
  <label for="adapt_retencionDigitos1">Serie 1:</label>
  <input type="text" id="adapt_retencionDigitos1" name="adapt_retencionDigitos1" class="retencion-input" placeholder="Ej: 1-2-6-3" required>
  
  <label for="adapt_retencionDigitos2">Serie 2:</label>
  <input type="text" id="adapt_retencionDigitos2" name="adapt_retencionDigitos2" class="retencion-input" placeholder="Ej: 2-3-4-2" required>
  
  <label for="adapt_retencionDigitos3">Serie 3:</label>
  <input type="text" id="adapt_retencionDigitos3" name="adapt_retencionDigitos3" class="retencion-input" placeholder="Ej: 3-4-5-9" required>
</div>

<!-- Script para autoformatear cada input con guiones -->
<script>
  document.querySelectorAll('.retencion-input').forEach(function(input) {
    input.addEventListener('input', function(e) {
      // Eliminar cualquier carácter que no sea dígito
      let value = e.target.value.replace(/[^0-9]/g, "");
      // Insertar guiones entre cada dígito
      let formatted = value.split("").join("-");
      e.target.value = formatted;
    });
  });
</script>

<!-- Incluir el script principal -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>

<?php else: ?>
 <!-- =========================================================
     EJERCICIO 5 (VERSIÓN NORMAL)
     COMPETENCIA: Planificación y Toma de Decisiones
     ========================================================= -->
<div class="ejercicio">
  <h2>Ejercicio 5 / Competencia de Planificación y Toma de Decisiones</h2>
  
  <!-- Reactivo de puzles visuales 1 -->
  <h3>Reactivo de puzles visuales</h3>
  <p><strong>Indicación:</strong> Observe la imagen e imagine que este dibujo es un rompecabezas, para ello debe escoger la opción correcta que permita completar el dibujo.</p>
  <p>
    <!-- Imagen con Fallback (ruta principal y ruta secundaria en onerror) -->
    <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.1.png" data-lightbox="galeria">
    <img 
      src=".png"
      alt="Rompecabezas 1"
      class="img-option-center"
      onerror="
        this.onerror=null; 
        this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.1.png';
      "
    >
  </a>
  </p>
  <div class="pregunta">
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta5_1" value="A" required>
        <!-- Literal A con fallback -->   
         <span class="literal-text">A</span>
         <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/A.png" data-lightbox="galeria">
        <img 
          src="imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/A.png"
       
          alt="Literal A" 
          class="literal-img"
          onerror="
            this.onerror=null; 
            this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/A.png';"  >
        </a>
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta5_1" value="B">
        <!-- Literal B con fallback -->
        <span class="literal-text">B</span>
        <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/B.png" data-lightbox="galeria">
        <img 
          src="/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/B.png"
          alt="Literal B" 
          class="literal-img"
          onerror="
            this.onerror=null;
            this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/B.png';"
        >
        </a>      
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta5_1" value="C">
        <!-- Literal C con fallback -->
        <span class="literal-text">C</span>
        <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/C.png" data-lightbox="galeria">
        <img 
          src="/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/C.png"
          alt="Literal C" 
          class="literal-img"
          onerror="
            this.onerror=null;
            this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.1/C.png';"
        >
        </a>
      </label>
    </div>
  </div>
  <hr>
  
  <!-- Reactivo de puzles visuales 2: Rompecabezas 2×2 -->
  <h3>Reactivo de figuras incompletas</h3>
  <p><strong>Indicación:</strong> Observe la imagen, identifique y coloque el elemento faltante que remplaza el espacio vacío y completa el conjunto de figuras. </p>
  <div class="puzzle-container-2x2">
    <!-- Celda 1 (Pieza 1) -->
    <div class="puzzle-cell" data-cell="1">
    <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/4.png" data-lightbox="galeria">
      <img 
        src="//imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/1.png" 
        alt="Pieza 1" 
        class="fixed-piece"
        onerror="
          this.onerror=null;
          this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/1.png';
        "
      >
    </a>
    </div>
    <!-- Celda 2 (Pieza 2) -->
    <div class="puzzle-cell" data-cell="2">
    <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/4.png" data-lightbox="galeria">
      <img 
        src="/04.PDO-MYSQL-V1---/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/2.png" 
        alt="Pieza 2" 
        class="fixed-piece"
        onerror="
          this.onerror=null; 
          this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/2.png';
        "
      >
      </a>
    </div>
    <!-- Celda 3 (Pieza 3) -->
    <div class="puzzle-cell" data-cell="3">
    <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/4.png" data-lightbox="galeria">
      <img 
        src="/04.PDO-MYSQL-V1---/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/3.png" 
        alt="Pieza 3" 
        class="fixed-piece"
        onerror="
          this.onerror=null; 
          this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/3.png';
        "
      >
      </a>  
    </div>
    <!-- Celda 4 (slot vacío) -->
    <div class="puzzle-slot" data-slot="slot1">
      <input type="hidden" name="slot1" value="">
    </div>
  </div>
  
  <!-- Piezas sueltas (A, B, C) con fallback -->
  <div class="puzzle-pieces">
    <div class="puzzle-piece-container">
      <span class="literal">A</span>
      <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/A.png" data-lightbox="galeria">
      <img 
        src="/04.PDO-MYSQL-V1---/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/A.png" 
        alt="Pieza A" 
        id="pieceA" 
        draggable="true" 
        class="puzzle-piece"
        onerror="
          this.onerror=null; 
          this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/A.png';"
      >
      </a>
    </div>
    <div class="puzzle-piece-container">
      <span class="literal">B</span>
      <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/B.png" data-lightbox="galeria">
      <img 
        src="/04.PDO-MYSQL-V1---/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/B.png"
        alt="Pieza B" 
        id="pieceB" 
        draggable="true" 
        class="puzzle-piece"
        onerror="
          this.onerror=null; 
          this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/B.png';"
      >
      </a>
    </div>
    <div class="puzzle-piece-container">
      <span class="literal">C</span>
      <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/C.png" data-lightbox="galeria">
      <img 
        src="/04.PDO-MYSQL-V1---/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/C.png"
        alt="Pieza C" 
        id="pieceC"
        draggable="true"
        class="puzzle-piece"
        onerror="
          this.onerror=null; 
          this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/literales5.2/C.png';"
      >
      </a>
    </div>
  </div>
  <hr>
  

  <h3>Reactivo Búsqueda de Símbolos</h3>
<p><strong>Indicación:</strong> En la siguiente imagen va observar una serie de símbolos Ud. debe contar los símbolos que se indican en el siguiente recuadro.</p>
<p>
  <!-- Imagen con fallback: si falla la primera ruta se usará la segunda -->
  <a href="../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.3.png" data-lightbox="galeria">
  <img 
    src="/04.PDO-MYSQL-V1---/assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.3.png" 
    alt="Serie de símbolos" 
    class="img-option-center"
    onerror="
      this.onerror=null; 
      this.src='../../../../assets/imagenes/DepartamentoDeGerenciaGeneral/ejercicio5/ejercicio5.3.png';"
  >
  </a>
</p>
<div class="pregunta">
  <label for="busquedaLlaveAbierta">¿Cuántos '}' hay?</label>
  <input type="number" id="busquedaLlaveAbierta" name="busquedaLlaveAbierta" min="0" required>
  
  <label for="busquedaLlaveCerrada">¿Cuántos '¿' hay?</label>
  <input type="number" id="busquedaLlaveCerrada" name="busquedaLlaveCerrada" min="0" required>
  
  <label for="busquedaMenor">¿Cuántos '¬' hay?</label>
  <input type="number" id="busquedaMenor" name="busquedaMenor" min="0" required>

  <label for="busquedaMayor">¿Cuántos '&gt;' hay?</label>
  <input type="number" id="busquedaMayor" name="busquedaMayor" min="0" required>
</div>
<hr>
  
 
</div>
<?php endif; ?>

<!-- Solo en la versión normal necesitamos Drag & Drop -->
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

    // Si el slot ya tiene una pieza, la devuelves al contenedor
    const existingPiece = slot.querySelector("img.puzzle-piece");
    if (existingPiece) {
      piecesContainer.appendChild(existingPiece);
      const hiddenInput = slot.querySelector("input[type='hidden']");
      if (hiddenInput) {
        hiddenInput.value = "";
      }
    }

    // Colocas la nueva pieza
    slot.appendChild(piece);
    piece.style.width = "150px";
    piece.style.height = "150px";

    // Actualiza el input hidden con la pieza elegida
    const hiddenInput = slot.querySelector("input[type='hidden']");
    if (hiddenInput) {
      hiddenInput.value = pieceId.replace("piece", "");
    }
  }
});
</script>

</body>
</html>
