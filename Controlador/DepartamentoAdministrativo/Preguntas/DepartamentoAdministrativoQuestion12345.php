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

// Si el usuario tiene discapacidad visual (id_discapacidad == 4), no mostramos el ejercicio.
$esVisual = ($usuarioIdDiscapacidad == 1 || $usuarioIdDiscapacidad == 5);

?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
</head>
<body>

  <style>
/* ================================
   Estilos para imágenes y elementos generales
================================ */
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
================================ */
body {
  font-family: "Comic Sans MS", cursive, sans-serif;
  background-color: #f0f8ff;
  margin: 0;
  padding: 0;
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

/* ================================
   Estilos para recuadros de preguntas y ejercicios
================================ */
.ejercicio {
  margin-bottom: 40px;
  padding: 20px;
  border: 2px solid #0044cc;
  border-radius: 10px;
  background-color: #e3f2fd;
  text-align: center;
}
.pregunta {
  background-color: #FFFACD; /* Fondo amarillo claro */
  border: 2px solid #FFA07A; /* LightSalmon */
  border-radius: 15px;
  padding: 20px;
  margin: 20px auto;
  width: 90%;
  max-width: 500px;
  text-align: center;
}
.opcion {
  background-color: #FFFACD;
  border: 1px solid #c5e1a5;
  padding: 10px;
  margin: 10px 0;
  border-radius: 8px;
}
.opcion label {
  font-size: 32px;
  color: #0044cc;
}

/* ================================
   Estilos para grid 2x2 de imágenes
================================ */
.grid-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  max-width: 500px;
  margin: 20px auto;
  text-align: center;
}
.grid-item {
  background-color: #FFFACD;
  padding: 10px;
  border: 2px solid #FFA07A;
  border-radius: 10px;
}
.grid-item img {
  width: 100%;
  height: auto;
  border: none;
}
.grid-item p {
  margin-top: 10px;
  font-size: 1.5em;
  color: #0044cc;
}

/* ================================
   Estilos para tablas de dígitos
================================ */
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
  
}.simbolos-container {
  background-color: #FFFACD; /* Fondo amarillo claro */
  border: 2px solid #FFA07A; /* Borde LightSalmon */
  border-radius: 15px;
  padding: 20px;
  margin: 20px auto;
  width: 90%;
  max-width: 500px;
}

.simbolos-container p {
  margin: 15px 0;
  text-align: center;
  font-size: 1.3em;
}

.simbolos-container img {
  display: block;
  margin: 20px auto;
  width: 80%;
  max-width: 400px;
  border: 3px dashed #FFD700; /* Borde dorado dashed */
  border-radius: 15px;
  box-shadow: 0 0 10px rgba(0,0,0,0.2);
}

.simbolos-container label {
  display: block;
  font-size: 1.5em;
  color: #2F4F4F;
  margin-bottom: 10px;
  text-align: center;
}

.simbolos-container input[type="number"] {
  width: 100%;
  padding: 10px;
  font-size: 1.4em;
  border: 2px solid #FFA07A;
  border-radius: 10px;
  margin-bottom: 15px;
}


  </style>

<?php if (!$esVisual): ?>

  <link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">

  
