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
$esVisual = ($usuarioIdDiscapacidad == 5 );
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 1 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
  <style>
    /* Puedes incluir aquí estilos específicos para el ejercicio */
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
      font-size: 32px;
      color: #0044cc;
    }
  </style>
</head>
<body>
  <!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>
<!-- Enlace a tu hoja de estilos (ajusta la ruta si hace falta) -->
<link rel="stylesheet" href="../../../../Vista/assets/css/Inicio/Inicio.css">


<?php if(!$esVisual): ?>
  


<!-- EJERCICIO 1: Comprensión Lectora (versión para usuarios con discapacidad intelectual) -->
<div class="ejercicio">
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
      <p><strong>1) ¿Qué hizo la abuela con la cinta?</strong></p>
      <p>La abuela se dispuso a elaborar 5 moños, cada uno con dos metros de cinta.</P>
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
    </div>
    
    <!-- Pregunta 2 -->
    <div class="pregunta">
      <p><strong>2) Qué le sucedió a la abuela cuando estaba elaborando los moños?</strong></p>
      <p>Ya terminados los moños se dio cuenta que solo quedaba 1 metro más de cinta para elaborar el quinto moño</P>
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
      <p><strong>3) ¿Qué tuvo que hacer Juan?</strong></p>
      <p>Juan se fue a la papelería y pidió que le vendieran 1 metro más de cinta </P>
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
    </div>
  </div>

<?php else: ?>

<!-- EJERCICIO 1: Comprensión Lectora (versión para usuarios sin discapacidad visual) -->
<div class="ejercicio">
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
      <p><strong>1) ¿Qué le pidió la abuela a Juan?</strong></p>
      <P>Le pidió que fuera a la papelería y le comprara 10 metros de cinta</P>
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
    </div>
    
    <!-- Pregunta 2 -->
    <div class="pregunta">
      <p><strong>2) ¿Qué hizo Juan al llegar a la papelería? </strong></p>
      <p>Juan pidió al vendedor el tipo de material y la cantidad indicada</P>
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
      <p><strong>3) ¿Qué hizo el comerciante?</strong></p>
      <p>El comerciante sacó la pieza de la cual cortó diez metros de cinta, los envolvió y se los entregó</P>
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
    </div>
  </div> 
<?php endif; ?>
</body>
</html>