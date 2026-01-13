<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Evaluación de Competencias - Modo Accesible</title>
  
  <!-- Enlaces a CSS (Bootstrap, estilos personalizados, etc.) -->
  <link rel="stylesheet" href="../assets/css/style.css">
  <link rel="stylesheet" href="../assets/css/accesibilidad.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!-- Lightbox2 CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css" rel="stylesheet" />


  <!-- jQuery, Popper, Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- FontAwesome -->
  <script src="https://kit.fontawesome.com/32a65358fa.js" crossorigin="anonymous"></script>
  
  <style>
    /* Personaliza el foco para elementos interactivos */
    a:focus, button:focus, input:focus, select:focus, textarea:focus {
      outline: 2px solid #007BFF;
    }
    /* Estilos para el botón de modo accesible */
    .btn-accesible {
      position: fixed;
      bottom: 100px; /* Ubicado arriba de la burbuja de ajustes */
      right: 20px;
      z-index: 1000;
    }
    /* Estilos para la burbuja de ajustes (botón flotante) */
    .ajustes-burbuja {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 60px;
      height: 60px;
      background-color: #0044cc;
      border-radius: 50%;
      box-shadow: 0 4px 8px rgba(0,0,0,0.3);
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
      font-size: 28px;
      cursor: pointer;
      z-index: 1001;
    }
    /* Panel de ajustes, inicialmente oculto */
    .panel-ajustes {
      position: fixed;
      bottom: 100px;
      right: 20px;
      background-color: #fff;
      border: 2px solid #0044cc;
      border-radius: 10px;
      padding: 15px;
      width: 300px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.3);
      display: none;
      z-index: 1001;
    }
    .panel-ajustes h5 {
      margin-top: 0;
      color: #0044cc;
    }
    .panel-ajustes label {
      font-size: 18px;
      color: #0044cc;
    }
    .panel-ajustes input, 
    .panel-ajustes select {
      margin-bottom: 10px;
      width: 100%;
      padding: 5px;
    }
    
    /* Temas de color */
    .theme-claro {
      background-color: #ffffff;
      color: #0044cc;
    }
    .theme-oscuro {
      background-color: #222;
      color: #ffffff; /* Texto en blanco para modo oscuro */
    }
    /* Asegurar que el contenido interno herede el color en modo oscuro */
    .theme-oscuro * {
      color: inherit !important;
      background-color: transparent !important;
    }
    .theme-daltonismo {
      background-color: #ffffe0; /* Fondo claro */
      color: #000080; /* Azul oscuro para contraste */
    }
    .theme-amarillo {
      background-color:rgb(255, 247, 0); /* Fondo amarillo */
      color:rgb(0, 0, 0); /* texto oscuro para contraste */
    }
    .theme-amarillo * {
    color: inherit !important;
    background-color: transparent !important;
    }
    .theme-contrasteInvertido {
      background-color:rgb(0, 0, 0); /* Fondo oscuro */
      color: rgb(255, 247, 0); /* texto Amarillo oscuro para contraste */
    }
    .theme-contrasteInvertido * {
    color: inherit !important;
    background-color: transparent !important;
    }
    /* style para ajustes de imagen */
    .img-option {
    width: 120px;
    margin: 10px;
    border: 2px solid #ccc;
    border-radius: 8px;
    cursor: zoom-in;
    transition: transform 0.3s ease;
  }
  .img-option:hover {
    transform: scale(1.05);
    border-color: #888;
  }
</style>

  
  <!-- Script para cargar ajustes guardados desde localStorage -->
  <script>
    document.addEventListener("DOMContentLoaded", () => {
      // Recuperar configuración guardada
      const savedFontFamily = localStorage.getItem("fontFamily");
      const savedFontSize = localStorage.getItem("fontSize");
      const savedTheme = localStorage.getItem("theme");
      const savedModoAccesible = localStorage.getItem("modoAccesible") === "true";

      if (savedFontFamily) {
        document.body.style.fontFamily = savedFontFamily;
        const fontFamilySelect = document.getElementById("fontFamilySelect");
        if (fontFamilySelect) {
          fontFamilySelect.value = savedFontFamily;
        }
      }
      if (savedFontSize) {
        document.body.style.fontSize = savedFontSize + "px";
        const fontSizeRange = document.getElementById("fontSizeRange");
        const fontSizeValue = document.getElementById("fontSizeValue");
        if (fontSizeRange && fontSizeValue) {
          fontSizeRange.value = savedFontSize;
          fontSizeValue.innerText = savedFontSize;
        }
      }
      if (savedTheme) {
        document.body.classList.remove("theme-claro", "theme-oscuro", "theme-daltonismo","theme-amarillo","theme-contrasteInvertido");
        document.body.classList.add(savedTheme);
        const themeSelect = document.getElementById("themeSelect");
        console.log("Tema aplicado:", nuevoTema); // Agrega esta línea para depurar
        if (themeSelect) {
          themeSelect.value = savedTheme;
        }
      }
      // Aplicar el estado del modo accesible
      const toggleButton = document.getElementById("toggleAccesibilidad");
      if (savedModoAccesible) {
        toggleButton.innerText = "Desactivar ayuda para personas con problemas visuales";
      } else {
        toggleButton.innerText = "Activar ayuda para personas con problemas visuales";
      }
      // Guardar el estado en una variable global
      window.modoAccesible = savedModoAccesible;
    });
  </script>
</head>
<body class="theme-claro">
  <!-- Contenido de la página (logo, menú, etc.) -->
  <div class="container-fluid text-center">
    <img src="../assets/imagenes/logo.png" alt="Logo de IncluLab" style="width: 150px; height: auto;">
    <h1 style="font-size: 50px;">IncluLab</h1>
  </div>

  <!-- Barra de navegación -->
  <div class="container-fluid bg-light">
    <div class="container">
      <ul class="nav nav-justified py-2 nav-pills">
        <li class="nav-item">
          <a class="nav-link active" href="index.php" tabindex="0">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ingreso.php" tabindex="0">Ingreso</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="registro.php" tabindex="0">Registro</a>
        </li>
      </ul>
    </div>    
  </div>

  <!-- Ejemplo de contenido: tabla -->
  <div class="container py-5">
    <table class="table">
      <thead>
        <tr>
          <th tabindex="0">Firstname</th>
          <th tabindex="0">Lastname</th>
          <th tabindex="0">Email</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td tabindex="0">John</td>
          <td tabindex="0">Doe</td>
          <td tabindex="0">john@example.com</td>
        </tr>
        <tr>
          <td tabindex="0">Mary</td>
          <td tabindex="0">Moe</td>
          <td tabindex="0">mary@example.com</td>
        </tr>
        <tr>
          <td tabindex="0">July</td>
          <td tabindex="0">Dooley</td>
          <td tabindex="0">july@example.com</td>
        </tr>
      </tbody>
    </table>
  </div>

 

<!-- Tus dos archivos JS separados -->
<link rel="stylesheet" href="assets/css/Inicio/accesibilidad.css">

<script src="assets/js/Inicio/accesibilidad.js"></script>

<?php include '../Controlador/accesibilidad.php'; ?>


  <!-- Footer -->
  <?php include 'Paginas/footer.php'; ?>

  <!-- Lightbox2 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>
 
</body>
</html>