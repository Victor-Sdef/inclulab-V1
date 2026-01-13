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
// Si el usuario tiene discapacidad intelectual (id_discapacidad == 5), no mostramos este ejercicio.
$esIntelecual = ($usuarioIdDiscapacidad == 5 );

// Si el usuario tiene discapacidad visual (id_discapacidad == 1), no mostramos este ejercicio.
$esVisual = ($usuarioIdDiscapacidad == 1  );
// Si el usuario tiene discapacidad auditiva (id_discapacidad == 2), no mostramos este ejercicio.
$esAuditiva = ($usuarioIdDiscapacidad == 2  );
// Si el usuario tiene discapacidad fisica (id_discapacidad == 3), no mostramos este ejercicio.
$esFisica = ($usuarioIdDiscapacidad == 3  );

?>


<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>AnalistaDeTalentoHumanoQuestion</title>
  
  <!-- Hoja de estilos amigable para niños y estilos específicos -->
  <style>
    /* ======= Estilos amigables para niños ======= */
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
    .pregunta input[type="number"],
    .pregunta input[type="text"] {
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
    
    /* ======= Estilos específicos adicionales ======= */
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
    
    /* ======= Encabezado: Logo a la izquierda y Cerrar sesión a la derecha ======= */
    .header-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem;
      background-color: #f8f9fa;
    }
    .header-container .logo {
      display: flex;
      align-items: center;
    }
    .header-container .logo img {
      width: 150px;
      height: auto;
      margin-right: 10px;
    }
    .header-container .logout-btn {
      font-size: 22px;
      color: #fff;
      background-color: #e74c3c;
      padding: 10px 20px;
      border-radius: 5px;
      text-decoration: none;
      margin: 0 10px;
    }
    .header-container .logout-btn:hover {
      background-color: #c0392b;
      text-decoration: none;
    }
  </style>
</head>
<body>



  <!-- EJERCICIO 1: Comprensión Lectora -->
  <div class="ejercicio">
    <link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">
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
    
    <!-- Audio para escuchar el texto -->
    <p><strong>Escuche el audio:</strong></p>
    <div class="audio-container">
      <audio id="audio-Ej1" ontimeupdate="updateProgressBar('Ej1')">
        <source src="/04.PDO-MYSQL-V1/assets/audio/DepartamentoDeGerenciaGeneral/ejercicio1/gerencia_ejercicio1LecturaInferencial.mp3" type="audio/mp3">
        <source src="../../../../assets/audio/DepartamentoDeGerenciaGeneral/ejercicio1/gerencia_ejercicio1LecturaInferencial.mp3" type="audio/mp3">
        Tu navegador no soporta el elemento de audio.
      </audio>
      <div class="speed-display" id="speed-Ej1">Normal</div>
      <div class="progress-bar" onclick="setAudioProgress(event, 'Ej1')">
        <span id="progress-Ej1"></span>
      </div>
      <div class="audio-controls">
        <button class="play-btn" type="button" onclick="playAudio('Ej1')">▶️ Play</button>
        <button class="pause-btn" type="button" onclick="pauseAudio('Ej1')">⏸️ Pause</button>
        <button class="speed-down-btn" type="button" onclick="changeSpeed('Ej1', 0.5)">⏪ Velocidad /2</button>
        <button class="speed-up-btn" type="button" onclick="changeSpeed('Ej1', 2)">⏩ Velocidad x2</button>
      </div>
    </div>
    
    <div class="pregunta">
      <p><strong>1) ¿Qué hizo la abuela con la cinta?</strong></p>
      La abuela se dispuso a elaborar 5 moños, cada uno con dos metros de cinta
      <div class="opcion"><label><input type="radio" name="respuesta1" value="A" required> A) Respuesta Correcta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta1" value="B"> B) Respuesta Incorrecta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta1" value="C"> C) No Sabe</label></div>
    </div>
    <div class="pregunta">
      <p><strong>2) ¿Qué le sucedió a la abuela al elaborar los moños?</strong></p>
      Ya terminados los moños se dio cuenta que solo quedaba 1 metro más de cinta para elaborar el quinto moño
      <div class="opcion"><label><input type="radio" name="respuesta2" value="A" required> A) Respuesta Correcta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta2" value="B"> B) Respuesta Incorrecta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta2" value="C"> C) No Sabe</label></div>
    </div>
    <div class="pregunta">
      <p><strong>3) ¿Qué tuvo que hacer Juan?</strong></p>
      Juan se fue a la papelería y pidió que le vendieran 1 metro más de cinta 
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
    <ul>
      <li>a. Son insectos pertenecientes</li>
      <li>b. Con alas escamosas.</li>
      <li>c. Al orden de los lepidópteros</li>
      <li>d. Las mariposas</li>
    </ul>
    <h4>Arrastre para ordenar:</h4>
    <ul id="sortable">
      <li draggable="true" data-value="d">D) Son insectos pertenecientes</li>
      <li draggable="true" data-value="a">A) Con alas escamosas</li>
      <li draggable="true" data-value="c">C) Al orden de los lepidópteros</li>
      <li draggable="true" data-value="b">B) Las mariposas</li>
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
  <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.4.png" 
       alt="Secuencia 4" 
       class="img-option"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.4.png';">
  </a>
  </div>