<!-- EJERCICIO 1: Comprensión Lectora -->
<div class="ejercicio">
  <h2>Ejercicio 1</h2>
  <h3>Comprensión Lectora / Lectura Inferencial</h3>
  <p><strong>Indicación:</strong> Lea detenidamente el siguiente texto y responda las preguntas.</p>
  <h4>Texto: "El comerciante tramposo"</h4>
  <p>
    La abuela de Juan le pidió que fuera a una papelería a comprar diez metros de cinta para elaborar moños.  
    Al llegar, Juan pidió al vendedor el tipo de material y la cantidad indicada.  
    El comerciante sacó la pieza de la cual cortó diez metros de cinta, los envolvió y se los entregó.
  </p>
  <p>
    Al recibir la cinta, la abuela se dispuso a elaborar cinco moños, cada uno con dos metros de cinta.  
    Tras terminar el cuarto, notó que solo quedaba un metro de cinta para el quinto moño.  
    Juan volvió a la papelería para comprar un metro más; sin embargo, el quinto moño quedó más pequeño.
  </p>


  <!-- Audio para escuchar el texto, con Controles Personalizados -->
  <p><strong>Escuche el audio:</strong></p>
  <div class="audio-container">
    <!-- El audio en sí -->
    <audio 
      id="audio-Ej1" 
      ontimeupdate="updateProgressBar('Ej1')"
    >
      <!-- Primera ruta (absoluta) -->
      <source 
        src="/04.PDO-MYSQL-V1/assets/audio/DepartamentoDeGerenciaGeneral/ejercicio1/gerencia_ejercicio1LecturaInferencial.mp3" 
        type="audio/mp3"
      >
      <!-- Segunda ruta (relativa, subiendo 4 niveles) -->
      <source 
        src="../../../../assets/audio/DepartamentoDeGerenciaGeneral/ejercicio1/gerencia_ejercicio1LecturaInferencial.mp3" 
        type="audio/mp3"
      >
      Tu navegador no soporta el elemento de audio.
    </audio>

    <!-- Velocidad actual -->
    <div class="speed-display" id="speed-Ej1">
      Normal
    </div>

    <!-- Barra de progreso -->
    <div class="progress-bar" onclick="setAudioProgress(event, 'Ej1')">
      <span id="progress-Ej1"></span>
    </div>

    <!-- Botones de control (type="button" para no enviar formulario) -->
    <div class="audio-controls">
      <button class="play-btn" type="button" onclick="playAudio('Ej1')">
        ▶️ Play
      </button>
      <button class="pause-btn" type="button" onclick="pauseAudio('Ej1')">
        ⏸️ Pause
      </button>
      <button class="speed-down-btn" type="button" onclick="changeSpeed('Ej1', 0.5)">
        ⏪ Velocidad /2
      </button>
      <button class="speed-up-btn" type="button" onclick="changeSpeed('Ej1', 2)">
        ⏩ Velocidad x2
      </button>
    </div>
  </div>

  <div class="pregunta">
    <p><strong>1) ¿Qué hizo la abuela con la cinta?</strong></p>
    <p> Se dispuso a elaborar cinco moños, cada uno utilizando dos metros de cinta</p>
    <div class="opcion"><label><input type="radio" name="respuesta1" value="A" required> A) Respuesta Correcta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta1" value="B"> B) Respuesta Incorrecta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta1" value="C"> C) No Sabe</label></div>
  </div>
  <p class="pregunta">
    <p><strong>2) ¿Qué le sucedió a la abuela al elaborar los moños?</strong></p>
    <p> Ya terminados los moños se dio cuenta que solo quedaba 1 metro más de cinta para elaborar el quinto moño </p>
    <div class="opcion"><label><input type="radio" name="respuesta2" value="A" required> A) Respuesta Correcta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta2" value="B"> B) Respuesta Incorrecta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta2" value="C"> C) No Sabe</label></div>
  </div>
  <div class="pregunta">
    <p><strong>3) ¿Qué tuvo que hacer Juan?</strong></p>
    <p> Juan se fue a la papelería y pidió que le vendieran 1 metro más de cinta </p>
    <div class="opcion"><label><input type="radio" name="respuesta3" value="A" required> A) Respuesta Correcta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta3" value="B"> B) Respuesta Incorrecta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta3" value="C"> C) No Sabe</label></div>
  </div>
</div>
<!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>

<!-- Fin Ejercicio 1 -->

<!-- EJERCICIO 2: Ordenar palabras -->
<div class="ejercicio">
  <h2>Ejercicio 2</h2>
  <h3>Competencia de Escritura</h3>
  <p><strong>Indicación:</strong> Ordene las palabras para formar la oración correcta.</p>
  
    <li>a. Son insectos pertenecientes</li>
    <li>b. Con alas escamosas.</li>
    <li>c. Al orden de los lepidópteros</li>
    <li>d. Las mariposas</li>
  
  <h4>Arrastre para ordenar:</h4>
  <ul id="sortable">
    <li draggable="true" data-value="a">A) Son insectos pertenecientes</li>
    <li draggable="true" data-value="b">B) Con alas escamosas</li>
    <li draggable="true" data-value="c">C) Al orden de los lepidópteros</li>
    <li draggable="true" data-value="d">D) Las mariposas</li>
  </ul>
  <input type="hidden" name="ordenFinal" id="ordenFinal" value="">
