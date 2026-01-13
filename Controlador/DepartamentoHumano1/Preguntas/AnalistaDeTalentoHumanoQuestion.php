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
    <p><strong>Indicación:</strong> A continuación, se le presenta un ejercicio de comprensión lectora, lea (escuche) 
    detenidamente el siguiente párrafo, posteriormente se le presentará preguntas y respuestas referentes a la lectura, 
    debe marcar la opción que usted considere correcta.</p>
    <h4>Texto: "El comerciante tramposo"</h4>
    <p>
      La abuela de Juan le pidió que fuera a una papelería a comprar diez metros de cinta para elaborar moños.  
      Al llegar, Juan pidió al vendedor el tipo de material y la cantidad indicada.  
      El comerciante sacó la pieza de la cual cortó diez metros de cinta, los envolvió y se los entregó.
    </p>
    <p>
    Al recibir la cinta la abuela se dispuso a elaborar cinco moños, cada uno con dos metros de cinta. 
    Ya había terminado el cuarto de ellos cuando se dio cuenta de que solo quedaba un metro de cinta para
     elaborar el quinto moño. Juan fue a la papelería a pedir que le vendieran un metro más de la misma cinta; 
     sucedió que el quinto moño quedó más pequeño que los otros, pues la abuela contó con un metro con
      noventa centímetros de cinta.
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
      <p>La abuela se dispuso a elaborar 5 moños, cada uno con dos metros de cinta. </p>
      <div class="opcion"><label><input type="radio" name="respuesta1" value="A" required> A) Respuesta Correcta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta1" value="B"> B) Respuesta Incorrecta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta1" value="C"> C) No Sabe.</label></div>
    </div>
    <div class="pregunta">
      <p><strong>2) ¿Qué le sucedió a la abuela al elaborar los moños?</strong></p>
      <p>Ya terminados los moños se dio cuenta que solo quedaba 1 metro más de cinta para elaborar el quinto moño.</p>
      <div class="opcion"><label><input type="radio" name="respuesta2" value="A" required> A) Respuesta Correcta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta2" value="B"> B) Respuesta Incorrecta</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta2" value="C"> C) No Sabe</label></div>
    </div>
    <div class="pregunta">
      <p><strong>3) ¿Qué tuvo que hacer Juan?</strong></p>
      <p>Juan se fue a la papelería y pidió que le vendieran 1 metro más de cinta.</p>
      <div class="opcion"><label><input type="radio" name="respuesta3" value="A" required> A) Respuesta Correcta.</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta3" value="B"> B) Respuesta Incorrecta.</label></div>
      <div class="opcion"><label><input type="radio" name="respuesta3" value="C"> C) No Sabe.</label></div>
    </div>
  </div>
  <!-- Fin Ejercicio 1 -->

  <!-- EJERCICIO 2: Ordenar palabras -->
  <div class="ejercicio">
    <h2>Ejercicio 2</h2>
    <h3>Competencia de Escritura</h3>
    <p><strong>Indicación:</strong>  Lea detenidamente cada palabra y luego ordene las mismas para formular una oración.</p>
    <style>
  ul {
    list-style-position: inside; /* Elimina la indentación por defecto */
    padding-left: 0; /* Quita el relleno izquierdo */
    margin-left: 0;  /* Quita el margen izquierdo */
  }

  li {
    text-align: left; /* Alinea el texto a la izquierda */
  }
</style>
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
    <p><strong>Reactivo de Matrices</strong></p>
    <p><strong>Indicación:</strong> Observe la siguiente secuencia de imágenes y elija la opción que completa el patrón.</p>
    <p>
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.1-.png" data-lightbox="galeria">
  <img src="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.1.png" 
       alt="Secuencia 1" 
       class="img-option"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.1.png';">
  <img src="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.2.png" 
       alt="Secuencia 2" 
       class="img-option"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.2.png';">
  <img src="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.3.png" 
       alt="Secuencia 3" 
       class="img-option"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.3.png';">
  <img src="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.4.png" 
       alt="Secuencia 4" 
       class="img-option"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/ejercicio3.1.4.png';">
  </a>
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
           onerror="this.onerror=null; 
           this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/A.png';">     
    </a>
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3" value="B">
      B
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/B.png" 
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
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/C.png" 
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
      <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/D.png" 
           alt="Opción D" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio3/literales/D.png';">
    </a>
    </label>
  </div>
</div>

  <!-- Fin Ejercicio 3 -->

  <!-- EJERCICIO 4: Organización y Recopilación de la Información -->
  <div class="ejercicio">
    <h2>Ejercicio 4</h2>
    <h3>Competencia organización de la información</h3>
    <!-- 4.1 Analogías -->
    <p><strong>Analogías:</strong> A continuación, va a leer una frase incompleta, usted debe completar la idea descubriendo la relación existente entre las dos palabras. Elija la opción correcta.</p>
    <fieldset><p>Ejemplo: <em>DEDO es a MANO como LADRILLO es a MURO.</em></p></fieldset>
    <p>entonces; ahora responda:</p>
    <p><strong>BOTELLA es a ____ como PLATO es a ____</strong></p>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_1" value="A" required> A) cristal - postre</label>
    </div>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_1" value="B"> B) vino - agua</label>
    </div>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_1" value="C"> C) líquido - sólido</label>
    </div>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_1" value="D"> D) lentejas - sopa</label>
    </div>
    <hr>
  <!-- 4.2 Reactivo con dibujos -->