</p>

<div class="pregunta">
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3" value="A" required>
      A
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/A.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/A.png" 
           alt="Opción A" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/A.png';">
      </a>
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3" value="B">
      B
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png" 
           alt="Opción B" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png';">
      </a>
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3" value="C">
      C
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/C.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/C.png" 
           alt="Opción C" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/C.png';">
      </a>
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3" value="D">
      D
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/D.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/D.png" 
           alt="Opción D" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/D.png';">
      </a>
    </label>
  </div>
</div>

  <!-- Fin Ejercicio 3 -->


 <!-- APLICA PARA LA DISCAPACIDAD AUDITIVA =2 , FISICA=3 , VISUAL=1 , Intelectual   -->
      <!-- EJERCICIO 4: Organización y Recopilación de la Información -->
  
 <!-- ===================================================== -->
  <!-- SECCIÓN: EJERCICIO 4- Organización y Recopilación de la Información -->
  <!-- ===================================================== -->
  <div class="ejercicio">
    <h2>Ejercicio 4 / Competencia: Organización y Recopilación de la Información</h2>
    
    <!-- Pregunta 1: Analogías verbales -->
    <div class="pregunta">
      <p><strong>1) Analogías verbales </strong></p>
      <p><strong>Indicación:</strong> Complete la siguiente frase incompleta descubriendo la relación entre las palabras.  
      <fieldset> Ejemplo: <strong>DEDO</strong> es a <strong>MANO</strong> como <strong>LADRILLO</strong> es a <strong>MURO</strong>.
      </fieldset></p>
      <p><strong>……... es a AGUA DULCE como MAR es a ....</strong></p>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE4_Analogias" value="A" required>
          A) azúcar - agua salada
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE4_Analogias" value="B">
          B) río - olas
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE4_Analogias" value="C">
          C) lago - agua salada
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE4_Analogias" value="D">
          D) lago – sal
        </label>
      </div>
    </div>
    
    <hr>

<!-- EJERCICIO 4.1 -->
    
    <div class="pregunta">
  <p><strong>2) Reactivos con Dibujos </strong></p>
  <p><strong>Indicación:</strong> Observe la imagen y seleccione el nombre correcto a la figura a la que pertenece.</p>
  <p><strong>Imagen:</strong></p>
  <!-- Imagen con URL de respaldo en caso de error -->
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/ejercicio4.1.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/ejercicio4.1.png" 
       alt="Imagen de ejemplo" 
       class="img-option-center"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/ejercicio4.1.png';">
  </a>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="A" required>
      A) Material de oficina
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="B">
      B) Material de protección personal
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="C">
      C) Artículos de carga
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="D">
      D) Bodega
    </label>
  </div>

</div>



 <!-- Pregunta 4.2 -->
 <div class="pregunta">
      <p><strong>3) Reactivo verbal</strong></p>
      <p><strong>Indicación:</strong> Se le presenta el siguiente significado. Elija la palabra correcta que lo describa.</p>
      <p><strong>Persona que tiene como función principal la de vigilar el cumplimiento de las órdenes e instrucciones:</strong></p>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Verbal" value="SUPERVISOR" required>
          SUPERVISOR
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Verbal" value="MAQUINARIA">
          MAQUINARIA
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Verbal" value="OBREROS">
          OBREROS
        </label>
      </div>
     
    </div>
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
      A
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png" 
           alt="Opción A" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png';">
           </a>
    </label>
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
  <!-- 5.2 Figuras Incompletas -->
  <p><strong>Reactivo Figuras Incompletas:</strong> Observe la imagen y seleccione la pieza que complete el conjunto.</p>
  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.2.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.2.png" 
         alt="Figuras Incompletas" 
         class="img-option-center"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.2.png';">
  </a>
  </p>
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
 <!-- Estilos específicos para la sección "Búsqueda de Símbolos" -->
