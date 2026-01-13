<?php
// AsistenteDeGerenciaQuestion_Ej1.php
// =========================================================
// EJERCICIO 1: Competencia Comprensión Lectora
// DISCAPACIDAD: auditiva, visual, fisica
// =========================================================

// (Opcional: si lo incluyes en un form, asegúrate de no forzar el envío con los botones.)
?>

<div class="ejercicio">
  <!-- Enlace a tu hoja de estilos (ajusta la ruta si hace falta) -->
  <link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">

  <h2>Ejercicio 1 / Competencia Comprensión Lectora</h2>
  <h3>Lectura Inferencial</h3>
  <p><strong>Indicación:</strong> Lea (o escuche) detenidamente el siguiente texto. Posteriormente, se le presentarán preguntas relacionadas y deberá marcar la opción correcta.</p>
  
  <h4>Texto: "El comerciante tramposo"</h4>
  <p>
    La abuela de Juan le pidió que fuera a una papelería a comprar diez metros de cinta para elaborar moños.<br>
    Al llegar, Juan pidió al vendedor el tipo de material y la cantidad indicada.<br>
    El comerciante sacó la pieza de la cual cortó diez metros de cinta, los envolvió y se los entregó.
  </p>
  <p>
    Al recibir la cinta, la abuela se dispuso a elaborar cinco moños, cada uno con dos metros de cinta.<br>
    Ya había terminado el cuarto cuando notó que solo quedaba un metro para el quinto moño.<br>
    Juan fue a pedir que le vendieran un metro más, pero el quinto moño quedó más pequeño.
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
  
  <!-- Preguntas del ejercicio -->
  <div class="pregunta">
    <p><strong>1) ¿Qué le pidió la abuela a Juan?</strong></p>
    <p>Le pidió que fuera a la papelería y le comprara 10 metros de cinta</p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="A" required> 
        A) Respuesta Correcta.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="B"> 
        B) Respuesta Incorrecta.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="C"> 
        C) No sabe.
      </label>
    </div>
  </div>
  
  <!-- (Más preguntas...) -->
  <div class="pregunta">
    <p><strong>2) ¿Qué hizo Juan al llegar a la papelería?</strong></p>
    <p>Juan pidió al vendedor el material y la cantidad indicada</p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="A" required> 
        A) Respuesta Correcta.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="B"> 
        B)  Respuesta Incorrecta.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="C"> 
        C) No Sabe
      </label>
    </div>
  </div>
  
  <div class="pregunta">
    <p><strong>3) ¿Qué hizo el comerciante?</strong></p>
    <p>El comerciante sacó la cinta al cual le cortó 10 metros de cinta, los envolvió y se los entregó.</p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="A" required> 
        A)Respuesta Correcta.                                     
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="B"> 
        B) Respuesta Incorrecta.
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="C"> 
        C) No sabe. 
      </label>
    </div>
  </div>
</div>

<!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>
