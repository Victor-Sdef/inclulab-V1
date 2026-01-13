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
  <p><strong>Indicación:</strong> A continuación, se le presenta un ejercicio de comprensión lectora, 
  lea (escuche) detenidamente el siguiente párrafo, posteriormente se le presentará preguntas y respuestas referentes
   a la lectura, debe marcar la opción que usted considere correcta.</p>
  <h2>Texto: "El comerciante tramposo"</h2>
  <p>
  La abuela de Juan le pidió que fuera a una papelería a comprar diez metros de cinta para elaborar moños. 
  Al llegar al lugar Juan pidió al vendedor el tipo de material y la cantidad indicada. 
  El comerciante sacó la pieza de la cual cortó diez metros de cinta, los envolvió y se los entregó. 
  </p>
  <p>
    Al recibir la cinta, la abuela se dispuso a elaborar cinco moños, cada uno con dos metros de cinta.  
    Tras terminar el cuarto, notó que solo quedaba un metro de cinta para el quinto moño.  
    Juan volvió a la papelería para comprar un metro más; sin embargo, el quinto moño quedó más pequeño
    que los otros, pues la abuela contó con un metro con noventa centímetros de cinta. 
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
    <p><strong>1) ¿Cuántos metros de cinta utilizo la abuela para hacer el último moño?</strong></p>
    <p>Un metro con noventa centímetros</p> 
    <div class="opcion"><label><input type="radio" name="respuesta1" value="A" required> A) Respuesta Correcta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta1" value="B"> B) Respuesta Incorrecta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta1" value="C"> C) No Sabe</label></div>
  </div>
  <div class="pregunta">
    <p><strong>2) Qué se infiere de esta información?</strong></p>
    <p>Que la abuela le pidió que fuera a comprar un metro más de la misma cinta</p> 
    <div class="opcion"><label><input type="radio" name="respuesta2" value="A" required> A) Respuesta Correcta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta2" value="B"> B) Respuesta Incorrecta</label></div>
    <div class="opcion"><label><input type="radio" name="respuesta2" value="C"> C) No Sabe</label></div>
  </div>
  <div class="pregunta">
    <p><strong>3) ¿En qué consistió la trampa del comerciante?</strong></p>
    <p>Estaba midiendo con el metro empezando por el número 1 hasta el 100, dando en total 90cms. </p>
    <div class="opcion"><label><input type="radio" name="respuesta3" value="A" required> A) Respuesta Correcta.</label></div>
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
  <ul style="text-align: left;">
    <li>a. De palabras</li>
    <li>b. Ha portado una</li>
    <li>c. El idioma latín</li>
    <li>d. A nuestro lenguaje.</li>
    <li>e. Gran cantidad</li>
  </ul>
  <h4>Arrastre estos recuadros para ordenar la oración:</h4>
  <ul id="sortable">
    <li draggable="true" data-value="a">A) De palabras</li>
    <li draggable="true" data-value="b">B) ha aportado una</li>
    <li draggable="true" data-value="c">C) El idioma latín</li>
    <li draggable="true" data-value="d">D) A nuestro lenguaje.</li>
    <li draggable="true" data-value="e">E) Gran cantidad</li>
  </ul>
  <input type="hidden" name="ordenFinal" id="ordenFinal" value="">
</div>
<!-- Fin Ejercicio 2 -->

<!-- EJERCICIO 3: Reactivo de Matrices -->

<div class="ejercicio">
    <h2>Ejercicio 3 / Actividades de Evaluación de la competencia generación de ideas y pensamiento analítico</h2>
    <p>
      <strong>Indicación:</strong> Va a observar una serie de imágenes que siguen un patrón de secuencia. 
      Descubra el patrón y elija la imagen que falta para completar la secuencia.
    </p>
    <!-- Muestra de la secuencia -->
    <div class="secuencia">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.png" 
           alt="Secuencia 1" 
           class="img-option-center"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.png';">
           </a>
          </div>
    <p><strong>Opciones de Respuesta:</strong></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="A" required>
          A
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/A.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/A.png" 
               alt="Opción A" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/A.png';">
          </a>
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="B">
          B
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/B.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/B.png" 
               alt="Opción B" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/B.png';">
          </a>
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="C">
          C
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/C.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/C.png" 
               alt="Opción C" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/C.png';">
          </a>
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="D">
          D
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/D.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/D.png" 
               alt="Opción D" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/D.png';">
          </a>
        </label>
      </div>
    </div>
  </div>


