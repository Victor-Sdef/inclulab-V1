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
$esVisual = ($usuarioIdDiscapacidad == 5);

?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
</head>
<body>

<?php if ($esVisual): ?>


<div class="ejercicio">

 <!-- Enlace a tu hoja de estilos (ajusta la ruta si hace falta) -->
 <link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">


  <h2>Ejercicio 1 / Actividades de Evaluación - Competencia Comprensión Lectora</h2>
  <h3>Lectura Inferencial</h3>
  <p>
    <strong>Indicación:</strong> A continuación, se le presenta un ejercicio de comprensión lectora. Lea (o escuche) detenidamente el siguiente párrafo; posteriormente se le presentarán preguntas y respuestas referentes a la lectura. Marque la opción que Ud. considere correcta.
  </p>
  
  <h4>Texto: "El comerciante tramposo"</h4>
  <p>
    La abuela de Juan le pidió que fuera a una papelería a comprar diez metros de cinta para elaborar moños. Al llegar al lugar, Juan pidió al vendedor el tipo de material y la cantidad indicada. El comerciante sacó la pieza de la cual cortó diez metros de cinta, los envolvió y se los entregó.
  </p>
  <p>
    Al recibir la cinta, la abuela se dispuso a elaborar cinco moños, cada uno con dos metros de cinta. Ya había terminado el cuarto de ellos cuando se dio cuenta de que solo quedaba un metro de cinta para elaborar el quinto moño. Juan fue a la papelería a pedir que le vendieran un metro más de la misma cinta; sin embargo, el quinto moño quedó más pequeño que los otros, pues la abuela contó con un metro con noventa centímetros de cinta.
  </p>
  <p>
    <strong>Comprensión Inferencial de la Lectura:</strong> El comerciante Tramposo
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
  

  <!-- Pregunta 1 -->
  <div class="pregunta">
    <p><strong>1) ¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?</strong></p>
    <p>Un metro con noventa centímetros</p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="A" required>
        A) Respuesta Correcta
      </label>
    </div>
    
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="B" required>
        B) Respuesta Incorrecta
      </label>
    </div>
    

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="C" required>
        C) No Sabe
      </label>
    </div>
  
    <!-- Puedes agregar más opciones si lo consideras necesario -->
  </div>
  
  <!-- Pregunta 2 -->
  <div class="pregunta">
    <p><strong>2) ¿Qué se infiere de esta información?</strong></p>
    <p>Que la abuela le pidió que fuera a comprar un metro más de la misma cinta</p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="A" required>
        A) Respuesta Correcta
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="B">
        B) Respuesta Incorrecta
      </label>
    </div>

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="C">
        C) No Sabe
      </label>
    </div>
  </div>
  
  <!-- Pregunta 3 -->
  <div class="pregunta">
    <p><strong>3) ¿En qué consistió la trampa del comerciante?</strong></p>
    <p>Estaba midiendo con el metro empezando por el número 1 hasta el 100, dando en total 90cms. </p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="A" required>
        A) Respuesta Correcta
      </label>
    </div>

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="B" required>
        B) Respuesta Incorrecta 
      </label>
    </div>

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="C" required>
        C) No Sabe 
      </label>
    </div>
    <!-- Puedes agregar otras opciones si lo deseas -->
  </div>
</div>
<!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>


  <?php else: ?>
  

<!-- DeapartamentoHumano2Question_Ej1.php -->
<!-- Discapacidad: auditiva, fisica, visual   -->
<div class="ejercicio">

 <!-- Enlace a tu hoja de estilos (ajusta la ruta si hace falta) -->
 <link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">


  <h2>Ejercicio 1 / Actividades de Evaluación - Competencia Comprensión Lectora</h2>
  <h3>Lectura Inferencial</h3>
  <p>
    <strong>Indicación:</strong> A continuación, se le presenta un ejercicio de comprensión lectora. Lea (o escuche) detenidamente el siguiente párrafo; posteriormente se le presentarán preguntas y respuestas referentes a la lectura. Marque la opción que Ud. considere correcta.
  </p>
  
  <h4>Texto: "El comerciante tramposo"</h4>
  <p>
    La abuela de Juan le pidió que fuera a una papelería a comprar diez metros de cinta para elaborar moños. Al llegar al lugar, Juan pidió al vendedor el tipo de material y la cantidad indicada. El comerciante sacó la pieza de la cual cortó diez metros de cinta, los envolvió y se los entregó.
  </p>
  <p>
    Al recibir la cinta, la abuela se dispuso a elaborar cinco moños, cada uno con dos metros de cinta. Ya había terminado el cuarto de ellos cuando se dio cuenta de que solo quedaba un metro de cinta para elaborar el quinto moño. Juan fue a la papelería a pedir que le vendieran un metro más de la misma cinta; sin embargo, el quinto moño quedó más pequeño que los otros, pues la abuela contó con un metro con noventa centímetros de cinta.
  </p>
  <p>
    <strong>Comprensión Inferencial de la Lectura:</strong> El comerciante Tramposo
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
  

  <!-- Pregunta 1 -->
   <!-- Pregunta 1 -->
   <div class="pregunta">
    <p><strong>1) ¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?</strong></p>
    <p>Un metro con noventa centímetros</p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="A" required>
        A) Respuesta Correcta
      </label>
    </div>
    
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="B" required>
        B) Respuesta Incorrecta
      </label>
    </div>
    

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta1" value="C" required>
        C) No Sabe
      </label>
    </div>
  
    <!-- Puedes agregar más opciones si lo consideras necesario -->
  </div>
  
  <!-- Pregunta 2 -->
  <div class="pregunta">
    <p><strong>2) ¿Qué se infiere de esta información?</strong></p>
    <p>Que la abuela le pidió que fuera a comprar un metro más de la misma cinta</p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="A" required>
        A) Respuesta Correcta
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="B">
        B) Respuesta Incorrecta
      </label>
    </div>

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta2" value="C">
        C) No Sabe
      </label>
    </div>
  </div>
  
  <!-- Pregunta 3 -->
  <div class="pregunta">
    <p><strong>3) ¿En qué consistió la trampa del comerciante?</strong></p>
    <p>Estaba midiendo con el metro empezando por el número 1 hasta el 100, dando en total 90cms. </p>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="A" required>
        A) Respuesta Correcta
      </label>
    </div>

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="B" required>
        B) Respuesta Incorrecta 
      </label>
    </div>

    <div class="opcion">
      <label>
        <input type="radio" name="respuesta3" value="C" required>
        C) No Sabe 
      </label>
    </div>
       <!-- Puedes agregar otras opciones si lo deseas -->
  </div>
</div>
<!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>

<?php endif; ?>

</body>
</html>