</div>
<!-- Fin Ejercicio 2 -->

<!-- EJERCICIO 3: Reactivo de Matrices -->
<div class="ejercicio">
  <h2>Ejercicio 3</h2>
  <h3>Competencia generación de ideas y pensamiento analítico</h3>
  <p><strong>Indicación:</strong> Observe la siguiente secuencia de imágenes y elija la opción que completa el patrón.</p>
  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.1.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.1.png" 
         alt="Secuencia 1" 
         class="img-option"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.1.png';">
        </a>
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.2.png" data-lightbox="galeria">
         <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.2.png" 
         alt="Secuencia 2" 
         class="img-option"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.2.png';">
        </a>
<a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.3.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.3.png" 
         alt="Secuencia 3" 
         class="img-option"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.3.png';">
</a>
         <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.4.png" data-lightbox="galeria">
         <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.4.png" 
         alt="Secuencia 4" 
         class="img-option"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.4.png';">
        </p>
        </a>
  <div class="pregunta">
    <div class="opcion">
      A
      <label>
        <input type="radio" name="respuestaE3" value="A" required>
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/A.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/A.png" 
             alt="Opción A" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/A.png';">
      </label>
    </a>
    </div>
    <div class="opcion">
      B
      <label>
        <input type="radio" name="respuestaE3" value="B">
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png" 
             alt="Opción B" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png';">
      </label>
    </a>
    </div>
    <div class="opcion">
      C
      <label>
        <input type="radio" name="respuestaE3" value="C">
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/C.png" 
             alt="Opción C" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/C.png';">
      </label>
    </a>
    </div>
    <div class="opcion">
      D
      <label>
        <input type="radio" name="respuestaE3" value="D">
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/D.png" 
             alt="Opción D" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/D.png';">
      </label>
      </a>
    </div>
  </div>
</div>

<!-- Fin Ejercicio 3 -->

<!-- EJERCICIO 4: Organización y Recopilación de la Información -->
<div class="ejercicio">
  <h2>Ejercicio 4</h2>
  <h3>Competencia organización de la información</h3>
 <strong>Indicación:</strong> A continuación, va a leer (escuchar) una frase incompleta, usted debe completar la idea descubriendo la relación existente entre las dos palabras. Elija la opción correcta. 
 <fieldset> <p>Ejemplo: <em>DEDO es a MANO como LADRILLO es a MURO.</em></p>
</fieldset>
<!-- 4.1 Analogías -->
  <p><strong>BOTELLA es a ____ como PLATO es a ____</strong></p>
  <div class="opcion"><label><input type="radio" name="respuesta4_1" value="A" required> A) cristal - postre</label></div>
  <div class="opcion"><label><input type="radio" name="respuesta4_1" value="B"> B) vino - agua</label></div>
  <div class="opcion"><label><input type="radio" name="respuesta4_1" value="C"> C) líquido - sólido</label></div>
  <div class="opcion"><label><input type="radio" name="respuesta4_1" value="D"> D) vino - lenteja</label></div>
  <hr>
 <!-- 4.2 Reactivo con dibujos -->
<p><strong>Reactivo con dibujos:</strong> Observe la imagen y seleccione el nombre correcto para la figura.</p>
<p><em>Imagen 2:</em></p>
<p>
<a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png" 
       alt="Imagen 2" 
       class="img-option-center"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png';">
</p>
</a>
<div class="opcion">
  <label>
    <input type="radio" name="respuesta4_2" value="A" required> A) Material de oficina
  </label>
</div>
<div class="opcion">
  <label>
    <input type="radio" name="respuesta4_2" value="B"> B) Material de protección personal
  </label>
</div>
<div class="opcion">
  <label>
    <input type="radio" name="respuesta4_2" value="C"> C) Artículos de carga
  </label>
</div>
<div class="opcion">
  <label>
    <input type="radio" name="respuesta4_2" value="D"> D) Bodega
  </label>
</div>
<hr>

  <!-- 4.3 Reactivos verbales -->
  <p><strong>Reactivos verbales:</strong> Seleccione la palabra que corresponde al siguiente significado.</p>
  <p><em>Persona que vigila el cumplimiento de las órdenes e instrucciones.</em></p>
  <div class="opcion"><label><input type="radio" name="respuesta4_3" value="SUPERVISOR" required> SUPERVISOR</label></div>
  <div class="opcion"><label><input type="radio" name="respuesta4_3" value="MAQUINARIA"> MAQUINARIA</label></div>
  <div class="opcion"><label><input type="radio" name="respuesta4_3" value="OBREROS"> OBREROS</label></div>