<style>
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
  <p><strong>Búsqueda de Símbolos</strong></p>
  <p><strong>Indicación:</strong>En la siguiente imagen va observar una serie de símbolos usted debe contar los símbolos que se indican en el siguiente recuadro.  Observe el ejemplo</p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png" 
       alt="Búsqueda de Símbolos" 
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png';">
  </a>
  <label for="busquedaMayor">¿Cuántos '>' hay?</label>
  <input type="number" id="busquedaMayor" name="busquedaMayor" min="0" placeholder="11" step="1" required>
  <label for="busquedaLlaveAbierta">¿Cuántos '[' hay?</label>
  <input type="number" id="busquedaLlaveAbierta" name="busquedaLlaveAbierta" min="0" step="1" required>
  <label for="busquedaLlaveCerrada">¿Cuántos ')' hay?</label>
  <input type="number" id="busquedaLlaveCerrada" name="busquedaLlaveCerrada" min="0" step="1" required>
</div>

</div>
<!-- Fin Ejercicio 5 -->

<?php if($esVisual): ?>
<!-- =========================================
       EJERCICIO 5 ADAPTADO PARA LA DISCAPACIDAD VISUAL
       EVALUACIÓN DE COMPETENCIAS DE PLANIFICACIÓN Y TOMA DE DECISIONES
  ========================================= -->
  <div class="ejercicio">
    <h2>Ejercicio 5 ADAPTADO para Discapacidad Visual<br>/ Competencia de Planificación y Toma de Decisiones</h2>
    
    <!-- Reactivo de Información -->
    <h3>Reactivo de Información</h3>
    <p><strong>Indicación:</strong>A continuación, se le presentara información acerca de los equipos o materiales de protección personal que deben ser usados en una empresa, estos están diseñados para proteger a los empleados de lesiones o enfermedades que puedan ser originadas por el contacto con radiaciones, con sustancias químicas, con peligros físicos, eléctricos, mecánicos entre otros
 
    <p>
      <strong>¿Cuál de los siguientes elementos son equipos o materiales de uso personal que protege al trabajador del riesgo de accidentes o de efectos adversos para la salud?</strong>
    </p>
    <p>OJO: debe señalar dos respuestas correctas:</p> 
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="A" required>
          a) Protectores auditivos, gafas, mascarillas.  
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="B">
          b) Señaléticas de seguridad.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="C">
          c) Ropa industrial como: chalecos, overoles.   
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE1" value="D">
          d) Equipos contra incendio.   
        </label>
      </div>
    </div>
    <hr>
    
    <!-- Reactivo de Semejanzas -->
    <h3>Reactivo de Semejanzas</h3>
    <p>
      <strong>Indicación:</strong> A continuación, le voy a presentar dos palabras Ud. deberá analizar que semejanza existen entre las dos y elegir la opción que Ud. considere correcta. 
    </p>
    <p><strong></strong> ¿En qué se parecen los aguantes y el casco? </p>
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
          b) Ayudan a una empresa a prevenir, informar, y orientar de las acciones de seguridad.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="adapt_respuestaPPE2_1" value="C">
          c) Tienen como objetivo de alertar a la persona de un peligro.
        </label>
      </div>
    </div>


    <!-- 5.3 Reactivo de Retención de Dígitos (Adaptado) -->
<link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">

    <!-- Reactivo de Retención de Dígitos -->
    <h3>Reactivo de Retención de Dígitos</h3>
    <p>
      <strong>Indicación:</strong> Escuche la siguiente serie de números en desorden (se reproducirá solo una vez) y escriba los números en orden ascendente.
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
    <fielset>
      <p><em>Ejemplo:</em></p>
    <table class="tabla-digitos">
    <tr>
        <th>Reactivo</th>
        <th>Respuesta</th>
      </tr>
      <tr>
        <td>4-9-3</td>
        <td>3-9-4</td>
      </tr>
</fieldset>
<tr>
        <th>Reactivo</th>
        <th>Respuesta</th>
      </tr>
      <tr>
        <td>6-1-7-5</td>
        <td>-------</td>
      </tr>
      <tr>
        <td>5-3-2-8</td>
        <td>-------</td>
      </tr>
      <tr>
        <td>6-2-4-8-1-3</td>
        <td>--------</td>
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

 
    <?php endif; ?>   

<!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>
