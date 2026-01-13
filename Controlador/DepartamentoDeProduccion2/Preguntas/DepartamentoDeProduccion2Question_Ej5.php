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

// Obtenemos el id de discapacidad del usuario desde la sesión
$usuarioIdDiscapacidad = $_SESSION['user']['id_discapacidad'] ?? null;
// Suponemos que para usuarios con discapacidad intelectual, el id es 5.
$esVisual = ($usuarioIdDiscapacidad == 5);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 5 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
  <style>
  /* Estilos para imágenes y elementos */
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
</style>

  

  
</head>
<body>
<?php if($esVisual): ?>
  <!-- =========================================
       EJERCICIO 5 ADAPTADO PARA LA DISCAPACIDAD VISUAL
       EVALUACIÓN DE COMPETENCIAS DE PLANIFICACIÓN Y TOMA DE DECISIONES
  ========================================= -->
  <div class="ejercicio">
    <h2>Ejercicio 5 ADAPTADO para Discapacidad Visual<br>/ Competencia de Planificación y Toma de Decisiones</h2>
    
    <!-- Reactivo de Información -->
    <h3>Reactivo de Información</h3>
    <p>
      A continuación, se le presentará información acerca de los equipos o materiales de protección personal que deben usarse en una empresa. Estos están diseñados para proteger a los empleados de lesiones o enfermedades originadas por radiaciones, sustancias químicas o peligros físicos, eléctricos y mecánicos.
    </p>
    <p>
      <strong>Indicación:</strong> Elija la respuesta correcta referente a equipos o materiales de protección personal que se utilizan en una empresa.
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
          b) Es un equipo de protección individual destinado a proteger total o parcialmente la mano, con la finalidad de ofrecer protección contra un determinado riesgo.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="C">
          c) El uso adecuado proporciona seguridad y ayuda al cuidado de la salud ocular, evitando accidentes que pueden dejar al trabajador con visión limitada o pérdida total de la visión.
        </label>
      </div>
    </div>
    <hr>
    
    <!-- Reactivo de Semejanzas -->
    <h3>Reactivo de Semejanzas</h3>
    <p>
      <strong>Indicación:</strong> Se le presentarán dos enunciados. Analice la semejanza existente y elija la opción correcta.
    </p>
    <p><strong>Ejemplo:</strong> ¿En qué se parecen el departamento financiero y el departamento de recursos humanos?</p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_1" value="A" required>
          a) Constantemente buscan personal adecuado a los requerimientos de la empresa y lidian con el personal ya existente en la organización
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_1" value="B">
          b) Son empleados con habilidades intelectuales, prácticas para desempeñar un cargo, realizando tareas determinadas en una empresa.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_1" value="C">
          c) Son secciones de la empresa que tienen por finalidad realizar ciertas tareas encomendadas.  
        </label>
      </div>
    </div>
  
    <hr>
    
    <!-- 5.3 Reactivo de Retención de Dígitos (Adaptado) -->
<link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">

    <!-- Reactivo de Retención de Dígitos -->
    <h3>Reactivo de Retención de Dígitos</h3>
    <p>
      <strong>Indicación:</strong> Escuche la siguiente serie de números (se reproducirá solo una vez) cuando termine escriba los números en el mismo orden que escucho.
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
        <th>Reactivo</th>
        <th>Respuesta</th>
      </tr>
      <tr>
        <td>6-1-7-5</td>
        <td>.......</td>
      </tr>
      <tr>
        <td>5-3-2-8</td>
        <td>.......</td>
      </tr>
      <tr>
        <td>3-7-8-1</td>
        <td>.......</td>
      </tr>
      <tr>
        <td>6-2-4-8-1-3</td>
        <td>...........</td>
      </tr>
    </table>
    <p><strong>Indique aquí la serie en orden ascendente:</strong></p>
    <div class="pregunta">
      <label for="adapt_retencionDigitos1">Serie 1:</label>
      <input type="text" id="adapt_retencionDigitos1" name="adapt_retencionDigitos1"  class="retencion-input" placeholder="Ej: 1-2-6-3" required>
    
      <label for="adapt_retencionDigitos2">Serie 2:</label>
      <input type="text" id="adapt_retencionDigitos2" name="adapt_retencionDigitos2" class="retencion-input" placeholder="Ej: 1-2-6-3" required>
      
      <label for="adapt_retencionDigitos3">Serie 3:</label>
      <input type="text" id="adapt_retencionDigitos3"name="adapt_retencionDigitos3" class="retencion-input" placeholder="Ej: 1-2-6-3" required>
    
    
    </div>
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

<style>
  /* ... (tus estilos previos) ... */

  /* Estilos para los inputs de retención de dígitos */
  .retencion-input {
    font-size: 2em;              /* Aumenta el tamaño de fuente */
    padding: 15px;               /* Espaciado interno mayor */
    width: 90%;                  /* Ancho amplio */
    max-width: 600px;            /* Máximo ancho */
    margin: 15px auto;           /* Centrado y separación vertical */
    display: block;              /* Asegura que ocupe toda la línea */
    border: 2px solid #FFA07A;    /* Borde con color LightSalmon */
    border-radius: 10px;         /* Bordes redondeados */
  }
