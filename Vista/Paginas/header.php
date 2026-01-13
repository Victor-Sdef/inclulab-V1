<header class="header">
  <div class="header-left">

  <!-- Logo y Título -->
  <div class="container-fluid text-center">
    <img src="../assets/imagenes/logo.png" alt="Logo de IncluLab" style="width: 150px; height: auto;">
    <h1 style="font-size: 50px;">IncluLab</h1>
    <h2 class="py-3">Evaluación de Competencias</h2>
  </div>

  <!-- Panel de accesibilidad -->
  <div class="header-right">
    
    <!-- Lectura en voz alta -->
    <section class="accessibility-group" aria-labelledby="voice-controls">
      <h3 id="voice-controls">Lectura en Voz Alta</h3>
      <button onclick="startReading()" aria-label="Reproducir lectura en voz alta">▶️ Reproducir</button>
      <button onclick="pauseReading()" aria-label="Pausar lectura">⏸️ Pausar</button>
      <button onclick="nextSentence()" aria-label="Ir a la siguiente oración">⏭️ Siguiente</button>
      <button onclick="previousSentence()" aria-label="Regresar a la oración anterior">⏮️ Anterior</button>
      <button onclick="changeSpeed('increase')" aria-label="Aumentar velocidad de lectura">🔼 Velocidad</button>
      <button onclick="changeSpeed('decrease')" aria-label="Disminuir velocidad de lectura">🔽 Velocidad</button>
      <button onclick="seek(-10)" aria-label="Retroceder 10 segundos">⏪ -10s</button>
      <button onclick="seek(10)" aria-label="Avanzar 10 segundos">⏩ +10s</button>
    </section>

    <!-- Ajustes de accesibilidad -->
    <section class="accessibility-group" aria-labelledby="reading-settings">
      <h3 id="reading-settings">Ajustes de Lectura</h3>
      <button onclick="openSettings()" aria-label="Abrir ajustes de accesibilidad">⚙️ Ajustes</button>
    </section>
  </div>
</header>

<!-- Mejora para el menú con accesibilidad -->
<script>
  function toggleMenu() {
    var menu = document.querySelector(".menu");
    var button = document.getElementById("menuButton");
    
    if (menu.style.display === "block") {
      menu.style.display = "none";
      button.setAttribute("aria-expanded", "false");
    } else {
      menu.style.display = "block";
      button.setAttribute("aria-expanded", "true");
    }
  }
</script>

<style>
  /* Mejora en accesibilidad de enfoque */
  button:focus, a:focus {
    outline: 3px solid #0056b3;
  }
  
  .menu {
    display: none;
  }

  /* Mejor contraste para botones */
  button {
    background-color: #007BFF;
    color: white;
    border: none;
    padding: 10px 15px;
    font-size: 16px;
    cursor: pointer;
    margin: 5px;
    border-radius: 5px;
  }
  
  button:hover, button:focus {
    background-color: #0056b3;
  }
</style>
<header class="header">
  <div class="header-left">
    <button onclick="toggleMenu()" aria-label="Abrir menú de navegación" aria-expanded="false" id="menuButton">
      ☰ Menú
    </button>

    <!-- Menú de navegación -->
    <nav class="menu" role="navigation" aria-label="Menú principal">
      <ul>
        <li><a href="inicio.php" tabindex="0">Inicio</a></li>
        <li><a href="servicios.php" tabindex="0">Servicios</a></li>
        <li><a href="contacto.php" tabindex="0">Contacto</a></li>
      </ul>
    </nav>
  </div>

  <!-- Logo y Título -->
  <div class="container-fluid text-center">
    <img src="../assets/imagenes/logo.png" alt="Logo de IncluLab" style="width: 150px; height: auto;">
    <h1 style="font-size: 50px;">IncluLab</h1>
    <h2 class="py-3">Evaluación de Competencias</h2>
  </div>

  <!-- Panel de accesibilidad -->
  <div class="header-right">
    
    <!-- Lectura en voz alta -->
    <section class="accessibility-group" aria-labelledby="voice-controls">
      <h3 id="voice-controls">Lectura en Voz Alta</h3>
      <button onclick="startReading()" aria-label="Reproducir lectura en voz alta">▶️ Reproducir</button>
      <button onclick="pauseReading()" aria-label="Pausar lectura">⏸️ Pausar</button>
      <button onclick="nextSentence()" aria-label="Ir a la siguiente oración">⏭️ Siguiente</button>
      <button onclick="previousSentence()" aria-label="Regresar a la oración anterior">⏮️ Anterior</button>
      <button onclick="changeSpeed('increase')" aria-label="Aumentar velocidad de lectura">🔼 Velocidad</button>
      <button onclick="changeSpeed('decrease')" aria-label="Disminuir velocidad de lectura">🔽 Velocidad</button>
      <button onclick="seek(-10)" aria-label="Retroceder 10 segundos">⏪ -10s</button>
      <button onclick="seek(10)" aria-label="Avanzar 10 segundos">⏩ +10s</button>
    </section>

    <!-- Ajustes de accesibilidad -->
    <section class="accessibility-group" aria-labelledby="reading-settings">
      <h3 id="reading-settings">Ajustes de Lectura</h3>
      <button onclick="openSettings()" aria-label="Abrir ajustes de accesibilidad">⚙️ Ajustes</button>
    </section>
  </div>
</header>

<!-- Mejora para el menú con accesibilidad -->
<script>
  function toggleMenu() {
    var menu = document.querySelector(".menu");
    var button = document.getElementById("menuButton");
    
    if (menu.style.display === "block") {
      menu.style.display = "none";
      button.setAttribute("aria-expanded", "false");
    } else {
      menu.style.display = "block";
      button.setAttribute("aria-expanded", "true");
    }
  }
</script>

<style>
  /* Mejora en accesibilidad de enfoque */
  button:focus, a:focus {
    outline: 3px solid #0056b3;
  }
  
  .menu {
    display: none;
  }

  /* Mejor contraste para botones */
  button {
    background-color: #007BFF;
    color: white;
    border: none;
    padding: 10px 15px;
    font-size: 16px;
    cursor: pointer;
    margin: 5px;
    border-radius: 5px;
  }
  
  button:hover, button:focus {
    background-color: #0056b3;
  }
</style>