<!-- Fin Ejercicio 4 -->
 <!-- EJERCICIO 4: Analogías verbales -->
 <div class="ejercicio">
    <h2>Ejercicio 4 / Competencia de organización de la información y recopilación de la información</h2>
    
    <!-- 4.1 Analogías verbales -->
    <h3>Analogías verbales</h3>
    <p>
      <strong>Indicación:</strong> A continuación, va a leer una frase incompleta.  
      Debe completar la idea descubriendo la relación existente entre las dos palabras.  
      Elija la opción correcta.
    </p> <fieldset>
      <p><em>Ejemplo:</em> <strong>DEDO</strong> es a <strong>MANO</strong> como <strong>LADRILLO</strong> es a <strong>MURO</strong>.</p>
      
      <li>a) GUANTE – PINTURA</li>
      <li>b) MANO – LADRILLO</li>
      <li>c) PIE – SUELO</li>
      <li>d) CUERPO – CASA</li>
      
      <p><strong>Respuesta:</strong> b</p>
    </fieldset>
    
    <hr>
    <!-- Nueva analogía -->
    <p><strong>PISCINA</strong> es a ____ como ____ es a <strong>GASOLINA</strong></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="A" required>
          A) depósito - cisterna
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="B">
          B) agua - depósito
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="C">
          C) verano - invierno
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="D">
          D) líquido - gas
        </label>
      </div>
    </div>


  </div>
  
<!-- EJERCICIO 4: Organización y Recopilación de la Información -->
<div class="ejercicio">
      <h3>Reactivos con Dibujos</h3>
      <p>
        <strong>Indicación:</strong> Observe el dibujo y seleccione el nombre correcto para la figura a la que pertenece.
      </p>

      <p>
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio4/ejercicio4.2.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio4/ejercicio4.2.png" 
             alt="Almacén con estanterías" 
             class="img-option-center"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio4/ejercicio4.2.png';">
      </a>
      </p>
      <div class="pregunta">
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="A" required>
            A) Material de oficina
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="B">
            B) Material de protección personal
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="C">
            C) Artículos de carga
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="D">
            D) Bodega
          </label>
        </div>
      </div>
    </div>
<div class="ejercicio"> 
   <!-- 4.3 Reactivos verbales -->
   <p><strong>Reactivos verbales:</strong> Seleccione la palabra que corresponde al siguiente significado.</p>
  <p><em>Instrumento que tiene por objeto multiplicar la capacidad productiva del trabajo humano.</em></p>
  <div class="opcion"><label><input type="radio" name="respuesta4_3" value="SUPERVISOR" required> SUPERVISOR</label></div>
  <div class="opcion"><label><input type="radio" name="respuesta4_3" value="MAQUINARIA"> MAQUINARIA</label></div>
  <div class="opcion"><label><input type="radio" name="respuesta4_3" value="OBREROS"> OBREROS</label></div>
</div>
<!-- Fin Ejercicio 4 -->
  