</div>
<!-- Fin Ejercicio 4 -->

<!-- EJERCICIO 5: Planificación y Toma de Decisiones -->
<div class="ejercicio">
  <h2>Ejercicio 5</h2>
  <h3>Competencia de Planificación y Toma de Decisiones</h3>
  <!-- 5.1 Rompecabezas visuales -->
  <p><strong>Reactivo rompecabezas visuales:</strong> Observe la imagen y seleccione la opción que complete la figura.</p>
  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.1.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.1.png" 
         alt="Rompecabezas" 
         class="img-option-center"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.1.png';">
  </a>
  </p>
  <div class="opcion">
    <label>
      <input type="radio" name="respuesta5_1" value="A" required> 
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png" data-lightbox="galeria">
      A
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png" 
           alt="Opción A" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png';">
          </label>
    </a>
        </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuesta5_1" value="B"> 
      B
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/B.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/B.png" 
           alt="Opción B" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/B.png';">
      </a>
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuesta5_1" value="C"> 
      C
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/C.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/C.png" 
           alt="Opción C" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/C.png';">
           </a>
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuesta5_1" value="D"> 
      D
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/D.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/D.png" 
           alt="Opción D" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/D.png';">
           </a>
    </label>
  </div>
  <hr>
</div>

 <!-- 5.2 Figuras Incompletas -->
<p><strong>Reactivo Figuras Incompletas:</strong> Observe la imagen y seleccione la pieza que complete el conjunto.</p>
<p>
<a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.2.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.2.png" 
       alt="Figuras Incompletas" 
       class="img-option-center"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.2.png';">
</p>
</a>
<div class="opcion">
  <label>
    <input type="radio" name="respuesta5_2" value="A" required>
    A
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/A.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/A.png" 
         alt="Opción A" 
         class="img-option"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/A.png';">
         </a>
  </label>
</div>
<div class="opcion">
  <label>
    <input type="radio" name="respuesta5_2" value="B">
    B
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/B.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/B.png" 
         alt="Opción B" 
         class="img-option"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/B.png';">
         </a>
  </label>
</div>
<div class="opcion">
  <label>
    <input type="radio" name="respuesta5_2" value="C">
    C
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/C.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/C.png" 
         alt="Opción C" 
         class="img-option"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/C.png';">
         </a>
  </label>
</div>
<hr>

 <!-- 5.3 Búsqueda de Símbolos -->
<div class="simbolos-container">
  <p><strong>Búsqueda de Símbolos:</strong> </p>
  <p><strong>Indicación:</strong>En la siguiente imagen va observar una serie de símbolos usted debe contar los símbolos que se indican en el siguiente recuadro. Observe el ejemplo    </p>
  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png" 
         alt="Búsqueda de Símbolos" 
         style="border:1px solid #ccc;" 
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png';">
         </a>
        </p>
  <p>
    <label for="busquedaMayor">¿Cuántos '>' hay?</label><br>
    <input type="number" id="busquedaMayor" name="busquedaMayor" placeholder="11" min="0" step="1" required>
  </p>
  <p>
    <label for="busquedaMenor">¿Cuántos '[' hay?</label><br>
    <input type="number" id="busquedaMenor" name="busquedaMenor" min="0" step="1" required>
  </p>
  <p>
    <label for="busquedaLlaveAbierta">¿Cuántos ')' hay?</label><br>
    <input type="number" id="busquedaLlaveAbierta" name="busquedaLlaveAbierta" min="0" step="1" required>
  </p>
  <p>
    <label for="busquedaLlaveCerrada">¿Cuántos '@' hay?</label><br>
    <input type="number" id="busquedaLlaveCerrada" name="busquedaLlaveCerrada" min="0" step="1" required>
  </p>
</div>
<!-- Fin Ejercicio 5 -->

  <?php else: ?>
  <p style="text-align:center; font-size:24px; color:#0044cc;">
    Este ejercicio no está disponible para usuarios con discapacidad visual, intelectual.
  </p>
<?php endif; ?>

</body>
</html>