<p><strong>Reactivo con dibujos:</strong> Observe la imagen y seleccione el nombre correcto para la figura a la que pertenece.</p>
<p><em>Imagen 2:</em></p>
<p>
<a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png" 
       alt="Imagen 2" 
       class="img-option-center"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png';">
  </a>
</p>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="A" required> A) Material de oficina</label>
</div>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="B"> B) Material de protección personal</label>
</div>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="C"> C) Artículos de carga</label>
</div>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="D"> D) Bodega</label>
</div>
<hr>

    <!-- 4.3 Reactivos verbales -->
    <p><strong>Reactivos verbales:</strong> A continuación, se le presentara varios significados, debe elegir la palabra correcta para enlazarla al significado que Ud. considere correcto.</p>
    <p><em>Persona que vigila el cumplimiento de las órdenes e instrucciones.</em></p>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_3" value="SUPERVISOR" required> SUPERVISOR</label>
    </div>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_3" value="MAQUINARIA"> MAQUINARIA</label>
    </div>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_3" value="OBREROS"> OBREROS</label>
    </div>
  </div>
  <!-- Fin Ejercicio 4 -->

 <!-- EJERCICIO 5: Planificación y Toma de Decisiones -->
<div class="ejercicio">
  <h2>Ejercicio 5</h2>
  <h3>Competencia de Planificación y Toma de Decisiones</h3>
  <!-- 5.1 Rompecabezas visuales -->
  <p><strong>Reactivo rompecabezas visuales:</strong> Observe la imagen e imagine que este dibujo es un rompecabezas, para ello debe escoger la opción correcta que permita completar el dibujo.</p>
  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.1.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.1.png" 
         alt="Rompecabezas" 
         class="img-option-center"
         onerror="this.onerror=null; 
         this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.1.png';">
      </a>
  </p>
  <div class="opcion">
    <label>
      A
      <input type="radio" name="respuesta5_1" value="A" required>
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png" 
           alt="Opción A" 
           class="img-option"
           onerror="this.onerror=null; 
           this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/A.png';"> 
    </label>
    </div>
  </a>
  
  <div class="opcion">
    <label>
      B
      <input type="radio" name="respuesta5_1" value="B">
       <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/B.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/B.png" 
           alt="Opción B" 
           class="img-option"
           onerror="this.onerror=null; 
           this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/B.png';">
    </label>
  </div>
</a>
  <div class="opcion">
    <label>
      C  
       <input type="radio" name="respuesta5_1" value="C">
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/C.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/C.png" 
           alt="Opción C" 
           class="img-option"
           onerror="this.onerror=null; 
           this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/C.png';">
    </label>
  </a>
  </div>
  <div class="opcion">
    <label>
      D
       <input type="radio" name="respuesta5_1" value="D">
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/D.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/D.png" 
           alt="Opción D" 
           class="img-option"
           onerror="this.onerror=null; 
           this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.1/D.png';">
    </label>
    </a>
  </div>
  <hr>
  <!-- 5.2 Figuras Incompletas -->
  <p><strong>Reactivo Figuras Incompletas:</strong> Observe la imagen, identifique y seleccione la pieza que complete el conjunto.</p>
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
    </label>
    </a>
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
    </label>
    </a>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuesta5_2" value="C">
      C
      <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/A.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/C.png" 
           alt="Opción C" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/literales5.2/C.png';">
    </label>
    </a>
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
  <p><strong>Búsqueda de Símbolos:</strong></p><p> 
  <p><strong>Indicación:</strong>En la siguiente imagen va observar una serie de símbolos, usted debe contar los símbolos que se indican en el siguiente recuadro. Observe el ejemplo.</p>

  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png" 
       alt="Búsqueda de Símbolos" 
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio5/ejercicio5.3.png';">
       </a>
  <label for="busquedaMayor">¿Cuántos '>' hay?</label>
  <input type="number" id="busquedaMayor" name="busquedaMayor"placeholder="11" min="0" step="1" required>
  <label for="busquedaLlaveAbierta">¿Cuántos '[' hay?</label>
  <input type="number" id="busquedaLlaveAbierta" name="busquedaLlaveAbierta" min="0" step="1" required>
  <label for="busquedaLlaveCerrada">¿Cuántos ')' hay?</label>
  <input type="number" id="busquedaLlaveCerrada" name="busquedaLlaveCerrada" min="0" step="1" required>
</div>

</div>
<!-- Fin Ejercicio 5 -->

<!-- Importación de tu JS (donde defines playAudio, pauseAudio, etc.) -->
<script src="../../../../Vista/assets/js/Inicio/Inicio.js"></script>