<!-- EJERCICIO 5 ORIGINAL (para discapacidad auditiva y física) -->
<div class="ejercicio">
 <h2>Ejercicio 5 / Competencia de Planificación y Toma de Decisiones</h2>
 
 <!-- 5.1 Reactivo Rompecabezas Visuales -->
 <h3>Reactivo Rompecabezas Visuales</h3>
 <p>
   <strong>Indicación:</strong> Observe la imagen e imagine que este dibujo es un rompecabezas.  
   Tenga en cuenta que faltan dos piezas en la parte izquierda; la ficha amarilla es una de ellas.
   De las siguientes opciones, ¿cuál completa el rompecabezas?
 </p>
 <p>
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.1.png" data-lightbox="galeria">
   <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.1.png" 
        alt="Rompecabezas incompleto" 
        class="img-option-center"
        onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.1.png';">
    </a>
 </p>
 <div class="pregunta">
   <div class="opcion">
     <label>
       <input type="radio" name="respuesta5_rompecabezas" value="A" required>
       A)
       <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/A.png" data-lightbox="galeria">
       <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/A.png" 
            alt="Opción A" 
            class="img-option"
            onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/A.png';">
        </a>
     </label>
   </div>
   <div class="opcion">
     <label>
       <input type="radio" name="respuesta5_rompecabezas" value="B">
       B)
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/B.png" data-lightbox="galeria">
       <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/B.png" 
            alt="Opción B" 
            class="img-option"
            onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/B.png';">
        </a>
     </label>
   </div>
   <div class="opcion">
     <label>
       <input type="radio" name="respuesta5_rompecabezas" value="C">
       C)
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/C.png" data-lightbox="galeria">
       <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/C.png" 
            alt="Opción C" 
            class="img-option"
            onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/C.png';">
        </a>
     </label>
   </div>
   <div class="opcion">
     <label>
       <input type="radio" name="respuesta5_rompecabezas" value="D">
       D)
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/D.png" data-lightbox="galeria">
       <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/D.png" 
            alt="Opción D" 
            class="img-option"
            onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.1/D.png';">
        </a>
     </label>
   </div>
 </div>
 <hr>
 <!-- 5.2 Puzzle 3x3 Drag & Drop -->
 <h3>Reactivo Figuras Incompletas</h3>
 <p>
   <strong>Indicación:</strong> Observe el rompecabezas 3×3. Algunas piezas ya están colocadas y hay 4 espacios vacíos.
   Arrastre cada una de las 4 piezas (A, B, C, D) y suéltela en los espacios correspondientes.
   Si ya hay una pieza en un espacio, ésta se reubica.
 </p>
 <div class="puzzle-container">
   <div class="puzzle-cell" data-cell="1">
   <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.2/1.png" data-lightbox="galeria">
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/1.png" 
          class="fixed-piece" 
          alt="Pieza 1"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/1.png';">
    </a>
   </div>
   <div class="puzzle-slot" data-slot="slot1">
     <input type="hidden" name="slot1" value="">
   </div>
   <div class="puzzle-cell" data-cell="3">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.2/3.png" data-lightbox="galeria">
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/3.png" 
          class="fixed-piece" 
          alt="Pieza 3"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/3.png';">
    </a>
   </div>
   <div class="puzzle-slot" data-slot="slot2">
     <input type="hidden" name="slot2" value="">
   </div>
   <div class="puzzle-cell" data-cell="5">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.2/5.png" data-lightbox="galeria">
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/5.png" 
          class="fixed-piece" 
          alt="Pieza 5"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/5.png';">
    </a>
   </div>
   <div class="puzzle-slot" data-slot="slot3">
     <input type="hidden" name="slot3" value="">
   </div>
   <div class="puzzle-cell" data-cell="7">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.2/7.png" data-lightbox="galeria">
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/7.png" 
          class="fixed-piece" 
          alt="Pieza 7"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/7.png';">
    </a>
   </div>
   <div class="puzzle-slot" data-slot="slot4">
     <input type="hidden" name="slot4" value="">
   </div>
   <div class="puzzle-cell" data-cell="9">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.2/9.png" data-lightbox="galeria">
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/9.png" 
          class="fixed-piece" 
          alt="Pieza 9"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/9.png';">
    </a>
   </div>
 </div>
 <div class="puzzle-pieces">
   <div class="puzzle-piece-container">
     <span class="literal"></span>
     <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/A.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/A.png" 
            alt="Pieza A" 
            id="pieceA" draggable="true" 
            class="puzzle-piece"
            onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/A.png';">
            </a>
</div>
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/A.png" data-lightbox="galeria"></a>
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/A.png" 
          alt="Pieza A" 
          id="pieceA" draggable="true" 
          class="puzzle-piece"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/A.png';">
          </a>
   </div>
   <div class="puzzle-piece-container">
     <span class="literal"></span>
     <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/B.png" data-lightbox="galeria"></a>
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/B.png" 
          alt="Pieza B" 
          id="pieceB" draggable="true" 
          class="puzzle-piece"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/B.png';">
          </a>
   </div>
   <div class="puzzle-piece-container">
     <span class="literal"></span>
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/C.png" data-lightbox="galeria"></a>
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/C.png" 
          alt="Pieza C" 
          id="pieceC" draggable="true" 
          class="puzzle-piece"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/C.png';">
          </a>
   </div>
   <div class="puzzle-piece-container">
     <span class="literal"></span>
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/D.png" data-lightbox="galeria"></a>
     <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/D.png" 
          alt="Pieza D" 
          id="pieceD" draggable="true" 
          class="puzzle-piece"
          onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/literales5.2/D.png';">
          </a></div>
   </div>
 </div>



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
 <p><strong>Búsqueda de Símbolos:</strong> </p>
 <p><strong>Indicación:</strong> En la siguiente imagen va observar una serie de símbolos usted debe contar los símbolos que se indican en el siguiente recuadro.  Observe el ejemplo   </p>
 <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.3.png" data-lightbox="galeria">
 <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png" 
      alt="Búsqueda de Símbolos" 
      onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio5/ejercicio5.3.png';">
      </a>


 <label for="busquedaMenor">¿Cuántos '&' hay?</label>
 <input type="number" id="busquedaMenor" name="busquedaMenor" min="0" placeholder="8" step="1" required>
 <label for="busquedaLlaveAbierta">¿Cuántos '¡' hay?</label>
 <input type="number" id="busquedaLlaveAbierta" name="busquedaLlaveAbierta" min="0" step="1" required>
 <label for="busquedaLlaveCerrada">¿Cuántos '{' hay?</label>
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


  <?php else: ?>
  <p style="text-align:center; font-size:24px; color:#0044cc;">
    Este ejercicio no está disponible para usuarios con discapacidad visual, intelectual.
  </p>
<?php endif; ?>

</body>
</html>