</style>

<!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>
  
<?php else: ?>
  
 <!-- EJERCICIO 5 ORIGINAL (para discapacidad auditiva y física) -->
<div class="ejercicio">
  <h2>Ejercicio 5 / Competencia de Planificación y Toma de Decisiones</h2>

   <!-- 5.3 Búsqueda de Símbolos -->
 <!-- Estilos específicos para la sección "Búsqueda de Símbolos" -->
<style>


   /* Contenedor principal: 3 columnas x 3 filas */
.puzzle-container {
  display: grid;
  grid-template-columns: repeat(3, 120px);
  grid-template-rows: repeat(3, 120px);
  gap: 2px; /* Espacio entre las celdas (ajusta a tu gusto) */
  justify-content: center;
  margin: 20px auto;
}

/* Celdas fijas y ranuras vacías */
.puzzle-cell,
.puzzle-slot {
  width: 120px;
  height: 120px;
  /* Si no quieres borde, pon border: none; */
  border: 1px solid #ccc;
  border-radius: 4px;
  overflow: hidden;          /* Para que la imagen no se salga */
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #fff;
}

/* Piezas fijas dentro de las celdas */
.fixed-piece {
  width: 120px;
  height: 120px;
  object-fit: cover;         /* Hace que la imagen llene el recuadro */
  border: none;              /* Quita bordes en la imagen */
}

/* Contenedor de piezas sueltas */
.puzzle-pieces {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
  margin-top: 20px;
}

/* Cada contenedor individual de la pieza (literal) */
.puzzle-piece-container {
  display: inline-block;
  text-align: center;
  margin: 10px;
}

/* Piezas arrastrables */
.puzzle-piece {
  width: 120px;
  height: 120px;
  object-fit: cover;         /* Llenar el recuadro */
  border: none;              /* Quitar borde a la imagen */
  cursor: move;
}

/* Ocultar la pieza mientras se arrastra */
.puzzle-piece.hidden {
  opacity: 0;
}

    

  .simbolos-container {
    background-color: #FFFACD; /* LemonChiffon */
    border: 2px dashed #FFA07A; /* LightSalmon */
    border-radius: 15px;
    padding: 20px;
    margin: 20px auto;
    width: 90%;
    max-width: 600px;
    text-align: center;
  }
  .simbolos-container img {
    display: block;
    margin: 20px auto;
    width: 80%;
    max-width: 400px;
    border: 3px dashed #FFD700; /* Gold dashed border */
    border-radius: 15px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  }
  .simbolos-container label {
    font-size: 1.5em;
    color: #2F4F4F;
    display: block;
    margin: 10px 0;
  }
  .simbolos-container input[type="number"] {
    width: 80%;
    padding: 10px;
    font-size: 1.4em;
    border: 2px solid #FFA07A;
    border-radius: 10px;
    margin-bottom: 15px;
  }
</style>

<!-- Sección de Búsqueda de Símbolos -->
<div class="simbolos-container">
  <p><strong>Búsqueda de Símbolos:</strong> En la siguiente imagen va observar una serie de símbolos usted debe contar los símbolos que se indican en el siguiente recuadro.  Observe el ejemplo pero igual llenelo </p>
  <a href="../../../../assets/imagenes/DepartamentoDeProduccion2/ejercicio5/ejercicio5.3.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeProduccion2/ejercicio5/ejercicio5.3.png" 
       alt="Búsqueda de Símbolos" 
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion2/ejercicio5/ejercicio5.3.png';">
  </a>

  <label for="busquedaMenor">¿Cuántos '}' hay?</label>
  <input type="number" id="busquedaMenor" name="busquedaMenor" min="0" placeholder="14" step="1" required>
  <label for="busquedaLlaveAbierta">¿Cuántos '¿' hay?</label>
  <input type="number" id="busquedaLlaveAbierta" name="busquedaLlaveAbierta" min="0" step="1" required>
  <label for="busquedaLlaveCerrada">¿Cuántos '¬' hay?</label>
  <input type="number" id="busquedaLlaveCerrada" name="busquedaLlaveCerrada" min="0" step="1" required>
</div>

</div>
<!-- Fin Ejercicio 5 -->

  <hr>
    <style>
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
    </style>
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

          // Si el slot ya tiene una pieza, reubicarla de vuelta al contenedor de piezas
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
          piece.style.width = "120px";
          piece.style.height = "120px";

          // Extraer el literal de la pieza
          let literal = pieceId.replace("piece", "");
          
          // Actualizar el input hidden del slot con el literal en minúsculas
          const hiddenInput = slot.querySelector("input[type='hidden']");
          if (hiddenInput) {
            hiddenInput.value = literal.toLowerCase();
          }
        }
      });
    </script>
  </div>
  
<?php endif; ?>
</body>
</html>
